import 'package:image_picker/image_picker.dart';
import 'package:laundryday/models/user_model.dart';

class EditProfileStates {
final  ProfileUpdateStates profileUpdateStates;
  XFile? image;

  EditProfileStates({
    this.image,
    required this.profileUpdateStates,
  });

  EditProfileStates copyWith({
      XFile? image,

    ProfileUpdateStates? profileUpdateStates,
  }) {
    return EditProfileStates(
      image: image??this.image,
      profileUpdateStates: profileUpdateStates ?? this.profileUpdateStates,
    );
  }
}

abstract class ProfileUpdateStates {}

class ProfileUpdateIntitialState extends ProfileUpdateStates {}

class ProfileUpdateLoadingState extends ProfileUpdateStates {}

class ProfileUpdateLoadedState extends ProfileUpdateStates {
  final UserModel userModel;
  ProfileUpdateLoadedState({required this.userModel});
}

class ProfileUpdateErrorState extends ProfileUpdateStates {
  String errorMessage;
  ProfileUpdateErrorState({required this.errorMessage});
}
