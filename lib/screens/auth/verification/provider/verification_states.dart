class VerificationStates {

  bool isLoading;

  VerificationStates({
    required this.isLoading,
  });

  VerificationStates copyWith({
    bool? isLoading,
    String? verificationId,
  }) {
    return VerificationStates(
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
