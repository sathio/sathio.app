import 'package:flutter/material.dart';
import 'package:animations/animations.dart';
import 'reduced_motion.dart';

/// Custom page transition builder for GoRouter / Navigator.
/// Implements Luma-inspired transitions from UI_UX.md Section 8.1.

// Forward: SharedAxisTransition (vertical) — 300ms, easeOutCubic
class SathioPageTransition extends PageRouteBuilder {
  final Widget page;
  final bool isModal;
  final bool isRootChange;

  SathioPageTransition({
    required this.page,
    this.isModal = false,
    this.isRootChange = false,
  }) : super(
         pageBuilder: (context, animation, secondaryAnimation) => page,
         transitionDuration: Duration(
           milliseconds: isRootChange ? 200 : (isModal ? 250 : 300),
         ),
         reverseTransitionDuration: const Duration(milliseconds: 250),
         transitionsBuilder: (context, animation, secondaryAnimation, child) {
           final isReduced = ReducedMotion.isReduced(context);
           if (isReduced) {
             return FadeTransition(opacity: animation, child: child);
           }

           if (isRootChange) {
             return FadeTransition(opacity: animation, child: child);
           }

           if (isModal) {
             final scaleAnim = Tween<double>(begin: 0.9, end: 1.0).animate(
               CurvedAnimation(parent: animation, curve: Curves.easeOutBack),
             );
             return FadeTransition(
               opacity: animation,
               child: ScaleTransition(scale: scaleAnim, child: child),
             );
           }

           // Default forward: vertical shared axis (slide up + fade)
           final slideAnim =
               Tween<Offset>(
                 begin: const Offset(0, 0.05),
                 end: Offset.zero,
               ).animate(
                 CurvedAnimation(parent: animation, curve: Curves.easeOutCubic),
               );

           return FadeTransition(
             opacity: animation,
             child: SlideTransition(position: slideAnim, child: child),
           );
         },
       );
}

/// Custom GoRouter page with Sathio transitions.
/// Uses Page<T> directly since CustomTransitionPage may not be available.
class SathioPage<T> extends Page<T> {
  final bool isModal;
  final bool isRootChange;
  final Widget child;

  const SathioPage({
    required this.child,
    super.key,
    this.isModal = false,
    this.isRootChange = false,
  });

  @override
  Route<T> createRoute(BuildContext context) {
    return PageRouteBuilder<T>(
      settings: this,
      pageBuilder: (context, animation, secondaryAnimation) => child,
      transitionDuration: Duration(
        milliseconds: isRootChange ? 200 : (isModal ? 250 : 300),
      ),
      reverseTransitionDuration: const Duration(milliseconds: 250),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final isReduced = ReducedMotion.isReduced(context);
        if (isReduced) {
          return FadeTransition(opacity: animation, child: child);
        }

        if (isRootChange) {
          return FadeTransition(opacity: animation, child: child);
        }

        if (isModal) {
          final scaleAnim = Tween<double>(begin: 0.9, end: 1.0).animate(
            CurvedAnimation(parent: animation, curve: Curves.easeOutBack),
          );
          return FadeTransition(
            opacity: animation,
            child: ScaleTransition(scale: scaleAnim, child: child),
          );
        }

        final slideAnim =
            Tween<Offset>(
              begin: const Offset(0, 0.05),
              end: Offset.zero,
            ).animate(
              CurvedAnimation(parent: animation, curve: Curves.easeOutCubic),
            );

        return FadeTransition(
          opacity: animation,
          child: SlideTransition(position: slideAnim, child: child),
        );
      },
    );
  }
}

/// Convenience wrapper for OpenContainer (card -> detail transitions).
/// Requires `animations` package.
class ContainerTransformWrapper extends StatelessWidget {
  final Widget closedWidget;
  final Widget Function(BuildContext, VoidCallback) openWidgetBuilder;
  final Color closedColor;
  final double closedElevation;
  final ShapeBorder closedShape;

  const ContainerTransformWrapper({
    super.key,
    required this.closedWidget,
    required this.openWidgetBuilder,
    this.closedColor = Colors.white,
    this.closedElevation = 0,
    this.closedShape = const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(16)),
    ),
  });

  @override
  Widget build(BuildContext context) {
    return OpenContainer(
      transitionDuration: const Duration(milliseconds: 350),
      closedColor: closedColor,
      closedElevation: closedElevation,
      closedShape: closedShape,
      openColor: Theme.of(context).scaffoldBackgroundColor,
      closedBuilder: (context, openContainer) {
        return GestureDetector(onTap: openContainer, child: closedWidget);
      },
      openBuilder: (context, closeContainer) {
        return openWidgetBuilder(context, closeContainer);
      },
    );
  }
}
