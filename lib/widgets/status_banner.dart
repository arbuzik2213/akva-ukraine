import 'package:flutter/material.dart';
import '../models/outage.dart';
import '../providers/app_state.dart';

class StatusBanner extends StatelessWidget {
  final AppState state;
  final VoidCallback onChangeAddress;

  const StatusBanner({
    super.key,
    required this.state,
    required this.onChangeAddress,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final status = state.currentStatus;

    Color statusColor;
    Color statusBgColor;
    IconData statusIcon;
    String statusTitle;
    String statusDescription;

    switch (status) {
      case WaterSupplyStatus.normal:
        statusColor = const Color(0xFF10B981);
        statusBgColor = isDark
            ? const Color(0xFF064E3B).withOpacity(0.3)
            : const Color(0xFFD1FAE5);
        statusIcon = Icons.water_drop_rounded;
        statusTitle = state.tr('water_ok');
        statusDescription = state.tr('water_ok_desc');
        break;
      case WaterSupplyStatus.lowPressure:
        statusColor = const Color(0xFFF59E0B);
        statusBgColor = isDark
            ? const Color(0xFF78350F).withOpacity(0.3)
            : const Color(0xFFFEF3C7);
        statusIcon = Icons.speed_rounded;
        statusTitle = state.tr('water_warning');
        statusDescription = state.tr('water_warning_desc');
        break;
      case WaterSupplyStatus.shutOff:
        statusColor = const Color(0xFFEF4444);
        statusBgColor = isDark
            ? const Color(0xFF7F1D1D).withOpacity(0.3)
            : const Color(0xFFFEE2E2);
        statusIcon = Icons.water_drop_outlined;
        statusTitle = state.tr('water_off');
        statusDescription = state.tr('water_off_desc');
        break;
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).cardTheme.color,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: statusColor.withOpacity(0.3),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: statusColor.withOpacity(0.08),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // City and address bar
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      state.selectedCity.name,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      state.selectedStreet,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.2,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              IconButton.filledTonal(
                onPressed: onChangeAddress,
                icon: const Icon(Icons.edit_location_alt_rounded, size: 20),
                tooltip: state.tr('change_address'),
              ),
            ],
          ),

          const SizedBox(height: 20),

          // Big Status Indicator Badge
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: statusBgColor,
              borderRadius: BorderRadius.circular(18),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: statusColor,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(statusIcon, color: Colors.white, size: 28),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        statusTitle,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: isDark ? Colors.white : const Color(0xFF0F172A),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        statusDescription,
                        style: TextStyle(
                          fontSize: 12,
                          color: isDark
                              ? const Color(0xFFCBD5E1)
                              : const Color(0xFF475569),
                          height: 1.3,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Pressure & Provider Stats Row
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  decoration: BoxDecoration(
                    color: isDark ? const Color(0xFF1E293B) : const Color(0xFFF1F5F9),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.speed, size: 18, color: statusColor),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          status == WaterSupplyStatus.normal
                              ? state.tr('normal_pressure')
                              : status == WaterSupplyStatus.lowPressure
                                  ? state.tr('low_pressure')
                                  : state.tr('zero_pressure'),
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  decoration: BoxDecoration(
                    color: isDark ? const Color(0xFF1E293B) : const Color(0xFFF1F5F9),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.verified_outlined, size: 18, color: Color(0xFF0284C7)),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          state.selectedCity.hotline,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
