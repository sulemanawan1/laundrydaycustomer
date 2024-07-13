import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:laundryday/app_services/date_picker_handler.dart';
import 'package:laundryday/helpers/validation_helper/validation_helper.dart';
import 'package:laundryday/screens/auth/signup/signup.dart';
import 'package:laundryday/screens/home/provider/home_notifier.dart';
import 'package:laundryday/screens/more/help/agent_registration/provider/delivery_agent_registartion_states.dart';
import 'package:laundryday/screens/more/help/agent_registration/provider/delivery_agent_registration_notifier.dart';
import 'package:laundryday/models/city_model.dart' as citymodel;
import 'package:laundryday/models/country_model.dart' as countrymodel;
import 'package:laundryday/models/district_model.dart' as districtmodel;
import 'package:laundryday/models/region_model.dart' as regionmodel;
import 'package:laundryday/utils/constants/colors.dart';
import 'package:laundryday/utils/constants/font_manager.dart';
import 'package:laundryday/utils/constants/sized_box.dart';
import 'package:laundryday/utils/constants/value_manager.dart';
import 'package:laundryday/utils/routes/route_names.dart';
import 'package:laundryday/utils/theme/styles_manager.dart';
import 'package:laundryday/utils/utils.dart';
import 'package:laundryday/widgets/heading.dart';
import 'package:laundryday/widgets/my_app_bar.dart';
import 'package:laundryday/widgets/my_button.dart';
import 'package:laundryday/widgets/resuable_dropdown.dart';

import '../../../../../widgets/my_textform_field.dart';

final agentRegistrationNotifier = StateNotifierProvider.autoDispose<
    DeliveryAgentRegistrationNotifier,
    DeliveryAgentStates>((ref) => DeliveryAgentRegistrationNotifier());

class AgentRegistration extends ConsumerWidget {
  final _key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(agentRegistrationNotifier.notifier);
    final states = ref.watch(agentRegistrationNotifier);
    DeliveryAgentButtonState buttonState =
        ref.watch(agentRegistrationNotifier).deliveryAgentButtonState;

    // final mobileNumber =
    //     ref.read(userProvider).userModel!.user!.customer!.mobileNumber;

