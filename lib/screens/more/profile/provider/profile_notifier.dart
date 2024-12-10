import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:laundryday/models/user_model.dart';
import 'package:laundryday/repsositories/user_repository.dart';
import 'package:laundryday/shared/provider/user_notifier.dart';

final getUserProfileApi = Provider((ref) {
  return UserRepository();
});

final userProfileProvider =
    FutureProvider.autoDispose<Either<String, UserModel>>((ref) {
  final userId = ref.read(userProvider).userModel!.user!.id;
  return ref.read(getUserProfileApi).getUserProfile(userId: userId!);
});
