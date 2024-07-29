import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laundryday/core/constants/font_manager.dart';
import 'package:laundryday/core/theme/styles_manager.dart';
import 'package:laundryday/models/item_model.dart';
import 'package:laundryday/models/laundry_model.dart';
import 'package:laundryday/models/services_model.dart';
import 'package:laundryday/screens/delivery_pickup/view/delivery_pickup.dart';
import 'package:laundryday/screens/laundries/model/delivery_pickup_laundry_model.dart';
import 'package:laundryday/screens/order_review/order_review_notifier.dart';
import 'package:laundryday/screens/order_review/order_review_states.dart';
import 'package:laundryday/core/constants/colors.dart';
import 'package:laundryday/core/constants/sized_box.dart';
import 'package:laundryday/core/constants/value_manager.dart';
import 'package:laundryday/core/routes/route_names.dart';
import 'package:laundryday/core/widgets/my_app_bar.dart';
import 'package:laundryday/core/widgets/my_button.dart';
import 'package:laundryday/core/widgets/heading.dart';
import 'package:laundryday/core/widgets/payment_method_widget.dart';
import 'package:laundryday/core/widgets/payment_summary_widget.dart';
import 'package:collection/collection.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';
import 'package:voice_message_package/voice_message_package.dart';
import 'package:laundryday/screens/services/model/services_model.dart' as s;

final orderReviewProvider =
    StateNotifierProvider<OrderReviewNotifier, OrderReviewStates>(
        (ref) => OrderReviewNotifier());

class OrderReview extends ConsumerStatefulWidget {
  OrderType orderType;
  s.Datum service;
  DeliveryPickupLaundryModel? laundry;

  OrderReview({
    required this.orderType,
    required this.service,
    this.laundry,
    super.key,
  });

  @override
  ConsumerState<OrderReview> createState() => _OrderCheckoutState();
}

class _OrderCheckoutState extends ConsumerState<OrderReview> {
  int totalSeconds = 0;
  final record = AudioRecorder();
  File? audioFile;
  bool isRecording = false;
  Timer? timer;
  late VoiceController voiceController;

  void stopRecording() async {
    await record.stop();
    timer!.cancel();
    totalSeconds = 0;
    isRecording = false;

    setState(() {});
  }

  String formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;

