import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/theme/app_colors.dart';
import '../onboarding_provider.dart';

class UseCaseScreen extends ConsumerStatefulWidget {
  const UseCaseScreen({super.key});

  @override
  ConsumerState<UseCaseScreen> createState() => _UseCaseScreenState();
}

class _UseCaseScreenState extends ConsumerState<UseCaseScreen> {
  final ScrollController _scrollController = ScrollController();

  // Configuration - Tuned for 70% Screen Height
  static const double _itemExtent = 240.0;
  static const double _minCardHeight = 110.0;
  static const double _maxCardHeight = 300.0;

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final onboardingState = ref.watch(onboardingProvider);

    // Dynamic padding calculation removed here as it is handled in LayoutBuilder below

    final useCases = [
      {
        'id': 'govt',
        'title': 'Government',
        'items': ['Adhaar', 'Pan', 'Ration'],
      },
      {
        'id': 'bills',
        'title': 'Pay Bills',
        'items': ['Electric', 'Mobile', 'Gas'],
      },
      {
        'id': 'health',
        'title': 'Health',
        'items': ['Doctors', 'Schemes', 'Others'],
      },
      {
        'id': 'education',
        'title': 'Education',
        'items': ['Scholarships', 'Jobs', 'Updates'],
      },
      {
        'id': 'bank',
        'title': 'Bank',
        'items': ['Bank Account', 'Loans', 'Pension'],
      },
      {
        'id': 'others',
        'title': 'Others',
        'items': ['General Help', 'Information'],
      },
    ];

    return Scaffold(
      backgroundColor: AppColors.orange,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // 1. Upper Half: Orange Background with Centered Text
          Expanded(
            flex: 3,
            child: Center(
              child: _UseCaseHeader(userName: onboardingState.userName),
            ),
          ),

          // 2. Lower Half: Scrollable Body
          Expanded(
            flex: 7,
            child: LayoutBuilder(
              builder: (context, constraints) {
                final double viewportHeight = constraints.maxHeight;
                final double verticalPadding =
                    (viewportHeight / 2) - (_itemExtent / 2);

                return Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Color(0xFFFBF4E2), // Cream Background
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(60),
                    ),
                  ),
                  clipBehavior: Clip.hardEdge,
                  child: Stack(
                    children: [
                      // The Renderer
                      AnimatedBuilder(
                        animation: _scrollController,
                        builder: (context, child) {
                          return _buildScrollableContent(
                            context,
                            useCases,
                            onboardingState,
                            verticalPadding,
                            viewportHeight,
                          );
                        },
                      ),

                      // The Driver
                      ListView.builder(
                        controller: _scrollController,
                        physics: const SnappingScrollPhysics(
                          itemHeight: _itemExtent,
                        ),
                        padding: EdgeInsets.symmetric(
                          vertical: verticalPadding,
                        ),
                        itemCount: useCases.length,
                        itemExtent: _itemExtent,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              ref
                                  .read(onboardingProvider.notifier)
                                  .toggleUseCase(
                                    useCases[index]['id'] as String,
                                  );
                            },
                            behavior: HitTestBehavior.opaque,
                            child: Container(color: Colors.transparent),
                          );
                        },
                      ),

                      // FAB Overlay
                      Positioned(
                        bottom: 30,
                        right: 30,
                        child: onboardingState.selectedUseCases.isNotEmpty
                            ? GestureDetector(
                                onTap: () {
                                  ref
                                      .read(onboardingProvider.notifier)
                                      .nextPage();
                                },
                                child: Container(
                                  width: 64,
                                  height: 64,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.1),
                                        blurRadius: 10,
                                        offset: const Offset(0, 4),
                                      ),
                                    ],
                                  ),
                                  child: const Icon(
                                    Icons.arrow_forward,
                                    color: Colors.black,
                                    size: 28,
                                  ),
                                ),
                              ).animate().scale(
                                duration: 300.ms,
                                curve: Curves.easeOutBack,
                              )
                            : const SizedBox(),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScrollableContent(
    BuildContext context,
    List<Map<String, Object>> useCases,
    onboardingState,
    double verticalPadding,
    double viewportHeight,
  ) {
    // FIX: Do not return SizedBox if no clients. Render initial state at offset 0.
    final double scrollOffset = _scrollController.hasClients
        ? _scrollController.offset
        : 0.0;

    // Viewport comes from LayoutBuilder now
    final double centerOffset = viewportHeight / 2;

    List<Widget> cardWidgets = [];

    for (int i = 0; i < useCases.length; i++) {
      final double itemCenterY =
          (i * _itemExtent) + (_itemExtent / 2) + verticalPadding;
      final double distFromCenter = (itemCenterY - scrollOffset - centerOffset)
          .abs();

      // Curve matches item extent for natural scaling
      final double normalizedDist = (distFromCenter / 240).clamp(0.0, 1.0);

      final double t = 1.0 - normalizedDist;
      final double curvedT = Curves.easeOutCubic.transform(t);

      // Height Calculation
      final double currentHeight =
          _minCardHeight + (_maxCardHeight - _minCardHeight) * curvedT;

      const double currentWidthScale = 1.0;

      // Opacity: User requested removing fade, so keeping it solid
      const double currentOpacity = 1.0;

      final double drawTop = (i * _itemExtent) + verticalPadding - scrollOffset;
      final double drawY = drawTop + (_itemExtent - currentHeight) / 2;

      // Skip rendering items far off screen (add buffer)
      if (drawY > viewportHeight + 50 || drawY + currentHeight < -50) continue;

      cardWidgets.add(
        Positioned(
          top: drawY,
          left: 24,
          right: 24,
          height: currentHeight,
          child: Transform.scale(
            scaleX: currentWidthScale,
            alignment: Alignment.center,
            child: Opacity(
              opacity: currentOpacity,
              child: UseCaseCardItem(
                useCase: useCases[i],
                isSelected: onboardingState.selectedUseCases.contains(
                  useCases[i]['id'],
                ),
                onTap: () => ref
                    .read(onboardingProvider.notifier)
                    .toggleUseCase(useCases[i]['id'] as String),
                isExpanded: curvedT > 0.8, // Only expand if very central
                focusValue: curvedT,
              ),
            ),
          ),
        ),
      );
    }

    return Stack(children: cardWidgets);
  }
}

