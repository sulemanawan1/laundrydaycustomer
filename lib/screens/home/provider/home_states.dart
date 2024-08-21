class HomeStates {
  int index;

  HomeStates({
    required this.index,
  });

  HomeStates copyWith({
    int? index,
  }) {
    return HomeStates(
      index: index ?? this.index,
    );
  }
}
