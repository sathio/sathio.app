import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/theme/app_colors.dart';
import '../onboarding_provider.dart';

class ProfileSetupScreen extends ConsumerStatefulWidget {
  const ProfileSetupScreen({super.key});

  @override
  ConsumerState<ProfileSetupScreen> createState() => _ProfileSetupScreenState();
}

class _ProfileSetupScreenState extends ConsumerState<ProfileSetupScreen> {
  final _nameController = TextEditingController();
  String? _selectedState;
  String? _selectedDistrict;

  final Map<String, List<String>> _stateDistricts = {
    'Delhi': [
      'Central Delhi',
      'East Delhi',
      'New Delhi',
      'North Delhi',
      'South Delhi',
    ],
    'Maharashtra': ['Mumbai', 'Pune', 'Nagpur', 'Nashik', 'Thane'],
    'Uttar Pradesh': ['Lucknow', 'Kanpur', 'Varanasi', 'Agra', 'Meerut'],
    'Bihar': ['Patna', 'Gaya', 'Bhagalpur', 'Muzaffarpur'],
    'Karnataka': ['Bangalore', 'Mysore', 'Hubli', 'Mangalore'],
  };

  @override
  void initState() {
    super.initState();
    final name = ref.read(onboardingProvider).userName;
    if (name != null) {
      _nameController.text = name;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _completeOnboarding() async {
    // Save name if changed
    if (_nameController.text.isNotEmpty) {
      ref.read(onboardingProvider.notifier).setUserName(_nameController.text);
    }
    // Proceed to next step (UseCase)
    ref.read(onboardingProvider.notifier).nextPage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.orange,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Top 25%: Orange header
          Expanded(
            flex: 3,
            child: SafeArea(
              bottom: false,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Profile',
                        style: GoogleFonts.poppins(
                          fontSize: 48,
                          height: 1.0,
                          fontWeight: FontWeight.w900,
                          color: const Color(0xFFFBF4E2),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Tell us a little about yourself',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.white.withOpacity(0.9),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        '(Optional)',
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: Colors.white.withOpacity(0.7),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Bottom 75%: Cream panel
          Expanded(
            flex: 8,
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Color(0xFFFBF4E2),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              child: Stack(
                children: [
                  // Form Content
                  SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(24, 40, 24, 120),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Profile Photo
                        Center(
                          child: Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: AppColors.orange.withOpacity(0.2),
                                width: 4,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.05),
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Icon(
                              Icons.person,
                              size: 50,
                              color: AppColors.orange.withOpacity(0.5),
                            ),
                          ),
                        ).animate().scale(delay: 200.ms),

                        const SizedBox(height: 32),

                        // Name Input
                        _buildLabel('Your Name'),
                        const SizedBox(height: 8),
                        TextFormField(
                          controller: _nameController,
                          style: GoogleFonts.poppins(fontSize: 16),
                          decoration: _inputDecoration(
                            prefixIcon: Icons.person_outline,
                            hint: 'Enter your name',
                          ),
                        ).animate().fadeIn(delay: 300.ms),

                        const SizedBox(height: 24),

                        // State Dropdown
                        _buildLabel('Where do you live? (State)'),
                        const SizedBox(height: 8),
                        DropdownButtonFormField<String>(
                          value: _selectedState,
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            color: Colors.black87,
                          ),
                          decoration: _inputDecoration(
                            prefixIcon: Icons.map_outlined,
                            hint: 'Select State',
                          ),
                          items: _stateDistricts.keys.map((String state) {
                            return DropdownMenuItem(
                              value: state,
                              child: Text(state),
                            );
                          }).toList(),
                          onChanged: (newValue) {
                            setState(() {
                              _selectedState = newValue;
                              _selectedDistrict = null;
                            });
                          },
                        ).animate().fadeIn(delay: 400.ms),

                        const SizedBox(height: 24),

                        // District Dropdown
                        AnimatedOpacity(
                          opacity: _selectedState != null ? 1.0 : 0.5,
                          duration: const Duration(milliseconds: 300),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildLabel('District'),
                              const SizedBox(height: 8),
                              DropdownButtonFormField<String>(
                                value: _selectedDistrict,
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  color: Colors.black87,
                                ),
                                decoration: _inputDecoration(
                                  prefixIcon: Icons.location_city,
                                  hint: 'Select District',
                                  enabled: _selectedState != null,
                                ),
                                items: _selectedState != null
                                    ? _stateDistricts[_selectedState]!.map((
                                        String district,
                                      ) {
                                        return DropdownMenuItem(
                                          value: district,
                                          child: Text(district),
                                        );
                                      }).toList()
                                    : [],
                                onChanged: _selectedState != null
                                    ? (newValue) {
                                        setState(() {
                                          _selectedDistrict = newValue;
                                        });
                                      }
                                    : null,
                              ),
                            ],
                          ),
                        ).animate().fadeIn(delay: 500.ms),

                        const SizedBox(height: 24),

                        // Helper Text
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: AppColors.orange.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.lightbulb_outline,
                                size: 20,
                                color: AppColors.orange,
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  'Selecting state helps show local schemes',
                                  style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    color: AppColors.orange,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ).animate().fadeIn(delay: 600.ms),
                      ],
                    ),
                  ),

                  // Bottom Actions
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Skip Button
                          TextButton(
                            onPressed: _completeOnboarding,
                            child: Text(
                              'Skip for now',
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                color: AppColors.orange.withOpacity(0.7),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),

                          // Save FAB
                          GestureDetector(
                            onTap: _completeOnboarding,
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
                          ),
                        ],
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

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: GoogleFonts.poppins(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: Colors.black87,
      ),
    );
  }

  InputDecoration _inputDecoration({
    required IconData prefixIcon,
    required String hint,
    bool enabled = true,
  }) {
    return InputDecoration(
      prefixIcon: Icon(prefixIcon, color: AppColors.orange),
      hintText: hint,
      hintStyle: GoogleFonts.poppins(color: Colors.black38),
      filled: true,
      fillColor: enabled ? Colors.white : Colors.grey.shade200,
      contentPadding: const EdgeInsets.symmetric(vertical: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: AppColors.orange, width: 2),
      ),
    );
  }
}
