// ignore_for_file: unused_local_variable

import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laundryday/Widgets/my_heading/heading.dart';
import 'package:laundryday/Widgets/my_textForm%20_field/my_textform_field.dart';
import 'package:laundryday/helpers/validation_helper/validation_helper.dart';
import 'package:laundryday/models/city.dart' as city;
import 'package:laundryday/models/state.dart';
import 'package:laundryday/screens/auth/signup/signup.dart';
import 'package:laundryday/screens/more/help/business_partner/notifier/business_partner_notifier.dart';
import 'package:laundryday/app_services/location_handler.dart';
import 'package:laundryday/utils/colors.dart';
import 'package:laundryday/utils/utils.dart';
import 'package:laundryday/utils/sized_box.dart';
import 'package:laundryday/utils/value_manager.dart';
import 'package:laundryday/widgets/my_app_bar/my_app_bar.dart';
import 'package:uuid/uuid.dart';

class BusinessPartner extends ConsumerStatefulWidget {
  const BusinessPartner({super.key});

  @override
  ConsumerState<BusinessPartner> createState() => _BusinessPartnerState();
}

class _BusinessPartnerState extends ConsumerState<BusinessPartner> {
  // ContactInformation

  // Bussiness Information

  int currentStep = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: 'Laundry Day Business',
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: AppPadding.p20),
        child: Stepper(
            elevation: 0,
            currentStep: currentStep,
            controlsBuilder: (context, details) {
              return Row(
                children: [
                  TextButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateColor.resolveWith(
                            (states) => ColorManager. primaryColor)),
                    onPressed: details.onStepContinue,
                    child: Text(
                      'Continue',
                      style: GoogleFonts.poppins(color: ColorManager.whiteColor),
                    ),
                  ),
                  TextButton(
                    onPressed: details.onStepCancel,
                    child: Text(
                      'Back',
                      style: GoogleFonts.poppins(color: ColorManager.blackColor),
                    ),
                  ),
                ],
              );
            },
            connectorColor: MaterialStateColor.resolveWith((states) {
              if (states.contains(MaterialState.selected)) {
                return ColorManager.primaryColor;
              }
              return Colors.grey;
            }),
            onStepContinue: () {
              if (currentStep < 2) {
                currentStep++;
                setState(() {});
              }
            },
            onStepCancel: () {
              if (currentStep <= 0) {
                currentStep = 0;
              } else {
                currentStep--;

                setState(() {});
              }
            },
            type: StepperType.horizontal,
            steps: [
              Step(
                  title: HeadingMedium(title: 'Step 1'),
                  isActive: currentStep >= 0 ? true : false,
                  content: ContactInformation()),
              Step(
                  title: HeadingMedium(title: 'Step 2'),
                  content: const BusinessInformation(),
                  isActive: currentStep >= 1 ? true : false),
              Step(
                  title: HeadingMedium(title: 'Step 3'),
                  content: const AddressInformation(),
                  isActive: currentStep >= 2 ? true : false),
            ]),
      ),
    );
  }
}

class ContactInformation extends StatelessWidget {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _mobileNumberContactController = TextEditingController();

