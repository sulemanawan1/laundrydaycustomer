import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laundryday/app_services/location_handler.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:laundryday/models/regions.dart';
import 'package:laundryday/screens/more/help/business_partner/components/selected_businesses.dart';
import 'package:laundryday/screens/more/help/business_partner/models/bussiness_partner_model.dart';
import 'package:laundryday/screens/more/help/business_partner/notifier/business_partner_notifier.dart';
import 'package:laundryday/screens/more/help/business_partner/notifier/business_partner_textformfields.dart';
import 'package:laundryday/utils/colors.dart';
import 'package:laundryday/utils/sized_box.dart';
import 'package:laundryday/widgets/heading.dart';
import 'package:laundryday/widgets/my_button.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:multi_select_flutter/util/multi_select_list_type.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

class AddressInformation extends ConsumerStatefulWidget {
  const AddressInformation({super.key});

  @override
  ConsumerState<AddressInformation> createState() => _AddressInformationState();
}

class _AddressInformationState extends ConsumerState<AddressInformation> {
  final _controller = TextEditingController();
  var uuid = const Uuid();
  final String _sessionToken = '1234567890';
  List<dynamic> _placeList = [];
  String? address;

  double _selectedLat = 0.0;
  double _selectedLng = 0.0;

  final Completer<GoogleMapController> _mapController =
      Completer<GoogleMapController>();

  _onChanged() {
    getSuggestion(_controller.text);
  }

