import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../services/voice/voice_state.dart';
import '../../../services/speech/tts_service.dart';
import '../response_provider.dart';
import '../voice_overlay_controller.dart'; // To reopen listening overlay
import '../../../services/voice/voice_interaction_manager.dart'; // To access provider

class ResponseScreen extends ConsumerStatefulWidget {
  static const routeName = '/response';

  const ResponseScreen({super.key});

  @override
  ConsumerState<ResponseScreen> createState() => _ResponseScreenState();
}

class _ResponseScreenState extends ConsumerState<ResponseScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;
  bool _stepsExpanded = false;

  @override
  void initState() {
    super.initState();
    // Pulse animation for avatar when speaking
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final responseState = ref.watch(responseProvider);
    final response = responseState.response;
    final isSpeaking = responseState.ttsState == TtsState.speaking;
    final controller = ref.read(responseProvider.notifier);

    // Stop pulse if not speaking
    if (isSpeaking) {
      if (!_pulseController.isAnimating) _pulseController.repeat(reverse: true);
    } else {
      _pulseController.stop();
      _pulseController.value = 0; // Reset
    }

    if (response == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(response.contextTitle ?? 'Sathio'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 20),
            // Avatar with pulse
            ScaleTransition(
              scale: isSpeaking
                  ? _pulseAnimation
                  : const AlwaysStoppedAnimation(1.0),
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: isSpeaking
                      ? [
                          BoxShadow(
                            color: Theme.of(
                              context,
                            ).primaryColor.withOpacity(0.4),
                            blurRadius: 20,
                            spreadRadius: 5,
                          ),
                        ]
                      : null,
                ),
                child: CircleAvatar(
                  radius: 60,
                  backgroundColor: Theme.of(context).cardColor,
                  backgroundImage: const AssetImage(
                    'assets/images/sathio_logo.png',
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),

            // Response Card
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Text Content
                    Text(
                      response.responseText,
                      style: Theme.of(
                        context,
                      ).textTheme.bodyLarge?.copyWith(height: 1.5),
                    ),
                    const SizedBox(height: 20),

                    // TTS Controls Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Play/Pause Button
                        IconButton.filled(
                          onPressed: controller.togglePlayback,
                          icon: Icon(
                            isSpeaking
                                ? Icons.pause_rounded
                                : Icons.play_arrow_rounded,
                          ),
                          style: IconButton.styleFrom(
                            backgroundColor: Theme.of(context).primaryColor,
                            foregroundColor: Colors.white,
                          ),
                        ),

                        // Speed Toggle
                        _buildSpeedToggle(responseState.speed, controller),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // Steps Section
            if (response.steps != null && response.steps!.isNotEmpty) ...[
              const SizedBox(height: 20),
              ExpansionTile(
                title: const Text('Detailed steps dekhein'),
                initiallyExpanded: _stepsExpanded,
                onExpansionChanged: (val) =>
                    setState(() => _stepsExpanded = val),
                children: response.steps!
                    .map(
                      (step) => ListTile(
                        leading: const Icon(
                          Icons.check_circle_outline,
                          size: 20,
                        ),
                        title: Text(step),
                        dense: true,
                      ),
                    )
                    .toList(),
              ),
            ],

            const SizedBox(height: 40),

            // Action Area
            Row(
              children: [
                if (response.isActionable)
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        // TODO: Implement "Next" functionality
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Processing next step...'),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: const Text('Aage Badhein'),
                    ),
                  ),
                if (response.isActionable) const SizedBox(width: 16),
                OutlinedButton(
                  onPressed: () {
                    controller.stop();
                    controller.play();
                  },
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: 24,
                    ),
                  ),
                  child: const Text('Repeat'),
                ),
              ],
            ),

            const SizedBox(height: 80), // Bottom padding for FAB
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Stop current playback
          ref.read(responseProvider.notifier).stop();
          // Re-open listening overlay for follow-up
          VoiceOverlayController.showAndStartListening(context, ref);
        },
        backgroundColor: Theme.of(context).primaryColor,
        child: const Icon(Icons.mic, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _buildSpeedToggle(double currentSpeed, ResponseController controller) {
    // Cycle: 1.0 -> 1.25 -> 0.75 -> 1.0
    String label = '${currentSpeed}x';
    if (currentSpeed == 1.0) label = 'Normal';

    return InkWell(
      onTap: () {
        double newSpeed = 1.0;
        if (currentSpeed == 1.0)
          newSpeed = 1.25;
        else if (currentSpeed == 1.25)
          newSpeed = 0.75;
        else
          newSpeed = 1.0;

        controller.setSpeed(newSpeed);
      },
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            const Icon(Icons.speed, size: 16, color: Colors.grey),
            const SizedBox(width: 4),
            Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
