import 'package:flutter/material.dart';

class SegmentedTimelineBar extends StatelessWidget {
  final List<bool> hourlyStatus; // 24 values
  final Color activeColor;
  final Color inactiveColor;

  const SegmentedTimelineBar({
    super.key,
    required this.hourlyStatus,
    this.activeColor = const Color(0xFFFFB800),
    this.inactiveColor = const Color(0xFF2C2C30),
  });

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    // Calculate current progress across 24 hours: 0.0 to 1.0
    final currentFraction = (now.hour * 60 + now.minute) / (24 * 60);

    return LayoutBuilder(
      builder: (context, constraints) {
        final totalWidth = constraints.maxWidth;
        final count = hourlyStatus.length;
        const spacing = 3.0;
        final totalSpacing = spacing * (count - 1);
        final segmentWidth = (totalWidth - totalSpacing) / count;

        final scrubberX = (currentFraction * totalWidth).clamp(0.0, totalWidth);

        return SizedBox(
          height: 22,
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.centerLeft,
            children: [
              // Segmented pills
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(count, (index) {
                  final isWaterOn = hourlyStatus[index];
                  return Container(
                    width: segmentWidth,
                    height: 12,
                    decoration: BoxDecoration(
                      color: isWaterOn ? activeColor : inactiveColor,
                      borderRadius: BorderRadius.circular(3),
                    ),
                  );
                }),
              ),

              // Current time scrubber (White vertical needle from screenshot)
              Positioned(
                left: scrubberX - 1.5,
                top: 0,
                bottom: 0,
                child: Container(
                  width: 3,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(2),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        blurRadius: 4,
                        offset: const Offset(0, 1),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