class UseCaseCardItem extends StatelessWidget {
  final Map<String, Object> useCase;
  final bool isSelected;
  final VoidCallback onTap;
  final bool isExpanded;
  final double focusValue;

  const UseCaseCardItem({
    super.key, // Added super.key for best practice
    required this.useCase,
    required this.isSelected,
    required this.onTap,
    required this.isExpanded,
    required this.focusValue,
  });

  @override
  Widget build(BuildContext context) {
    final items = useCase['items'] as List<String>;
    final textColor = const Color(0xFFE65100);

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(
          horizontal: 24,
          vertical: isExpanded ? 24 : 16,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(32),
          border: isSelected
              ? Border.all(color: AppColors.orange, width: 3)
              : null,
          boxShadow: [
            BoxShadow(
              color: AppColors.orange.withOpacity(0.15 * focusValue),
              blurRadius: 16 * focusValue,
              offset: Offset(0, 8 * focusValue),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    useCase['title'] as String,
                    style: GoogleFonts.poppins(
                      fontSize: 20 + (4 * focusValue),
                      fontWeight: FontWeight.bold,
                      color: AppColors.orange,
                    ),
                  ),
                ),
                if (isSelected)
                  const Icon(Icons.check_circle, color: AppColors.orange),
              ],
            ),

            if (isExpanded) ...[
              const Spacer(),
              for (var item in items)
                Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Row(
                    children: [
                      const CircleAvatar(
                        radius: 4,
                        backgroundColor: AppColors.orange,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        item,
                        style: GoogleFonts.poppins(
                          fontSize: 15,
                          color: textColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              const Spacer(),
            ],
          ],
        ),
      ),
    );
  }
}

class _UseCaseHeader extends StatelessWidget {
  final String? userName;
  const _UseCaseHeader({this.userName});

  @override
  Widget build(BuildContext context) {
    return Padding(
      // Removed top/bottom padding to let the parent Center widget handle alignment
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        mainAxisSize: MainAxisSize.min, // Use minimum size for centering
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            userName != null && userName!.isNotEmpty ? userName! : 'User',
            style: GoogleFonts.poppins(
              fontSize: 64,
              height: 1.0,
              fontWeight: FontWeight.w900,
              color: const Color(0xFFFBF4E2),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'What can I do for you?',
            style: GoogleFonts.poppins(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

class SnappingScrollPhysics extends ScrollPhysics {
  final double itemHeight;

  const SnappingScrollPhysics({super.parent, required this.itemHeight});

  @override
  SnappingScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return SnappingScrollPhysics(
      parent: buildParent(ancestor),
      itemHeight: itemHeight,
    );
  }

  @override
  Simulation? createBallisticSimulation(
    ScrollMetrics position,
    double velocity,
  ) {
    // If we're out of range, defer to parent (bouncing/clamping)
    if ((velocity <= 0.0 && position.pixels <= position.minScrollExtent) ||
        (velocity >= 0.0 && position.pixels >= position.maxScrollExtent)) {
      return super.createBallisticSimulation(position, velocity);
    }

    final Tolerance tolerance = this.toleranceFor(position);
    final double target = _getTargetPixels(position, velocity, tolerance);

    if (target != position.pixels) {
      return ScrollSpringSimulation(
        spring,
        position.pixels,
        target,
        velocity,
        tolerance: tolerance,
      );
    }
    return null;
  }

  double _getTargetPixels(
    ScrollMetrics position,
    double velocity,
    Tolerance tolerance,
  ) {
    double page = position.pixels / itemHeight;
    if (velocity < -tolerance.velocity) {
      page -= 0.5;
    } else if (velocity > tolerance.velocity) {
      page += 0.5;
    }
    return page.roundToDouble() * itemHeight;
  }
}
