import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laundryday/utils/colors.dart';
import 'package:laundryday/utils/font_manager.dart';
import 'package:laundryday/utils/sized_box.dart';
import 'package:laundryday/utils/value_manager.dart';

final reusableOrderNowCardProvider =
    StateNotifierProvider<ReusableOrderNowCardNotifier, Color>(
        (ref) => ReusableOrderNowCardNotifier());

class ReusableOrderNowCardNotifier extends StateNotifier<Color> {
  ReusableOrderNowCardNotifier() : super(ColorManager.primaryColor);

  changeColor() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      state = state == ColorManager.primaryColor
          ? Colors.green
          : ColorManager.primaryColor;
    });
  }
}

class ReusableOrderNowCard extends ConsumerStatefulWidget {
  final void Function()? onPressed;

  const ReusableOrderNowCard({super.key, this.onPressed});

  @override
  ConsumerState<ReusableOrderNowCard> createState() =>
      _ReusableOrderNowCardState();
}

class _ReusableOrderNowCardState extends ConsumerState<ReusableOrderNowCard> {
  @override
  void initState() {
    super.initState();
    ref.read(reusableOrderNowCardProvider.notifier).changeColor();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: EdgeInsets.zero,
      color: ColorManager.purpleColor,
      shadowColor: ColorManager.mediumWhiteColor,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          5.ph,
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  flex: 4,
                  child: Padding(
                    padding: const EdgeInsets.only(left: AppPadding.p12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Order from the Nearest',
                          style: GoogleFonts.poppins(
                              color: ColorManager.whiteColor,
                              fontWeight: FontWeightManager.bold,
                              fontSize: FontSize.s18),
                        ),
                        Text(
                          'Laundry',
                          style: GoogleFonts.poppins(
                              color: ColorManager.mediumWhiteColor,
                              fontWeight: FontWeightManager.medium,
                              fontSize: FontSize.s14),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Image.asset(
                    height: 80,
                    'assets/order_now.png',
                  ),
                )
              ],
            ),
          ),
          10.ph,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppPadding.p10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  borderRadius: BorderRadius.circular(AppSize.s40),
                  onTap: widget.onPressed,
                  child: Consumer(builder: (context, ref, child) {
                    final color = ref.watch(reusableOrderNowCardProvider);
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      width: MediaQuery.of(context).size.width * 0.35,
                      height: AppSize.s40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(AppSize.s40),
                          color: color),
                      child: Center(
                        child: Text(
                          'Order Now',
                          style: GoogleFonts.poppins(
                            color: ColorManager.whiteColor,
                            fontSize: FontSize.s16,
                            fontWeight: FontWeightManager.semiBold,
                          ),
                        ),
                      ),
                    );
                  }),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Card(
                    child: Row(
                      children: [
                        Image.asset(
                          'assets/delivery_agent_vector.png',
                          height: 40,
                        ),
                        Text(
                          '4',
                          style: GoogleFonts.poppins(
                              color: ColorManager.primaryColor,
                              fontSize: FontSize.s20,
                              fontWeight: FontWeightManager.heavyBold),
                        ),
                        10.pw
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          10.ph
        ],
      ),
    );
  }
}
