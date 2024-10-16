
class ChangeMobileNumberStates {

  bool isLoading;
  String? verificationId;
  ChangeMobileNumberStates({
    required this.isLoading,
    this.verificationId,
  });


  ChangeMobileNumberStates copyWith({
    bool? isLoading,
    String? verificationId,
  }) {
    return ChangeMobileNumberStates(
      isLoading: isLoading ?? this.isLoading,
      verificationId: verificationId ?? this.verificationId,
    );
  }
}
