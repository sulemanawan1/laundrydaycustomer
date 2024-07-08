import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laundryday/provider/user_states.dart';

final userProvider =
    StateNotifierProvider<UserNotifier, UserStates>((ref) => UserNotifier());

class UserNotifier extends StateNotifier<UserStates> {
  UserNotifier() : super(UserStates());
}
