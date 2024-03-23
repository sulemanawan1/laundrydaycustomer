import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laundryday/Widgets/my_heading/heading.dart';
import 'package:laundryday/app_services/location_handler.dart';
import 'package:laundryday/models/city.dart' as city;
import 'package:laundryday/models/state.dart' as state;
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:laundryday/models/state.dart';
import 'package:laundryday/screens/auth/signup/signup.dart';
import 'package:laundryday/screens/more/help/business_partner/models/bussiness_partner_model.dart';
import 'package:laundryday/screens/more/help/business_partner/notifier/business_partner_notifier.dart';
import 'package:laundryday/screens/more/help/business_partner/notifier/business_partner_textformfields.dart';
import 'package:laundryday/utils/colors.dart';
import 'package:laundryday/utils/font_manager.dart';
import 'package:laundryday/utils/sized_box.dart';
import 'package:laundryday/utils/utils.dart';
import 'package:laundryday/utils/value_manager.dart';
import 'package:laundryday/widgets/my_button/my_button.dart';
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
  state.Datum? datum;
  List<state.Datum> stateLi = [];

  List<city.Datum> citiesLi = [];

  double _selectedLat = 0.0;
  double _selectedLng = 0.0;

  int? stateID;

  String? _selected;

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

  Future<List<state.Datum>> fetchAlbum() async {
    try {
      final response =
          await http.post(Uri.parse('http://192.168.1.7:8000/api/states/194'));
      // print(response.body);
      if (response.statusCode == 200) {
        final StateModel stateModel = StateModel.fromJson(
            jsonDecode(response.body) as Map<String, dynamic>);
        stateLi.clear();
        stateLi.addAll(stateModel.data);
        return stateLi;
      } else {
        throw Exception('Failed to load Country');
      }
    } on SocketException catch (e) {
      Utils.showToast(msg: e);
    }

    return [];
  }

  Future<List<city.Datum>> fetchCities({required stateId}) async {
    try {
      final response = await http
          .post(Uri.parse('http://192.168.1.7:8000/api/cities/$stateId'));

      if (response.statusCode == 200) {
        final city.City stateModel = city.City.fromJson(
            jsonDecode(response.body) as Map<String, dynamic>);
        citiesLi.cast();
        citiesLi.addAll(stateModel.data as Iterable<city.Datum>);
        return citiesLi;
      } else {
        throw Exception('Failed to load Cities');
      }
    } on SocketException catch (e) {
      Utils.showToast(msg: e);
    }

    return [];
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
    final states = ref.read(businessPartnerProvider);
    final laudnryList = ref.watch(businessPartnerProvider).laundriesList;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Heading(text: 'Address'),
          8.ph,
          FutureBuilder<List<state.Datum>>(
            future: fetchAlbum(),
            builder: (BuildContext context,
                AsyncSnapshot<List<state.Datum>> snapshot) {
              if (snapshot.hasData) {
                return DropdownButton(
                  // value: datum,

                  onChanged: (state.Datum? v) {
                    datum = v;

                    stateID = v!.id;
                    setState(() {});
                  },
                  hint: HeadingMedium(
                    title: 'Select Region',
                  ),
                  isExpanded: true,
                  items: [
                    for (int i = 0; i < snapshot.data!.length; i++)
                      DropdownMenuItem(
                          value: snapshot.data![i],
                          child: Text(snapshot.data![i].name))
                  ],
                );
              } else if (snapshot.hasError) {
                return const Text('failed to fetch Region');
              } else {
                return const CircularProgressIndicator();
              }
            },
          ),
          FutureBuilder<List<city.Datum>>(
            future: fetchCities(stateId: stateID),
            builder: (BuildContext context,
                AsyncSnapshot<List<city.Datum>> snapshot) {
              if (snapshot.hasData) {
                return DropdownButton(
                    hint: HeadingMedium(title: 'Select City'),
                    isExpanded: true,
                    value: _selected,
                    items: snapshot.data
                        ?.map((e) => DropdownMenuItem(
                            value: e.name.toString(),
                            child: Text(e.name.toString())))
                        .toList(),
                    onChanged: (v) {
                      _selected = v;
                      setState(() {});
                    });
              } else if (snapshot.hasError) {
                return const Text('failed to fetch cities');
              } else {
                return const CircularProgressIndicator();
              }
            },
          ),
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
                    List<Placemark> placemarks = await placemarkFromCoordinates(
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
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: laudnryList.length,
            itemBuilder: (BuildContext context, int index) {
              final laundry = laudnryList[index];
              return Card(
                child: ExpansionTile(
                  expandedAlignment: Alignment.topLeft,
                  trailing: InkWell(
                    onTap: () {
                      ref
                          .read(businessPartnerProvider.notifier)
                          .deleteBusiness(id: laundry.id!);
                    },
                    child: SvgPicture.asset(
                      'assets/icons/delete.svg',
                      height: 20,
                      color: Colors.red,
                    ),
                  ),
                  title: Text(laundry.name.toString(),
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeightManager.semiBold),
                  ),
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: AppPadding.p6),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Heading(text: 'Store Name in English'),
                          HeadingMedium(
                            title: laundry.name.toString(),
                            color: ColorManager.greyColor,
                          ),
                          8.ph,
                          const Heading(text: 'Store Name in Arabic'),
                          HeadingMedium(
                            title: laundry.secondaryName.toString(),
                            color: ColorManager.greyColor,
                          ),
                          8.ph,
                          8.ph,
                          const Heading(text: 'Store Type'),
                          HeadingMedium(
                            title: laundry.type.toString(),
                            color: ColorManager.greyColor,
                          ),
                          8.ph,
                          const Heading(text: 'Number of  Branches'),
                          HeadingMedium(
                            title:  laundry.branches.toString(),
                            color: ColorManager.greyColor,
                          ),
                          8.ph,
                          const Heading(text: 'Services'),
                          HeadingMedium(
                            title: '', 
                            color: ColorManager.greyColor,
                          ),
                          const Heading(text: 'Service Types'),
                          HeadingMedium(
                            title: 'Dry Cleaning ,Pressing,Laundry',
                            color: ColorManager.greyColor,
                          ),
                          8.ph,
                          const Heading(text: 'Region'),
                          HeadingMedium(
                            title: 'Riyadh Region',
                            color: ColorManager.greyColor,
                          ),
                          8.ph,
                          const Heading(text: 'City'),
                          HeadingMedium(
                            title: 'Riyadh',
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
          MyButton(
            onPressed: () {
              // List<LaundryBusinessModel> laundryBusinessModel =
              final iD = DateTime.now().millisecondsSinceEpoch;

              LaundryBusinessModel laundryBusinessModel = LaundryBusinessModel(
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

              // UserModel user = UserModel(
              //   firstName:
              //       BusinessPartnerTextFormFields.firstNameController.text,
              //   lastName: BusinessPartnerTextFormFields.lastNameController.text,
              //   email: BusinessPartnerTextFormFields.emailController.text,
              //   password: BusinessPartnerTextFormFields.passwordController.text,
              //   role: 'businessowner',
              //   mobileNumber: BusinessPartnerTextFormFields
              //       .mobileNumberContactController.text,
              // );

              ref
                  .read(businessPartnerProvider.notifier)
                  .addBusiness(laundryBusinessModel: laundryBusinessModel);

              BusinessPartnerTextFormFields.cleartAllTextFormFields();
            },
            name: 'Add Another Store',
            isBorderButton: true,
            color: Colors.amber,
          )
        ],
      ),
    );
  }
}
