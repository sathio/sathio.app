import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

/// Skeleton shimmer placeholders per UI_UX.md Section 8.6.
/// Dark mode: gradient #1A1A1A → #2A2A2A → #1A1A1A
/// Light mode: gradient #E8E8E8 → #F5F5F5 → #E8E8E8

class SkeletonShimmer extends StatelessWidget {
  final double width;
  final double height;
  final double borderRadius;
  final bool isDark;

  const SkeletonShimmer({
    super.key,
    required this.width,
    required this.height,
    this.borderRadius = 8,
    this.isDark = true,
  });

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final dark = isDark || brightness == Brightness.dark;
    final baseColor = dark ? const Color(0xFF1A1A1A) : const Color(0xFFE8E8E8);
    final shimmerColor = dark
        ? const Color(0xFF2A2A2A)
        : const Color(0xFFF5F5F5);

    return Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: baseColor,
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        )
        .animate(onPlay: (c) => c.repeat())
        .shimmer(
          duration: 1200.ms,
          colors: [baseColor, shimmerColor, baseColor],
          angle: 0.5,
        );
  }
}

/// Skeleton shaped like a card.
class SkeletonCard extends StatelessWidget {
  final double height;
  final bool isDark;

  const SkeletonCard({super.key, this.height = 120, this.isDark = true});

  @override
  Widget build(BuildContext context) {
    return SkeletonShimmer(
      width: double.infinity,
      height: height,
      borderRadius: 16,
      isDark: isDark,
    );
  }
}

/// Skeleton for a single line of text.
class SkeletonText extends StatelessWidget {
  final double width;
  final double height;
  final bool isDark;

  const SkeletonText({
    super.key,
    this.width = 200,
    this.height = 14,
    this.isDark = true,
  });

  @override
  Widget build(BuildContext context) {
    return SkeletonShimmer(
      width: width,
      height: height,
      borderRadius: 4,
      isDark: isDark,
    );
  }
}

/// Skeleton for a circular avatar.
class SkeletonAvatar extends StatelessWidget {
  final double size;
  final bool isDark;

  const SkeletonAvatar({super.key, this.size = 48, this.isDark = true});

  @override
  Widget build(BuildContext context) {
    return SkeletonShimmer(
      width: size,
      height: size,
      borderRadius: size / 2,
      isDark: isDark,
    );
  }
}

/// Skeleton list with multiple rows mimicking a typical feed layout.
class SkeletonList extends StatelessWidget {
  final int itemCount;
  final bool isDark;

  const SkeletonList({super.key, this.itemCount = 5, this.isDark = true});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(itemCount, (index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            children: [
              SkeletonAvatar(size: 40, isDark: isDark),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SkeletonText(
                      width: double.infinity,
                      height: 14,
                      isDark: isDark,
                    ),
                    const SizedBox(height: 8),
                    SkeletonText(width: 160, height: 12, isDark: isDark),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
