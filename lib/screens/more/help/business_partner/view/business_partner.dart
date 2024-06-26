import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laundryday/screens/more/help/business_partner/components/address_information.dart';
import 'package:laundryday/screens/more/help/business_partner/components/business_information.dart';
import 'package:laundryday/screens/more/help/business_partner/components/business_information_2.dart';
import 'package:laundryday/screens/more/help/business_partner/components/contact_information.dart';
import 'package:laundryday/screens/more/help/business_partner/notifier/business_partner_notifier.dart';
import 'package:laundryday/screens/more/help/business_partner/notifier/business_partner_state.dart';
import 'package:laundryday/screens/more/help/business_partner/notifier/business_partner_textformfields.dart';
import 'package:laundryday/utils/colors.dart';
import 'package:laundryday/widgets/my_app_bar.dart';

final bussinessPartnerProvider = StateNotifierProvider.autoDispose<
    BusinessPartnerNotifier,
    BusinessPartnerState>((ref) => BusinessPartnerNotifier());

class BusinessPartner extends ConsumerStatefulWidget {
  const BusinessPartner({super.key});

  @override
  ConsumerState<BusinessPartner> createState() => _BusinessPartnerState();
}

class _BusinessPartnerState extends ConsumerState<BusinessPartner> {
  @override
  Widget build(BuildContext context) {
    var currentStep = ref.watch(businessPartnerProvider).currentStep;

    return Scaffold(
      appBar: MyAppBar(
        onPressed: () {
          BusinessPartnerTextFormFields.cleartAllTextFormFields();
          context.pop();
        },
        title: 'Laundry Day Business',
      ),
      body: Theme(
          data: ThemeData(
            canvasColor: ColorManager.tranparentColor,
          ),
          child: Stepper(
              elevation: 0,
              connectorThickness: 0.3,
              currentStep: currentStep,
              controlsBuilder: (context, details) {
                return Row(
                  children: [
                    TextButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateColor.resolveWith(
                              (states) => ColorManager.primaryColor)),
                      onPressed: details.onStepContinue,
                      child: Text(
                        'Continue',
                        style:
                            GoogleFonts.poppins(color: ColorManager.whiteColor),
                      ),
                    ),
                    TextButton(
                      onPressed: details.onStepCancel,
                      child: Text(
                        'Back',
                        style:
                            GoogleFonts.poppins(color: ColorManager.blackColor),
                      ),
                    ),
                  ],
                );
              },
              connectorColor: MaterialStateColor.resolveWith((states) {
                if (states.contains(MaterialState.selected)) {
                  return ColorManager.primaryColor;
                }
                return Colors.grey;
              }),
              onStepContinue: () {
                ref
                    .read(businessPartnerProvider.notifier)
                    .onStepContinue(context: context);
              },
              onStepCancel: () {
                ref
                    .read(businessPartnerProvider.notifier)
                    .onStepCancel(context: context);
              },
              type: StepperType.horizontal,
              steps: [
                Step(
                    title: const SizedBox(),
                    isActive: currentStep >= 0 ? true : false,
                    content: BusinessInformation()),
                Step(
                    title: const SizedBox(),
                    content: const BusinessInformation2(),
                    isActive: currentStep >= 1 ? true : false),
                Step(
                    title: const SizedBox(),
                    content: const AddressInformation(),
                    isActive: currentStep >= 2 ? true : false),
                Step(
                    title: const SizedBox(),
                    content: const ContactInformation(),
                    isActive: currentStep >= 3 ? true : false),
              ])),
    );
  }
}
