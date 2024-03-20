import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laundryday/screens/more/help/business_partner/components/address_information.dart';
import 'package:laundryday/screens/more/help/business_partner/components/business_information.dart';
import 'package:laundryday/screens/more/help/business_partner/components/contact_information.dart';
import 'package:laundryday/screens/more/help/business_partner/notifier/business_partner_notifier.dart';
import 'package:laundryday/screens/more/help/business_partner/state/business_partner_state.dart';
import 'package:laundryday/utils/colors.dart';
import 'package:laundryday/utils/font_manager.dart';
import 'package:laundryday/utils/value_manager.dart';
import 'package:laundryday/widgets/my_app_bar/my_app_bar.dart';

final bussinessPartnerProvider = StateNotifierProvider.autoDispose<
    BusinessPartnerNotifier,
    BusinessPartnerState>((ref) => BusinessPartnerNotifier());

class BusinessPartner extends ConsumerStatefulWidget {
  const BusinessPartner({super.key});

  @override
  ConsumerState<BusinessPartner> createState() => _BusinessPartnerState();
}

class _BusinessPartnerState extends ConsumerState<BusinessPartner> {
  int currentStep = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: 'Laundry Day Business',
      ),
      body: Theme(
        data: ThemeData(
          canvasColor: ColorManager.tranparentColor,
        ),
        child: Builder(builder: (context) {
          return LayoutBuilder(builder: (context, constraint) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: SizedBox(
                    height: constraint.maxHeight * 0.15,
                    child: ListView.builder(
                      itemCount: 2,
                      itemBuilder: (BuildContext context, int index) {
                        return ExpansionTile(
                          collapsedBackgroundColor:
                              Colors.amber.withOpacity(0.2),
                          title: Text(
                            'Shop ${index+1}',
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeightManager.semiBold,
                                fontSize: FontSize.s15),
                          ),
                          children: [
                            Card(
                              color: ColorManager.whiteColor,
                              child: ListTile(
                                title: Text(
                                  'Laundry ${index + 1}',
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeightManager.semiBold,
                                      fontSize: FontSize.s15),
                                ),
                                trailing: SvgPicture.asset(
                                  'assets/icons/delete.svg',
                                  height: 20,
                                  color: Colors.red,
                                ),
                              ),
                            )
                          ],
                        );
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: constraint.maxHeight * 0.85,
                  child: Stepper(
                      elevation: 0,
                      connectorThickness: 0.3,
                      currentStep: currentStep,
                      controlsBuilder: (context, details) {
                        return Row(
                          children: [
                            TextButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateColor.resolveWith((states) =>
                                          ColorManager.primaryColor)),
                              onPressed: details.onStepContinue,
                              child: Text(
                                'Continue',
                                style: GoogleFonts.poppins(
                                    color: ColorManager.whiteColor),
                              ),
                            ),
                            TextButton(
                              onPressed: details.onStepCancel,
                              child: Text(
                                'Back',
                                style: GoogleFonts.poppins(
                                    color: ColorManager.blackColor),
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
                        if (currentStep < 2) {
                          currentStep++;
                          setState(() {});
                        }
                      },
                      onStepCancel: () {
                        if (currentStep <= 0) {
                          currentStep = 0;
                        } else {
                          currentStep--;

                          setState(() {});
                        }
                      },
                      type: StepperType.horizontal,
                      steps: [
                        Step(
                            title: const SizedBox(),
                            isActive: currentStep >= 0 ? true : false,
                            content: BusinessInformation()),
                        Step(
                            title: const SizedBox(),
                            content: ContactInformation(),
                            isActive: currentStep >= 1 ? true : false),
                        Step(
                            title: const SizedBox(),
                            content: const AddressInformation(),
                            isActive: currentStep >= 2 ? true : false),
                      ]),
                ),
              ],
            );
          });
        }),
      ),
    );
  }
}
