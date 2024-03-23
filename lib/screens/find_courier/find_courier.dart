import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:laundryday/app_services/location_handler.dart';
import 'package:laundryday/screens/auth/signup/signup.dart';
import 'package:laundryday/screens/delivery_pickup/view/delivery_pickup.dart';
import 'package:laundryday/screens/find_courier/find_courier_notifier.dart';
import 'package:laundryday/screens/find_courier/find_courier_states.dart';
import 'package:laundryday/utils/colors.dart';
import 'package:laundryday/utils/routes/route_names.dart';
import 'package:laundryday/utils/sized_box.dart';
import 'package:laundryday/widgets/map_icon_widget.dart';
import 'package:laundryday/widgets/my_app_bar/my_app_bar.dart';
import 'package:laundryday/widgets/my_button/my_button.dart';
import 'package:laundryday/widgets/my_heading/heading.dart';

final findCourierNotifier =
    StateNotifierProvider<FindCourierNotifier, FindCourierState?>(
        (_) => FindCourierNotifier());

class FindCourier extends ConsumerStatefulWidget {
  final Arguments? orderDatailsArguments;

  const FindCourier({super.key, required this.orderDatailsArguments});

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

    BitmapDescriptor.fromAssetImage(
            const ImageConfiguration(size: Size(32, 32)),
            'assets/icons/car.png')
        .then((onValue) {
      customIcon = onValue;

      courierMarkers = [
        Marker(
          icon: customIcon!,
          markerId: const MarkerId('courier1'),
          position: const LatLng(24.542401221727932, 46.65266108194772),
          infoWindow: const InfoWindow(title: 'Courier 1'),
        ),

        Marker(
          icon: customIcon!,
          markerId: const MarkerId('courier2'),
          position: const LatLng(24.537055308085204, 46.647226462391004),
          infoWindow: const InfoWindow(title: 'Courier 2'),
        ),

        Marker(
          icon: customIcon!,
          markerId: const MarkerId('courier3'),
          position: const LatLng(24.547472660637418, 46.648258219680784),
          infoWindow: const InfoWindow(title: 'Courier 3'),
        ),
        // Add more courier markers here
      ];
    });

    LocationHandler.goToTheCurrentLoaction(
        googleMapcontroller: _googleMapcontroller);

    log(widget.orderDatailsArguments!.laundryModel!.id.toString());

    Future.delayed(const Duration(seconds: 0), () {
      ref
          .read(findCourierNotifier.notifier)
          .addMarkers(markers: courierMarkers);
    });

    Timer(const Duration(seconds: 7), () {
      if (mounted) {
        context.pushNamed(RouteNames().orderProcess,
            extra: widget.orderDatailsArguments);
      }
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
                          LocationHandler.goToTheCurrentLoaction(
                              googleMapcontroller: _googleMapcontroller);
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
                    const Heading(text: 'Find Courier'),
                    10.ph,
                    HeadingMedium(
                      title:
                          'Patience always pay off.. Kindly allow us some time while we are looking for available courier.',
                      color: ColorManager.greyColor,
                    ),
                    20.ph,
                    MyButton(
                      name: 'Cancel Request',
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
