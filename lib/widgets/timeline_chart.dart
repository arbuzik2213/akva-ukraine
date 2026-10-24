import 'package:flutter/material.dart';
import '../models/outage.dart';
import '../providers/app_state.dart';

class TimelineChart extends StatefulWidget {
  final AppState state;

  const TimelineChart({super.key, required this.state});

  @override
  State<TimelineChart> createState() => _TimelineChartState();
}

class _TimelineChartState extends State<TimelineChart> {
  int? _selectedHour;

  @override
  Widget build(BuildContext context) {
    final timeline = widget.state.timeline24h;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    if (timeline.isEmpty) {
      return const SizedBox.shrink();
    }

    final selectedSlot = _selectedHour != null && _selectedHour! < timeline.length
        ? timeline[_selectedHour!]
        : timeline.firstWhere(
            (s) => s['isCurrentHour'] == true,
            orElse: () => timeline.first,
          );

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).cardTheme.color,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: isDark ? const Color(0xFF1E293B) : const Color(0xFFE2E8F0),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.state.tr('schedule_title'),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.2,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: isDark ? const Color(0xFF1E293B) : const Color(0xFFF1F5F9),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  widget.state.tr('day_today'),
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),

          Text(
            widget.state.tr('schedule_subtitle'),
            style: TextStyle(
              fontSize: 12,
              color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B),
            ),
          ),

          const SizedBox(height: 20),

          // 24 Hour Bar Visualizer
          SizedBox(
            height: 90,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: timeline.length,
              separatorBuilder: (_, __) => const SizedBox(width: 6),
              itemBuilder: (context, index) {
                final slot = timeline[index];
                final int hour = slot['hour'];
                final WaterSupplyStatus status = slot['status'];
                final bool isCurrent = slot['isCurrentHour'] == true;
                final bool isSelected = _selectedHour == hour;

                Color barColor;
                switch (status) {
                  case WaterSupplyStatus.normal:
                    barColor = const Color(0xFF10B981);
                    break;
                  case WaterSupplyStatus.lowPressure:
                    barColor = const Color(0xFFF59E0B);
                    break;
                  case WaterSupplyStatus.shutOff:
                    barColor = const Color(0xFFEF4444);
                    break;
                }

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedHour = hour;
                    });
                  },
                  child: Container(
                    width: 32,
                    decoration: BoxDecoration(
                      color: isSelected
                          ? Theme.of(context).colorScheme.primary.withOpacity(0.15)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(10),
                      border: isSelected
                          ? Border.all(
                              color: Theme.of(context).colorScheme.primary,
                              width: 1.5,
                            )
                          : null,
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        // Current hour indicator dot
                        if (isCurrent)
                          Container(
                            width: 6,
                            height: 6,
                            margin: const EdgeInsets.only(bottom: 4),
                            decoration: const BoxDecoration(
                              color: Color(0xFF0284C7),
                              shape: BoxShape.circle,
                            ),
                          )
                        else
                          const SizedBox(height: 10),

                        // Bar
                        Expanded(
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              width: 14,
                              height: status == WaterSupplyStatus.shutOff ? 16 : 42,
                              decoration: BoxDecoration(
                                color: barColor,
                                borderRadius: BorderRadius.circular(6),
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 6),

                        // Hour text
                        Text(
                          '${hour.toString().padLeft(2, '0')}',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: isCurrent || isSelected
                                ? FontWeight.w700
                                : FontWeight.w500,
                            color: isCurrent
                                ? Theme.of(context).colorScheme.primary
                                : (isDark
                                    ? const Color(0xFF94A3B8)
                                    : const Color(0xFF64748B)),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 16),

          // Selected Hour Detail Card
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF1E293B) : const Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.info_outline_rounded,
                  size: 20,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Час: ${selectedSlot['label']} (${selectedSlot['isCurrentHour'] == true ? "Поточна година" : "Прогноз"})',
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '${selectedSlot['note']}',
                        style: TextStyle(
                          fontSize: 11,
                          color: isDark ? const Color(0xFFCBD5E1) : const Color(0xFF475569),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
