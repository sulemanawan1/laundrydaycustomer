import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:laundryday/models/user_model.dart';
import 'package:laundryday/provider/user_notifier.dart';
import 'package:laundryday/screens/more/profile/service/user_service.dart';

final getUserProfileApi = Provider((ref) {
  return UserService();
});

final userProfileProvider =
    FutureProvider.autoDispose<Either<String, UserModel>>((ref) {
  final userId = ref.read(userProvider).userModel!.user!.id;
  return ref.read(getUserProfileApi).getUserProfile(userId: userId!);
});
