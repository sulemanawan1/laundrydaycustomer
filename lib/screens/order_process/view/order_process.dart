import 'dart:async';
import 'dart:math';
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:laundryday/models/ratings.dart';
import 'package:laundryday/screens/auth/signup/signup.dart';
import 'package:laundryday/screens/laundry_items/view/laundry_items.dart';
import 'package:laundryday/screens/delivery_pickup/view/delivery_pickup.dart';
import 'package:laundryday/screens/order_process/components/delivery_time_widget.dart';
import 'package:laundryday/screens/order_process/components/four_digit_code_widget.dart';
import 'package:laundryday/screens/order_process/components/order_status_info_widget.dart';
import 'package:laundryday/screens/order_process/providers/order_process_notifier.dart';
import 'package:laundryday/screens/order_process/providers/order_process_states.dart';
import 'package:laundryday/screens/order_summary/order_summary.dart';
import 'package:laundryday/utils/colors.dart';
import 'package:laundryday/utils/routes/route_names.dart';
import 'package:laundryday/utils/sized_box.dart';
import 'package:laundryday/utils/utils.dart';
import 'package:laundryday/widgets/address_detail_widget.dart';
import 'package:laundryday/widgets/map_icon_widget.dart';
import 'package:laundryday/widgets/my_app_bar.dart';
import 'package:laundryday/widgets/my_button.dart';
import 'package:laundryday/widgets/heading.dart';
import 'package:laundryday/widgets/my_loader.dart';
import 'package:url_launcher/url_launcher.dart';

final orderProcessProvider =
    StateNotifierProvider.autoDispose<OrderProcessNotifier, OrderProcessStates>(
        (ref) => OrderProcessNotifier());

class OrderProcess extends ConsumerStatefulWidget {
  final Arguments? orderDatailsArguments;

  const OrderProcess({super.key, required this.orderDatailsArguments});

  @override
  ConsumerState<OrderProcess> createState() => _OrderProcessState();
}

class _OrderProcessState extends ConsumerState<OrderProcess> {
  TimeOfDay? selectedTime;

  final _controller = DraggableScrollableController();

  final Completer<GoogleMapController> _googleMapcontroller =
      Completer<GoogleMapController>();

  static const LatLng sourceLocation =
      LatLng(24.549946260906324, 46.65291910092833);
  static const LatLng destination =
      LatLng(24.545658765869764, 46.665644942355414);

  List<Ratings> users = [];
  String fourDigitcode = '';

  @override
  void initState() {
    ref.read(orderProcessProvider.notifier).getCurrentLocation();
    selectedTime = TimeOfDay.now();

    super.initState();
    generateRandomCode();

    List.generate(7, (index) {
      var random = Random();
      double min = 1.0;
      double max = 5.0;

      double randomRating = min + random.nextDouble() * (max - min);
      var faker = Faker();

      users.add(Ratings(
          id: index,
          rating: randomRating,
          prefixName: faker.person.firstName(),
          name: faker.person.lastName(),
          image: 'assets/icons/user-avatar.png'));
    });
  }

