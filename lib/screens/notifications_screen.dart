import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_state.dart';
import '../widgets/sms_preview_sheet.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();
    final settings = state.notificationSettings;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          state.tr('tab_alerts'),
          style: const TextStyle(fontWeight: FontWeight.w800),
        ),
      ),
      body: ListView(
        children: [
          const SizedBox(height: 8),

          // SMS & Widget Preview Simulator at top
          SmsPreviewSheet(state: state),

          const SizedBox(height: 8),

          // Notification Settings Card
          Container(
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
                Text(
                  state.tr('notifications_title'),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.2,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  state.tr('notifications_subtitle'),
                  style: TextStyle(
                    fontSize: 12,
                    color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B),
                  ),
                ),
                const SizedBox(height: 16),

                // 10 Min Alert
                _buildSwitchTile(
                  context,
                  title: state.tr('alert_10_min'),
                  subtitle: state.tr('alert_10_min_desc'),
                  value: settings.alert10Min,
                  icon: Icons.timer_10_rounded,
                  onChanged: (val) {
                    state.updateNotificationSettings(
                      settings.copyWith(alert10Min: val),
                    );
                  },
                ),

                const Divider(height: 20),

                // 30 Min Alert
                _buildSwitchTile(
                  context,
                  title: state.tr('alert_30_min'),
                  subtitle: state.tr('alert_30_min_desc'),
                  value: settings.alert30Min,
                  icon: Icons.alarm_rounded,
                  onChanged: (val) {
                    state.updateNotificationSettings(
                      settings.copyWith(alert30Min: val),
                    );
                  },
                ),

                const Divider(height: 20),

                // 1 Hour Alert
                _buildSwitchTile(
                  context,
                  title: state.tr('alert_1_hour'),
                  subtitle: state.tr('alert_1_hour_desc'),
                  value: settings.alert1Hour,
                  icon: Icons.hourglass_top_rounded,
                  onChanged: (val) {
                    state.updateNotificationSettings(
                      settings.copyWith(alert1Hour: val),
                    );
                  },
                ),

                const Divider(height: 20),

                // Restore Alert
                _buildSwitchTile(
                  context,
                  title: state.tr('alert_on_restore'),
                  subtitle: state.tr('alert_on_restore_desc'),
                  value: settings.alertOnRestore,
                  icon: Icons.check_circle_outline_rounded,
                  onChanged: (val) {
                    state.updateNotificationSettings(
                      settings.copyWith(alertOnRestore: val),
                    );
                  },
                ),

                const Divider(height: 20),

                // Sound & Vibration
                _buildSwitchTile(
                  context,
                  title: state.tr('sound_vibration'),
                  subtitle: state.tr('sound_vibration_desc'),
                  value: settings.soundEnabled,
                  icon: Icons.volume_up_outlined,
                  onChanged: (val) {
                    state.updateNotificationSettings(
                      settings.copyWith(
                        soundEnabled: val,
                        vibrationEnabled: val,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildSwitchTile(
    BuildContext context, {
    required String title,
    required String subtitle,
    required bool value,
    required IconData icon,
    required ValueChanged<bool> onChanged,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Row(
      children: [
        Icon(icon, size: 22, color: Theme.of(context).colorScheme.primary),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 11,
                  color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B),
                ),
              ),
            ],
          ),
        ),
        Switch.adaptive(
          value: value,
          onChanged: onChanged,
          activeColor: Theme.of(context).colorScheme.primary,
        ),
      ],
    );
  }
}
