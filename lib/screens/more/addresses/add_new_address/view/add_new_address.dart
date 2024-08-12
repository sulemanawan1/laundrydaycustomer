import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:laundryday/helpers/google_helper.dart';
import 'package:laundryday/helpers/validation_helper.dart';
import 'package:laundryday/provider/user_notifier.dart';
import 'package:laundryday/screens/auth/signup/signup.dart';
import 'package:laundryday/screens/more/addresses/add_new_address/provider/add_new_address_notifier.dart';
import 'package:laundryday/config/resources/colors.dart';
import 'package:laundryday/config/resources/sized_box.dart';
import 'package:laundryday/config/resources/value_manager.dart';
import 'package:laundryday/core/widgets/heading.dart';
import 'package:laundryday/core/widgets/my_app_bar.dart';
import 'package:laundryday/core/widgets/my_button.dart';
import 'package:laundryday/core/widgets/my_textform_field.dart';

class AddNewAddress extends ConsumerWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final states = ref.watch(addAddressNotifier);
    final selectedCameraPos = ref.watch(addAddressNotifier).selectedCameraPos;
    final controller = ref.read(addAddressNotifier.notifier);
    final reader = ref.read(addAddressNotifier);
    final customerId = ref.read(userProvider).userModel!.user!.id;

    return Scaffold(
      appBar: MyAppBar(title: "Add New Address"),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            states.isLoading
                ? CircularProgressIndicator()
                : 
                SizedBox(
                    height: 280,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        GoogleMap(
                          initialCameraPosition: states.initialCameraPos,
                          compassEnabled: false,
                          myLocationEnabled: true,
                          zoomControlsEnabled: false,
                          myLocationButtonEnabled: false,
                          mapToolbarEnabled: false,
                          onCameraIdle: () {
                            controller.coordinateToAddress(
                                taget: LatLng(selectedCameraPos.target.latitude,
                                    selectedCameraPos.target.longitude));
                          },
                          onCameraMove: (cameraPos) {
                            controller.getCameraPosition(
                                selectedCameraPos: cameraPos);
                          },
                          onMapCreated: (GoogleMapController gcontroller) {
                            reader.googleMapController = gcontroller;
                          },
                        ),
                       
                       
                        Icon(
                          Icons.location_on,
                          color: ColorManager.primaryColor,
                        ),
                        Positioned(
                          right: 10,
                          bottom: 10,
                          child: Align(
                            alignment: Alignment.bottomRight,
                            child: GestureDetector(
                              onTap: () async {
                                CameraPosition currentCameraPosition =
                                    await controller.getCurrentCameraPosition();

                                reader.googleMapController!.animateCamera(
                                  CameraUpdate.newCameraPosition(
                                      currentCameraPosition),
                                );
                              },
                              child: Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: ColorManager.whiteColor,
                                ),
                                child: const Center(
                                    child: Icon(Icons.my_location)),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
          
          
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: AppPadding.p10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      20.ph,
                      HeadingMedium(
                        title:
                            states.address == null ? "" : states.address ?? "",
                      ),
                      20.ph,
                      MyTextFormField(
                        controller: controller.addressNameController,
                        validator: AppValidator.emptyStringValidator,
                        hintText: 'Ex: Home',
                        labelText: 'Address Name',
                      ),
                      10.ph,
                      MyTextFormField(
                        controller: controller.addressDetailController,
                        validator: AppValidator.emptyStringValidator,
                        hintText: 'Ex: Building no',
                        labelText: 'Address Details',
                      ),
                      10.ph,
                      Heading(title: 'Address Photo'),
                      10.ph,
                      GestureDetector(
                        onTap: () {
                          resuableCameraGalleryBottomSheet(
                              context: context,
                              onCamerButtonPressed: () {
                                controller.pickImage(
                                  imageSource: ImageSource.camera,
                                );
                                context.pop();
                              },
                              onGalleryButtonPressed: () {
                                controller.pickImage(
                                  imageSource: ImageSource.camera,
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
                                image: states.imagePath == null
                                    ? null
                                    : DecorationImage(
                                        fit: BoxFit.cover,
                                        image: FileImage(
                                            File(states.imagePath.toString())),
                                      ),
                                color: ColorManager.mediumWhiteColor,
                                shape: BoxShape.circle,
                              ),
                            ),
                            Positioned(
                              left: 60,
                              top: 40,
                              child: Container(
                                width: 30,
                                height: 30,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: Icon(
                                    Icons.camera_alt,
                                    color: ColorManager.primaryColor,
                                    size: 20,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      10.ph,
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: MyButton(
                          title: 'Save',
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              // log(customerId.toString());
                              // log(states.address.toString());
                              // log(states.selectedCameraPos.target.latitude
                              //     .toString());
                              // log(states.selectedCameraPos.target.longitude
                              //     .toString());

                              String? district = await GoogleServices()
                                  .getDistrict(
                                      states.selectedCameraPos.target.latitude,
                                      states
                                          .selectedCameraPos.target.longitude);

                              log(district.toString());

                              controller.addAddress(
                                district: district ?? "NA",
                                file: states.imagePath,
                                ref: ref,
                                customerId: customerId!,
                                googleAddress: states.address!,
                                addressName:
                                    controller.addressNameController.text,
                                addressDetail:
                                    controller.addressDetailController.text,
                                lat: states.selectedCameraPos.target.latitude,
                                lng: states.selectedCameraPos.target.longitude,
                                context: context,
                              );
                            }
                          },
                        ),
                      ),
                      10.ph,
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<dynamic> resuableCameraGalleryBottomSheet(
      {required BuildContext context,
      required void Function()? onCamerButtonPressed,
      required void Function()? onGalleryButtonPressed}) {
    return showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(AppSize.s12),
          topRight: Radius.circular(AppSize.s12),
        ),
      ),
      context: context,
      builder: (context) {
        return SizedBox(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              10.ph,
              const Text(
                'Choose Photo',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              10.ph,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorManager.primaryColor,
                    ),
                    icon: const Icon(Icons.camera),
                    onPressed: onCamerButtonPressed,
                    label: const Text('Camera'),
                  ),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorManager.primaryColor,
                    ),
                    icon: const Icon(Icons.image),
                    onPressed: onGalleryButtonPressed,
                    label: const Text('Gallery'),
                  ),
                ],
              ),
              10.ph,
            ],
          ),
        );
      },
    );
  }
}
