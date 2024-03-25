import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laundryday/screens/auth/signup/signup.dart';
import 'package:laundryday/screens/more/help/business_partner/notifier/business_partner_notifier.dart';
import 'package:laundryday/utils/colors.dart';
import 'package:laundryday/utils/font_manager.dart';
import 'package:laundryday/utils/sized_box.dart';
import 'package:laundryday/utils/value_manager.dart';
import 'package:laundryday/widgets/heading.dart';

class SelectedBuinesses extends ConsumerWidget {
  const SelectedBuinesses({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final laudnryList = ref.watch(businessPartnerProvider).laundriesList;
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: laudnryList.length,
      itemBuilder: (BuildContext context, int index) {
        final laundry = laudnryList[index];
        return Card(
          child: ExpansionTile(
            expandedAlignment: Alignment.topLeft,
            trailing: InkWell(
              onTap: () {
                ref
                    .read(businessPartnerProvider.notifier)
                    .deleteBusiness(id: laundry.id!);
              },
              child: SvgPicture.asset(
                'assets/icons/delete.svg',
                height: 20,
                color: Colors.red,
              ),
            ),
            title: Text(
              laundry.name.toString(),
              style:
                  GoogleFonts.poppins(fontWeight: FontWeightManager.semiBold),
            ),
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppPadding.p6),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Heading(text: 'Store Name in English'),
                    HeadingMedium(
                      title: laundry.name.toString(),
                      color: ColorManager.greyColor,
                    ),
                    8.ph,
                    const Heading(text: 'Store Name in Arabic'),
                    HeadingMedium(
                      title: laundry.secondaryName.toString(),
                      color: ColorManager.greyColor,
                    ),
                    8.ph,
                    8.ph,
                    const Heading(text: 'Store Type'),
                    HeadingMedium(
                      title: laundry.type.toString(),
                      color: ColorManager.greyColor,
                    ),
                    8.ph,
                    const Heading(text: 'Number of  Branches'),
                    HeadingMedium(
                      title: laundry.branches.toString(),
                      color: ColorManager.greyColor,
                    ),
                    8.ph,
                    const Heading(text: 'Services'),
                    HeadingMedium(
                      title: '',
                      color: ColorManager.greyColor,
                    ),
                    const Heading(text: 'Service Types'),
                    HeadingMedium(
                      title: 'Dry Cleaning ,Pressing,Laundry',
                      color: ColorManager.greyColor,
                    ),
                    8.ph,
                    const Heading(text: 'Region'),
                    HeadingMedium(
                      title: 'Riyadh Region',
                      color: ColorManager.greyColor,
                    ),
                    8.ph,
                    const Heading(text: 'City'),
                    HeadingMedium(
                      title: 'Riyadh',
                      color: ColorManager.greyColor,
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