    return '$minutes:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  void startRecording() async {
    if (await record.hasPermission()) {
      Directory documentDirectory = await getApplicationDocumentsDirectory();
      String path = join(documentDirectory.path,
          '${DateTime.now().microsecondsSinceEpoch}.m4a');
      // Start recording to file
      await record.start(const RecordConfig(), path: path);
      isRecording = true;

      timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        totalSeconds++;
        log('Recording Time :$totalSeconds');

        setState(() {});
        if (totalSeconds >= 90) {
          stopRecording();
        }
      });

      audioFile = File(path);

      setState(() {});
    }
  }

  @override
  void dispose() {
    super.dispose();
    record.dispose();
    timer?.cancel();
    voiceController.dispose();
  }

  @override
  void initState() {
    voiceController = VoiceController(
        audioSrc: '',
        maxDuration: Duration(),
        isFile: false,
        onComplete: () {},
        onPause: () {},
        onPlaying: () {});
    super.initState();

    // widget.orderDatailsArguments.laundryModel!.service!.vat =
    //     (subtotal * 15) / 100;
  }

  Map<int?, List<ItemModel>> groupItemsByCategory(List<ItemModel> items) {
    return groupBy(items, (items) => items.categoryId);
  }

  @override
  Widget build(BuildContext context) {
    // final itemsList = ref.watch(selectedItemNotifier);
    final deliveryPickupReceipt = ref.watch(deliverPickupProvider).image;
    // Map<int?, List<ItemModel>> li = groupItemsByCategory(itemsList);

    return Scaffold(
      appBar: MyAppBar(title: 'Review Order'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: LayoutBuilder(builder: (context, cx) {
          return widget.orderType == OrderType.delivery_pickup
              ? SingleChildScrollView(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // widget.orderDatailsArguments.laundryModel!.service!.id == 3
                        //     ? ListView.builder(
                        //         shrinkWrap: true,
                        //         physics: const NeverScrollableScrollPhysics(),
                        //         itemCount: itemsList.length,
                        //         itemBuilder: (BuildContext context, int index) {
                        //           double total = 0.0;
                        //           for (int i = 0; i < itemsList.length; i++) {
                        //             total = total + itemsList[i].charges!;
                        //           }

                        //           log('The Total is $total');
                        //           return groupItemCard(
                        //               textColor: ColorManager.blackColor,
                        //               color: Colors.white,
                        //               quantityCardColor:
                        //                   ColorManager.primaryColorOpacity10,
                        //               element: itemsList[index],
                        //               buttonColor: ColorManager.blackColor);
                        //         },
                        //       )
                        //     : widget.orderDatailsArguments.laundryModel!.type ==
                        //             'deliverypickup'
                        //         ?

                        Card(
                          elevation: 0,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  5.ph,
                                  const Heading(
                                    title: 'Order Details',
                                  ),
                                  10.ph,
                                  Text(
                                    'Pickup Recipt',
                                    style: getMediumStyle(
                                        color: ColorManager.greyColor,
                                        fontSize: FontSize.s10),
                                  ),
                                  10.ph,
                                  SizedBox(
                                    height: 200,
                                    width: MediaQuery.of(context).size.width,
                                    child: Image.file(
                                        height: 100,
                                        File(
                                          deliveryPickupReceipt!.path
                                              .toString(),
                                        )),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),

                        // ListView.builder(
                        //     physics: const NeverScrollableScrollPhysics(),
                        //     shrinkWrap: true,
                        //     itemCount: li.length,
                        //     itemBuilder: (BuildContext context, int index) {
                        //       int? category = li.keys.elementAt(index);

                        //       List<ItemModel> itemsInCategory = li[category]!;

                        //       return Column(
                        //         children: [
                        //           if (category == 1) ...[
                        //             GroupHeaderCard(
                        //               color: Colors.blue.withOpacity(0.7),
                        //               text: 'Laundry',
                        //               image: 'assets/icons/laundry.png',
                        //             ),
                        //           ] else if (category == 2) ...[
                        //             GroupHeaderCard(
                        //               color: Colors.red.withOpacity(0.7),
                        //               text: 'Dry Cleaning',
                        //               image: 'assets/icons/dry_cleaning.png',
                        //             ),
                        //           ] else if (category == 3) ...[
                        //             GroupHeaderCard(
                        //               color: Colors.green.withOpacity(0.7),
                        //               text: 'Pressing',
                        //               image: 'assets/icons/pressing.png',
                        //             ),
                        //           ],
                        //           ListView.builder(
                        //             shrinkWrap: true,
                        //             physics: const NeverScrollableScrollPhysics(),
                        //             itemCount: itemsInCategory.length,
                        //             itemBuilder:
                        //                 (BuildContext context, int index) {
                        //               return Column(
                        //                 children: [
                        //                   if (category == 1) ...[
                        //                     groupItemCard(
                        //                         color:
                        //                             Colors.blue.withOpacity(0.7),
                        //                         element: itemsInCategory[index],
                        //                         buttonColor: Colors.blue),
                        //                   ] else if (category == 2) ...[
                        //                     groupItemCard(
                        //                         color:
                        //                             Colors.red.withOpacity(0.7),
                        //                         buttonColor: Colors.red,
                        //                         element: itemsInCategory[index])
                        //                   ] else if (category == 3) ...[
                        //                     groupItemCard(
                        //                       color:
                        //                           Colors.green.withOpacity(0.7),
                        //                       element: itemsInCategory[index],
                        //                       buttonColor: Colors.green,
                        //                     )
                        //                   ]
                        //                 ],
                        //               );
                        //             },
                        //           ),
                        //           10.ph,
                        //         ],
                        //       );
                        //     },
                        //   ),

                        Card(
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  isRecording == false
                                      ? Row(
                                          children: [
                                            IconButton(
                                                onPressed: () {
                                                  startRecording();
                                                },
                                                icon: Icon(Icons.mic,
                                                    color: ColorManager
                                                        .blueColor)),
                                            5.pw,
                                            Text(
                                              'Record your Order instructions.',
                                              style: GoogleFonts.poppins(
                                                  fontWeight: FontWeight.w600),
                                            )
                                          ],
                                        )
                                      : Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            IconButton(
                                                onPressed: () {
                                                  stopRecording();
                                                },
                                                icon: Icon(
                                                  Icons.stop,
                                                  color: ColorManager.redColor,
                                                )),
                                            5.pw,
                                            Text(
                                              'Stop Recording ${formatTime(totalSeconds)}',
                                              style: GoogleFonts.poppins(
                                                  fontWeight: FontWeight.w600),
                                            )
                                          ],
                                        )
                                ],
                              ),
                              audioFile?.path != null
                                  ? Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                          10.ph,
                                          VoiceMessageView(
                                            backgroundColor:
                                                ColorManager.whiteColor,
                                            activeSliderColor:
                                                ColorManager.primaryColor,
                                            circlesColor:
                                                ColorManager.primaryColor,
                                            controller: voiceController =
                                                VoiceController(
                                                    audioSrc: audioFile!.path
                                                        .toString(),
                                                    maxDuration: const Duration(
                                                        seconds: 90),
                                                    isFile: true,
                                                    onComplete: () {},
                                                    onPause: () {},
                                                    onPlaying: () {}),
                                            innerPadding: 12,
                                            cornerRadius: 20,
                                            size: 38,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: AppPadding.p10),
                                            child: OutlinedButton(
                                                style: ButtonStyle(
                                                    overlayColor: WidgetStateColor
                                                        .resolveWith((states) =>
                                                            ColorManager
                                                                .redColor
                                                                .withOpacity(
                                                                    0.1)),
                                                    textStyle:
                                                        WidgetStateProperty
                                                            .resolveWith(
                                                      (states) =>
                                                          GoogleFonts.poppins(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                    ),
                                                    side: WidgetStateBorderSide
                                                        .resolveWith((states) =>
                                                            BorderSide(
                                                                color: ColorManager
                                                                    .redColor))),
                                                onPressed: () {
                                                  audioFile = null;
                                                  stopRecording();

                                                  setState(() {});
                                                },
                                                child: Center(
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Icon(
                                                        Icons.delete,
                                                        color: ColorManager
                                                            .redColor,
                                                      ),
                                                      Text(
                                                        'Delete',
                                                        style: GoogleFonts.poppins(
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color: ColorManager
                                                                .blackColor),
                                                      )
                                                    ],
                                                  ),
                                                )),
                                          ),
                                          10.ph,
                                        ])
                                  : const SizedBox(),
                            ],
                          ),
                        ),
                        10.ph,
                        const PaymentMethodWidget(),
                        10.ph,
                        PaymentSummaryWidget(
                          service: widget.service,
                        ),
                        10.ph,

                        MyButton(
                          title: 'Order',
                          onPressed: () async {
                            context.pushNamed(
                              RouteNames().findCourier,
                            );
                          },
                        )
                        // Column(
                        //   crossAxisAlignment: CrossAxisAlignment.start,
                        //   children: [
                        //     10.ph,

                        //     15.ph,
                        //     PaymentSummaryWidget(
                        //       service: widget.orderDatailsArguments.laundryModel!.service,
                        //       ref: ref,
                        //     ),
                        //     15.ph,
                        //     widget.orderDatailsArguments.laundryModel!.type ==
                        //             'deliverypickup'
                        //         ? MyButton(
                        //             title: 'Pay $finalAmount',
                        //             onPressed: () async {
                        //               context.pushNamed(RouteNames().findCourier,
                        //                   extra: widget.orderDatailsArguments);
                        //             },
                        //           )
                        //         : MyButton(
                        //             title: 'Place Order',
                        //             onPressed: () {
                        //               context.pushNamed(RouteNames().findCourier,
                        //                   extra: widget.orderDatailsArguments);
                        //             },
                        //           ),
                        //     30.ph,
                        //   ],
                        // )
                      ]),
                )
              : SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [],
                  ),
                );
        }),
      ),
    );
  }

  Widget groupItemCard({
    required ItemModel element,
    required Color color,
    required Color buttonColor,
    Color? textColor,
    Color? quantityCardColor,
  }) {
    return Container(
      margin: EdgeInsets.zero,
      color: color,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            title: Text(
              element.name.toString(),
              style: GoogleFonts.poppins(
                  color: textColor ?? ColorManager.whiteColor,
                  fontWeight: FontWeight.w600),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                '${(element.initialCharges! * int.parse(element.quantity.toString())).toString()} SAR ',
                maxLines: 2,
                style: GoogleFonts.poppins(
                    color: textColor ?? ColorManager.whiteColor,
                    fontWeight: FontWeight.w500),
              ),
            ),
            trailing: Container(
              height: 30,
              decoration: ShapeDecoration(
                  color: quantityCardColor ?? Colors.white,
                  shape: const StadiumBorder()),
              margin: EdgeInsets.zero,
              child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    5.pw,
                    element.quantity == 1
                        ? IconButton(
                            padding: const EdgeInsets.only(left: 5),
                            constraints: const BoxConstraints(
                                minWidth: 30, maxWidth: 30),
                            onPressed: () {
                              // ref
                              //     .read(selectedItemNotifier.notifier)
                              //     .deleteQuantity(id: element.id);
                            },
                            icon: SvgPicture.asset(
                              'assets/icons/delete.svg',
                              height: 18,
                              color: buttonColor,
                            ))
                        : IconButton(
                            // ignore: prefer_const_constructors
                            padding: EdgeInsets.only(left: 5),
                            constraints: const BoxConstraints(
                                minWidth: 30, maxWidth: 30),
                            onPressed: () {
                              // ref
                              //     .read(selectedItemNotifier.notifier)
                              //     .removeQuantity(id: element.id);
                            },
                            icon: Icon(
                              Icons.remove,
                              color: buttonColor,
                            )),
                    ConstrainedBox(
                      constraints:
                          const BoxConstraints(minWidth: 40, maxWidth: 40),
                      child: Center(
                        child: Text(
                          element.quantity.toString(),
                          style: GoogleFonts.poppins(
                              color: buttonColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                    IconButton(
                        padding: const EdgeInsets.only(right: 5),
                        constraints:
                            const BoxConstraints(minWidth: 30, maxWidth: 30),
                        onPressed: () {
                          // ref
                          //     .read(selectedItemNotifier.notifier)
                          //     .addQuantity(id: element.id);
                        },
                        icon: Icon(
                          Icons.add,
                          color: buttonColor,
                        )),
                  ]),
            ),
          ),
          element.category == 'carpets'
              ? Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: AppPadding.p12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'L:${element.prefixLength}.${element.postfixLength}*W:${element.prefixWidth}.${element.postfixWidth}'
                            .toString(),
                        style: GoogleFonts.poppins(
                            color: textColor ?? ColorManager.whiteColor,
                            fontWeight: FontWeight.w500),
                      ),
                      Text(
                        element.category.toString(),
                        style: GoogleFonts.poppins(
                            color: textColor ?? ColorManager.whiteColor,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                )
              : const SizedBox()
        ],
      ),
    );
  }
}

class GroupHeaderCard extends StatelessWidget {
  final Color? color;
  final String? text;
  final String? image;

  const GroupHeaderCard(
      {super.key,
      required this.color,
      required this.text,
      required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.zero,
      color: color ?? ColorManager.backgroundColor,
      child: IntrinsicHeight(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                text!,
                style: GoogleFonts.poppins(
                    fontSize: 18,
                    color: ColorManager.whiteColor,
                    fontWeight: FontWeight.bold),
              ),
              Image.asset(
                image!,
                height: 34,
                color: ColorManager.whiteColor,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ClothDetailsArguments {
  ServicesModel? servicesModel;
  LaundryModel? laundryModel;

  ClothDetailsArguments({
    required this.laundryModel,
    required this.servicesModel,
  });
}
