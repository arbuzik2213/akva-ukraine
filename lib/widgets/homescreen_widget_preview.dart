import 'package:flutter/material.dart';
import '../models/outage.dart';
import '../providers/app_state.dart';

class HomescreenWidgetPreview extends StatefulWidget {
  final AppState state;

  const HomescreenWidgetPreview({super.key, required this.state});

  @override
  State<HomescreenWidgetPreview> createState() => _HomescreenWidgetPreviewState();
}

class _HomescreenWidgetPreviewState extends State<HomescreenWidgetPreview> {
  int _selectedSize = 1; // 0: Small, 1: Medium, 2: Large

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final status = widget.state.currentStatus;

    Color statusColor;
    String statusTitle;
    IconData statusIcon;

    switch (status) {
      case WaterSupplyStatus.normal:
        statusColor = const Color(0xFF10B981);
        statusTitle = widget.state.tr('widget_live_status');
        statusIcon = Icons.water_drop_rounded;
        break;
      case WaterSupplyStatus.lowPressure:
        statusColor = const Color(0xFFF59E0B);
        statusTitle = widget.state.tr('water_warning');
        statusIcon = Icons.speed_rounded;
        break;
      case WaterSupplyStatus.shutOff:
        statusColor = const Color(0xFFEF4444);
        statusTitle = widget.state.tr('water_off');
        statusIcon = Icons.water_drop_outlined;
        break;
    }

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
                widget.state.tr('widget_title'),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.2,
                ),
              ),
              const Icon(Icons.widgets_outlined, size: 20, color: Color(0xFF0284C7)),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            widget.state.tr('widget_subtitle'),
            style: TextStyle(
              fontSize: 12,
              color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B),
            ),
          ),
          const SizedBox(height: 16),

          // Size selector pills
          Row(
            children: [
              _buildSizePill(0, widget.state.tr('widget_size_small')),
              const SizedBox(width: 8),
              _buildSizePill(1, widget.state.tr('widget_size_medium')),
              const SizedBox(width: 8),
              _buildSizePill(2, widget.state.tr('widget_size_large')),
            ],
          ),

          const SizedBox(height: 20),

          // Simulated Launcher Widget Canvas
          Center(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              width: _selectedSize == 0 ? 150 : (_selectedSize == 1 ? 310 : 310),
              height: _selectedSize == 0 ? 150 : (_selectedSize == 1 ? 140 : 240),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: isDark
                      ? [const Color(0xFF1E293B), const Color(0xFF0F172A)]
                      : [Colors.white, const Color(0xFFF1F5F9)],
                ),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: isDark ? const Color(0xFF334155) : const Color(0xFFCBD5E1),
                  width: 1.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 18,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: _buildWidgetContent(statusColor, statusTitle, statusIcon, isDark),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSizePill(int index, String label) {
    final isSelected = _selectedSize == index;
    return ChoiceChip(
      label: Text(label, style: const TextStyle(fontSize: 11)),
      selected: isSelected,
      onSelected: (_) {
        setState(() {
          _selectedSize = index;
        });
      },
    );
  }

  Widget _buildWidgetContent(
    Color statusColor,
    String statusTitle,
    IconData statusIcon,
    bool isDark,
  ) {
    if (_selectedSize == 0) {
      // 2x2 Small Widget
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(statusIcon, color: statusColor, size: 24),
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(color: statusColor, shape: BoxShape.circle),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                statusTitle,
                style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 2),
              Text(
                widget.state.tr('widget_countdown'),
                style: TextStyle(
                  fontSize: 10,
                  color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B),
                ),
              ),
            ],
          ),
        ],
      );
    } else if (_selectedSize == 1) {
      // 4x2 Medium Widget
      return Row(
        children: [
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: statusColor.withOpacity(0.15),
              borderRadius: BorderRadius.circular(18),
            ),
            child: Icon(statusIcon, color: statusColor, size: 32),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Text(
                      widget.state.selectedCity.name,
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: statusColor.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        statusTitle,
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          color: statusColor,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  widget.state.selectedStreet,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  widget.state.tr('widget_countdown'),
                  style: TextStyle(
                    fontSize: 11,
                    color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B),
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    } else {
      // 4x4 Large Widget
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(statusIcon, color: statusColor, size: 24),
                  const SizedBox(width: 8),
                  Text(
                    widget.state.tr('app_title'),
                    style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
                  ),
                ],
              ),
              Text(
                '3.2 бар',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: statusColor,
                ),
              ),
            ],
          ),
          const Divider(height: 24),
          Text(
            widget.state.selectedStreet,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 6),
          Text(
            widget.state.tr('water_ok_desc'),
            style: TextStyle(
              fontSize: 11,
              color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B),
            ),
            maxLines: 2,
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF0F172A) : const Color(0xFFE2E8F0),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.state.tr('utility_provider'),
                  style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600),
                ),
                Text(
                  widget.state.selectedCity.hotline,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    }
  }
}
