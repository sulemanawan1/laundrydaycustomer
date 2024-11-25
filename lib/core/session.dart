import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laundryday/models/user_model.dart';
import 'package:laundryday/provider/user_notifier.dart';
import 'package:laundryday/constants/my_shareprefrences_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MySharedPreferences {
  static Future<void> deleterUserSession() async {
    await SharedPreferences.getInstance().then((value) {
      value.remove(userIdSPKey);
      value.remove(firstNameSPKey);
      value.remove(lastNameSPKey);
      value.remove(roleSPKEY);
      value.remove(tokenSPKEY);
      value.remove(userNameSPKEY);
      value.remove(mobileNumberSPKEY);
    });
  }

  static saveUserSession({UserModel? user}) async {
    await SharedPreferences.getInstance().then((value) {
      value.setInt(userIdSPKey, user?.user?.id ?? 0);
      value.setString(firstNameSPKey, user?.user?.firstName ?? '');
      value.setString(lastNameSPKey, user?.user?.lastName ?? '');
      value.setString(roleSPKEY, user?.user?.role ?? '');
      value.setString(tokenSPKEY, user?.token ?? '');
      value.setString(userNameSPKEY, user?.user?.userName ?? '');
      value.setString(mobileNumberSPKEY, user?.user?.mobileNumber ?? '');
    });
  }

  static Future<UserModel> getUserSession() async {
    UserModel user = UserModel();

    await SharedPreferences.getInstance().then((value) {
      user = UserModel(
        token: value.getString(tokenSPKEY),
        user: User(
          id: value.getInt(userIdSPKey) ?? 0,
          firstName: value.getString(firstNameSPKey),
          lastName: value.getString(lastNameSPKey),
          role: value.getString(roleSPKEY),
          userName: value.getString(providerSPKEY),
          mobileNumber: value.getString(mobileNumberSPKEY)
        ),
      );
    });
    return user;
  }

  Future<int?> getUserData({required WidgetRef ref}) async {
    var userState = ref.watch(userProvider);

    userState.userModel = await MySharedPreferences.getUserSession();

    userState = userState.copyWith(userModel: userState.userModel);

    return userState.userModel?.user?.id;
  }
}
