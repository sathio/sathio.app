class OnboardingState {
  final int currentIndex;
  final bool isCompleted;
  final String? selectedLanguage;
  final String? selectedPurpose;
  final List<String> selectedUseCases;
  final String? userName; // New field

  const OnboardingState({
    this.currentIndex = 0,
    this.isCompleted = false,
    this.selectedLanguage,
    this.selectedPurpose,
    this.selectedUseCases = const [],
    this.userName,
  });

  OnboardingState copyWith({
    int? currentIndex,
    bool? isCompleted,
    String? selectedLanguage,
    String? selectedPurpose,
    List<String>? selectedUseCases,
    String? userName,
  }) {
    return OnboardingState(
      currentIndex: currentIndex ?? this.currentIndex,
      isCompleted: isCompleted ?? this.isCompleted,
      selectedLanguage: selectedLanguage ?? this.selectedLanguage,
      selectedPurpose: selectedPurpose ?? this.selectedPurpose,
      selectedUseCases: selectedUseCases ?? this.selectedUseCases,
      userName: userName ?? this.userName,
    );
  }
}
