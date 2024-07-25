import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laundryday/core/constants/colors.dart';
import 'package:laundryday/core/constants/font_manager.dart';
import 'package:laundryday/core/constants/value_manager.dart';

final reusableOrderNowCardProvider =
    StateNotifierProvider<ReusableOrderNowCardNotifier, Color>(
        (ref) => ReusableOrderNowCardNotifier());

class ReusableOrderNowCardNotifier extends StateNotifier<Color> {
  ReusableOrderNowCardNotifier() : super(ColorManager.primaryColor);

  changeColor() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      state = state == ColorManager.purpleColor
          ? Colors.purple
          : ColorManager.purpleColor;
    });
  }
}

class ReusableOrderNowCard extends ConsumerStatefulWidget {
  final void Function()? onPressed;
  final String image;

  const ReusableOrderNowCard({super.key, this.onPressed, required this.image});

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
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.bottomLeft,
      children: [
        Image.asset(
          width: MediaQuery.of(context).size.width,
          widget.image,
        ),
        Positioned(
          right: 60,
          bottom: 10,
          child: Align(
            alignment: Alignment.bottomRight,
            child: InkWell(
              borderRadius: BorderRadius.circular(AppSize.s40),
              onTap: widget.onPressed,
              child: Consumer(builder: (context, ref, child) {
                final color = ref.watch(reusableOrderNowCardProvider);
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: MediaQuery.of(context).size.width * 0.5,
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
          ),
        ),
        Positioned(
          right: 5,
          bottom: 10,
          child: Align(
            alignment: Alignment.bottomRight,
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8), color: Colors.purple),
              width: 40,
              height: 40,
              child: Center(
                child: Text(
                  '4',
                  style: GoogleFonts.poppins(
                      color: ColorManager.primaryColor,
                      fontSize: FontSize.s20,
                      fontWeight: FontWeightManager.semiBold),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
