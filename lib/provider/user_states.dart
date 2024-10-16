import 'package:laundryday/models/user_model.dart';

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
