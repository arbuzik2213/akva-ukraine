import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../localization/app_strings.dart';
import '../providers/app_state.dart';
import '../theme/app_theme.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final accentColor = AppTheme.getAccentColor(state.accentColor);

    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          children: [
            // Top Navigation Bar: "< Графіки"
            Row(
              children: [
                TextButton.icon(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(
                    Icons.arrow_back_ios_new_rounded,
                    size: 16,
                    color: isDark ? Colors.white : Colors.black,
                  ),
                  label: Text(
                    state.tr('back_schedules'),
                    style: TextStyle(
                      fontSize: 16,
                      color: isDark ? Colors.white : Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),

            // Big Bold Title: "Налаштування"
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Text(
                state.tr('settings_title'),
                style: TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.w900,
                  color: isDark ? Colors.white : Colors.black,
                ),
              ),
            ),

            const SizedBox(height: 20),

            // 1. ВИГЛЯД (Appearance)
            _buildSectionHeader(state.tr('section_appearance')),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: _cardDecoration(isDark),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Segmented Theme Selector [ Авто | Світла | Темна | Чорна ]
                  Container(
                    decoration: BoxDecoration(
                      color: isDark ? const Color(0xFF0C0C0E) : const Color(0xFFE5E5EA),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.all(3),
                    child: Row(
                      children: [
                        _buildThemeSegment(context, state, AppAppearance.auto, state.tr('theme_auto'), isDark),
                        _buildThemeSegment(context, state, AppAppearance.light, state.tr('theme_light'), isDark),
                        _buildThemeSegment(context, state, AppAppearance.dark, state.tr('theme_dark'), isDark),
                        _buildThemeSegment(context, state, AppAppearance.black, state.tr('theme_black'), isDark),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Колір (Color Circles)
                  Text(
                    state.tr('color_title'),
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: isDark ? Colors.white : Colors.black,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildColorDot(state, AppAccentColor.yellow, const Color(0xFFFFB800)),
                      _buildColorDot(state, AppAccentColor.orange, const Color(0xFFFF9500)),
                      _buildColorDot(state, AppAccentColor.green, const Color(0xFF34C759)),
                      _buildColorDot(state, AppAccentColor.blue, const Color(0xFF007AFF)),
                      _buildColorDot(state, AppAccentColor.purple, const Color(0xFFAF52DE)),
                      _buildColorDot(state, AppAccentColor.pink, const Color(0xFFFF2D55)),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // Іконка застосунку
                  Text(
                    state.tr('app_icon_title'),
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: isDark ? Colors.white : Colors.black,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _buildIconGrid(state, isDark),

                  const SizedBox(height: 12),
                  Text(
                    state.tr('app_icon_note'),
                    style: const TextStyle(fontSize: 12, color: Color(0xFF8E8E93), height: 1.3),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // 2. ВІДЖЕТ (Widget)
            _buildSectionHeader(state.tr('section_widget')),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: _cardDecoration(isDark),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: isDark ? const Color(0xFF0C0C0E) : const Color(0xFFE5E5EA),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.all(3),
                    child: Row(
                      children: [
                        _buildWidgetSegment(context, state, 'theme', state.tr('widget_as_theme'), isDark),
                        _buildWidgetSegment(context, state, 'transparent', state.tr('widget_transparent'), isDark),
                        _buildWidgetSegment(context, state, 'colored', state.tr('widget_colored'), isDark),
                      ],
                    ),
                  ),
                  const SizedBox(height: 14),
                  Text(
                    state.tr('widget_desc'),
                    style: const TextStyle(fontSize: 12, color: Color(0xFF8E8E93), height: 1.4),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // 3. МОВА (Language - Screenshots 1 & 2)
            _buildSectionHeader(state.tr('section_language')),
            Container(
              decoration: _cardDecoration(isDark),
              child: Column(
                children: AppStrings.supportedLanguages.map((code) {
                  final isSelected = state.languageCode == code;
                  final label = AppStrings.languageNames[code] ?? code;
                  return Column(
                    children: [
                      ListTile(
                        title: Text(
                          label,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: isDark ? Colors.white : Colors.black,
                          ),
                        ),
                        trailing: isSelected
                            ? const Icon(Icons.check, size: 20, color: Colors.white)
                            : null,
                        onTap: () => state.setLanguageCode(code),
                      ),
                      if (code != AppStrings.supportedLanguages.last)
                        Divider(
                          height: 1,
                          color: isDark ? const Color(0xFF242426) : const Color(0xFFE5E5EA),
                          indent: 16,
                        ),
                    ],
                  );
                }).toList(),
              ),
            ),

            const SizedBox(height: 24),

            // 4. НАГАДУВАННЯ (Reminders / SMS Alerts)
            _buildSectionHeader(state.tr('section_notifications')),
            Container(
              decoration: _cardDecoration(isDark),
              child: Column(
                children: [
                  SwitchListTile.adaptive(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    title: Text(
                      state.tr('notify_emergency'),
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: isDark ? Colors.white : Colors.black,
                      ),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Text(
                        state.tr('notify_emergency_sub'),
                        style: const TextStyle(fontSize: 12, color: Color(0xFF8E8E93)),
                      ),
                    ),
                    value: state.notifyEmergency,
                    activeColor: accentColor,
                    onChanged: (val) => state.setNotifyEmergency(val),
                  ),
                  Divider(
                    height: 1,
                    color: isDark ? const Color(0xFF242426) : const Color(0xFFE5E5EA),
                    indent: 16,
                  ),
                  SwitchListTile.adaptive(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    title: Text(
                      state.tr('notify_before'),
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: isDark ? Colors.white : Colors.black,
                      ),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Text(
                        state.tr('notify_before_sub'),
                        style: const TextStyle(fontSize: 12, color: Color(0xFF8E8E93)),
                      ),
                    ),
                    value: state.notifyBefore,
                    activeColor: accentColor,
                    onChanged: (val) => state.setNotifyBefore(val),
                  ),
                  Divider(
                    height: 1,
                    color: isDark ? const Color(0xFF242426) : const Color(0xFFE5E5EA),
                    indent: 16,
                  ),
                  ListTile(
                    leading: Icon(Icons.sms_outlined, color: accentColor),
                    title: Text(
                      state.tr('send_test_sms'),
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: isDark ? Colors.white : Colors.black,
                      ),
                    ),
                    subtitle: const Text(
                      'Тест нагадування за 30 хв та 10 хв',
                      style: TextStyle(fontSize: 11, color: Color(0xFF8E8E93)),
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 14, color: Color(0xFF8E8E93)),
                    onTap: () {
                      state.triggerTestAlert();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Тестове сповіщення відправлено на телефон!'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // 5. ГРАФІК (Schedule settings)
            _buildSectionHeader(state.tr('section_schedule')),
            Container(
              decoration: _cardDecoration(isDark),
              child: SwitchListTile.adaptive(
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                title: Text(
                  state.tr('show_tomorrow'),
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: isDark ? Colors.white : Colors.black,
                  ),
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(
                    state.tr('show_tomorrow_sub'),
                    style: const TextStyle(fontSize: 12, color: Color(0xFF8E8E93)),
                  ),
                ),
                value: state.showTomorrow,
                activeColor: accentColor,
                onChanged: (val) => state.setShowTomorrow(val),
              ),
            ),

            const SizedBox(height: 24),

            // 6. ДАНІ (Data / Cache)
            _buildSectionHeader(state.tr('section_data')),
            Container(
              decoration: _cardDecoration(isDark),
              child: ListTile(
                title: Text(
                  state.tr('clear_cache'),
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: isDark ? Colors.white : Colors.black,
                  ),
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(
                    state.tr('clear_cache_sub'),
                    style: const TextStyle(fontSize: 12, color: Color(0xFF8E8E93)),
                  ),
                ),
                onTap: () {
                  state.clearSavedSchedules();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.tr('cache_cleared')),
                      duration: const Duration(seconds: 2),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 24),

            // 7. ПРО ЗАСТОСУНОК (About App)
            _buildSectionHeader(state.tr('section_about')),
            Container(
              decoration: _cardDecoration(isDark),
              child: Column(
                children: [
                  ListTile(
                    title: Text(
                      state.tr('version'),
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: isDark ? Colors.white : Colors.black,
                      ),
                    ),
                    trailing: Text(
                      state.tr('version_value'),
                      style: const TextStyle(fontSize: 15, color: Color(0xFF8E8E93)),
                    ),
                  ),
                  Divider(
                    height: 1,
                    color: isDark ? const Color(0xFF242426) : const Color(0xFFE5E5EA),
                    indent: 16,
                  ),
                  ListTile(
                    title: Text(
                      state.tr('sources_title'),
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: isDark ? Colors.white : Colors.black,
                      ),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Text(
                        state.tr('sources_sub'),
                        style: const TextStyle(fontSize: 12, color: Color(0xFF8E8E93), height: 1.4),
                      ),
                    ),
                  ),
                  Divider(
                    height: 1,
                    color: isDark ? const Color(0xFF242426) : const Color(0xFFE5E5EA),
                    indent: 16,
                  ),
                  ListTile(
                    title: Text(
                      state.tr('code_github'),
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: isDark ? Colors.white : Colors.black,
                      ),
                    ),
                    trailing: const Icon(Icons.arrow_outward_rounded, size: 18, color: Color(0xFF8E8E93)),
                    onTap: () {},
                  ),
                ],
              ),
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 8),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w700,
          color: Color(0xFF8E8E93),
          letterSpacing: 0.8,
        ),
      ),
    );
  }

  BoxDecoration _cardDecoration(bool isDark) {
    return BoxDecoration(
      color: isDark ? const Color(0xFF161618) : Colors.white,
      borderRadius: BorderRadius.circular(20),
      border: Border.all(
        color: isDark ? const Color(0xFF242426) : const Color(0xFFE5E5EA),
      ),
    );
  }

  Widget _buildThemeSegment(
    BuildContext context,
    AppState state,
    AppAppearance target,
    String label,
    bool isDark,
  ) {
    final isSelected = state.appearance == target;
    return Expanded(
      child: GestureDetector(
        onTap: () => state.setAppearance(target),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: isSelected
                ? (isDark ? const Color(0xFF262628) : Colors.white)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.15),
                      blurRadius: 4,
                      offset: const Offset(0, 1),
                    ),
                  ]
                : null,
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: TextStyle(
              fontSize: 13,
              fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
              color: isSelected
                  ? (isDark ? Colors.white : Colors.black)
                  : const Color(0xFF8E8E93),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildWidgetSegment(
    BuildContext context,
    AppState state,
    String target,
    String label,
    bool isDark,
  ) {
    final isSelected = state.widgetStyle == target;
    return Expanded(
      child: GestureDetector(
        onTap: () => state.setWidgetStyle(target),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: isSelected
                ? (isDark ? const Color(0xFF262628) : Colors.white)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.15),
                      blurRadius: 4,
                      offset: const Offset(0, 1),
                    ),
                  ]
                : null,
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: TextStyle(
              fontSize: 13,
              fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
              color: isSelected
                  ? (isDark ? Colors.white : Colors.black)
                  : const Color(0xFF8E8E93),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildColorDot(AppState state, AppAccentColor color, Color displayColor) {
    final isSelected = state.accentColor == color;
    return GestureDetector(
      onTap: () => state.setAccentColor(color),
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: displayColor,
          shape: BoxShape.circle,
        ),
        child: isSelected
            ? const Icon(Icons.check, color: Colors.black, size: 20)
            : null,
      ),
    );
  }

  Widget _buildIconGrid(AppState state, bool isDark) {
    final icons = [
      {'name': state.tr('icon_classic'), 'color': const Color(0xFFFFB800)},
      {'name': state.tr('icon_orange'), 'color': const Color(0xFFFF9500)},
      {'name': state.tr('icon_green'), 'color': const Color(0xFF34C759)},
      {'name': state.tr('icon_blue'), 'color': const Color(0xFF007AFF)},
      {'name': state.tr('icon_purple'), 'color': const Color(0xFFAF52DE)},
      {'name': state.tr('icon_pink'), 'color': const Color(0xFFFF2D55)},
      {'name': state.tr('icon_light'), 'color': Colors.white},
      {'name': state.tr('icon_sunny'), 'color': const Color(0xFFFFCC00)},
    ];

    return Wrap(
      spacing: 12,
      runSpacing: 14,
      children: List.generate(icons.length, (i) {
        final item = icons[i];
        final isSelected = state.selectedIconIndex == i;
        final color = item['color'] as Color;

        return GestureDetector(
          onTap: () => state.setSelectedIconIndex(i),
          child: SizedBox(
            width: 70,
            child: Column(
              children: [
                Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    color: isDark ? const Color(0xFF0C0C0E) : const Color(0xFFE5E5EA),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: isSelected ? Colors.white : Colors.transparent,
                      width: 2,
                    ),
                  ),
                  child: Center(
                    child: Container(
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: color, width: 3),
                      ),
                      child: Center(
                        child: Container(
                          width: 6,
                          height: 6,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  item['name'] as String,
                  style: const TextStyle(fontSize: 10, color: Color(0xFF8E8E93)),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
