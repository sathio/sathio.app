import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/india_data.dart';
import '../providers/onboarding_provider.dart';
import '../widgets/avatar_selector.dart';

class ProfileSetupScreen extends ConsumerStatefulWidget {
  final VoidCallback? onContinue;
  final VoidCallback? onBack; // New callback

  const ProfileSetupScreen({super.key, this.onContinue, this.onBack});

  @override
  ConsumerState<ProfileSetupScreen> createState() => _ProfileSetupScreenState();
}

class _ProfileSetupScreenState extends ConsumerState<ProfileSetupScreen>
    with AutomaticKeepAliveClientMixin {
  final TextEditingController _nameController = TextEditingController();

  @override
  bool get wantKeepAlive => true; // Keep screen alive

  // State for form
  int _avatarIndex = 1;
  String? _selectedState;
  String? _selectedDistrict;

  @override
  void initState() {
    super.initState();
    // Randomize avatar on init
    _avatarIndex = Random().nextInt(12) + 1;

    // Load existing data if any (e.g. if coming back)
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final state = ref.read(onboardingProvider);
      if (state.name != null) _nameController.text = state.name!;
      if (state.selectedState != null) {
        setState(() {
          _selectedState = state.selectedState;
          _selectedDistrict = state.selectedDistrict;
          // If avatar was previously saved (not default 1), verify?
          // Implementation choice: random on first load, saved on subsequent.
          if (state.avatarIndex != 1) _avatarIndex = state.avatarIndex;
        });
      }
    });

    _nameController.addListener(() {
      setState(() {}); // Rebuild to update button state
    });
  }

  void _onAvatarTap() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => AvatarSelectionSheet(
        selectedIndex: _avatarIndex,
        onSelect: (index) {
          setState(() => _avatarIndex = index);
          Navigator.pop(context);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); // Required for AutomaticKeepAliveClientMixin
    final districts = _selectedState != null
        ? IndiaData.indiaStatesDistricts[_selectedState] ?? []
        : <String>[];

    final isFormValid =
        _nameController.text.trim().isNotEmpty &&
        _selectedState != null &&
        _selectedDistrict != null;

    return Scaffold(
      backgroundColor: Colors.white, // Clean white background like reference
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            if (widget.onBack != null) {
              widget.onBack!();
            } else {
              Navigator.of(context).pop();
            }
          },
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, // Left aligned
            children: [
              const SizedBox(height: 10),

              // Avatar (Left Aligned)
              AvatarSelector(
                selectedAvatarIndex: _avatarIndex,
                onTap: _onAvatarTap,
              ),

              const SizedBox(height: 24),

              // Title
              Text(
                'Your Profile',
                style: GoogleFonts.inter(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF111111),
                ),
              ),
              const SizedBox(height: 8),

              // Description
              Text(
                'Introduce yourself to others in your events.',
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF666666),
                ),
              ),

              const SizedBox(height: 32),

              // Name Input
              _buildLabel('Name'),
              const SizedBox(height: 8),
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFF5F5F5), // Light grey fill
                  borderRadius: BorderRadius.circular(12),
                ),
                child: TextField(
                  controller: _nameController,
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF111111),
                  ),
                  decoration: InputDecoration(
                    hintText: 'Your Name',
                    hintStyle: GoogleFonts.inter(
                      color: const Color(0xFF999999),
                      fontWeight: FontWeight.normal,
                    ),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // State Dropdown
              _buildLabel('State'),
              const SizedBox(height: 8),
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFF5F5F5),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: DropdownButtonFormField<String>(
                  value: _selectedState,
                  items: IndiaData.indiaStatesDistricts.keys.map((state) {
                    return DropdownMenuItem(value: state, child: Text(state));
                  }).toList(),
                  onChanged: (val) {
                    setState(() {
                      _selectedState = val;
                      _selectedDistrict = null; // Reset district
                    });
                  },
                  icon: const Icon(
                    Icons.keyboard_arrow_down,
                    color: Color(0xFF999999),
                  ),
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF111111),
                  ),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                  ),
                  dropdownColor: Colors.white,
                  menuMaxHeight: 400,
                  hint: Text(
                    "Select State",
                    style: GoogleFonts.inter(color: const Color(0xFF999999)),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // District Dropdown (Visible only if State selected)
              if (_selectedState != null) ...[
                _buildLabel('District'),
                const SizedBox(height: 8),
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFF5F5F5),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: DropdownButtonFormField<String>(
                    value: _selectedDistrict,
                    items: districts.map((district) {
                      return DropdownMenuItem(
                        value: district,
                        child: Text(district),
                      );
                    }).toList(),
                    onChanged: (val) {
                      setState(() {
                        _selectedDistrict = val;
                      });
                    },
                    icon: const Icon(
                      Icons.keyboard_arrow_down,
                      color: Color(0xFF999999),
                    ),
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF111111),
                    ),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),
                    ),
                    dropdownColor: Colors.white,
                    menuMaxHeight: 400,
                    hint: Text(
                      "Select District",
                      style: GoogleFonts.inter(color: const Color(0xFF999999)),
                    ),
                  ),
                ),
              ],

              const SizedBox(height: 48),

              // Save Profile Button
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: isFormValid
                      ? () {
                          // Save to provider
                          ref
                              .read(onboardingProvider.notifier)
                              .updateProfile(
                                avatarIndex: _avatarIndex,
                                name: _nameController.text.trim(),
                                stateName: _selectedState,
                                district: _selectedDistrict,
                              );

                          if (widget.onContinue != null) {
                            widget.onContinue!();
                          }
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF111111), // Black
                    foregroundColor: Colors.white,
                    disabledBackgroundColor: const Color(0xFF999999),
                    disabledForegroundColor: const Color(
                      0xFFFFFFFF,
                    ).withOpacity(0.5),
                    elevation: 0,
                    shape: const StadiumBorder(),
                  ),
                  child: Text(
                    'Save Profile',
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Skip
              Center(
                child: InkWell(
                  onTap: widget.onContinue,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Do this later',
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF666666),
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w600, // Semi-bold
        color: const Color(0xFF999999), // Grey
      ),
    );
  }
}
