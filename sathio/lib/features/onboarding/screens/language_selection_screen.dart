import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class LanguageOption {
  final String nativeName;
  final String englishName;
  final bool hasVoice;

  const LanguageOption({
    required this.nativeName,
    required this.englishName,
    this.hasVoice = false,
  });
}

class LanguageSelectionScreen extends ConsumerStatefulWidget {
  final VoidCallback? onContinue;

  const LanguageSelectionScreen({super.key, this.onContinue});

  @override
  ConsumerState<LanguageSelectionScreen> createState() =>
      _LanguageSelectionScreenState();
}

class _LanguageSelectionScreenState
    extends ConsumerState<LanguageSelectionScreen>
    with AutomaticKeepAliveClientMixin {
  int? _selectedIndex;

  static const List<LanguageOption> _languages = [
    LanguageOption(
      nativeName: 'English',
      englishName: 'English',
      hasVoice: true,
    ),
    LanguageOption(nativeName: 'हिंदी', englishName: 'Hindi', hasVoice: true),
    LanguageOption(nativeName: 'বাংলা', englishName: 'Bengali', hasVoice: true),
    LanguageOption(nativeName: 'தமிழ்', englishName: 'Tamil', hasVoice: true),
    LanguageOption(nativeName: 'मराठी', englishName: 'Marathi', hasVoice: true),
    LanguageOption(nativeName: 'తెలుగు', englishName: 'Telugu'),
    LanguageOption(nativeName: 'ಕನ್ನಡ', englishName: 'Kannada'),
    LanguageOption(nativeName: 'ગુજરાતી', englishName: 'Gujarati'),
    LanguageOption(nativeName: 'ਪੰਜਾਬੀ', englishName: 'Punjabi'),
    LanguageOption(nativeName: 'മലയാളം', englishName: 'Malayalam'),
  ];

  @override
  bool get wantKeepAlive => true; // Keep screen alive

  void _onSelect(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); // Required by AutomaticKeepAliveClientMixin
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 24),

            // --- Header ---
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Section Icon
                  Container(
                    width: 40,
                    height: 40,
                    decoration: const BoxDecoration(
                      color: Color(0xFFF5F5F5),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.language,
                      color: Color(0xFF666666),
                      size: 20,
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Title
                  Text(
                    'Choose Your Language',
                    style: GoogleFonts.inter(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF111111),
                    ),
                  ),

                  const SizedBox(height: 8),

                  // Description
                  Text(
                    'Sathio speaks your language',
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF666666),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // --- Language Grid ---
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 1.15, // ~width/80dp height
                  ),
                  itemCount: _languages.length,
                  itemBuilder: (context, index) {
                    final lang = _languages[index];
                    final isSelected = _selectedIndex == index;

                    return GestureDetector(
                      onTap: () => _onSelect(index),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? const Color(0xFFFFF5EB)
                              : Colors.white,
                          border: Border.all(
                            color: isSelected
                                ? const Color(0xFFF58220)
                                : const Color(0xFFE8E8E8),
                            width: isSelected ? 2 : 1,
                          ),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Stack(
                          children: [
                            // Content
                            Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    lang.nativeName,
                                    style: GoogleFonts.inter(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: const Color(0xFF111111),
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    lang.englishName,
                                    style: GoogleFonts.inter(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: const Color(0xFF999999),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            // Checkmark (top-right)
                            if (isSelected)
                              Positioned(
                                top: 8,
                                right: 8,
                                child: Container(
                                  width: 20,
                                  height: 20,
                                  decoration: const BoxDecoration(
                                    color: Color(0xFFF58220),
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.check,
                                    size: 14,
                                    color: Colors.white,
                                  ),
                                ),
                              ),

                            // Voice badge (bottom-left)
                            if (lang.hasVoice)
                              Positioned(
                                bottom: 6,
                                left: 8,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(
                                      Icons.mic,
                                      size: 10,
                                      color: Color(0xFFF58220),
                                    ),
                                    const SizedBox(width: 2),
                                    Text(
                                      'Voice',
                                      style: GoogleFonts.inter(
                                        fontSize: 9,
                                        fontWeight: FontWeight.w500,
                                        color: const Color(0xFFF58220),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),

            // --- Continue Button ---
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: _selectedIndex != null
                      ? () {
                          // Save selection and continue
                          if (widget.onContinue != null) {
                            widget.onContinue!();
                          }
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF111111),
                    foregroundColor: Colors.white,
                    disabledBackgroundColor: const Color(0xFFE0E0E0),
                    disabledForegroundColor: const Color(0xFF999999),
                    elevation: 0,
                    shape: const StadiumBorder(),
                  ),
                  child: Text(
                    'Continue',
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
