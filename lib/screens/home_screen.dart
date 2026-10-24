import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/location_schedule.dart';
import '../providers/app_state.dart';
import '../theme/app_theme.dart';
import '../widgets/segmented_timeline_bar.dart';
import 'settings_screen.dart';
import 'region_select_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();
    final accentColor = AppTheme.getAccentColor(state.accentColor);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // Date formatting in Ukrainian uppercase (as in screenshot: "24 ЖОВТНЯ, СУБОТА")
    const dateText = '24 ЖОВТНЯ, СУБОТА';

    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          children: [
            // Top Header: Date + Settings Gear
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  dateText,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF8E8E93),
                    letterSpacing: 0.6,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const SettingsScreen(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.settings_outlined, size: 24),
                  color: isDark ? Colors.white : Colors.black,
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ],
            ),

            const SizedBox(height: 6),

            // Big Bold Title: "Є Вода"
            Text(
              state.tr('app_name'),
              style: TextStyle(
                fontSize: 34,
                fontWeight: FontWeight.w900,
                color: isDark ? Colors.white : Colors.black,
                letterSpacing: -0.5,
              ),
            ),

            const SizedBox(height: 16),

            // Location Cards List
            ...state.locations.map((loc) {
              return _buildLocationCard(context, state, loc, accentColor, isDark);
            }).toList(),

            const SizedBox(height: 8),

            // "+ Додати графік" Button Card (Exact look from Screenshot 5)
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const RegionSelectScreen(),
                  ),
                );
              },
              borderRadius: BorderRadius.circular(20),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 18),
                decoration: BoxDecoration(
                  color: isDark ? const Color(0xFF161618) : Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isDark ? const Color(0xFF242426) : const Color(0xFFE5E5EA),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.add_rounded,
                      size: 22,
                      color: isDark ? Colors.white : Colors.black,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      state.tr('add_schedule'),
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: isDark ? Colors.white : Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildLocationCard(
    BuildContext context,
    AppState state,
    LocationSchedule loc,
    Color accentColor,
    bool isDark,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF161618) : Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: isDark ? const Color(0xFF242426) : const Color(0xFFE5E5EA),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row: "ДІМ" (left) | "черга 15.1" (right)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                loc.label,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF8E8E93),
                  letterSpacing: 1.0,
                ),
              ),
              Text(
                loc.queue,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF8E8E93),
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // Status Row: "● Вода є"
          Row(
            children: [
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: loc.hasWater ? accentColor : const Color(0xFF8E8E93),
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 10),
              Text(
                loc.statusText,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: isDark ? Colors.white : Colors.black,
                ),
              ),
            ],
          ),

          const SizedBox(height: 4),

          // Subtitle: "вимкнуть о 16:00"
          Padding(
            padding: const EdgeInsets.only(left: 22),
            child: Text(
              loc.nextEventTimeText,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: isDark ? const Color(0xFFE5E5EA) : const Color(0xFF3C3C43),
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Capsule Segmented Timeline Bar
          SegmentedTimelineBar(
            hourlyStatus: loc.hourlyWaterStatus,
            activeColor: accentColor,
            inactiveColor: isDark ? const Color(0xFF2C2C30) : const Color(0xFFD1D1D6),
          ),

          const SizedBox(height: 14),

          // Address Line: "вул. Голего Миколи, 7В • Київ"
          Text(
            loc.address,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Color(0xFF8E8E93),
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
