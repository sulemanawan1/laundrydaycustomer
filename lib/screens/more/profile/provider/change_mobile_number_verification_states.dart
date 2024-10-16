class ChangeMobileNumberVerificationStates {
  bool isLoading;

  ChangeMobileNumberVerificationStates({
    required this.isLoading,
  });

  ChangeMobileNumberVerificationStates copyWith({
    bool? isLoading,
  }) {
    return ChangeMobileNumberVerificationStates(
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
