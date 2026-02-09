import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'onboarding_state.dart';

// Keys for Hive
const String kOnboardingBox = 'onboarding_box';
const String kOnboardingCompletedKey = 'is_completed';

final onboardingProvider =
    NotifierProvider<OnboardingNotifier, OnboardingState>(
      OnboardingNotifier.new,
    );

class OnboardingNotifier extends Notifier<OnboardingState> {
  late Box _box;

  @override
  OnboardingState build() {
    _initBox();
    return const OnboardingState();
  }

  Future<void> _initBox() async {
    // Ensure box is open (should be opened in main.dart ideally, or lazily here)
    if (!Hive.isBoxOpen(kOnboardingBox)) {
      _box = await Hive.openBox(kOnboardingBox);
    } else {
      _box = Hive.box(kOnboardingBox);
    }

    // Check if already completed (though redirect logic might be in router)
    final isCompleted = _box.get(kOnboardingCompletedKey, defaultValue: false);
    state = state.copyWith(isCompleted: isCompleted);
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

  void selectLanguage(String languageCode) {
    state = state.copyWith(selectedLanguage: languageCode);
  }

  void selectPurpose(String purpose) {
    state = state.copyWith(selectedPurpose: purpose);
  }

  void toggleUseCase(String useCase) {
    final currentList = List<String>.from(state.selectedUseCases);
    if (currentList.contains(useCase)) {
      currentList.remove(useCase);
    } else {
      currentList.add(useCase);
    }
    state = state.copyWith(selectedUseCases: currentList);
  }

  Future<void> completeOnboarding() async {
    await _box.put(kOnboardingCompletedKey, true);
    state = state.copyWith(isCompleted: true);
  }

  Future<void> resetOnboarding() async {
    await _box.delete(kOnboardingCompletedKey);
    state = const OnboardingState();
  }
}