  ContactInformation({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        20.ph,
        const Heading(
          text: 'Contact Information',
        ),
        20.ph,
        const HeadingSmall(title: 'First Name'),
        10.ph,
        MyTextFormField(
          hintText: '',
          labelText: 'First Name',
          controller: _firstNameController,
        ),
        10.ph,
        const HeadingSmall(title: 'Last Name'),
        10.ph,
        MyTextFormField(
          hintText: '',
          labelText: 'Last Name',
          controller: _lastNameController,
        ),
        10.ph,
        const HeadingSmall(
          title: 'Email',
        ),
        10.ph,
        MyTextFormField(
          hintText: '',
          labelText: 'Email',
          controller: _emailController,
        ),
        10.ph,
        const HeadingSmall(
          title: 'Mobile Number',
        ),
        10.ph,
        MyTextFormField(
          controller: _mobileNumberContactController,
          textInputType: TextInputType.number,
          maxLength: 9,
          validator: ValidationHelper().validatePhoneNumber,
          hintText: '5xxxxxxxx',
          labelText: 'Mobile Number',
          contentPadding: const EdgeInsets.only(top: AppPadding.p20),
          prefixIcon: Padding(
            padding:
                const EdgeInsetsDirectional.only(end:AppPadding.p12, top: AppPadding.p14, start: AppPadding.p10),
            child: Text(
              '+966',
              style: GoogleFonts.poppins(
                fontSize: 15,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          suffixIcon:  Icon(
            Icons.phone_android,
            color: ColorManager. primaryColor,
          ),
        ),
      ],
    );
  }
}

// ignore: must_be_immutable
class BusinessInformation extends StatefulWidget {
  const BusinessInformation({super.key});

  @override
  State<BusinessInformation> createState() => _BusinessInformationState();
}

class _BusinessInformationState extends State<BusinessInformation> {
  final _storeNameTradeLicenseController = TextEditingController();

  final _branchController = TextEditingController();

  final _mobileNumberBusinessController = TextEditingController();

  List<String> items = ['Furniture', 'Clothing', 'Blankets', 'Carpets'];
  List<String> selectedItems = [];
  List<String> allItems = [];
  CategoryType? categoryType;

  @override
  Widget build(BuildContext context) {
    // final businessProvider = ref.watch(businessPartnerProvider);
    // final businessPartnerNotifier = ref.watch(businessPartnerProvider.notifier);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        20.ph,
        const Heading(text: 'Tell us about your business'),
        20.ph,
        const HeadingSmall(title: 'Store Name on Trade Licence'),
        10.ph,
        MyTextFormField(
          hintText: 'Store Name on Trade Licence',
          labelText: '',
          controller: _storeNameTradeLicenseController,
        ),
        10.ph,
        const HeadingSmall(title: 'Category'),
        DropdownButton<CategoryType>(
            isExpanded: true,
            padding: EdgeInsets.zero,
            value: categoryType,
            onChanged: (CategoryType? newValue) {
              if (newValue != null) {
                categoryType = newValue;
                setState(() {});
              }
            },
            items: CategoryType.values.map((CategoryType type) {
              return DropdownMenuItem<CategoryType>(
                value: type,
                child: Text(
                  type == CategoryType.laundry ? 'Laundry' : 'Laundry',
                  style: GoogleFonts.poppins(),
                ),
              );
            }).toList()),
        10.ph,
        GestureDetector(
            onTap: () {
              showDialog(
                  context: context,
                  builder: ((context) =>
                      StatefulBuilder(builder: (context, stat) {
                        return SimpleDialog(
                            title: const Heading(text: 'Select Service Type'),
                            children: [
                              Column(
                                children: items
                                    .map((e) => CheckboxListTile(
                                        title: Text(e.toString()),
                                        value: selectedItems.contains(e),
                                        onChanged: (item) {
                                          if (item == true) {
                                            selectedItems.add(e);
                                            stat(() {});
                                            setState(() {});
                                          } else {
                                            selectedItems.remove(e);
                                            stat(() {});
                                            setState(() {});
                                          }
                                        }))
                                    .toList(),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  TextButton(
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateColor.resolveWith(
                                                (states) => ColorManager.primaryColor)),
                                    onPressed: () {
                                      context.pop(selectedItems);
                                    },
                                    child: Text(
                                      "Submit",
                                      style: GoogleFonts.poppins(
                                          color: ColorManager.whiteColor),
                                    ),
                                  ),
                                  10.pw,
                                  TextButton(
                                    onPressed: () {
                                      context.pop();
                                    },
                                    child: Text(
                                      "Cancel",
                                      style: GoogleFonts.poppins(
                                          color: ColorManager.blackColor),
                                    ),
                                  ),
                                ],
                              )
                            ]);
                      })));
            },
            child: const HeadingSmall(title: 'Service Type')),
        10.ph,
        Wrap(
            children: selectedItems
                .map((e) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Chip(
                        deleteIconColor: ColorManager. whiteColor,
                        onDeleted: () {
                          selectedItems.remove(e);
                          setState(() {});
                        },
                        backgroundColor: Colors.green,
                        label: Text(
                          e.toString(),
                          style: GoogleFonts.poppins(color: ColorManager. whiteColor),
                        ),
                      ),
                    ))
                .toList()),
        10.ph,
        MyTextFormField(
          hintText: '',
          labelText: 'Branches',
          controller: _branchController,
        ),
        10.ph,
        const HeadingSmall(title: 'Mobile Number'),
        10.ph,
        MyTextFormField(
          controller: _mobileNumberBusinessController,
          textInputType: TextInputType.number,
          maxLength: 9,
          validator: ValidationHelper().validatePhoneNumber,
          hintText: '5xxxxxxxx',
          labelText: 'Mobile Number',
          contentPadding: const EdgeInsets.only(top: AppPadding.p20),
          prefixIcon: Padding(
            padding:
                const EdgeInsetsDirectional.only(end: AppPadding.p12, top: AppPadding.p14, start: AppPadding.p10),
            child: Text(
              '+966',
              style: GoogleFonts.poppins(
                fontSize: 15,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          suffixIcon:  Icon(
            Icons.phone_android,
            color: ColorManager. primaryColor,
          ),
        ),
      ],
    );
  }
}

