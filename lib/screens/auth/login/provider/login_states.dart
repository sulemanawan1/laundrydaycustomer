
class LoginStates {
  bool isLoading;
  String? verificationId;

  
  LoginStates({
    required this.isLoading,
    this.verificationId,
  });

  LoginStates copyWith({
    bool? isLoading,
    String? verificationId,
  }) {
    return LoginStates(
      isLoading: isLoading ?? this.isLoading,
      verificationId: verificationId ?? this.verificationId,
    );
  }

  
}
