import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:laundryday/models/wallet_model.dart';
import 'package:laundryday/repsositories/wallet_repository.dart';
import 'package:laundryday/shared/provider/user_notifier.dart';

final walletApi = Provider((ref) {
  return WalletRepository();
});

final walletBalanceProvider =
    FutureProvider.autoDispose<Either<String, WalletModel>>((ref) {
  final userId = ref.read(userProvider).userModel!.user!.id;

  return ref.read(walletApi).walletBalance(userId: userId!);
});
