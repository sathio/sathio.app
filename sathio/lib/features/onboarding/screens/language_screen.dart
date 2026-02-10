import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/theme/app_colors.dart';
import '../onboarding_provider.dart';

class LanguageScreen extends ConsumerStatefulWidget {
  const LanguageScreen({super.key});

  @override
  ConsumerState<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends ConsumerState<LanguageScreen> {
  final FlutterTts flutterTts = FlutterTts();

  // Greetings for animation
  final List<String> greetings = [
    'HELLO',
    'नमस्ते',
    'নমস্কার',
    'வணக்கம்',
    'नमस्कार',
  ];

  int _currentGreetingIndex = 0;

  @override
  void initState() {
    super.initState();
    // Initialize TTS after the frame to avoid blocking UI
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initTts();
    });
    _startGreetingAnimation();
  }

  void _startGreetingAnimation() {
    // Use a Timer instead of Future.doWhile for better control and less risk of loops
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _currentGreetingIndex =
              (_currentGreetingIndex + 1) % greetings.length;
        });
        _startGreetingAnimation();
      }
    });
  }

  Future<void> _initTts() async {
    // Run in background / non-blocking if possible, though flutter_tts uses platform channel
    // which is async by default. The key is not to await it in initState.
    try {
      await flutterTts.setLanguage("hi-IN");
      await flutterTts.setSpeechRate(0.5);
      await flutterTts.setVolume(1.0);
    } catch (e) {
      debugPrint("Error initializing TTS: $e");
    }
  }

  Future<void> _speak(String text, String languageCode) async {
    await flutterTts.stop();
    // Basic mapping for demo purposes
    // In production, check available languages
    if (languageCode == 'hi')
      await flutterTts.setLanguage('hi-IN');
    else if (languageCode == 'bn')
      await flutterTts.setLanguage('bn-IN');
    else if (languageCode == 'ta')
      await flutterTts.setLanguage('ta-IN');
    else if (languageCode == 'mr')
      await flutterTts.setLanguage('mr-IN');
    else
      await flutterTts.setLanguage('en-IN');

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

    final languages = [
      {'code': 'en', 'name': 'English', 'native': 'English', 'greet': 'Hello'},
      {'code': 'hi', 'name': 'Hindi', 'native': 'हिंदी', 'greet': 'नमस्ते'},
      {'code': 'bn', 'name': 'Bengali', 'native': 'বাংলা', 'greet': 'নমস্কার'},
      {'code': 'ta', 'name': 'Tamil', 'native': 'தமிழ்', 'greet': 'வணக்கம்'},
      {'code': 'mr', 'name': 'Marathi', 'native': 'मराठी', 'greet': 'नमस्कार'},
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF36D43), // Orange Background
      body: Stack(
        children: [
          // Header Content
          // Header Content
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: MediaQuery.of(context).size.height * 0.5,
            child: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Animated Greeting
                  SizedBox(
                    height: 60,
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 500),
                      transitionBuilder:
                          (Widget child, Animation<double> animation) {
                            return FadeTransition(
                              opacity: animation,
                              child: child,
                            );
                          },
                      child: Text(
                        greetings[_currentGreetingIndex],
                        key: ValueKey<int>(_currentGreetingIndex),
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          fontSize: 48,
                          fontWeight: FontWeight.w900,
                          color: const Color(0xFFFFF0E5),
                          height: 1.0,
                          shadows: _currentGreetingIndex >= 2
                              ? [
                                  const Shadow(
                                    offset: Offset(-1, -1),
                                    color: Color(0xFFFFF0E5),
                                  ),
                                  const Shadow(
                                    offset: Offset(1, -1),
                                    color: Color(0xFFFFF0E5),
                                  ),
                                  const Shadow(
                                    offset: Offset(1, 1),
                                    color: Color(0xFFFFF0E5),
                                  ),
                                  const Shadow(
                                    offset: Offset(-1, 1),
                                    color: Color(0xFFFFF0E5),
                                  ),
                                ]
                              : [],
                          textStyle: const TextStyle(
                            fontFamilyFallback: [
                              'NotoSansDevanagari',
                              'NotoSansBengali',
                              'NotoSansTamil',
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Text(
                        'Which language should we speak in?',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          color: Colors.white.withOpacity(0.9),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          Positioned(
            top: MediaQuery.of(context).size.height * 0.5, // Start from middle
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              decoration: const BoxDecoration(
                color: Color(0xFFFFF8F0), // Off-white/Cream
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 30),
                  Text(
                    'Select Language',
                    style: GoogleFonts.poppins(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFFD95D39), // Darker orange/rust
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Language List
                  Expanded(
                    child: ListView.separated(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 10,
                      ),
                      itemCount: languages.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 16),
                      itemBuilder: (context, index) {
                        final language = languages[index];
                        final isSelected =
                            onboardingState.selectedLanguage ==
                            language['code'];

                        return GestureDetector(
                          onTap: () {
                            ref
                                .read(onboardingProvider.notifier)
                                .selectLanguage(language['code']!);
                            _speak(language['greet']!, language['code']!);
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            height: 60,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: isSelected
                                    ? const Color(0xFFF36D43)
                                    : Colors.transparent,
                                width: 2,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.05),
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Center(
                              child: Text(
                                language['native']!,
                                style: GoogleFonts.poppins(
                                  fontSize: 18,
                                  fontWeight: isSelected
                                      ? FontWeight.w600
                                      : FontWeight.w400,
                                  color: isSelected
                                      ? const Color(0xFFF36D43)
                                      : const Color(0xFFD95D39),
                                  textStyle: const TextStyle(
                                    fontFamilyFallback: [
                                      'NotoSansDevanagari',
                                      'NotoSansBengali',
                                      'NotoSansTamil',
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  // Next Button (Floating or Bottom)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 40, right: 24),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: onboardingState.selectedLanguage != null
                            ? () => ref
                                  .read(onboardingProvider.notifier)
                                  .nextPage()
                            : null,
                        child: AnimatedOpacity(
                          duration: const Duration(milliseconds: 300),
                          opacity: onboardingState.selectedLanguage != null
                              ? 1.0
                              : 0.0,
                          child: Container(
                            width: 60,
                            height: 60,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 10,
                                  offset: Offset(0, 4),
                                ),
                              ],
                            ),
                            child: const Icon(
                              Icons.arrow_forward,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
