import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:laundryday/app_services/location_handler.dart';
import 'package:laundryday/screens/auth/signup/signup.dart';
import 'package:laundryday/screens/more/addresses/add_new_address/add_address_state.dart';
import 'package:laundryday/screens/more/addresses/add_new_address/notifiers/add_new_address_notifier.dart';
import 'package:laundryday/utils/colors.dart';
import 'package:laundryday/utils/sized_box.dart';
import 'package:laundryday/widgets/my_app_bar.dart';
import 'package:laundryday/widgets/my_button.dart';
import 'package:laundryday/widgets/my_textform_field.dart';

final addAddressNotifier =
    StateNotifierProvider.autoDispose<AddAddressNotifier, AddAddressState?>(
        (_) => AddAddressNotifier());

class AddNewAddress extends ConsumerStatefulWidget {
  const AddNewAddress({super.key});

  @override
  ConsumerState<AddNewAddress> createState() => _AddNewAddressState();
}

class _AddNewAddressState extends ConsumerState<AddNewAddress> {
  final   Completer<GoogleMapController> _googleMapcontroller =
      Completer<GoogleMapController>();
  @override
  void initState() {
    super.initState();
   LocationHandler. goToTheCurrentLoaction(googleMapcontroller: _googleMapcontroller);
  }



  @override
  Widget build(BuildContext context) {
    final states = ref.watch(addAddressNotifier);

    return Scaffold(
        appBar: MyAppBar(title: "Add New Address"),
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(children: [
                  SizedBox(
                    height: 300,
                    child: Stack(alignment: Alignment.center, children: [
                      GoogleMap(
                        initialCameraPosition: CameraPosition(
                          zoom: 14,
                          target: LatLng(
                              states!.selectedLat, states.selectedLng),
                        ),
                        onMapCreated: (GoogleMapController controller) {
                          _googleMapcontroller.complete(controller);
                        },
                        compassEnabled: false,
                        myLocationEnabled: true,
                        zoomControlsEnabled: false,
                        myLocationButtonEnabled: false,
                        mapToolbarEnabled: false,
                        onCameraMove: (CameraPosition cameraPosition) {
                          states.selectedLat =
                              cameraPosition.target.latitude;
                          states.selectedLng =
                              cameraPosition.target.longitude;
                        },
                        onCameraIdle: () async {
                          String fullAddress;

                          try {
                            List<Placemark> placemarks =
                                await placemarkFromCoordinates(
                                    states.selectedLat,
                                    states.selectedLng);

                            if (placemarks.isNotEmpty) {
                              Placemark placemark = placemarks[0];
                              fullAddress =
                                  "${placemark.street},${placemark.thoroughfare}, ${placemark.subLocality}, ${placemark.locality} ";

                              ref
                                  .read(addAddressNotifier.notifier)
                                  .userSelectedAddress(address: fullAddress);
                            } else {
                              fullAddress =
                                  'No address found for the coordinates';
                            }
                          } catch (e) {
                            fullAddress = 'Error: $e';
                          }
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
                            onTap: () {
                              LocationHandler.goToTheCurrentLoaction(
                                  googleMapcontroller: _googleMapcontroller);
                            },
                            child: Container(
                              width: 50,
                              height: 50,
                              decoration:  BoxDecoration(
                                  shape: BoxShape.circle, color: ColorManager. whiteColor),
                              child:
                                  const Center(child: Icon(Icons.my_location)),
                            ),
                          ),
                        ),
                      )
                    ]),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          20.ph,
                          Column(
                            children: [
                              HeadingMedium(
                                  title: states.address == null
                                      ? ""
                                      : states.address ?? ""),
                            ],
                          ),
                          10.ph,
                          const HeadingSmall(title: 'Address Name'),
                          10.ph,
                          MyTextFormField(hintText: 'Ex: Home', labelText: ''),
                          10.ph,
                          const HeadingSmall(title: 'Address Details'),
                          10.ph,
                          MyTextFormField(
                              hintText: 'Ex: Building no', labelText: ''),
                          10.ph,
                          const HeadingSmall(title: 'Address Photo'),
                          10.ph,
                          GestureDetector(
                            onTap: () {
                              ref
                                  .read(addAddressNotifier.notifier)
                                  .pickImage(imageSource: ImageSource.gallery);
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
                                            image: FileImage(File(states
                                                .imagePath
                                                .toString()))),
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
                                    decoration:  BoxDecoration(
                                        shape: BoxShape.circle,
                                        ),
                                    child:  Center(
                                        child: Icon(
                                      Icons.camera_alt,
                                      color: ColorManager. whiteColor,
                                      size: 16,
                                    )),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ]),
                  ),
                ]),
              ),
            ),
            20.ph,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: MyButton(
                name: 'Save',
                onPressed: () {},
              ),
            ),
            40.ph,
          ],
        ));
  }


}