  @override
  void dispose() {
    super.dispose();
    if (mounted) {
      _controller.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    var states = ref.watch(orderProcessProvider);
    final currentLocation = ref.watch(orderProcessProvider).currentLocation;
    final selectedItems = ref.watch(selectedItemNotifier);

    return Scaffold(
        appBar: MyAppBar(
          title: 'order',
          actions: [
            PopupMenuButton(
              iconColor: ColorManager.blackColor,
              icon: const Icon(Icons.more_vert),
              onSelected: (value) {
                // your logic
              },
              itemBuilder: (BuildContext bc) {
                return [
                  PopupMenuItem(
                    value: 'support',
                    child: SizedBox(
                      width: MediaQuery.of(context).size.height * 0.2,
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [Text("Support"), Icon(Icons.support_agent)],
                      ),
                    ),
                  ),
                  PopupMenuItem(
                    value: 'cancel order',
                    child: SizedBox(
                      width: MediaQuery.of(context).size.height * 0.2,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Cancel Order",
                            style: GoogleFonts.poppins(color: Colors.red),
                          ),
                          const Icon(
                            Icons.cancel,
                            color: Colors.red,
                          )
                        ],
                      ),
                    ),
                  ),
                ];
              },
            )
          ],
        ),
        body: Stack(children: [
          LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
            return SizedBox(
              height: constraints.maxHeight / 1,
              child: SingleChildScrollView(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                    if (widget.orderDatailsArguments!.laundryModel!.type ==
                        'deliverypickup') ...[
                      if (states.orderStatus == 0) ...[
                        const OrderStatusInfoWidget(
                            image: 'assets/vectors/step0.png',
                            title: 'Accepted Order',
                            description:
                                'The driver is coming to pick up your clothes.'),
                      ]
                      // else if (states.orderStatus == 1) ...[
                      //   const OrderStatusInfoWidget(
                      //       image: 'assets/vectors/step1.png',
                      //       title: 'Approach You',
                      //       description:
                      //           'The driver is coming to pick up your clothes.'),
                      // ] else if (states.orderStatus == 2) ...[
                      //   const OrderStatusInfoWidget(
                      //       image: 'assets/vectors/step2.png',
                      //       title: 'The invoice has been Issued',
                      //       description: 'The representative issue the invoice')
                      // ]

                      else if (states.orderStatus == 3) ...[
                        const OrderStatusInfoWidget(
                            image: 'assets/vectors/step3.png',
                            title: 'Driver recieved order.',
                            description:
                                'Driver received order,he is on his way'),
                      ] else if (states.orderStatus == 4) ...[
                        const OrderStatusInfoWidget(
                            image: 'assets/vectors/step4.png',
                            title: 'Driver near you.',
                            description:
                                'Driver near you,be ready to get your order,')
                      ] else if (states.orderStatus == 5) ...[
                        const OrderStatusInfoWidget(
                            image: 'assets/vectors/step5.png',
                            title: 'Your Order Completed',
                            description:
                                'Your Order Completed,we hope to see you again.')
                      ],
                      5.ph,
                      if (states.orderStatus == 4) ...[
                        FourDigitCodeWidget(fourDigitcode: fourDigitcode)
                      ] else ...[
                        const DeliveryTimeWidget(),
                      ],
                      20.ph,
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: states.orderStatusList
                              .map((e) => (e.status == 1 || e.status == 2)
                                  ? const SizedBox()
                                  : InkWell(
                                      onTap: () {
                                        ref
                                            .read(orderProcessProvider.notifier)
                                            .updateStatus(status: e.status);

                                        ref
                                            .read(orderProcessProvider.notifier)
                                            .updateIsActive(id: e.id);
                                        ref
                                            .read(orderProcessProvider.notifier)
                                            .getCurrentLocation();

                                        if (e.status == 5) {
                                          context.pushNamed(
                                              RouteNames().rateCourier);
                                        }
                                      },
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Icon(
                                            e.isActive
                                                ? Icons.check_circle_rounded
                                                : Icons.circle,
                                            color: e.isActive
                                                ? ColorManager.primaryColor
                                                : ColorManager.greyColor,
                                            size: 30,
                                          ),
                                          Text(
                                            e.description.toString(),
                                            style: GoogleFonts.poppins(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 10,
                                                color: e.isActive
                                                    ? ColorManager.primaryColor
                                                    : ColorManager.greyColor),
                                            textAlign: TextAlign.center,
                                          ),
                                          5.ph,
                                          e.isActive
                                              ? Text(
                                                  DateFormat("jm")
                                                      .format(e.createdAt!)
                                                      .toString(),
                                                  style: GoogleFonts.poppins(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 10,
                                                      color: ColorManager
                                                          .primaryColor),
                                                  textAlign: TextAlign.center,
                                                )
                                              : const SizedBox()
                                        ],
                                      ),
                                    ))
                              .toList()),
                    ] else ...[
                      if (states.orderStatus == 0) ...[
                        const OrderStatusInfoWidget(
                            image: 'assets/vectors/step0.png',
                            title: 'Accepted Order',
                            description:
                                'The driver is coming to pick up your clothes.'),
                      ] else if (states.orderStatus == 1) ...[
                        const OrderStatusInfoWidget(
                            image: 'assets/vectors/step1.png',
                            title: 'Approach You',
                            description:
                                'The driver is coming to pick up your clothes.'),
                      ] else if (states.orderStatus == 2) ...[
                        const OrderStatusInfoWidget(
                            image: 'assets/vectors/step2.png',
                            title: 'The invoice has been Issued',
                            description: 'The representative issue the invoice')
                      ] else if (states.orderStatus == 3) ...[
                        const OrderStatusInfoWidget(
                            image: 'assets/vectors/step3.png',
                            title: 'Driver recieved order.',
                            description:
                                'Driver received order,he is on his way')
                      ] else if (states.orderStatus == 4) ...[
                        const OrderStatusInfoWidget(
                            image: 'assets/vectors/step4.png',
                            title: 'Driver near you.',
                            description:
                                'Driver near you,be ready to get your order,')
                      ] else if (states.orderStatus == 5) ...[
                        const OrderStatusInfoWidget(
                            image: 'assets/vectors/step5.png',
                            title: 'Your Order Completed',
                            description:
                                'Your Order Completed,we hope to see you again.')
                      ],
                      5.ph,
                      if (states.orderStatus == 4) ...[
                        FourDigitCodeWidget(fourDigitcode: fourDigitcode)
                      ] else ...[
                        const DeliveryTimeWidget(),
                      ],
                      20.ph,
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: states.orderStatusList
                              .map((e) => InkWell(
                                    onTap: () {
                                      ref
                                          .read(orderProcessProvider.notifier)
                                          .updateStatus(status: e.status);

                                      ref
                                          .read(orderProcessProvider.notifier)
                                          .updateIsActive(id: e.id);
                                      ref
                                          .read(orderProcessProvider.notifier)
                                          .getCurrentLocation();

                                      if (e.status == 5) {
                                        context.pushNamed(
                                            RouteNames().rateCourier);
                                      }
                                    },
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Icon(
                                          e.isActive
                                              ? Icons.check_circle_rounded
                                              : Icons.circle,
                                          color: e.isActive
                                              ? ColorManager.primaryColor
                                              : ColorManager.greyColor,
                                          size: 30,
                                        ),
                                        Text(
                                          e.description.toString(),
                                          style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 10,
                                              color: e.isActive
                                                  ? ColorManager.primaryColor
                                                  : ColorManager.greyColor),
                                          textAlign: TextAlign.center,
                                        ),
                                        5.ph,
                                        e.isActive
                                            ? Text(
                                                DateFormat("jm")
                                                    .format(e.createdAt!)
                                                    .toString(),
                                                style: GoogleFonts.poppins(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 10,
                                                    color: ColorManager
                                                        .primaryColor),
                                                textAlign: TextAlign.center,
                                              )
                                            : const SizedBox()
                                      ],
                                    ),
                                  ))
                              .toList()),
                    ],
                    30.ph,
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: MyButton(
                        title: 'Request Details',
                        onPressed: () {
                          Utils.showResuableBottomSheet(
                              context: context,
                              widget: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  HeadingMedium(title: 'Address Details'),
                                  10.ph,
                                  const AddressDetailWidget(),
                                  10.ph,
                                  HeadingMedium(title: 'Order Details'),
                                  10.ph,
                                  const OrderDetailAddressWidget(),
                                  10.ph,
                                  Container(
                                    constraints: const BoxConstraints(
                                        maxHeight: double.infinity),
                                    child: Card(
                                      elevation: 0,
                                      child: ListView.separated(
                                        separatorBuilder: (context, index) =>
                                            5.ph,
                                        itemCount: selectedItems.length,
                                        shrinkWrap: true,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10),
                                            child: SizedBox(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                        selectedItems[index]
                                                            .name
                                                            .toString()),
                                                  ),
                                                  Expanded(
                                                    child: Text(
                                                        "x${selectedItems[index].quantity.toString()}"),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                  30.ph,
                                ],
                              ),
                              title: 'Request Details');
                        },
                        isBorderButton: true,
                        borderColor: Colors.amber,
                        textColor: Colors.amber,
                      ),
                    ),
                    5.ph,
                    states.orderStatus == 2
                        ? Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: MyButton(
                              color: ColorManager.amber,
                              title: 'Confirm Pickup',
                              onPressed: () {
                                _showMyDialog();
                              },
                            ),
                          )
                        : const SizedBox(),
                    5.ph,
                    states.orderStatus != 1 && states.orderStatus != 0
                        ? Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: MyButton(
                              title: 'View Invoice and Payment',
                              onPressed: () {
                                context.pushNamed(RouteNames().orderCheckout);
                              },
                            ),
                          )
                        : const SizedBox(),
                    10.ph,
                    currentLocation == null
                        ? const Loader()
                        : Stack(
                            children: [
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.17,
                                child: GoogleMap(
                                  initialCameraPosition: CameraPosition(
                                    target: LatLng(
                                        states.currentLocation!.latitude!,
                                        states.currentLocation!.longitude!),
                                    zoom: 13.5,
                                  ),
                                  onMapCreated:
                                      (GoogleMapController controller) {
                                    // _googleMapcontroller.complete(controller);
                                  },
                                  markers: {
                                    Marker(
                                      markerId:
                                          const MarkerId("currentLocation"),
                                      position: LatLng(
                                          states.currentLocation!.latitude!,
                                          states.currentLocation!.longitude!),
                                    ),
                                    const Marker(
                                      markerId: MarkerId('source'),
                                      position: sourceLocation,
                                    ),

                                    const Marker(
                                      markerId: MarkerId('desitonation'),
                                      position: destination,
                                    ),
                                    // Add more courier markers here
                                  },
                                  myLocationEnabled: true,
                                  zoomControlsEnabled: false,
                                  buildingsEnabled: false,
                                  myLocationButtonEnabled: false,
                                  mapToolbarEnabled: false,
                                  onCameraMove:
                                      (CameraPosition cameraPosition) {
                                    // states.selectedLat = cameraPosition.target.latitude;
                                    // states.selectedLng = cameraPosition.target.longitude;
                                  },
                                  onCameraIdle: () async {},
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Align(
                                  alignment: Alignment.topRight,
                                  child: MapIconWidget(
                                    onTap: () {
                                      showModalBottomSheet(
                                          isScrollControlled: true,
                                          context: context,
                                          builder: (BuildContext context) {
                                            return Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                10.ph,
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 10),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      const Heading(
                                                          title:
                                                              'Track your Courier.'),
                                                      IconButton(
                                                          onPressed: () {
                                                            GoRouter.of(context)
                                                                .pop();
                                                          },
                                                          icon: Icon(
                                                            Icons.close,
                                                            color: ColorManager
                                                                .greyColor,
                                                          ))
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 500,
                                                  child: GoogleMap(
                                                    initialCameraPosition:
                                                        CameraPosition(
                                                      target: LatLng(
                                                          states
                                                              .currentLocation!
                                                              .latitude!,
                                                          states
                                                              .currentLocation!
                                                              .longitude!),
                                                      zoom: 13.5,
                                                    ),
                                                    onMapCreated:
                                                        (GoogleMapController
                                                            controller) {
                                                      _googleMapcontroller
                                                          .complete(controller);
                                                    },
                                                    markers: {
                                                      Marker(
                                                        markerId: const MarkerId(
                                                            "currentLocation"),
                                                        position: LatLng(
                                                            states
                                                                .currentLocation!
                                                                .latitude!,
                                                            states
                                                                .currentLocation!
                                                                .longitude!),
                                                      ),
                                                      const Marker(
                                                        markerId:
                                                            MarkerId('source'),
                                                        position:
                                                            sourceLocation,
                                                      ),

                                                      const Marker(
                                                        markerId: MarkerId(
                                                            'desitonation'),
                                                        position: destination,
                                                      ),
                                                      // Add more courier markers here
                                                    },
                                                    myLocationEnabled: true,
                                                    zoomControlsEnabled: false,
                                                    buildingsEnabled: false,
                                                    myLocationButtonEnabled:
                                                        false,
                                                    mapToolbarEnabled: false,
                                                    onCameraMove:
                                                        (CameraPosition
                                                            cameraPosition) {
                                                      // states.selectedLat = cameraPosition.target.latitude;
                                                      // states.selectedLng = cameraPosition.target.longitude;
                                                    },
                                                    onCameraIdle: () async {},
                                                  ),
                                                ),
                                              ],
                                            );
                                          });
                                    },
                                    icon: Icons.zoom_out_map_outlined,
                                  ),
                                ),
                              )
                            ],
                          ),
                  ])),
            );
          }),
          DraggableScrollableSheet(
              controller: _controller,
              initialChildSize: 0.22,
              minChildSize: 0.22,
              builder: (context, scrollController) => Container(
                  decoration: BoxDecoration(
                      color: ColorManager.whiteColor,
                      borderRadius: const BorderRadius.horizontal(
                          right: Radius.circular(20),
                          left: Radius.circular(20))),
                  child: ListView.builder(
                    controller: scrollController,
                    shrinkWrap: true,
                    itemCount: users.length,
                    itemBuilder: (BuildContext context, int index) {
                      if (index == 0) {
                        return _courierDetails(context);
                      }

                      return ListTile(
                        leading: CircleAvatar(
                          backgroundColor: ColorManager.backgroundColor,
                          backgroundImage: AssetImage(users[index].image),
                        ),
                        title: Text(users[index].prefixName),
                        subtitle: Text(users[index].name),
                        trailing: RatingBar(
                          onRatingUpdate: (rating) {},
                          itemSize: 18,
                          ignoreGestures: true,
                          initialRating: users[index].rating,
                          direction: Axis.horizontal,
                          allowHalfRating: false,
                          ratingWidget: RatingWidget(
                            full: const Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            half: const Icon(
                              Icons.star_half,
                              color: Colors.amber,
                            ),
                            empty: Icon(
                              Icons.star_border,
                              color: ColorManager.greyColor,
                            ),
                          ),
                          itemPadding:
                              const EdgeInsets.symmetric(horizontal: 4.0),
                        ),
                      );
                    },
                  )))
        ]));
  }

  Widget _courierDetails(BuildContext context) {
    return Column(
      children: [
        5.ph,
        Container(
          width: 80,
          height: 5,
          decoration: BoxDecoration(
              color: const Color.fromARGB(255, 216, 213, 213),
              borderRadius: BorderRadius.circular(12)),
        ),
        5.ph,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            5.pw,
            const CircleAvatar(
              radius: 40,
              backgroundImage: AssetImage('assets/icons/user.png'),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Suleman Abrar'),
                        Row(
                          children: [
                            IconButton(
                                padding: EdgeInsets.zero,
                                onPressed: () {
                                  context.pushNamed(RouteNames().orderChat);
                                },
                                icon: const Icon(
                                    Icons.chat_bubble_outline_rounded)),
                            IconButton(
                                padding: EdgeInsets.zero,
                                onPressed: () async {
                                  Utils.showResuableBottomSheet(
                                      context: context,
                                      widget: Column(
                                        children: [
                                          SizedBox(
                                            width: double.infinity,
                                            child: TextButton(
                                                onPressed: () async {
                                                  var uri = Uri.parse(
                                                      "tel://${05134357098}");

                                                  try {
                                                    await launchUrl(uri);

                                                    // ignore: use_build_context_synchronously
                                                    context.pop();
                                                  } catch (e) {
                                                    Utils.showToast(
                                                        msg: e.toString(),
                                                        isNegative: true);
                                                  }
                                                },
                                                child: Text(
                                                  '05134357098',
                                                  style: GoogleFonts.poppins(
                                                      fontWeight:
                                                          FontWeight.w500),
                                                )),
                                          ),
                                          const Divider(),
                                          SizedBox(
                                            width: double.infinity,
                                            child: TextButton(
                                                onPressed: () {
                                                  context.pop();
                                                },
                                                child: Text(
                                                  'Cancel',
                                                  style: GoogleFonts.poppins(
                                                      fontWeight:
                                                          FontWeight.w500),
                                                )),
                                          ),
                                          10.ph
                                        ],
                                      ),
                                      title: 'Call');
                                },
                                icon: const Icon(Icons.call)),
                          ],
                        )
                      ],
                    ),
                    Text(
                      'Courier',
                      style: GoogleFonts.poppins(
                        color: ColorManager.greyColor,
                      ),
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.star,
                          size: 12,
                          color: Colors.amber,
                        ),
                        5.pw,
                        Text(
                          '4',
                          style:
                              GoogleFonts.poppins(fontWeight: FontWeight.w500),
                        ),
                        5.pw,
                        Text(
                          'base on (16)',
                          style: GoogleFonts.poppins(),
                        ),
                        TextButton(
                            style: ButtonStyle(
                                backgroundColor: MaterialStateColor.resolveWith(
                                    (states) => Colors.transparent)),
                            onPressed: () {},
                            child: Text(
                              'Reviews',
                              style: GoogleFonts.poppins(
                                  color: ColorManager.primaryColor),
                            ))
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.directions_car),
                            5.pw,
                            const Text('2023 Honda Civic'),
                          ],
                        ),
                        Text(
                          '9194',
                          style:
                              GoogleFonts.poppins(fontWeight: FontWeight.w500),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
        5.ph,
      ],
    );
  }

  void generateRandomCode() {
    // Generate a random 4-digit code
    Random random = Random();
    int code = random.nextInt(10000);
    setState(() {
      fourDigitcode = code.toString().padLeft(4, '0');
    });
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Availability'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                    "If you are present at your location, press the 'I'm Available' button. Otherwise, select your availability time. This way, your order will be delivered at your chosen time."),
                Text('Would you like to approve of this message?'),
              ],
            ),
          ),
          actions: [
            TextButton.icon(
              icon: const Icon(
                Icons.schedule,
                color: Colors.grey,
              ),
              label: Text(
                'Set availability',
                style: GoogleFonts.poppins(color: ColorManager.amber),
              ),
              onPressed: () {
                _selectTime(context);
              },
            ),
            TextButton(
              child: Text(
                "I'm available",
                style: GoogleFonts.poppins(color: ColorManager.primaryColor),
              ),
              onPressed: () {
                context.pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay currentTime = TimeOfDay.now();

    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialEntryMode: TimePickerEntryMode.dialOnly,
      initialTime: currentTime,
    );
    const TimeOfDay nineAm = TimeOfDay(hour: 9, minute: 00);
    const TimeOfDay tweleveAm = TimeOfDay(hour: 00, minute: 00);

    if (picked != null) {
      if (picked.hour > nineAm.hour && picked.hour > tweleveAm.hour) {
        selectedTime = picked;
        context.pop();
      } else {
        Utils.showToast(msg: 'The Availbilty Time Must between 9 AM to  12 AM');
      }
      setState(() {});
    }
  }
}
