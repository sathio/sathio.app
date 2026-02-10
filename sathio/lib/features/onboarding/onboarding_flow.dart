import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme/app_colors.dart';

import 'screens/start_screen.dart';
import 'screens/language_screen.dart';
import 'screens/auth_screen.dart';
import 'screens/use_case_screen.dart';
import 'screens/voice_demo_screen.dart';
import 'screens/permission_screen.dart';
import 'screens/quick_win_screen.dart';
import 'screens/profile_setup_screen.dart';
import 'onboarding_provider.dart';
import 'transitions/circle_reveal_clipper.dart';
import 'transitions/rounded_card_clipper.dart';
import 'transitions/center_squircle_clipper.dart';

class OnboardingFlow extends ConsumerStatefulWidget {
  const OnboardingFlow({super.key});

  @override
  ConsumerState<OnboardingFlow> createState() => _OnboardingFlowState();
}

class _OnboardingFlowState extends ConsumerState<OnboardingFlow>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  int _currentIndex = 0;
  int _targetIndex = -1;
  bool _isForward = true;
  bool _isAnimating = false;

  Widget _buildScreen(int index) {
    switch (index) {
      case 0:
        return const StartScreen();
      case 1:
        return const LanguageScreen();
      case 2:
        return const AuthScreen();
      case 3:
        return const ProfileSetupScreen();
      case 4:
        return const UseCaseScreen();
      case 5:
        return const VoiceDemoScreen();
      case 6:
        return const PermissionScreen();
      case 7:
        return const QuickWinScreen();
      default:
        return const StartScreen();
    }
  }

  @override
  void initState() {
    super.initState();
    _currentIndex = ref.read(onboardingProvider).currentIndex;

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOutCubic,
    );

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          _currentIndex = _targetIndex;
          _targetIndex = -1;
          _isAnimating = false;
        });
        _controller.reset();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _startTransition(int newIndex) {
    if (_isAnimating) return;

    _isForward = newIndex > _currentIndex;
    _targetIndex = newIndex;
    _isAnimating = true;
    setState(() {});

    // Start animation AFTER the overlay widget is in the tree
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted && _isAnimating) {
        _controller.forward(from: 0.0);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(onboardingProvider, (previous, next) {
      if (previous != null && previous.currentIndex != next.currentIndex) {
        _startTransition(next.currentIndex);
      }
    });

    final bool showBackButton =
        _currentIndex > 0 || (_isAnimating && _targetIndex > 0);

    return Scaffold(
      backgroundColor: const Color(0xFFFBF4E2),
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Layer 1: Current screen (base)
          KeyedSubtree(
            key: ValueKey('base_$_currentIndex'),
            child: _buildScreen(_currentIndex),
          ),

          // Layer 2: Solid colored shape expanding
          if (_isAnimating && _targetIndex >= 0)
            AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                final double t = _animation.value;

                if (!_isForward) {
                  // Backward: slide from left + fade
                  final w = MediaQuery.of(context).size.width;
                  return Transform.translate(
                    offset: Offset(-w * (1.0 - t), 0),
                    child: Opacity(opacity: t, child: child),
                  );
                }

                // Forward two-phase:
                // Phase 1 (t: 0.0 → 0.5): Solid shape expands to fill screen
                // Phase 2 (t: 0.5 → 1.0): New screen fades in over the solid color
                final double shapeT = (t / 0.5).clamp(0.0, 1.0);
                final double fadeT = ((t - 0.5) / 0.5).clamp(0.0, 1.0);

                return ClipPath(
                  clipper: _getClipper(_currentIndex, _targetIndex, shapeT),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      // Solid color fills the clipped area
                      Container(
                        color: _getShapeColor(_currentIndex, _targetIndex),
                      ),
                      // New screen fades in on top of the solid color
                      if (fadeT > 0) Opacity(opacity: fadeT, child: child),
                    ],
                  ),
                );
              },
              child: KeyedSubtree(
                key: ValueKey('incoming_$_targetIndex'),
                child: _buildScreen(_targetIndex),
              ),
            ),

          // Layer 3: Back button overlay
          if (showBackButton)
            Positioned(
              top: 0,
              left: 16,
              child: SafeArea(
                child: GestureDetector(
                  onTap: () {
                    if (!_isAnimating) {
                      ref.read(onboardingProvider.notifier).previousPage();
                    }
                  },
                  child: Container(
                    margin: const EdgeInsets.only(top: 8),
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.12),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.arrow_back,
                      color: Colors.black87,
                      size: 20,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  CustomClipper<Path> _getClipper(int fromIndex, int toIndex, double t) {
    // 0 -> 1: Circle Reveal from the "Get Started" button
    if (fromIndex == 0 && toIndex == 1) {
      final size = MediaQuery.of(context).size;
      return CircleRevealClipper(
        revealPercent: t,
        centerOffset: Offset(size.width / 2, size.height * 0.85),
      );
    }

    // 1 -> 2: Rounded Card sliding up from bottom
    if (fromIndex == 1 && toIndex == 2) {
      return RoundedCardClipper(revealPercent: t);
    }

    // All others: Squircle expansion from center
    return CenterSquircleClipper(revealPercent: t);
  }

  Color _getShapeColor(int fromIndex, int toIndex) {
    // 0 -> 1: Saffron Orange (warm, energetic circle)
    if (fromIndex == 0 && toIndex == 1) {
      return AppColors.orange;
    }
    // 1 -> 2: Warm cream (card coming up)
    if (fromIndex == 1 && toIndex == 2) {
      return const Color(0xFFFBF4E2);
    }
    // Default: Orange
    return AppColors.orange;
  }
}
