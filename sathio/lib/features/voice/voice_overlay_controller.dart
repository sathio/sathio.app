import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../services/voice/voice_providers.dart';
import 'widgets/listening_overlay.dart';

/// Controller that manages showing / hiding the [ListeningOverlay].
///
/// Usage from anywhere:
/// ```dart
/// VoiceOverlayController.showAndStartListening(context, ref);
/// ```
///
/// This handles the full flow:
/// 1. Opens the overlay (modal bottom sheet)
/// 2. Triggers VoiceInteractionManager.startListening()
/// 3. Overlay auto-closes when pipeline returns to idle or goes to AgentOverlay
class VoiceOverlayController {
  VoiceOverlayController._(); // Prevent instantiation

  /// Show the overlay and start recording immediately.
  static Future<void> showAndStartListening(
    BuildContext context,
    WidgetRef ref,
  ) async {
    // Start listening (this sets state to VoiceListening)
    // but don't await it — let it run while we show the overlay
    final voiceManager = ref.read(voiceInteractionProvider.notifier);
    unawaited(voiceManager.startListening());

    // Show the overlay immediately so user sees UI feedback
    if (context.mounted) {
      await ListeningOverlay.show(context);
    }
  }

  /// Show the overlay without auto-starting recording.
  /// Useful when recording has already been triggered externally.
  static Future<void> show(BuildContext context) {
    return ListeningOverlay.show(context);
  }
}
