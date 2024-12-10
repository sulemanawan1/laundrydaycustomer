import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laundryday/config/theme/styles_manager.dart';
import 'package:laundryday/constants/colors.dart';
import 'package:laundryday/constants/font_manager.dart';
import 'package:laundryday/constants/sized_box.dart';
import 'package:laundryday/constants/value_manager.dart';
import 'package:laundryday/screens/more/wallet/provider/wallet_notifier.dart';
import 'package:laundryday/widgets/my_app_bar.dart';
import 'package:laundryday/widgets/my_loader.dart';

class Wallet extends ConsumerWidget {
  const Wallet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final walletBalance = ref.watch(walletBalanceProvider);
    return Scaffold(
        appBar: MyAppBar(
          title: 'Wallet',
        ),
        body: walletBalance.when(
            data: (data) {
              return data.fold((l) {
                return Text(l.toString());
              }, (r) {
                return Container(
                    margin: EdgeInsets.all(AppPadding.p12),
                    height: MediaQuery.of(context).size.height / 6,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(AppSize.s8),
                        color: ColorManager.nprimaryColor.withOpacity(0.2)),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: AppPadding.p10, top: AppPadding.p10),
                          child: Text(
                            'Wallet Balance',
                            style: getBoldStyle(
                                color: ColorManager.blackColor,
                                fontSize: FontSize.s16),
                          ),
                        ),
                        20.ph,
                        Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "${r.balance!.toStringAsFixed(2)}",
                                style: getSemiBoldStyle(
                                    color: ColorManager.blackColor,
                                    fontSize: FontSize.s24),
                              ),
                              6.pw,
                              Text(
                                "SAR",
                                style: getSemiBoldStyle(
                                    color: ColorManager.blackColor,
                                    fontSize: FontSize.s16),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ));
              });
            },
            error: (error, stackTrace) => Text(error.toString()),
            loading: () => Loader()));
  }
}
