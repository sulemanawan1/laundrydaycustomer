import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:laundryday/models/address_model.dart';
import 'package:laundryday/services/google_service.dart';
import 'package:laundryday/helpers/validation_helper.dart';
import 'package:laundryday/provider/user_notifier.dart';
import 'package:laundryday/screens/auth/signup/signup.dart';
import 'package:laundryday/screens/more/addresses/add_new_address/provider/add_new_address_notifier.dart';
import 'package:laundryday/constants/colors.dart';
import 'package:laundryday/constants/sized_box.dart';
import 'package:laundryday/constants/value_manager.dart';
import 'package:laundryday/widgets/my_app_bar.dart';
import 'package:laundryday/widgets/my_button.dart';
import 'package:laundryday/widgets/my_textform_field.dart';

class AddNewAddress extends ConsumerWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final states = ref.watch(addAddressNotifier);
    final selectedCameraPos = ref.watch(addAddressNotifier).selectedCameraPos;
    final controller = ref.read(addAddressNotifier.notifier);
    final reader = ref.read(addAddressNotifier);
    final userId = ref.read(userProvider).userModel!.user!.id;

    return Scaffold(
      appBar: MyAppBar(title: "Add New Address"),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            states.isLoading
                ? CircularProgressIndicator()
                : SizedBox(
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
                                CameraPosition? currentCameraPosition =
                                    await controller.getCurrentCameraPosition();

                                if (currentCameraPosition != null) {
                                  reader.googleMapController!.animateCamera(
                                    CameraUpdate.newCameraPosition(
                                        currentCameraPosition),
                                  );
                                }
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
                        controller: controller.addressDetailController,
                        validator: AppValidator.emptyStringValidator,
                        hintText: 'Ex: Building no',
                        labelText: 'Address Details',
                      ),
                      10.ph,
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: MyButton(
                          title: 'Save',
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              AddressModel? addressModel =
                                  await GoogleServices.getAddress(
                                      states.selectedCameraPos.target.latitude,
                                      states
                                          .selectedCameraPos.target.longitude);

                              if (addressModel != null) {
                                controller.addAddress(
                                  country: addressModel.country,
                                  city: addressModel.city,
                                  district: addressModel.district,
                                  ref: ref,
                                  userId: userId!,
                                  googleAddress: states.address!,
                                  
                                  addressDetail:
                                      controller.addressDetailController.text,
                                  lat: states.selectedCameraPos.target.latitude,
                                  lng:
                                      states.selectedCameraPos.target.longitude,
                                  context: context,
                                );
                              }
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
