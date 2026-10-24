import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/water_point.dart';
import '../providers/app_state.dart';

class WaterPointsScreen extends StatefulWidget {
  const WaterPointsScreen({super.key});

  @override
  State<WaterPointsScreen> createState() => _WaterPointsScreenState();
}

class _WaterPointsScreenState extends State<WaterPointsScreen> {
  int _selectedFilter = 0; // 0: All, 1: Buvette, 2: Tanker, 3: Resilience

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final filteredPoints = state.waterPoints.where((p) {
      if (_selectedFilter == 1) return p.type == WaterPointType.buvette;
      if (_selectedFilter == 2) return p.type == WaterPointType.tanker;
      if (_selectedFilter == 3) return p.type == WaterPointType.resilienceHub;
      return true;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          state.tr('tab_points'),
          style: const TextStyle(fontWeight: FontWeight.w800),
        ),
      ),
      body: Column(
        children: [
          // Filter Chips
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                _buildFilterChip(0, state.tr('filter_all')),
                const SizedBox(width: 8),
                _buildFilterChip(1, state.tr('point_type_buvette')),
                const SizedBox(width: 8),
                _buildFilterChip(2, state.tr('point_type_tanker')),
                const SizedBox(width: 8),
                _buildFilterChip(3, state.tr('point_type_invincible')),
              ],
            ),
          ),

          // Points List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: filteredPoints.length,
              itemBuilder: (context, index) {
                final point = filteredPoints[index];
                return _buildPointCard(context, state, point, isDark);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(int index, String label) {
    final isSelected = _selectedFilter == index;
    return ChoiceChip(
      label: Text(label, style: const TextStyle(fontSize: 12)),
      selected: isSelected,
      onSelected: (_) {
        setState(() {
          _selectedFilter = index;
        });
      },
    );
  }

  Widget _buildPointCard(
    BuildContext context,
    AppState state,
    WaterPoint point,
    bool isDark,
  ) {
    IconData typeIcon;
    Color typeColor;
    String typeName;

    switch (point.type) {
      case WaterPointType.buvette:
        typeIcon = Icons.opacity_rounded;
        typeColor = const Color(0xFF0284C7);
        typeName = state.tr('point_type_buvette');
        break;
      case WaterPointType.tanker:
        typeIcon = Icons.local_shipping_outlined;
        typeColor = const Color(0xFFF59E0B);
        typeName = state.tr('point_type_tanker');
        break;
      case WaterPointType.resilienceHub:
        typeIcon = Icons.shield_outlined;
        typeColor = const Color(0xFF10B981);
        typeName = state.tr('point_type_invincible');
        break;
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Theme.of(context).cardTheme.color,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isDark ? const Color(0xFF1E293B) : const Color(0xFFE2E8F0),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: typeColor.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(typeIcon, color: typeColor, size: 22),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          typeName,
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: typeColor,
                          ),
                        ),
                        const Spacer(),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: const Color(0xFF10B981).withOpacity(0.12),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            state.tr('open_now'),
                            style: const TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF10B981),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      point.name,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      point.address,
                      style: TextStyle(
                        fontSize: 12,
                        color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 14),

          // Working hours & distance row
          Row(
            children: [
              Icon(Icons.schedule, size: 14, color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B)),
              const SizedBox(width: 4),
              Text(
                point.workingHours,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                  color: isDark ? const Color(0xFFCBD5E1) : const Color(0xFF475569),
                ),
              ),
              const Spacer(),
              Icon(Icons.near_me_outlined, size: 14, color: Theme.of(context).colorScheme.primary),
              const SizedBox(width: 4),
              Text(
                '${point.distanceKm} км',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          // Quality note
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF1E293B) : const Color(0xFFF1F5F9),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                const Icon(Icons.verified_user_outlined, size: 14, color: Color(0xFF10B981)),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    point.waterQualityNote,
                    style: TextStyle(
                      fontSize: 10,
                      color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF475569),
                    ),
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
