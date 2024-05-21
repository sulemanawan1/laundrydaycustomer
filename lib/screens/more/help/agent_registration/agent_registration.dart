import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:laundryday/screens/auth/signup/signup.dart';
import 'package:laundryday/screens/more/help/agent_registration/notfiers/agent_registration_notifier.dart';
import 'package:laundryday/screens/more/help/agent_registration/notfiers/agent_registration_state.dart';
import 'package:laundryday/screens/more/help/agent_registration/notfiers/driving_licence_image_notifier.dart';
import 'package:laundryday/screens/more/help/agent_registration/notfiers/front_vechile_image_notifier.dart';
import 'package:laundryday/screens/more/help/agent_registration/notfiers/national_or_iqama_id_notifier.dart';
import 'package:laundryday/screens/more/help/agent_registration/notfiers/profile_picture_notifier.dart';
import 'package:laundryday/screens/more/help/agent_registration/notfiers/rear_vechile_image.notifier.dart';
import 'package:laundryday/screens/more/help/agent_registration/notfiers/vechile_registration_image_notifier.dart';
import 'package:laundryday/utils/colors.dart';
import 'package:laundryday/utils/sized_box.dart';

import 'package:laundryday/app_services/date_picker_handler.dart';
import 'package:laundryday/utils/value_manager.dart';
import 'package:laundryday/widgets/my_app_bar.dart';
import 'package:laundryday/widgets/my_button.dart';
import 'package:laundryday/widgets/my_textform_field.dart';

final agentRegistrationNotifier = StateNotifierProvider.autoDispose<
    AgentRegistrationNotifier,
    AgentRegistrationState>((ref) => AgentRegistrationNotifier());

// ignore: must_be_immutable
class AgentRegistration extends ConsumerStatefulWidget {
  String? area;
  String? city;

  AgentRegistration({super.key, required this.area, required this.city});

  @override
  ConsumerState<AgentRegistration> createState() => _AgentRegistrationState();
}

class _AgentRegistrationState extends ConsumerState<AgentRegistration> {
  // AgentRegistrationNotifier agentRegistrationController =
  //     AgentRegistrationNotifier();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final areaController = TextEditingController();
    final cityController = TextEditingController();
    final profileImage = ref.watch(profilePictureProvider);
    final firstNameController = TextEditingController();
    final lastNameContrller = TextEditingController();
    final dobController = TextEditingController();

    final drivingLicenceImage = ref.watch(dringLicenceImageProvider);
    final vechileRegistrationImage =
        ref.watch(vechileRegistrationImageProvider);
    final nationalOrIqamaIdImage = ref.watch(nationalOrIqamaIdProvider);
    final frontVechileImage = ref.watch(frontVechileImageProvider);
    final rearVechileImage = ref.watch(rearVechileImageProvider);

