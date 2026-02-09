import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_tts/flutter_tts.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/spacing.dart';
import '../../../core/utils/extensions.dart';
import '../onboarding_provider.dart';

class LanguageScreen extends ConsumerStatefulWidget {
  const LanguageScreen({super.key});

  @override
  ConsumerState<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends ConsumerState<LanguageScreen> {
  final FlutterTts flutterTts = FlutterTts();

  @override
  void initState() {
    super.initState();
    _initTts();
  }

  Future<void> _initTts() async {
    await flutterTts.setLanguage("hi-IN");
    await flutterTts.setSpeechRate(0.5);
    await flutterTts.setVolume(1.0);
  }

  Future<void> _speak(String text, String languageCode) async {
    // Attempt to set the language for TTS if possible, though mostly standard Hindi voice might be used for all for now
    // In a real app, we'd check availability.
    // Mapping rudimentary codes for demo
    String locale = 'hi-IN';
    if (languageCode == 'bn') locale = 'bn-IN';
    if (languageCode == 'ta') locale = 'ta-IN';
    if (languageCode == 'mr') locale = 'mr-IN';

    // Check if language is available (optional optimization)
    // await flutterTts.setLanguage(locale);

    await flutterTts.speak(text);
  }

  @override
  void dispose() {
    flutterTts.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final onboardingState = ref.watch(onboardingProvider);

    // Data for the 4 languages
    final languages = [
      {
        'code': 'hi',
        'name': 'Hindi',
        'native': 'हिंदी',
        'flag': '🇮🇳',
        'speak': 'Main Hindi mein baat kar sakta hoon',
      },
      {
        'code': 'bn',
        'name': 'Bengali',
        'native': 'বাংলা',
        'flag': '🇮🇳',
        'speak': 'Aami Bangla e kotha bolte pari', // Approximation
      },
      {
        'code': 'ta',
        'name': 'Tamil',
        'native': 'தமிழ்',
        'flag': '🇮🇳',
        'speak': 'Naan Tamilil pesuven', // Approximation
      },
      {
        'code': 'mr',
        'name': 'Marathi',
        'native': 'मराठी',
        'flag': '🇮🇳',
        'speak': 'Mi Marathi bolu shakte', // Approximation
      },
    ];

    return Scaffold(
      backgroundColor: context.colorScheme.surface,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: AppSpacing.xl),

            // Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
              child: Column(
                children: [
                  Text(
                    'Kaunsi bhasha mein baat karein?',
                    style: context.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimaryLight,
                    ),
                    textAlign: TextAlign.center,
                  ).animate().fadeIn().slideY(begin: -0.2, end: 0),
                  const SizedBox(height: 8),
                  Text(
                    '(Which language should we speak in?)',
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: AppColors.textSecondaryLight,
                    ),
                  ).animate().fadeIn(delay: 200.ms),
                ],
              ),
            ),

            const SizedBox(height: AppSpacing.xl),

            // Card Grid
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.85, // Taller cards
                ),
                itemCount: languages.length,
                itemBuilder: (context, index) {
                  final language = languages[index];
                  final isSelected =
                      onboardingState.selectedLanguage == language['code'];

                  return GestureDetector(
                        onTap: () async {
                          ref
                              .read(onboardingProvider.notifier)
                              .selectLanguage(language['code']!);
                          await _speak(language['speak']!, language['code']!);
                        },
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              width: double.infinity,
                              height: double.infinity,
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? AppColors.secondary.withValues(
                                        alpha: 0.1,
                                      ) // Teal tint
                                    : Colors.white,
                                border: Border.all(
                                  color: isSelected
                                      ? AppColors
                                            .secondary // Teal border
                                      : AppColors.gray200,
                                  width: isSelected ? 3 : 1.5,
                                ),
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: isSelected
                                        ? AppColors.secondary.withValues(
                                            alpha: 0.2,
                                          )
                                        : AppColors.gray200,
                                    offset: const Offset(0, 4),
                                    blurRadius: isSelected ? 8 : 0,
                                  ),
                                ],
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    language['flag']!,
                                    style: const TextStyle(fontSize: 48),
                                  ),
                                  const SizedBox(height: 12),
                                  Text(
                                    language['native']!,
                                    style: context.textTheme.headlineSmall
                                        ?.copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.textPrimaryLight,
                                        ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    language['name']!,
                                    style: context.textTheme.bodyMedium
                                        ?.copyWith(
                                          color: AppColors.textSecondaryLight,
                                          fontWeight: FontWeight.w500,
                                        ),
                                  ),
                                ],
                              ),
                            ),

                            // Checkmark Badge
                            if (isSelected)
                              Positioned(
                                top: 8,
                                right: 8,
                                child: Container(
                                  padding: const EdgeInsets.all(4),
                                  decoration: const BoxDecoration(
                                    color: AppColors.secondary,
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.check,
                                    color: Colors.white,
                                    size: 16,
                                  ),
                                ).animate().scale(curve: Curves.elasticOut),
                              ),

                            // Confetti/Sparkle Effect (Simulated with simple scaling icon for now)
                            if (isSelected)
                              Positioned(
                                top: -10,
                                right: -10,
                                child:
                                    const Icon(
                                          Icons.auto_awesome,
                                          color: AppColors.primary,
                                          size: 30,
                                        )
                                        .animate()
                                        .scale(
                                          duration: 400.ms,
                                          curve: Curves.easeOutBack,
                                        )
                                        .fadeOut(delay: 500.ms),
                              ),
                          ],
                        ),
                      )
                      .animate()
                      .fadeIn(delay: (100 * index).ms)
                      .slideY(begin: 0.2, end: 0);
                },
              ),
            ),

            // Footer Section
            if (onboardingState.selectedLanguage != null)
              Padding(
                padding: const EdgeInsets.all(AppSpacing.lg),
                child: Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: () {
                          ref.read(onboardingProvider.notifier).nextPage();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.secondary, // Teal button
                          foregroundColor: Colors.white,
                          elevation: 4,
                          shadowColor: AppColors.secondary.withValues(
                            alpha: 0.4,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: const Text(
                          'AAGE BADHEIN', // Continue
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.0,
                          ),
                        ),
                      ),
                    ).animate().slideY(
                      begin: 1.0,
                      end: 0,
                      curve: Curves.easeOutBack,
                    ),
                  ],
                ),
              ),

            // Progress Dots (2 of 7)
            Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.lg),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(7, (index) {
                  final isActive = index == 1; // 2nd Screen
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    height: 8,
                    width: isActive ? 24 : 8,
                    decoration: BoxDecoration(
                      color: isActive ? AppColors.secondary : AppColors.gray300,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