  void getSuggestion(String input) async {
    const String placesApiKey = "AIzaSyBxYoAYSwy-GASmbxY8R3cVwaA_fPfsUJs";

    try {
      String baseURL =
          'https://maps.googleapis.com/maps/api/place/autocomplete/json';
      String request =
          '$baseURL?input=$input&key=$placesApiKey&sessiontoken=$_sessionToken';
      var response = await http.get(Uri.parse(request));
      var data = json.decode(response.body);
      if (kDebugMode) {
        print('mydata');
        print(data);
      }
      if (response.statusCode == 200) {
        setState(() {
          _placeList = json.decode(response.body)['predictions'];
        });
      } else {
        throw Exception('Failed to load predictions');
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  @override
  void initState() {
    super.initState();

    _goToTheCurrentLoaction();
    _controller.addListener(() {
      _onChanged();
    });
  }

  Future<void> _goToTheCurrentLoaction() async {
    final GoogleMapController controller = await _mapController.future;

    Position pos = await LocationHandler.getLocationPermission();
    _selectedLat = pos.latitude;
    _selectedLng = pos.longitude;

    await controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
            bearing: 90,
            target: LatLng(_selectedLat, _selectedLng),
            tilt: 0.0,
            zoom: 16)));
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final states = ref.watch(businessPartnerProvider);
    return SingleChildScrollView(
      child: Form(
        key: BusinessPartnerTextFormFields.formKey3,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Heading(text: 'Address'),
            8.ph,

            FutureBuilder<Regions?>(
              future: ref.read(businessPartnerProvider.notifier).fetchRegions(),
              builder:
                  (BuildContext context, AsyncSnapshot<Regions?> snapshot) {
                return DropdownMenu(
                    inputDecorationTheme: InputDecorationTheme(
                      errorStyle: GoogleFonts.poppins(
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w400,
                        fontSize: 10,
                      ),
                      labelStyle: GoogleFonts.poppins(
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w400,
                          fontSize: 15,
                          color: const Color(0xff555555)),
                      hintStyle: const TextStyle(
                        fontWeight: FontWeight.w400,
                        color: Color(0xff555555),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(
                            color: ColorManager.primaryColor, width: 1.5),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(
                            color: Color(0xffEEEEEE), width: 1.5),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide:
                            const BorderSide(color: Colors.red, width: 1.5),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(
                            color: ColorManager.primaryColor, width: 1.0),
                      ),
                      fillColor: ColorManager.whiteColor,
                      filled: true,
                      isDense: true,
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 16),
                      constraints:
                          const BoxConstraints(maxHeight: 44, minHeight: 44),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    width: MediaQuery.of(context).size.width * 0.9,
                    hintText: 'Select the Regions',
                    label: const Text('Regions'),
                    textStyle: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                    ),
                    menuStyle: MenuStyle(
                        backgroundColor: MaterialStateColor.resolveWith(
                            (states) => ColorManager.whiteColor)),
                    onSelected: (val) {
                      log(val.toString());

                      ref
                          .read(businessPartnerProvider.notifier)
                          .setRegionId(regionId: val!);
                    },
                    dropdownMenuEntries: List.generate(
                      snapshot.data!.regions!.length,
                      (index) => DropdownMenuEntry(
                          value: snapshot.data!.regions![index].id,
                          label:
                              snapshot.data!.regions![index].name.toString()),
                    ));
              },
            ),
            8.ph,

            DropdownMenu(
              inputDecorationTheme: InputDecorationTheme(
                errorStyle: GoogleFonts.poppins(
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w400,
                  fontSize: 10,
                ),
                labelStyle: GoogleFonts.poppins(
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w400,
                    fontSize: 15,
                    color: const Color(0xff555555)),
                hintStyle: const TextStyle(
                  fontWeight: FontWeight.w400,
                  color: Color(0xff555555),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide:
                      BorderSide(color: ColorManager.primaryColor, width: 1.5),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide:
                      const BorderSide(color: Color(0xffEEEEEE), width: 1.5),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: const BorderSide(color: Colors.red, width: 1.5),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide:
                      BorderSide(color: ColorManager.primaryColor, width: 1.0),
                ),
                fillColor: ColorManager.whiteColor,
                filled: true,
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                constraints: const BoxConstraints(maxHeight: 44, minHeight: 44),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              width: MediaQuery.of(context).size.width * 0.9,
              hintText: 'Select the Cities',
              label: const Text('Cities'),
              textStyle: GoogleFonts.poppins(
                fontWeight: FontWeight.w500,
                fontSize: 15,
              ),
              menuStyle: MenuStyle(
                  backgroundColor: MaterialStateColor.resolveWith(
                      (states) => ColorManager.whiteColor)),
              onSelected: (val) {
                log(val.toString());
              },
              dropdownMenuEntries: [
                "Riyadh",
                "Diriyah",
                "Thadiq",
                "Al-Kharj",
                "Al-Majma'ah",
                "Hawtat Sudayr",
                "Shaqraa",
                "Wadi ad-Dawasir",
                "Huraymila",
                "Afif",
                "Al-Ghat",
                "Al-Dilam",
                "Dhruma",
                "Rumah",
                "Al-Muzahimiyah"
              ].map((e) => DropdownMenuEntry(value: e, label: e)).toList(),
            ),

            8.ph,
            states.type == 'Central Laundry'
                ? MultiSelectDialogField(
                    backgroundColor: ColorManager.mediumWhiteColor,
                    unselectedColor: Colors.white,
                    selectedColor: ColorManager.primaryColor,
                    selectedItemsTextStyle:
                        GoogleFonts.poppins(color: ColorManager.blackColor),
                    buttonIcon: const Icon(Icons.arrow_drop_down),
                    title: const Text('Services'),
                    items: [
                      'Al Olaya',
                      'Al-Murabba',
                      'Al Malaz',
                      'Al-Bathaa',
                      'Al-Ma\'ather',
                      'Al-Worood',
                      'Al-Rabwah',
                      'Al-Quds',
                      'Al-Riyadh Al-Jadidah', // New Riyadh
                      'Al-Nasim',
                      'Al-Nakheel',
                      'Al-Sulaimaniah',
                      'Al-Aziziyah',
                      'Al-Ma\'athar Ash Shamali',
                      'Al-Yasmin',
                    ].map((e) => MultiSelectItem(e, e)).toList(),
                    listType: MultiSelectListType.CHIP,
                    onConfirm: (values) {},
                  )
                : const SizedBox(),
            // FutureBuilder(
            //   future: ref.read(businessPartnerProvider.notifier).fetchRegions(),
            //   builder: (BuildContext context,
            //       AsyncSnapshot<List<Regions>> snapshot) {
            //     return DropdownButton(
            //         items: List.generate(
            //             snapshot.data!.length,
            //             (index) =>
            //                 DropdownMenuItem(child: Text(snapshot.data![index].regions![index].name.toString()))),
            //         onChanged: (val){

            //         });
            //   },
            // ),
            8.ph,
            Align(
              alignment: Alignment.topCenter,
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(
                  hintText: "Search your location here",
                  focusColor: Colors.white,
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  prefixIcon: const Icon(Icons.map),
                  suffixIcon: address != null
                      ? IconButton(
                          icon: const Icon(Icons.cancel),
                          onPressed: () {
                            _controller.clear();
                            address = null;
                            setState(() {});
                          },
                        )
                      : null,
                ),
              ),
            ),
            address == null
                ? SizedBox(
                    height: _controller.text.isEmpty ? 0 : 160,
                    child: ListView.builder(
                      // physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: _placeList.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () async {
                            address = _placeList[index]["description"];
                            log(address.toString());
                            _controller.text = address!;
                            _placeList.clear();
                            setState(() {});
                          },
                          child: ListTile(
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
                            title: Text(_placeList[index]["description"]),
                          ),
                        );
                      },
                    ),
                  )
                : Container(),
            8.ph,
            SizedBox(
              height: 300,
              child: Stack(alignment: Alignment.center, children: [
                GoogleMap(
                  initialCameraPosition: CameraPosition(
                    zoom: 14,
                    target: LatLng(_selectedLat, _selectedLng),
                  ),
                  onMapCreated: (GoogleMapController controller) {
                    _mapController.complete(controller);
                    setState(() {});
                  },
                  compassEnabled: false,
                  myLocationEnabled: true,
                  zoomControlsEnabled: false,
                  myLocationButtonEnabled: false,
                  mapToolbarEnabled: false,
                  onCameraMove: (CameraPosition cameraPosition) {
                    _selectedLat = cameraPosition.target.latitude;
                    _selectedLng = cameraPosition.target.longitude;
                  },
                  onCameraIdle: () async {
                    String fullAddress;

                    try {
                      List<Placemark> placemarks =
                          await placemarkFromCoordinates(
                              _selectedLat, _selectedLng);

                      if (placemarks.isNotEmpty) {
                        Placemark placemark = placemarks[0];
                        fullAddress =
                            "${placemark.street},${placemark.thoroughfare}, ${placemark.subLocality}, ${placemark.locality} ";

                        setState(() {});
                      } else {
                        fullAddress = 'No address found for the coordinates';
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
                      onTap: _goToTheCurrentLoaction,
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: ColorManager.whiteColor),
                        child: const Center(child: Icon(Icons.my_location)),
                      ),
                    ),
                  ),
                )
              ]),
            ),
            8.ph,
            const SelectedBuinesses(),
            MyButton(
              onPressed: () {
                final iD = DateTime.now().millisecondsSinceEpoch;

                LaundryBusinessModel laundryBusinessModel =
                    LaundryBusinessModel(
                  id: iD.toString(),
                  name: BusinessPartnerTextFormFields.storeNameEnglish.text,
                  secondaryName:
                      BusinessPartnerTextFormFields.storeNameArabic.text,
                  type: 'Laundry',
                  service: states.selectedItems,
                  branches: int.tryParse(
                      BusinessPartnerTextFormFields.branchController.text),
                  taxNumber: BusinessPartnerTextFormFields.taxNumber.text,
                  commercialRegNo: BusinessPartnerTextFormFields.taxNumber.text,
                  commercialRegImage: states.image,
                  address: 'Unknown',
                  lat: 22.0,
                  lng: 33.0,
                  googleMapAddress: 'sjsjs',
                  region: 'Riyadh Region',
                  city: 'Riyad City',
                );

                ref
                    .read(businessPartnerProvider.notifier)
                    .addBusiness(laundryBusinessModel: laundryBusinessModel);

                BusinessPartnerTextFormFields.cleartAllTextFormFields();
                ref.read(businessPartnerProvider.notifier).onStepFirst();
              },
              name: 'Add Another Store',
              isBorderButton: true,
              color: Colors.amber,
            )
          ],
        ),
      ),
    );
  }
}
