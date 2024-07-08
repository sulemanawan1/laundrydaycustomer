
class SignupStates {
  bool isLoading;
  SignupStates({
    required this.isLoading,
  });

  SignupStates copyWith({
    bool? isLoading,
  }) {
    return SignupStates(
      isLoading: isLoading ?? this.isLoading,
    );
  }


}
