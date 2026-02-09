class OnboardingState {
  final int currentIndex;
  final bool isCompleted;
  final String? selectedLanguage;
  final String? selectedPurpose;
  final List<String> selectedUseCases; // New field

  const OnboardingState({
    this.currentIndex = 0,
    this.isCompleted = false,
    this.selectedLanguage,
    this.selectedPurpose,
    this.selectedUseCases = const [], // Default empty list
  });

  OnboardingState copyWith({
    int? currentIndex,
    bool? isCompleted,
    String? selectedLanguage,
    String? selectedPurpose,
    List<String>? selectedUseCases,
  }) {
    return OnboardingState(
      currentIndex: currentIndex ?? this.currentIndex,
      isCompleted: isCompleted ?? this.isCompleted,
      selectedLanguage: selectedLanguage ?? this.selectedLanguage,
      selectedPurpose: selectedPurpose ?? this.selectedPurpose,
      selectedUseCases: selectedUseCases ?? this.selectedUseCases,
    );
  }
}
