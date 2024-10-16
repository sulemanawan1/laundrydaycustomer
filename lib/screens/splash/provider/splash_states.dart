import 'package:laundryday/models/user_model.dart';

class SplashStates {
  UserModel? userModel;
  SplashStates({
    required this.userModel,
  });

  SplashStates copyWith({
    UserModel? userModel,
  }) {
    return SplashStates(
      userModel: userModel ?? this.userModel,
    );
  }
}
