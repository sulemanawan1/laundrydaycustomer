import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laundryday/screens/auth/signup/signup.dart';
import 'package:laundryday/utils/colors.dart';
import 'package:laundryday/utils/sized_box.dart';
import 'package:laundryday/utils/value_manager.dart';
import 'package:laundryday/widgets/my_heading/heading.dart';

class AddressDetailWidget extends ConsumerWidget {
  const AddressDetailWidget({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Heading(text: 'Addresss details'),
        6.ph,
        HeadingMedium(
          title: "Select the location of delievry",
          color: ColorManager.greyColor,
        ),
        6.ph,
        SizedBox(
          width: double.infinity,
          height: 80,
          child: Card(
            elevation: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppPadding.p10, vertical: AppPadding.p8),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const HeadingSmall(title: 'Deliver to'),
                    HeadingMedium(
                      title: 'RkHA, Al- Mahamid Riyadh',
                      color: ColorManager.primaryColor,
                    ),
                  ]),
            ),
          ),
        )
      ],
    );

    ;
  }
}