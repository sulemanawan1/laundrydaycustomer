import 'dart:async';
import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:laundryday/helpers/validation_helper.dart';
import 'package:laundryday/models/city_model.dart' as citymodel;
import 'package:laundryday/models/country_model.dart' as countrymodel;
import 'package:laundryday/models/district_model.dart' as districtmodel;
import 'package:laundryday/models/region_model.dart' as regionmodel;
import 'package:laundryday/screens/add_laundry/data/models/branch_model.dart';
import 'package:laundryday/screens/add_laundry/presentation/provider/add_laundry_notifier.dart';
import 'package:laundryday/screens/add_laundry/presentation/provider/add_laundry_states.dart';
import 'package:laundryday/config/resources/colors.dart';
import 'package:laundryday/config/resources/sized_box.dart';
import 'package:laundryday/config/resources/value_manager.dart';
import 'package:laundryday/config/theme/styles_manager.dart';
import 'package:laundryday/core/utils.dart';
import 'package:laundryday/core/widgets/heading.dart';
import 'package:laundryday/core/widgets/sub_heading.dart';
import '../../../../core/widgets/my_button.dart';
import '../../../../core/widgets/resuable_dropdown.dart';

final addressInformationFormKey = GlobalKey<FormState>();

Widget addressInformation(BuildContext context,
    AddLaundryNotifier laundryNotifier, AddLaundryStates states) {
  return states.countryModel == null
      ? const CircularProgressIndicator()
      : SingleChildScrollView(
          child: Form(
              key: addressInformationFormKey,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Heading(title: 'Address'),
                    8.ph,
                    ReusableDropMenu<countrymodel.Datum?>(
                        controller: laundryNotifier.countryController,
                        label: 'Select  Country',
                        onSelected: (selectedCoutry) {
                          laundryNotifier.selectedCountry(
                              selectedCoutry: selectedCoutry!);
                          laundryNotifier.regions(
                              countryId: selectedCoutry.id!);
                        },
                        list: List.generate(
                            states.countryModel!.data!.length,
                            (index) => DropdownMenuEntry(
                                label: states.countryModel!.data![index].name ??
                                    "",
                                value: states.countryModel!.data![index]))),
                    8.ph,
                    ReusableDropMenu<regionmodel.Datum?>(
                        controller: laundryNotifier.regionController,
                        label: 'Select  Region',
                        onSelected: (selectedRegion) {
                          laundryNotifier.selectedRegion(
                              selectedRegion: selectedRegion!);
                          laundryNotifier.cities(regionId: selectedRegion.id!);
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
                        controller: laundryNotifier.cityController,
                        label: 'Select  City',
                        onSelected: (selectedCity) {
                          laundryNotifier.selectedCity(
                              selectedCity: selectedCity!);
                          laundryNotifier.districts(cityId: selectedCity.id!);
                        },
                        list: List.generate(
                            states.cityModel == null
                                ? 0
                                : states.cityModel!.data!.length,
                            (index) => DropdownMenuEntry(
                                label:
                                    states.cityModel!.data![index].name ?? "",
                                value: states.cityModel!.data![index]))),
                    8.ph,
                    ReusableDropMenu<districtmodel.Datum?>(
                        controller: laundryNotifier.districtController,
                        label: 'Select  District',
                        onSelected: (selectedDistrict) {
                          laundryNotifier.selectedDistrict(
                              selectedDistrict: selectedDistrict!);
                        },
                        list: List.generate(
                            states.districtModel == null
                                ? 0
                                : states.districtModel!.data!.length,
                            (index) => DropdownMenuEntry(
                                label:
                                    states.districtModel!.data![index].name ??
                                        "",
                                value: states.districtModel!.data![index]))),
                    8.ph,
                    TextFormField(
                      validator: AppValidator.emptyStringValidator,
                      onChanged: (val) {
                        if (laundryNotifier.deounce?.isActive ?? false) {
                          laundryNotifier.deounce?.cancel();
                        }
                        laundryNotifier.deounce =
                            Timer(const Duration(milliseconds: 300), () {
                          laundryNotifier.getSuggestion(
                              laundryNotifier.textController.text);
                        });
                      },
                      readOnly: states.googleMapAdress != null ? true : false,
                      controller: laundryNotifier.textController,
                      decoration: InputDecoration(
                        hintText: "Search your location here",
                        focusColor: Colors.white,
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        prefixIcon: const Icon(Icons.map),
                        suffixIcon: laundryNotifier.textController.text.isEmpty
                            ? const SizedBox()
                            : IconButton(
                                icon: const Icon(Icons.cancel),
                                onPressed: () {
                                  laundryNotifier.clearState();
                                },
                              ),
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: states.placeList.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          onTap: () async {
                            log(states.placeList[index]["description"]);
                            laundryNotifier.setGoogleMapAddress(
                                googleMapAddress: states.placeList[index]
                                        ["description"] ??
                                    '');

                            laundryNotifier.clearList();

                            states.coordinates =
                                await laundryNotifier.getCoordinates(
                                    laundryNotifier.textController.text);

                            laundryNotifier.setCoordinates(
                                coodinates: states.coordinates!);

                            if (states.coordinates != null) {
                              final controller =
                                  await laundryNotifier.mapController.future;

                              final newPos = CameraPosition(
                                  target: LatLng(states.coordinates?.lat ?? 0.0,
                                      states.coordinates?.lng ?? 0.0),
                                  zoom: 16);

                              controller.animateCamera(
                                  CameraUpdate.newCameraPosition(newPos));

                              laundryNotifier.addMarker(
                                  position: LatLng(
                                states.coordinates!.lat!,
                                states.coordinates!.lng!,
                              ));
                            }
                          },
                          leading: Container(
                              width: 35,
                              height: 35,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  shape: BoxShape.rectangle,
                                  color: ColorManager.primaryColor
                                      .withOpacity(0.2)),
                              child: Center(
                                  child: Icon(
                                Icons.location_on,
                                color: ColorManager.primaryColor,
                              ))),
                          title: Text(states.placeList[index]["description"]),
                        );
                      },
                    ),
                    5.ph,
                    SizedBox(
                      height: 300,
                      child: GoogleMap(
                        markers: states.markers,
                        initialCameraPosition: laundryNotifier.kGooglePlex,
                        onMapCreated: (GoogleMapController controller) {
                          laundryNotifier.mapController.complete(controller);
                        },
                        compassEnabled: false,
                        myLocationEnabled: false,
                        myLocationButtonEnabled: false,
                        mapToolbarEnabled: false,
                      ),
                    ),
                    10.ph,
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: states.selectedBranchModel.length,
                      itemBuilder: (BuildContext context, int index) {
                        final laundry = states.selectedBranchModel[index];

                        return Card(
                          child: ExpansionTile(
                            expandedAlignment: Alignment.topLeft,
                            trailing: IconButton(
                              icon: Text(
                                'Delete',
                                style: getSemiBoldStyle(
                                    color: ColorManager.redColor, fontSize: 15),
                              ),
                              onPressed: () {
                                laundryNotifier.deleteBranch(
                                    states.selectedBranchModel[index]);
                              },
                            ),
                            title: Text(
                              'Branch ${index + 1}',
                              style: getMediumStyle(
                                  color: ColorManager.blackColor),
                            ),
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: AppPadding.p6),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Heading(
                                      title: 'Country',
                                      color: ColorManager.blackColor,
                                    ),
                                    5.ph,
                                    SubHeading(
                                      title: laundry.country?.name ?? "",
                                      color: ColorManager.greyColor,
                                    ),
                                    5.ph,
                                    Heading(
                                      title: 'Region',
                                      color: ColorManager.blackColor,
                                    ),
                                    5.ph,
                                    SubHeading(
                                      title: laundry.region?.name ?? "",
                                      color: ColorManager.greyColor,
                                    ),
                                    5.ph,
                                    Heading(
                                      title: 'City',
                                      color: ColorManager.blackColor,
                                    ),
                                    5.ph,
                                    SubHeading(
                                      title: laundry.city?.name ?? "",
                                      color: ColorManager.greyColor,
                                    ),
                                    Heading(
                                      title: 'District',
                                      color: ColorManager.blackColor,
                                    ),
                                    5.ph,
                                    SubHeading(
                                      title: laundry.district?.name ?? "",
                                      color: ColorManager.greyColor,
                                    ),
                                    5.ph,
                                    Heading(
                                      title: 'Google Map Address',
                                      color: ColorManager.blackColor,
                                    ),
                                    5.ph,
                                    SubHeading(
                                      title: laundry.googleMapAddress ?? "",
                                      color: ColorManager.greyColor,
                                    ),
                                    Heading(
                                      title: 'Coordinates',
                                      color: ColorManager.blackColor,
                                    ),
                                    5.ph,
                                    SubHeading(
                                      title:
                                          "Latitude : ${laundry.coordinates?.lat.toString()} Longitude : ${laundry.coordinates?.lng.toString()}" ??
                                              "",
                                      color: ColorManager.greyColor,
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        );
                      },
                    ),
                    Align(
                        alignment: Alignment.centerRight,
                        child: MyButton(
                            color: ColorManager.amber,
                            onPressed: () {
                              if (laundryNotifier
                                  .countryController.text.isEmpty) {
                                Utils.showSnackBar(
                                    context: context,
                                    message: 'Please  Select Country',
                                    color: ColorManager.redColor);
                              } else if (laundryNotifier
                                  .regionController.text.isEmpty) {
                                Utils.showSnackBar(
                                    context: context,
                                    message: 'Please  Select Region',
                                    color: ColorManager.redColor);
                              } else if (laundryNotifier
                                  .cityController.text.isEmpty) {
                                Utils.showSnackBar(
                                    context: context,
                                    message: 'Please  Select City',
                                    color: ColorManager.redColor);
                              } else if (laundryNotifier
                                  .districtController.text.isEmpty) {
                                Utils.showSnackBar(
                                    context: context,
                                    message: 'Please  Select District',
                                    color: ColorManager.redColor);
                              } else if (addressInformationFormKey.currentState!
                                  .validate()) {
                                if (kDebugMode) {
                                  print("*" * 20);
                                  print('Step 2');
                                  print(
                                      "Country ${states.selectedCountry!.id}");
                                  print("Region ${states.selectedRegion!.id}");
                                  print("City ${states.selectedCity!.id}");
                                  print(
                                      "District ${states.selectedDistrict!.id}");
                                  print(
                                      "Google Map Address ${states.googleMapAdress}");
                                  print(
                                      "Latitiude ${states.coordinates!.lat!}");
                                  print(
                                      "Longitude ${states.coordinates!.lng!}");
                                  print("*" * 20);

                                  laundryNotifier.addBranch(BranchModel(
                                      coordinates: states.coordinates,
                                      country: states.selectedCountry,
                                      city: states.selectedCity,
                                      district: states.selectedDistrict,
                                      region: states.selectedRegion,
                                      googleMapAddress:
                                          states.googleMapAdress));
                                }
                              }
                            },
                            title: 'Add More Branch')),
                    10.ph,
                  ])),
        );
}
