import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:laundryday/models/user_model.dart';
import 'package:laundryday/resources/api_routes.dart';
import 'package:laundryday/resources/assets_manager.dart';
import 'package:laundryday/resources/colors.dart';
import 'package:laundryday/screens/auth/signup/signup.dart';
import 'package:laundryday/resources/sized_box.dart';
import 'package:laundryday/resources/value_manager.dart';
import 'package:laundryday/core/utils.dart';
import 'package:laundryday/screens/more/profile/provider/edit_profile_notifier.dart';
import 'package:laundryday/widgets/my_app_bar.dart';
import 'package:laundryday/widgets/my_button.dart';
import 'package:laundryday/widgets/heading.dart';
import 'package:laundryday/widgets/my_textform_field.dart';

class EditProfile extends ConsumerStatefulWidget {
  final UserModel userModel;
  const EditProfile({super.key, required this.userModel});

  @override
  ConsumerState<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends ConsumerState<EditProfile> {
  @override
  void initState() {
    super.initState();
    ref.read(editProfileProvider.notifier).fullNameController.text =
        widget.userModel.user!.firstName.toString();
  }

  @override
  Widget build(BuildContext context) {
    final controller = ref.read(editProfileProvider.notifier);
    final image = ref.watch(editProfileProvider).image;

    return Scaffold(
      appBar: MyAppBar(title: 'Edit Profile'),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Heading(title: 'Profile Information'),
          40.ph,
          Center(
            child: GestureDetector(
              onTap: () {
                Utils().resuableCameraGalleryBottomSheet(
                    context: context,
                    onCamerButtonPressed: () {
                      controller.pickImage(
                        ref: ref,
                        context: context,
                        imageSource: ImageSource.camera,
                      );
                      context.pop();
                    },
                    onGalleryButtonPressed: () {
                      controller.pickImage(
                        ref: ref,
                        context: context,
                        imageSource: ImageSource.gallery,
                      );
                      context.pop();
                    });
              },
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  image != null
                      ? Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            border: Border.all(color: ColorManager.lightGrey),
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: FileImage(File(image.path.toString()))),
                            color: ColorManager.mediumWhiteColor,
                            shape: BoxShape.circle,
                          ),
                        )
                      : Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            border: Border.all(color: ColorManager.lightGrey),
                            image: widget.userModel.user!.image == null
                                ? DecorationImage(
                                    fit: BoxFit.cover,
                                    image: AssetImage(AssetImages.user))
                                : DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(Api.imageUrl +
                                        widget.userModel.user!.image
                                            .toString())),
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
          HeadingMedium(title: 'Full Name'),
          10.ph,
          MyTextFormField(
              controller: controller.fullNameController,
              hintText: 'Full Name',
              labelText: ''),
          40.ph,
          MyButton(
            title: 'Update Profile',
            onPressed: () {
              Map? files;

              Map data = {
                "first_name": controller.fullNameController.text.toString(),
                "last_name": controller.fullNameController.text.toString(),
                "user_id": widget.userModel.user!.id,
              };

              if (image != null) {
                files = {"image": image.path.toString()};
              }
              ref.read(editProfileProvider.notifier).updateUser(
                  data: data,
                  files: image != null ? files : null,
                  ref: ref,
                  context: context);
            },
          ),
          40.ph,
        ]),
      ),
    );
  }
}
