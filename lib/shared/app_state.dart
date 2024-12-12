abstract class AppState {}

class AppInitialState extends AppState {}

class AppLoadingState extends AppState {}

class AppLoadedState <T> extends AppState {
    final T data;

  AppLoadedState({required this.data});
}


class AppErrorState<T> extends AppState {
  final T error;

  AppErrorState({required this.error});
}