    return Scaffold(
        appBar: MyAppBar(
          title: 'Agent Registration',
        ),
        body: Form(
          key: _key,
          child: SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  20.ph,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Heading(title: 'Personal Details'),
                  ),
                  20.ph,
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        Utils().resuableCameraGalleryBottomSheet(
                            context: context,
                            onCamerButtonPressed: () {
                              controller.pickImage(
                                imageSource: ImageSource.camera,
                              );
                              context.pop();
                            },
                            onGalleryButtonPressed: () {
                              controller.pickImage(
                                imageSource: ImageSource.gallery,
                              );
                              context.pop();
                            });
                      },
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              image: states.image?.path == null
                                  ? DecorationImage(
                                      fit: BoxFit.cover,
                                      image: AssetImage('assets/user.png'))
                                  : DecorationImage(
                                      fit: BoxFit.cover,
                                      image: FileImage(
                                          File(states.image!.path.toString()))),
                              color: ColorManager.mediumWhiteColor,
                              shape: BoxShape.circle,
                            ),
                          ),
                          Positioned(
                            left: 60,
                            top: 40,
                            child: GestureDetector(
                              child: Container(
                                width: 30,
                                height: 30,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: ColorManager.primaryColor),
                                child: Center(
                                    child: Icon(
                                  Icons.camera_alt,
                                  color: ColorManager.whiteColor,
                                  size: 16,
                                )),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  10.ph,
                  Align(
                    alignment: Alignment.center,
                    child: HeadingMedium(
                      title: 'Profile Picture',
                      color: ColorManager.greyColor,
                    ),
                  ),
                  10.ph,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: MyTextFormField(
                        controller: controller.firstNameController,
                        validator: AppValidator().emptyStringValidator,
                        textInputType: TextInputType.name,
                        hintText: 'First Name',
                        labelText: 'First Name'),
                  ),
                  10.ph,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: MyTextFormField(
                        controller: controller.lastNameController,
                        validator: AppValidator().emptyStringValidator,
                        textInputType: TextInputType.name,
                        hintText: 'Last Name',
                        labelText: 'Last Name'),
                  ),
                  10.ph,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: MyTextFormField(
                        validator: AppValidator().emptyStringValidator,
                        controller: controller.dobController,
                        autofillHints: const [AutofillHints.birthday],
                        readOnly: true,
                        onTap: () {
                          DatePickerHandler.datePicker(context).then((value) {
                            ref
                                .read(agentRegistrationNotifier.notifier)
                                .pickDob(dateTime: value);
                          });
                        },
                        textInputType: TextInputType.number,
                        hintText: 'Date of Birth',
                        labelText: 'Date of Birth'),
                  ),
                  10.ph,
                  ReusableDropMenu(
                      controller: controller.identityTypeController,
                      label: 'Select  Identity Type',
                      onSelected: (selectedIdentity) {},
                      list: List.generate(
                          states.IdentityTypes.length,
                          (index) => DropdownMenuEntry(
                              label: states.IdentityTypes[index],
                              value: states.IdentityTypes[index]))),
                  10.ph,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: MyTextFormField(
                        validator: AppValidator().emptyStringValidator,
                        controller: controller.identityNumberController,
                        textInputType: TextInputType.number,
                        hintText: 'Identity or Iqama Number',
                        labelText: 'Identity or Iqama Number'),
                  ),
                  20.ph,
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Heading(title: 'Address Details')),
                  20.ph,
                  ReusableDropMenu<countrymodel.Datum?>(
                      controller: controller.countryController,
                      label: 'Select  Country',
                      onSelected: (selectedCoutry) {
                        controller.selectedCountry(
                            selectedCoutry: selectedCoutry!);
                        controller.regions(countryId: selectedCoutry.id!);
                      },
                      list: List.generate(
                          states.countryModel == null
                              ? 0
                              : states.countryModel!.data!.length,
                          (index) => DropdownMenuEntry(
                              label:
                                  states.countryModel!.data![index].name ?? "",
                              value: states.countryModel!.data![index]))),
                  8.ph,
                  ReusableDropMenu<regionmodel.Datum?>(
                      controller: controller.regionController,
                      label: 'Select  Region',
                      onSelected: (selectedRegion) {
                        controller.selectedRegion(
                            selectedRegion: selectedRegion!);
                        controller.cities(regionId: selectedRegion.id!);
                      },
                      list: List.generate(
                          states.regionModel == null
                              ? 0
                              : states.regionModel!.data!.length,
                          (index) => DropdownMenuEntry(
                              label:
                                  states.regionModel!.data![index].name ?? "",
                              value: states.regionModel!.data![index]))),
                  8.ph,
                  ReusableDropMenu<citymodel.Datum?>(
                      controller: controller.cityController,
                      label: 'Select  City',
                      onSelected: (selectedCity) {
                        controller.selectedCity(selectedCity: selectedCity!);
                        controller.districts(cityId: selectedCity.id!);
                      },
                      list: List.generate(
                          states.cityModel == null
                              ? 0
                              : states.cityModel!.data!.length,
                          (index) => DropdownMenuEntry(
                              label: states.cityModel!.data![index].name ?? "",
                              value: states.cityModel!.data![index]))),
                  8.ph,
                  ReusableDropMenu<districtmodel.Datum?>(
                      controller: controller.districtController,
                      label: 'Select  District',
                      onSelected: (selectedDistrict) {
                        controller.selectedDistrict(
                            selectedDistrict: selectedDistrict!);
                      },
                      list: List.generate(
                          states.districtModel == null
                              ? 0
                              : states.districtModel!.data!.length,
                          (index) => DropdownMenuEntry(
                              label:
                                  states.districtModel!.data![index].name ?? "",
                              value: states.districtModel!.data![index]))),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        20.ph,
                        Heading(title: 'Vechile Details'),
                        20.ph,
                        MyTextFormField(
                            controller: controller.serialNumberController,
                            validator: AppValidator().emptyStringValidator,
                            hintText: 'Serial Number',
                            labelText: 'Serial Number'),
                        10.ph,
                        MyTextFormField(
                            controller: controller.typeController,
                            validator: AppValidator().emptyStringValidator,
                            hintText: 'Type',
                            labelText: 'Type'),
                        10.ph,
                        MyTextFormField(
                            textInputType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(4),
                            ],
                            controller: controller.modelController,
                            validator: AppValidator().emptyStringValidator,
                            hintText: 'ex : 2012',
                            labelText: 'Model'),
                        10.ph,
                        MyTextFormField(
                            controller: controller.classificationController,
                            validator: AppValidator().emptyStringValidator,
                            hintText: 'ex: Car,Bike etc',
                            labelText: 'Classification'),
                        10.ph,
                        Text(
                          "Vechile Plate Number",
                          style: getMediumStyle(
                              color: ColorManager.greyColor, fontSize: 12),
                        ),
                        10.ph,
                        Row(
                          children: [
                            Expanded(
                              child: MyTextFormField(
                                  onChange: (value) {
                                    if (value.length == 4) {
                                      FocusScope.of(context).requestFocus(
                                          controller.plateNumberLetterFocus);
                                    }
                                  },
                                  textInputType: TextInputType.number,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                    LengthLimitingTextInputFormatter(4),
                                  ],
                                  controller:
                                      controller.plateNumberDigitsController,
                                  validator:
                                      AppValidator().emptyStringValidator,
                                  hintText: '0000',
                                  labelText: 'Plate Number'),
                            ),
                            5.pw,
                            Expanded(
                              child: MyTextFormField(
                                  focusNode: controller.plateNumberLetterFocus,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(
                                        RegExp(r'[A-Za-z]')),
                                    LengthLimitingTextInputFormatter(3),
                                  ],
                                  controller:
                                      controller.plateNumberLettersController,
                                  validator:
                                      AppValidator().emptyStringValidator,
                                  hintText: 'ABC',
                                  labelText: 'Plate Letters'),
                            ),
                          ],
                        ),
                        5.ph,
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Note : Car plate Number must be in english like this ex",
                              style: getMediumStyle(
                                  color: ColorManager.greyColor, fontSize: 12),
                            ),
                            5.ph,
                            Text(
                              "1234ABC",
                              style: getSemiBoldStyle(
                                  color: ColorManager.purpleColor,
                                  fontSize: 12),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        20.ph,
                        Heading(title: 'Documents'),
                        20.ph,
                        _agentDoucmentPicker(
                            onTap: () {
                              Utils().resuableCameraGalleryBottomSheet(
                                  context: context,
                                  onCamerButtonPressed: () {
                                    controller.pickIdentityImage(
                                      imageSource: ImageSource.camera,
                                    );
                                    context.pop();
                                  },
                                  onGalleryButtonPressed: () {
                                    controller.pickIdentityImage(
                                      imageSource: ImageSource.gallery,
                                    );
                                    context.pop();
                                  });
                            },
                            imageFile: states.identityImage,
                            title: "National / Iqama Id"),
                        10.ph,
                        _agentDoucmentPicker(
                            imageFile: states.drivingLicenseImage,
                            onTap: () {
                              Utils().resuableCameraGalleryBottomSheet(
                                  context: context,
                                  onCamerButtonPressed: () {
                                    controller.pickdrivingLicenceImage(
                                      imageSource: ImageSource.camera,
                                    );
                                    context.pop();
                                  },
                                  onGalleryButtonPressed: () {
                                    controller.pickdrivingLicenceImage(
                                      imageSource: ImageSource.gallery,
                                    );
                                    context.pop();
                                  });
                            },
                            title: "Driver's Licence Image"),
                        10.ph,
                        _agentDoucmentPicker(
                            imageFile: states.registrationImage,
                            onTap: () {
                              Utils().resuableCameraGalleryBottomSheet(
                                  context: context,
                                  onCamerButtonPressed: () {
                                    controller.pickRegistrationeImage(
                                      imageSource: ImageSource.camera,
                                    );
                                    context.pop();
                                  },
                                  onGalleryButtonPressed: () {
                                    controller.pickRegistrationeImage(
                                      imageSource: ImageSource.gallery,
                                    );
                                    context.pop();
                                  });
                            },
                            title: "Vechile Registation"),
                        10.ph,
                        _agentDoucmentPicker(
                            imageFile: states.frontImage,
                            onTap: () {
                              Utils().resuableCameraGalleryBottomSheet(
                                  context: context,
                                  onCamerButtonPressed: () {
                                    controller.pickFrontImage(
                                      imageSource: ImageSource.camera,
                                    );
                                    context.pop();
                                  },
                                  onGalleryButtonPressed: () {
                                    controller.pickFrontImage(
                                      imageSource: ImageSource.gallery,
                                    );
                                    context.pop();
                                  });
                            },
                            title: "Front Vechile Image"),
                        10.ph,
                        _agentDoucmentPicker(
                            imageFile: states.rearImage,
                            onTap: () {
                              Utils().resuableCameraGalleryBottomSheet(
                                  context: context,
                                  onCamerButtonPressed: () {
                                    controller.pickRearImage(
                                      imageSource: ImageSource.camera,
                                    );
                                    context.pop();
                                  },
                                  onGalleryButtonPressed: () {
                                    controller.pickRearImage(
                                      imageSource: ImageSource.gallery,
                                    );
                                    context.pop();
                                  });
                            },
                            title: "Rear Vechile Image"),
                        10.ph,
                      ],
                    ),
                  ),
                  10.ph,
                  if (buttonState is DeliveryAgentButtonInitialState) ...[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: MyButton(
                        title: 'Submit',
                        onPressed: () async {
                          if (_key.currentState!.validate()) {
                            if (states.selectedCountry == null) {
                              Utils.showSnackBar(
                                  color: ColorManager.redColor,
                                  context: context,
                                  message: 'Country Required');
                            } else if (states.selectedRegion == null) {
                              Utils.showSnackBar(
                                  color: ColorManager.redColor,
                                  context: context,
                                  message: 'Region Required');
                            } else if (states.selectedCity == null) {
                              Utils.showSnackBar(
                                  color: ColorManager.redColor,
                                  context: context,
                                  message: 'City Required');
                            } else if (states.selectedDistrict == null) {
                              Utils.showSnackBar(
                                  color: ColorManager.redColor,
                                  context: context,
                                  message: 'District Required');
                            } else if (states.image == null) {
                              Utils.showSnackBar(
                                  color: ColorManager.redColor,
                                  context: context,
                                  message: 'Profile Image Required');
                            } else if (states.identityImage == null) {
                              Utils.showSnackBar(
                                  color: ColorManager.redColor,
                                  context: context,
                                  message: 'National / Iqama ID Required');
                            } else if (states.drivingLicenseImage == null) {
                              Utils.showSnackBar(
                                  color: ColorManager.redColor,
                                  context: context,
                                  message: 'Driving Licence Image Required');
                            } else if (states.registrationImage == null) {
                              Utils.showSnackBar(
                                  color: ColorManager.redColor,
                                  context: context,
                                  message:
                                      'Vechile Registration Image Required');
                            } else if (states.frontImage == null) {
                              Utils.showSnackBar(
                                  color: ColorManager.redColor,
                                  context: context,
                                  message: 'Vechile Rear Image Required');
                            } else if (states.frontImage == null) {
                              Utils.showSnackBar(
                                  color: ColorManager.redColor,
                                  context: context,
                                  message: 'Vechile Front Image Required');
                            } else {
                              // log("....................................................\n");
                              // log("Image: ${states.image!.path}");
                              // log("First Name : ${controller.firstNameController.text}");
                              // log("Last Name : ${controller.lastNameController.text}");
                              // log("Date of Birth  : ${controller.dobController.text}");
                              // log("Identity Type  : ${controller.identityTypeController.text}");
                              // log("Identity Number  : ${controller.identityNumberController.text}");
                              // log("Country Id : ${states.selectedCountry!.id}");
                              // log("Region Id : ${states.selectedRegion!.id}");
                              // log("City Id : ${states.selectedCity!.id}");
                              // log("District Id : ${states.selectedDistrict!.id}");
                              // log("Serial Number : ${controller.serialNumberController.text}");
                              // log("Type : ${controller.typeController.text}");
                              // log("Classification : ${controller.classificationController.text}");
                              // log("Model : ${controller.modelController.text}");
                              // log("Plate Number : ${controller.plateNumberController.text}");
                              // log("....................................................\n");
                              Map<String, String> files = {
                                'image': states.image!.path.toString(),
                                'identity_image':
                                    states.identityImage!.path.toString(),
                                'front_image':
                                    states.frontImage!.path.toString(),
                                'rear_image': states.rearImage!.path.toString(),
                                'driving_license_image':
                                    states.drivingLicenseImage!.path.toString(),
                                'registration_image':
                                    states.registrationImage!.path.toString(),
                              };

                              Map<String, String> data = {
                                'first_name':
                                    controller.firstNameController.text,
                                'last_name': controller.lastNameController.text,
                                'date_of_birth': controller.dobController.text,
                                'identity_type':
                                    controller.identityTypeController.text,
                                'identity_number':
                                    controller.identityNumberController.text,
                                'country_id':
                                    states.selectedCountry!.id.toString(),
                                'region_id':
                                    states.selectedRegion!.id.toString(),
                                'city_id': states.selectedCity!.id.toString(),
                                'district_id':
                                    states.selectedDistrict!.id.toString(),
                                'serial_number':
                                    controller.serialNumberController.text,
                                'type': controller.typeController.text,
                                'classification':
                                    controller.classificationController.text,
                                'model': controller.modelController.text,
                                'plate_number':
                                    "${controller.plateNumberDigitsController.text}-${controller.plateNumberLettersController.text}",
                                'mobile_number': '+9666655555'
                              };

                              controller.registerDeliveryAgent(
                                  context: context,
                                  files: files,
                                  data: data,
                                  ref: ref);
                            }
                          }
                        },
                      ),
                    )
                  ] else if (buttonState
                      is DeliveryAgentButtonLoadingState) ...[
                    Center(child: CircularProgressIndicator()),
                  ] else if (buttonState is DeliveryAgentButtonLoadedState) ...[
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              buttonState.deliveryAgentRegistrationModel.message
                                  .toString(),
                              style: getSemiBoldStyle(
                                  color: ColorManager.amber,
                                  fontSize: FontSize.s14),
                            ),
                            10.ph,
                            OutlinedButton(
                                onPressed: () {
                                  ref
                                      .read(homeProvider.notifier)
                                      .changeIndex(index: 0, ref: ref);

                                  context
                                      .pushReplacementNamed(RouteNames().home);
                                },
                                child: Text('Go to homen sccreen.'))
                          ],
                        ),
                      ),
                    ),
                  ] else if (buttonState is DeliveryAgentButtonErrorState) ...[
                    Text(buttonState.errorMessage.toString())
                  ],
                  20.ph,
                ]),
          ),
        ));
  }

  Widget _agentDoucmentPicker(
      {void Function()? onTap, XFile? imageFile, required String? title}) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title ?? "",
            style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
                fontSize: 14,
                color: imageFile?.path == null
                    ? Colors.blue
                    : ColorManager.primaryColor),
          ),
          Icon(
            imageFile?.path == null ? Icons.upload : Icons.check,
            color: imageFile?.path == null
                ? ColorManager.greyColor
                : ColorManager.primaryColor,
          )
        ],
      ),
    );
  }
}