    return Scaffold(
        appBar: MyAppBar(
          title: 'Agent Registration',
          
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppPadding.p10),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        20.ph,
                        Center(
                          child: GestureDetector(
                            onTap: () {
                              showModalBottomSheet(
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(AppSize.s12),
                                          topRight: Radius.circular(AppSize.s12))),
                                  context: context,
                                  builder: (context) {
                                    return SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.14,
                                      child: Column(
                                        children: <Widget>[
                                          10.ph,
                                          const Text(
                                            'Choose Photo',
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          20.ph,
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: <Widget>[
                                              ElevatedButton.icon(
                                                style: ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                      ColorManager
                                                            .  primaryColor),
                                                icon: const Icon(
                                                  Icons.camera,
                                                ),
                                                onPressed: () async {
                                                  await ref
                                                      .read(
                                                          profilePictureProvider
                                                              .notifier)
                                                      .pickImage(
                                                          imageSource:
                                                              ImageSource
                                                                  .camera);
                                                  // ignore: use_build_context_synchronously
                                                  context.pop();
                                                },
                                                label: const Text('Camera'),
                                              ),
                                              ElevatedButton.icon(
                                                style: ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                       ColorManager
                                                            . primaryColor),
                                                icon: const Icon(Icons.image),
                                                onPressed: () async {
                                                  await ref
                                                      .read(
                                                          profilePictureProvider
                                                              .notifier)
                                                      .pickImage(
                                                          imageSource:
                                                              ImageSource
                                                                  .gallery);
                                                  // ignore: use_build_context_synchronously
                                                  context.pop();
                                                },
                                                label: const Text('Gallery'),
                                              ),
                                            ],
                                          ),
                                          20.ph
                                        ],
                                      ),
                                    );
                                  });
                            },
                            child: Stack(
                              clipBehavior: Clip.none,
                              children: [
                                Container(
                                  width: 80,
                                  height: 80,
                                  decoration: BoxDecoration(
                                    image: profileImage?.path == null
                                        ? null
                                        : DecorationImage(
                                            fit: BoxFit.cover,
                                            image: FileImage(File(profileImage!
                                                .path
                                                .toString()))),
                                    color: ColorManager. mediumWhiteColor,
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
                                      decoration:  BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: ColorManager. primaryColor),
                                      child:  Center(
                                          child: Icon(
                                        Icons.camera_alt,
                                        color: ColorManager. whiteColor,
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
                            title: 'Tap to add Profile Picture',
                            color: ColorManager.greyColor,
                          ),
                        ),
                        10.ph,
                        MyTextFormField(
                            autofillHints: const [AutofillHints.givenName],
                            controller: firstNameController,
                            textInputType: TextInputType.name,
                            hintText: 'First Name',
                            labelText: 'First Name'),
                        10.ph,
                        MyTextFormField(
                            autofillHints: const [AutofillHints.familyName],
                            controller: lastNameContrller,
                            textInputType: TextInputType.name,
                            hintText: 'Last Name',
                            labelText: 'Last Name'),
                        10.ph,
                        MyTextFormField(
                            autofillHints: const [AutofillHints.birthday],
                            controller: dobController,
                            readOnly: true,
                            onTap: () {
                              DatePickerHandler.datePicker(context)
                                  .then((value) {
                                ref
                                    .read(agentRegistrationNotifier.notifier)
                                    .pickDob(dateTime: value);

                                ref
                                    .read(agentRegistrationNotifier.notifier)
                                    .setDob(dobController: dobController);
                              });
                            },
                            textInputType: TextInputType.number,
                            hintText: 'Date of Birth',
                            labelText: 'Date of Birth'),
                        10.ph,
                        HeadingMedium(
                          title: "Your Identity",
                          color: ColorManager. primaryColor,
                        ),
                        DropdownButton<IDType?>(
                            isExpanded: true,
                            padding: EdgeInsets.zero,
                            value: ref.watch(agentRegistrationNotifier).idType,
                            onChanged: (IDType? newValue) {
                              if (newValue != null) {
                                ref
                                    .read(agentRegistrationNotifier.notifier)
                                    .setIDType(newValue);
                              }
                            },
                            items: IDType.values.map((IDType type) {
                              return DropdownMenuItem<IDType>(
                                value: type,
                                child: Text(
                                  type == IDType.residentId
                                      ? 'Resident ID'
                                      : 'National ID',
                                  style: GoogleFonts.poppins(),
                                ),
                              );
                            }).toList()),
                        10.ph,
                        MyTextFormField(
                            textInputType: TextInputType.number,
                            hintText: 'Identity or Iqama Number',
                            labelText: 'Identity or Iqama Number'),
                        10.ph,
                        HeadingMedium(
                          title: "Select your preferred  area for work.",
                          color: ColorManager. primaryColor,
                        ),
                        10.ph,
                        MyTextFormField(
                            readOnly: true,
                            controller: areaController,
                            onTap: () {
                              // GoRouter.of(context)
                              //     .pushNamed(RouteNames().fetchAgentAddress);
                            },
                            hintText: 'Ex : Area',
                            labelText: 'Area'),
                        10.ph,
                        MyTextFormField(
                            readOnly: true,
                            controller: cityController,
                            hintText: 'City',
                            labelText: 'City'),
                        10.ph,
                        MyTextFormField(
                            textInputType: TextInputType.name,
                            hintText: 'Car Serial Number',
                            labelText: 'Car Serial Number'),
                        10.ph,
                        MyTextFormField(
                            textInputType: TextInputType.name,
                            hintText: 'Car Brand',
                            labelText: 'Car Brand'),
                        10.ph,
                        MyTextFormField(
                            textInputType: TextInputType.name,
                            hintText: 'Model',
                            labelText: 'Model'),
                        10.ph,
                        MyTextFormField(
                            textInputType: TextInputType.name,
                            hintText: 'Plate Number',
                            labelText: 'Plate Number'),
                        20.ph,
                        _agentDoucmentPicker(
                            onTap: () {
                              ref
                                  .read(dringLicenceImageProvider.notifier)
                                  .pickImage(imageSource: ImageSource.gallery);
                            },
                            imageFile: drivingLicenceImage,
                            title: "Driver's Licence Image"),
                        10.ph,
                        _agentDoucmentPicker(
                            onTap: () {
                              ref
                                  .read(
                                      vechileRegistrationImageProvider.notifier)
                                  .pickImage(imageSource: ImageSource.gallery);
                            },
                            imageFile: vechileRegistrationImage,
                            title: "Vechile Registation"),
                        10.ph,
                        _agentDoucmentPicker(
                            onTap: () {
                              ref
                                  .read(nationalOrIqamaIdProvider.notifier)
                                  .pickImage(imageSource: ImageSource.gallery);
                            },
                            imageFile: nationalOrIqamaIdImage,
                            title: "National / Iqama Id"),
                        10.ph,
                        _agentDoucmentPicker(
                            onTap: () {
                              ref
                                  .read(frontVechileImageProvider.notifier)
                                  .pickImage(imageSource: ImageSource.gallery);
                            },
                            imageFile: frontVechileImage,
                            title: "Front Vechile Image"),
                        10.ph,
                        _agentDoucmentPicker(
                            onTap: () {
                              ref
                                  .read(rearVechileImageProvider.notifier)
                                  .pickImage(imageSource: ImageSource.gallery);
                            },
                            imageFile: rearVechileImage,
                            title: "Rear Vechile Image"),
                        10.ph,
                      ],
                    ),
                  ),
                ),
                Column(
                  children: [
                    10.ph,
                    MyButton(
                      name: 'Submit',
                      onPressed: () {
                        log("....................................................\n");
                        log("Profile Image :$profileImage");
                        log("First Name : ${firstNameController.text}");
                        log("Last Name : ${lastNameContrller.text}");
                        // log("Dob $dob");
                        // log("Driving License $dri");

                        log("....................................................\n");
                      },
                    ),
                    30.ph,
                  ],
                )
              ]),
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
                color: imageFile?.path == null ? ColorManager. blackColor : ColorManager.primaryColor),
          ),
          Icon(
            imageFile?.path == null ? Icons.upload : Icons.check,
            color: imageFile?.path == null ? ColorManager. greyColor : ColorManager.primaryColor,
          )
        ],
      ),
    );
  }


}

