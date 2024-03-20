class AddNewCardStates {
  
  bool isValidate = false;
  AddNewCardStates({
    required this.isValidate,
  });

  AddNewCardStates copyWith({
    bool? isValidate,
  }) {
    return AddNewCardStates(
      isValidate: isValidate ?? this.isValidate,
    );
  }
}
