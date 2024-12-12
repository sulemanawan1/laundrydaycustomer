import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laundryday/models/user_model.dart';

final userProvider =
    StateNotifierProvider<UserNotifier, UserStates>((ref) => UserNotifier());

class UserNotifier extends StateNotifier<UserStates> {
  UserNotifier() : super(UserStates());
}

class UserStates {
  UserModel? userModel;
  UserStates({
    this.userModel,
  });

  UserStates copyWith({
    UserModel? userModel,
  }) {
    return UserStates(
      userModel: userModel ?? this.userModel,
    );
  }
}
