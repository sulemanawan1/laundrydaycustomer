import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:laundryday/screens/auth/signup/signup.dart';
import 'package:laundryday/screens/find_courier/provider/find_courier_notifier.dart';
import 'package:laundryday/screens/find_courier/provider/find_courier_states.dart';
import 'package:laundryday/core/constants/colors.dart';
import 'package:laundryday/core/constants/sized_box.dart';
import 'package:laundryday/core/routes/route_names.dart';
import 'package:laundryday/core/widgets/map_icon_widget.dart';
import 'package:laundryday/core/widgets/my_app_bar.dart';
import 'package:laundryday/core/widgets/my_button.dart';
import 'package:laundryday/core/widgets/heading.dart';

final findCourierNotifier =
    StateNotifierProvider<FindCourierNotifier, FindCourierState?>(
        (_) => FindCourierNotifier());

class FindCourier extends ConsumerStatefulWidget {

  const FindCourier({super.key, });

  @override
  ConsumerState<FindCourier> createState() => _FindCourierState();
}

class _FindCourierState extends ConsumerState<FindCourier> {
  BitmapDescriptor? customIcon;

  List<Marker> courierMarkers = [
    // Add more courier markers here
  ];
  final Completer<GoogleMapController> _googleMapcontroller =
      Completer<GoogleMapController>();

  @override
  void initState() {
    super.initState();
    
    Future.delayed(Duration(seconds: 7), () {
      context.pushNamed(RouteNames().orderProcess,
       );
    });
  }

  @override
  Widget build(BuildContext context) {
    final states = ref.watch(findCourierNotifier);

    log(states!.markers!.length.toString());

    return Scaffold(
      appBar: MyAppBar(
        title: 'Find Courier',
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 4,
            child: Stack(
              children: <Widget>[
                Stack(alignment: Alignment.center, children: [
                  GoogleMap(
                    
                    initialCameraPosition: CameraPosition(
                      zoom: 25,
                      target: LatLng(states.selectedLat, states.selectedLng),
                    ),
                    onMapCreated: (GoogleMapController controller) {
                      _googleMapcontroller.complete(controller);
                    },
                    // compassEnabled: false,
                    markers: Set<Marker>.of(states.markers!),
                    myLocationEnabled: true,
                    zoomControlsEnabled: false,
                    buildingsEnabled: false,
                    myLocationButtonEnabled: false,
                    mapToolbarEnabled: false,
                    onCameraMove: (CameraPosition cameraPosition) {
                      states.selectedLat = cameraPosition.target.latitude;
                      states.selectedLng = cameraPosition.target.longitude;
                    },
                    onCameraIdle: () async {},
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
                      child: MapIconWidget(
                        onTap: () {
                          // LocationHandler.goToTheCurrentLoaction(
                          //     googleMapcontroller: _googleMapcontroller);
                        },
                      ),
                    ),
                  )
                ])
              ],
            ),
          ),
          Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    10.ph,
                    const Heading(title: 'Find Courier'),
                    10.ph,
                    HeadingMedium(
                      title:
                          'Patience always pay off.. Kindly allow us some time while we are looking for available courier.',
                      color: ColorManager.greyColor,
                    ),
                    20.ph,
                    MyButton(
                      title: 'Cancel Request',
                      borderColor: Colors.red,
                      isBorderButton: true,
                      textColor: Colors.red,
                      onPressed: () {},
                    )
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
