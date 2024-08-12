import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laundryday/config/resources/colors.dart';

import 'package:laundryday/config/resources/sized_box.dart';
import 'package:laundryday/config/theme/styles_manager.dart';
import 'package:laundryday/core/widgets/heading.dart';
import 'package:laundryday/screens/delivery_pickup/view/delivery_pickup.dart';
import 'package:laundryday/screens/services/model/services_model.dart' as s;

class PaymentSummaryWidget extends ConsumerWidget {
  s.Datum? service;

  PaymentSummaryWidget({
    super.key,
    this.service,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deliveryfee = ref.watch(deliverPickupProvider).deliveryfees;
    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Heading(
              title: 'Payment Summary',
            ),
            10.ph,
            PaymentSummaryText(
                text1: 'Delievery Fees', text2: "${service!.deliveryFee} SAR"),
            PaymentSummaryText(
                text1: 'Operation Fees',
                text2: "${service!.operationFee.toString()} SAR"),
          ],
        ),
      ),
    );
  }
}

class PaymentSummaryText extends StatelessWidget {
  final String text1;
  final String text2;

  const PaymentSummaryText(
      {super.key, required this.text1, required this.text2});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text1,
              style: getRegularStyle(fontSize: 16,color: ColorManager.blackColor),
            ),
            Text(
              text2,
              style: getSemiBoldStyle(color: ColorManager.blackColor,
                  fontSize: 16,),
            ),
          ],
        ),
        5.ph,
      ],
    );
  }
}
