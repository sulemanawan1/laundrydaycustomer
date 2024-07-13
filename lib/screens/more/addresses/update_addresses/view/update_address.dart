import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';

import 'package:laundryday/helpers/validation_helper/validation_helper.dart';
import 'package:laundryday/provider/user_notifier.dart';
import 'package:laundryday/screens/auth/signup/signup.dart';
import 'package:laundryday/screens/more/addresses/my_addresses/model/my_addresses_model.dart'
    as myaddressesmodel;
import 'package:laundryday/screens/more/addresses/update_addresses/provider/update_address_notifier.dart';
import 'package:laundryday/utils/constants/colors.dart';
import 'package:laundryday/utils/constants/sized_box.dart';
import 'package:laundryday/utils/constants/value_manager.dart';
import 'package:laundryday/widgets/heading.dart';
import 'package:laundryday/widgets/my_app_bar.dart';
import 'package:laundryday/widgets/my_button.dart';
import 'package:laundryday/widgets/my_textform_field.dart';

class UpdateAddress extends ConsumerStatefulWidget {
  myaddressesmodel.Address address;
  UpdateAddress({
    required this.address,
  });

  @override
  ConsumerState<UpdateAddress> createState() => _UpdateAddressState();
}

class _UpdateAddressState extends ConsumerState<UpdateAddress> {
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();

    ref
        .read(updateAddressProvider.notifier)
        .intitilzeAddress(address: widget.address);
  }

  @override
  Widget build(BuildContext context) {
    final states = ref.watch(updateAddressProvider);
    final controller = ref.read(updateAddressProvider.notifier);
    final reader = ref.read(updateAddressProvider);
    final customerId = ref.read(userProvider).userModel!.user!.id;

    return Scaffold(
      appBar: MyAppBar(title: "Update Address"),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            SizedBox(
              height: 280,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Consumer(builder: (context, ref, child) {
                    return GoogleMap(
                      initialCameraPosition: states.initialCameraPos,
                      compassEnabled: false,
                      myLocationEnabled: true,
                      zoomControlsEnabled: false,
                      myLocationButtonEnabled: false,
                      mapToolbarEnabled: false,
                      onCameraIdle: () {
                        log("Camera Idle Call");
                        controller.coordinateToAddress(
                            taget: states.selectedCameraPos.target);
                      },
                      onCameraMove: (cameraPos) {
                        controller.updatetoCurrent(
                          selectedCameraPos: cameraPos,
                        );
                      },
                      // initialCameraPosition: states.initialCameraPosition,
                      onMapCreated: (GoogleMapController gcontroller) {
                        reader.googleMapController = gcontroller;
                      },
                    );
                  }),
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
                          Position pos = await controller.determinePosition();
                          final newCameraPosition = CameraPosition(
                            target: LatLng(pos.latitude, pos.longitude),
                            zoom: 14,
                          );
                          log(newCameraPosition.target.latitude.toString());
                          log(newCameraPosition.target.longitude.toString());

                          reader.googleMapController!.animateCamera(
                            CameraUpdate.newCameraPosition(newCameraPosition),
                          );

                          // controller.coordinateToAddress(
                          //     taget: newCameraPosition.target);
                        },
                        child: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: ColorManager.whiteColor,
                          ),
                          child: const Center(child: Icon(Icons.my_location)),
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
                        validator: AppValidator().emptyStringValidator,
                        hintText: 'Ex: Home',
                        labelText: 'Address Name',
                      ),
                      10.ph,
                      MyTextFormField(
                        controller: controller.addressDetailController,
                        validator: AppValidator().emptyStringValidator,
                        hintText: 'Ex: Building no',
                        labelText: 'Address Details',
                      ),
                      10.ph,
                      Heading(title: 'Address Photo'),
                      10.ph,
                      GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                        ElevatedButton.icon(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                ColorManager.primaryColor,
                                          ),
                                          icon: const Icon(Icons.camera),
                                          onPressed: () {
                                            controller.pickImage(
                                              imageSource: ImageSource.camera,
                                            );
                                            context.pop();
                                          },
                                          label: const Text('Camera'),
                                        ),
                                        ElevatedButton.icon(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                ColorManager.primaryColor,
                                          ),
                                          icon: const Icon(Icons.image),
                                          onPressed: () {
                                            controller.pickImage(
                                              imageSource: ImageSource.gallery,
                                            );
                                            context.pop();
                                          },
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
                          title: 'Update',
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              log(customerId.toString());
                              log(states.address.toString());
                              log(states.selectedCameraPos.target.latitude
                                  .toString());
                              log(states.selectedCameraPos.target.longitude
                                  .toString());
                              controller.updateAddress(
                                addressId: widget.address.id!,
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
}
