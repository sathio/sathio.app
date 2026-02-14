import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

// --- State ---
class OnboardingState {
  final int currentIndex;
  final String? selectedLanguage;
  final int avatarIndex; // 1-12
  final String? name;
  final String? selectedState;
  final String? selectedDistrict;
  final List<String> selectedInterests;
  final bool isCompleted;
  final bool isGuest;

  const OnboardingState({
    this.currentIndex = 0,
    this.selectedLanguage,
    this.avatarIndex = 1,
    this.name,
    this.selectedState,
    this.selectedDistrict,
    this.selectedInterests = const [],
    this.isCompleted = false,
    this.isGuest = false,
  });

  OnboardingState copyWith({
    int? currentIndex,
    String? selectedLanguage,
    int? avatarIndex,
    String? name,
    String? selectedState,
    String? selectedDistrict,
    List<String>? selectedInterests,
    bool? isCompleted,
    bool? isGuest,
  }) {
    return OnboardingState(
      currentIndex: currentIndex ?? this.currentIndex,
      selectedLanguage: selectedLanguage ?? this.selectedLanguage,
      avatarIndex: avatarIndex ?? this.avatarIndex,
      name: name ?? this.name,
      selectedState: selectedState ?? this.selectedState,
      selectedDistrict: selectedDistrict ?? this.selectedDistrict,
      selectedInterests: selectedInterests ?? this.selectedInterests,
      isCompleted: isCompleted ?? this.isCompleted,
      isGuest: isGuest ?? this.isGuest,
    );
  }
}

// --- Notifier ---
class OnboardingNotifier extends Notifier<OnboardingState> {
  static const _boxName = 'onboarding_box';

  @override
  OnboardingState build() {
    _loadProgress();
    return const OnboardingState();
  }

  Future<void> _loadProgress() async {
    final box = await Hive.openBox(_boxName);
    final completed = box.get('isCompleted', defaultValue: false);
    final avatar = box.get('avatarIndex', defaultValue: 1);
    final name = box.get('name');
    final pState = box.get('state');
    final district = box.get('district');

    state = state.copyWith(
      isCompleted: completed,
      avatarIndex: avatar,
      name: name,
      selectedState: pState,
      selectedDistrict: district,
    );
  }

  void nextPage() {
    state = state.copyWith(currentIndex: state.currentIndex + 1);
  }

  void previousPage() {
    if (state.currentIndex > 0) {
      state = state.copyWith(currentIndex: state.currentIndex - 1);
    }
  }

  void setPage(int index) {
    state = state.copyWith(currentIndex: index);
  }

  void selectLanguage(String language) {
    state = state.copyWith(selectedLanguage: language);
  }

  void setGuest(bool isGuest) {
    state = state.copyWith(isGuest: isGuest);
  }

  void updateProfile({
    int? avatarIndex,
    String? name,
    String? stateName,
    String? district,
  }) {
    state = state.copyWith(
      avatarIndex: avatarIndex,
      name: name,
      selectedState: stateName,
      selectedDistrict: district,
    );
    _saveProfile();
  }

  Future<void> _saveProfile() async {
    final box = await Hive.openBox(_boxName);
    if (state.avatarIndex != 1) await box.put('avatarIndex', state.avatarIndex);
    if (state.name != null) await box.put('name', state.name);
    if (state.selectedState != null) {
      await box.put('state', state.selectedState);
    }
    if (state.selectedDistrict != null) {
      await box.put('district', state.selectedDistrict);
    }
  }

  void toggleInterest(String interest) {
    final interests = List<String>.from(state.selectedInterests);
    if (interests.contains(interest)) {
      interests.remove(interest);
    } else {
      interests.add(interest);
    }
    state = state.copyWith(selectedInterests: interests);
  }

  Future<void> completeOnboarding() async {
    state = state.copyWith(isCompleted: true);
    final box = await Hive.openBox(_boxName);
    await box.put('isCompleted', true);
  }

  // Method to reset for testing
  Future<void> resetOnboarding() async {
    state = const OnboardingState();
    final box = await Hive.openBox(_boxName);
    await box.put('isCompleted', false);
  }
}

// --- Provider ---
final onboardingProvider =
    NotifierProvider<OnboardingNotifier, OnboardingState>(
      OnboardingNotifier.new,
    );