class AddressInformation extends StatefulWidget {
  const AddressInformation({super.key});

  @override
  State<AddressInformation> createState() => _AddressInformationState();
}

class _AddressInformationState extends State<AddressInformation> {
  final _controller = TextEditingController();
  var uuid = const Uuid();
  final String _sessionToken = '1234567890';
  List<dynamic> _placeList = [];
  String? address;
  Datum? datum;
  List<Datum> stateLi = [];
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

  Future<List<Datum>> fetchAlbum() async {
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
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          10.ph,
          const Heading(text: 'Where is your Laundry located.'),
          10.ph,
          HeadingMedium(
            title:
                'Customers will use this delivery information\nto find your laundry location.',
            color: ColorManager. greyColor,
          ),
          10.ph,

          FutureBuilder<List<Datum>>(
            future: fetchAlbum(),
            builder:
                (BuildContext context, AsyncSnapshot<List<Datum>> snapshot) {
              if (snapshot.hasData) {
                return DropdownButton(
                  // value: datum,

                  onChanged: (Datum? v) {
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
          10.ph,
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
                                  color: ColorManager.primaryColor.withOpacity(0.2)),
                              child:  Center(
                                  child: Icon(
                                Icons.location_on,
                                color: ColorManager. primaryColor,
                              ))),
                          title: Text(_placeList[index]["description"]),
                        ),
                      );
                    },
                  ),
                )
              : Container(),
          10.ph,

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
                color: ColorManager. primaryColor,
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
                      decoration:  BoxDecoration(
                          shape: BoxShape.circle, color: ColorManager.whiteColor),
                      child: const Center(child: Icon(Icons.my_location)),
                    ),
                  ),
                ),
              )
            ]),
          ),
          20.ph
          //  FutureBuilder<StateModel>(
          //     future: fetchAlbum(),
          //     builder: (context, snapshot) {
          //       if (snapshot.connectionState == ConnectionState.waiting) {
          //         return const CircularProgressIndicator();
          //       } else if (snapshot.hasError) {
          //         return Text('Error: ${snapshot.error}');
          //       } else {
          //         // DropdownButton
          //         return DropdownButton<StateModel>(
          //           value: snapshot.data, // Set default value if needed
          //           items: snapshot.data?.data.map((states) {
          //             return DropdownMenuItem<StateModel>(
          //               value: states as StateModel,
          //               child: Text(states.name),
          //             );
          //           }).toList(),
          //           onChanged: (value) {
          //             // Handle dropdown value change
          //             // print(value?.name);
          //           },
          //         );
          //       }
          //     },
          //   ),
        ],
      ),
    );
  }
}
