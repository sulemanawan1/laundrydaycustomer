import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:laundryday/core/fees_calculations.dart';
import 'package:laundryday/core/utils.dart';
import 'package:laundryday/helpers/order_helper.dart';
import 'package:laundryday/constants/font_manager.dart';
import 'package:laundryday/config/theme/styles_manager.dart';
import 'package:laundryday/screens/laundries/view/laundries.dart';
import 'package:laundryday/widgets/my_loader.dart';
import 'package:laundryday/widgets/payment_summary_widget.dart';
import 'package:laundryday/shared/provider/user_notifier.dart';
import 'package:laundryday/screens/auth/signup/signup.dart';
import 'package:laundryday/screens/delivery_pickup/view/delivery_pickup.dart';
import 'package:laundryday/screens/laundries/provider/laundries_notifier.dart';
import 'package:laundryday/screens/laundry_items/model/item_variation_model.dart';
import 'package:laundryday/screens/laundry_items/provider/laundry_items.notifier.dart';
import 'package:laundryday/screens/order_review/presentaion/riverpod/order_review_notifier.dart';
import 'package:laundryday/constants/colors.dart';
import 'package:laundryday/constants/sized_box.dart';
import 'package:laundryday/constants/value_manager.dart';
import 'package:laundryday/config/routes/route_names.dart';
import 'package:laundryday/widgets/my_app_bar.dart';
import 'package:laundryday/widgets/my_button.dart';
import 'package:laundryday/widgets/heading.dart';
import 'package:laundryday/screens/order_review/presentaion/riverpod/payment_method_nofifier.dart';
import 'package:laundryday/screens/services/provider/addresses_notifier.dart';
import 'package:laundryday/screens/services/provider/services_notifier.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';
import 'package:voice_message_package/voice_message_package.dart';

class OrderReview extends ConsumerStatefulWidget {
  final OrderScreenType orderType;

  OrderReview({
    required this.orderType,
    super.key,
  });

  @override
  ConsumerState<OrderReview> createState() => _OrderReviewState();
}

class _OrderReviewState extends ConsumerState<OrderReview> {
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
          '${DateTime.now().microsecondsSinceEpoch}.wav');
      // Start recording to file
      await record.start(
          const RecordConfig(
            encoder: AudioEncoder.wav,
            bitRate: 128000,
            sampleRate: 44100,
          ),
          path: path);
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
  }

  @override
  void initState() {
    super.initState();

    if (widget.orderType == OrderScreenType.normal) {
      ref.read(orderReviewProvider.notifier).getAllItems();
    }
  }

  @override
  Widget build(BuildContext context) {
    final userId = ref.watch(userProvider).userModel!.user!.id;
    final deliveryPickupReceipt = ref.watch(deliverPickupProvider).image;
    final items = ref.watch(orderReviewProvider).items;
    final selectedService = ref.watch(serviceProvider).selectedService;
    final selectedLaundry = ref.watch(laundriessProvider).selectedLaundry;
    final selectedAddress = ref.watch(selectedAddressProvider);
    final selectedCategory = ref.watch(laundryItemProver).selectedCategory;
    final serviceTiming = ref.watch(laundriessProvider).serviceTiming;
    final selectedLaundryByArea =
        ref.watch(laundriessProvider).selectedLaundryByArea;
    final selectedPaymentMethod =
        ref.watch(PaymentMethodProvider).selectedPaymentMethod;
    final isLoading = ref.watch(orderReviewProvider).isLoading;

    final deliveryTypes = ref.watch(orderReviewProvider).deliveryTypes;
    final selecteddeliveryType =
        ref.watch(orderReviewProvider).selecteddeliveryType;
    final count = ref.watch(laundryItemProver).count;
    final total = ref.watch(laundryItemProver).total;
    final isBlanketSelected =
        ref.watch(deliverPickupProvider).isBlanketSelected;
    final isCarpetSelected = ref.watch(deliverPickupProvider).isCarpetSelected;
    final additionalDeliveryFee =
        ref.watch(deliverPickupProvider).additionalDeliveryFee;
    final additionalOperationFee =
        ref.watch(deliverPickupProvider).additionalOperationFee;

    return Scaffold(
      appBar: MyAppBar(title: 'Review Order'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: LayoutBuilder(builder: (context, cx) {
          return widget.orderType == OrderScreenType.delivery_pickup
              ? SingleChildScrollView(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
                                    8.ph,
                                    Container(
                                      color: ColorManager.silverWhite,
                                      height: 200,
                                      width: MediaQuery.of(context).size.width,
                                      child: Image.file(
                                          height: 100,
                                          File(
                                            deliveryPickupReceipt!.path
                                                .toString(),
                                          )),
                                    ),
                                    8.ph,
                                    _recording(),
                                    8.ph,
                                    if (isCarpetSelected == true ||
                                        isBlanketSelected == true)
                                      PaymentSummaryText(
                                          text1: 'Additional Fee',
                                          text2:
                                              '${additionalOperationFee + additionalDeliveryFee}'),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                Utils.showReusableDialog(
                                                    context: context,
                                                    title: 'Note',
                                                    description:
                                                        '''Your delivery fee will increase if the number of items exceeds 7. If the items are clothes, an additional 1 SAR will be added to the delivery fee for each item. In the case of carpets and blankets, if the number exceeds 2, an extra 2 SAR will be added to the delivery fee for each type of carpet or blanket. ''',
                                                    buttons: [
                                                      OutlinedButton(
                                                          onPressed: () {
                                                            context.pop();
                                                          },
                                                          child: Text('Okay'))
                                                    ]);
                                              },
                                              child: Row(
                                                children: [
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text('Delivery Fee',
                                                          style: getRegularStyle(
                                                              fontSize: 14,
                                                              color: Color(
                                                                  0xFF818181))),
                                                      10.pw,
                                                      Text(
                                                        'Will be Change',
                                                        style: getMediumStyle(
                                                            color: ColorManager
                                                                .blackColor),
                                                      ),
                                                    ],
                                                  ),
                                                  4.pw,
                                                  IconButton(
                                                    splashRadius: 20,
                                                    onPressed: null,
                                                    icon: Icon(
                                                      Icons.info,
                                                      color: ColorManager.amber,
                                                    ),
                                                    iconSize: 20,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Text(
                                              "${getTotal(deliveryFee: selectedService!.deliveryFee!, operationFee: selectedService.operationFee!).toStringAsFixed(2)} SAR",
                                              style: getMediumStyle(
                                                color: Color(0xFF242424),
                                                fontSize: 14,
                                              ),
                                            ),
                                          ],
                                        ),
                                        5.ph,
                                        Divider(
                                          color: Color(0xFF818181),
                                        ),
                                      ],
                                    ),
                                    PaymentSummaryText(
                                        text1: 'Vat ',
                                        text2:
                                            "${getVat(deliveryFee: selectedService.deliveryFee!, operationFee: selectedService.operationFee!).toStringAsFixed(2)}"),
                                    PaymentSummaryText(
                                      text1style: getSemiBoldStyle(
                                          fontSize: 14,
                                          color: ColorManager.blackColor),
                                      text1: 'Delivery cost Including VAT ',
                                      text2: getTotalIncludedVat(
                                              deliveryFee:
                                                  selectedService.deliveryFee!,
                                              operationFee:
                                                  selectedService.operationFee!)
                                          .toStringAsFixed(2),
                                    )
                                  ]),
                            ),
                          ),
                        ),
                        Card(
                          elevation: 0,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                5.ph,
                                const Heading(title: "Payment Method"),
                                5.ph,
                                InkWell(
                                  onTap: () {
                                    showModalBottomSheet<void>(
                                      isDismissible: false,
                                      context: context,
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(8),
                                              topRight: Radius.circular(8))),
                                      builder: (BuildContext context) {
                                        return Consumer(
                                            builder: (context, reff, child) {
                                          final paymentMethods = reff
                                              .read(PaymentMethodProvider)
                                              .paymentMethods;
                                          final selectedPaymentMethod = reff
                                              .watch(PaymentMethodProvider)
                                              .selectedPaymentMethod;
                                          return Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: <Widget>[
                                                10.ph,
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    HeadingMedium(
                                                        title:
                                                            'Choose payment method'),
                                                    IconButton(
                                                        onPressed: () {
                                                          context.pop();
                                                        },
                                                        icon: Icon(
                                                          Icons.close,
                                                          color: ColorManager
                                                              .greyColor,
                                                        ))
                                                  ],
                                                ),
                                                Expanded(
                                                  child: ListView.separated(
                                                    separatorBuilder:
                                                        ((context, index) =>
                                                            18.ph),
                                                    itemCount:
                                                        paymentMethods.length,
                                                    shrinkWrap: true,
                                                    itemBuilder:
                                                        (BuildContext context,
                                                            int index) {
                                                      print(
                                                          "Selected ${selectedPaymentMethod.name}");
                                                      print(
                                                          "List ${paymentMethods[index].name}");
                                                      return Container(
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        6),
                                                            border: Border.all(
                                                                color: ColorManager
                                                                    .primaryColor)),
                                                        child: ListTile(
                                                          onTap: () {
                                                            reff
                                                                .read(PaymentMethodProvider
                                                                    .notifier)
                                                                .selectIndex(
                                                                    selectedPaymentMethod:
                                                                        paymentMethods[
                                                                            index]);
                                                          },
                                                          trailing: Image.asset(
                                                            paymentMethods[
                                                                    index]
                                                                .icon
                                                                .toString(),
                                                            height: 20,
                                                          ),
                                                          leading: Wrap(
                                                              children: [
                                                                (selectedPaymentMethod
                                                                            .name ==
                                                                        paymentMethods[index]
                                                                            .name)
                                                                    ? Icon(
                                                                        Icons
                                                                            .check_circle_rounded,
                                                                        color: ColorManager
                                                                            .primaryColor,
                                                                      )
                                                                    : const Icon(
                                                                        Icons
                                                                            .circle_outlined),
                                                                10.pw,
                                                                Heading(
                                                                    title: paymentMethods[
                                                                            index]
                                                                        .name
                                                                        .toString())
                                                              ]),
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ),
                                                5.ph,
                                                MyButton(
                                                  isBorderButton: true,
                                                  widget: Center(
                                                      child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      const Icon(Icons
                                                          .add_circle_outline),
                                                      5.pw,
                                                      Text(
                                                        'Add New Debit/Credit',
                                                        style: getSemiBoldStyle(
                                                          color: ColorManager
                                                              .primaryColor,
                                                          fontSize: 16,
                                                        ),
                                                      ),
                                                    ],
                                                  )),
                                                  title: '',
                                                  onPressed: () {
                                                    context.pushNamed(
                                                        RouteNames.addNewCard);
                                                  },
                                                ),
                                                10.ph,
                                                MyButton(
                                                  title: 'Select Method',
                                                  onPressed: () {
                                                    context.pop();
                                                  },
                                                ),
                                                20.ph
                                              ],
                                            ),
                                          );
                                        });
                                      },
                                    );
                                  },
                                  child: Row(
                                    children: [
                                      Row(
                                        children: [
                                          Image.asset(
                                            selectedPaymentMethod.icon,
                                            width: 50,
                                            height: 20,
                                          ),
                                          10.pw,
                                          HeadingMedium(
                                              title: selectedPaymentMethod.name)
                                        ],
                                      ),
                                      const Spacer(),
                                      Heading(
                                        color: ColorManager.primaryColor,
                                        title: 'Change',
                                      )
                                    ],
                                  ),
                                ),
                                10.ph,
                              ],
                            ),
                          ),
                        ),
                        5.ph,
                        isLoading
                            ? Loader()
                            : MyButton(
                                title: 'Order',
                                onPressed: () async {
                                  Map files = {
                                    'pickup_invoice':
                                        deliveryPickupReceipt.path,
                                  };

                                  if (audioFile != null) {
                                    files.addAll({
                                      'recording': audioFile!.path,
                                    });
                                  }
                                  var total = selectedService.deliveryFee! +
                                      selectedService.operationFee!;

                                  Map data = {
                                    "user_id": userId,
                                    "service_id": selectedService.id,
                                    "shop_address":
                                        selectedLaundry!.destinationAddresses,
                                    "customer_address":
                                        selectedLaundry.originAddresses,
                                    "payment_method":
                                        selectedPaymentMethod.name,
                                    "item_total_price": 0,
                                    "total_items": 0,
                                    "total_price": total,
                                    "delivery_fee": selectedService.deliveryFee,
                                    "operation_fee":
                                        selectedService.operationFee,
                                    "country": selectedAddress!.country,
                                    "city": selectedAddress.city,
                                    "area": selectedAddress.district,
                                    "branch_lat": selectedLaundry.lat,
                                    "branch_lng": selectedLaundry.lng,
                                    "branch_name": selectedLaundry.name,
                                    "customer_lat": selectedAddress.lat!,
                                    "customer_lng": selectedAddress.lng!,
                                    "additional_operation_fee":
                                        additionalOperationFee,
                                    "additional_delivery_fee":
                                        additionalDeliveryFee,
                                  };
                                  ref
                                      .read(orderReviewProvider.notifier)
                                      .pickupOrder(
                                          context: context,
                                          data: data,
                                          files: files,
                                          ref: ref);
                                },
                              ),
                        20.ph
                      ]),
                )
              : SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Delivery Type",
                        style: getSemiBoldStyle(
                            color: ColorManager.blackColor,
                            fontSize: FontSize.s16),
                      ),
                      20.ph,
                      GridView.builder(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 15.0,
                                mainAxisExtent: 148),
                        itemCount: deliveryTypes.length,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: () {
                              ref
                                  .read(orderReviewProvider.notifier)
                                  .selectDeliveryType(
                                      deliveryTypeModel: deliveryTypes[index]);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 0.1,
                                ),
                                borderRadius: BorderRadius.circular(12),
                                color:
                                    selecteddeliveryType == deliveryTypes[index]
                                        ? ColorManager.nprimaryColor
                                        : ColorManager.whiteColor,
                              ),
                              child: Column(
                                children: [
                                  26.ph,
                                  Image.asset(
                                    deliveryTypes[index].image,
                                    height: 34,
                                    color: selecteddeliveryType ==
                                            deliveryTypes[index]
                                        ? ColorManager.whiteColor
                                        : ColorManager.blackColor,
                                  ),
                                  12.12.ph,
                                  Text(
                                    deliveryTypes[index].title,
                                    style: getMediumStyle(
                                        color: selecteddeliveryType ==
                                                deliveryTypes[index]
                                            ? ColorManager.whiteColor
                                            : ColorManager.blackColor,
                                        fontSize: 16),
                                    textAlign: TextAlign.center,
                                  ),
                                  5.ph,
                                  Text(
                                    deliveryTypes[index].description,
                                    style: getRegularStyle(
                                        color: selecteddeliveryType ==
                                                deliveryTypes[index]
                                            ? ColorManager.whiteColor
                                            : ColorManager.blackColor,
                                        fontSize: 14),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                      30.ph,
                      ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: items.length,
                        itemBuilder: (BuildContext context, int index) {
                          ItemVariation item = items[index];
                          return Container(
                            decoration:
                                BoxDecoration(color: ColorManager.whiteColor),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Column(
                                children: [
                                  10.ph,
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "${item.name.toString()}(X${item.quantity})",
                                        style: getMediumStyle(
                                            color: ColorManager.blackColor,
                                            fontSize: 14),
                                      ),
                                      Text(
                                        "${(item.price! * item.quantity!).toStringAsFixed(2)} SAR",
                                        style: getMediumStyle(
                                            color: ColorManager.blackColor,
                                            fontSize: 14),
                                      )
                                    ],
                                  ),
                                  10.ph
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                      10.ph,
                      _recording(),
                      10.ph,
                      Card(
                        elevation: 0,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              5.ph,
                              const Heading(title: "Payment Method"),
                              5.ph,
                              InkWell(
                                onTap: () {
                                  showModalBottomSheet<void>(
                                    isDismissible: false,
                                    context: context,
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(8),
                                            topRight: Radius.circular(8))),
                                    builder: (BuildContext context) {
                                      return Consumer(
                                          builder: (context, reff, child) {
                                        final paymentMethods = reff
                                            .read(PaymentMethodProvider)
                                            .paymentMethods;
                                        final selectedPaymentMethod = reff
                                            .watch(PaymentMethodProvider)
                                            .selectedPaymentMethod;
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              10.ph,
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  HeadingMedium(
                                                      title:
                                                          'Choose payment method'),
                                                  IconButton(
                                                      onPressed: () {
                                                        context.pop();
                                                      },
                                                      icon: Icon(
                                                        Icons.close,
                                                        color: ColorManager
                                                            .greyColor,
                                                      ))
                                                ],
                                              ),
                                              Expanded(
                                                child: ListView.separated(
                                                  separatorBuilder:
                                                      ((context, index) =>
                                                          18.ph),
                                                  itemCount:
                                                      paymentMethods.length,
                                                  shrinkWrap: true,
                                                  itemBuilder:
                                                      (BuildContext context,
                                                          int index) {
                                                    print(
                                                        "Selected ${selectedPaymentMethod.name}");
                                                    print(
                                                        "List ${paymentMethods[index].name}");
                                                    return Container(
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(6),
                                                          border: Border.all(
                                                              color: ColorManager
                                                                  .primaryColor)),
                                                      child: ListTile(
                                                        onTap: () {
                                                          reff
                                                              .read(
                                                                  PaymentMethodProvider
                                                                      .notifier)
                                                              .selectIndex(
                                                                  selectedPaymentMethod:
                                                                      paymentMethods[
                                                                          index]);
                                                        },
                                                        trailing: Image.asset(
                                                          paymentMethods[index]
                                                              .icon
                                                              .toString(),
                                                          height: 20,
                                                        ),
                                                        leading:
                                                            Wrap(children: [
                                                          (selectedPaymentMethod
                                                                      .name ==
                                                                  paymentMethods[
                                                                          index]
                                                                      .name)
                                                              ? Icon(
                                                                  Icons
                                                                      .check_circle_rounded,
                                                                  color: ColorManager
                                                                      .primaryColor,
                                                                )
                                                              : const Icon(Icons
                                                                  .circle_outlined),
                                                          10.pw,
                                                          Heading(
                                                              title:
                                                                  paymentMethods[
                                                                          index]
                                                                      .name
                                                                      .toString())
                                                        ]),
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ),
                                              5.ph,
                                              MyButton(
                                                isBorderButton: true,
                                                widget: Center(
                                                    child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    const Icon(Icons
                                                        .add_circle_outline),
                                                    5.pw,
                                                    Text(
                                                      'Add New Debit/Credit',
                                                      style: getSemiBoldStyle(
                                                        color: ColorManager
                                                            .primaryColor,
                                                        fontSize: 16,
                                                      ),
                                                    ),
                                                  ],
                                                )),
                                                title: '',
                                                onPressed: () {
                                                  context.pushNamed(
                                                      RouteNames.addNewCard);
                                                },
                                              ),
                                              10.ph,
                                              MyButton(
                                                title: 'Select Method',
                                                onPressed: () {
                                                  context.pop();
                                                },
                                              ),
                                              20.ph
                                            ],
                                          ),
                                        );
                                      });
                                    },
                                  );
                                },
                                child: Row(
                                  children: [
                                    Row(
                                      children: [
                                        Image.asset(
                                          selectedPaymentMethod.icon,
                                          width: 50,
                                          height: 20,
                                        ),
                                        10.pw,
                                        HeadingMedium(
                                            title: selectedPaymentMethod.name)
                                      ],
                                    ),
                                    const Spacer(),
                                    Heading(
                                      color: ColorManager.primaryColor,
                                      title: 'Change',
                                    )
                                  ],
                                ),
                              ),
                              10.ph,
                            ],
                          ),
                        ),
                      ),
                      10.ph,
                      isLoading == true
                          ? Loader()
                          : MyButton(
                              title: 'Order',
                              onPressed: () async {
                                if (selecteddeliveryType == null) {
                                  BotToast.showNotification(
                                      leading: (leading) => Icon(
                                            Icons.info,
                                            color: ColorManager.whiteColor,
                                          ),
                                      backgroundColor: ColorManager.redColor,
                                      title: (t) => Text(
                                            'Select Delivery Type',
                                            style: getRegularStyle(
                                                color: ColorManager.whiteColor),
                                          ));
                                } else {
                                  Map data = {};

                                  if (selectedService!.serviceName!
                                          .toLowerCase() ==
                                      ServiceTypes.carpets.name) {
                                    data = {
                                      "user_id": userId,
                                      "service_id": selectedService.id,
                                      "shop_address": selectedLaundry!
                                          .destinationAddresses!,
                                      "customer_address":
                                          selectedAddress!.googleMapAddress,
                                      "payment_method":
                                          selectedPaymentMethod.name,
                                      "item_total_price": total,
                                      "total_items": count,
                                      "delivery_fee":
                                          selectedService.deliveryFee,
                                      "operation_fee":
                                          selectedService.operationFee,
                                      "country": selectedAddress.country,
                                      "city": selectedAddress.city,
                                      "area": selectedAddress.district,
                                      "branch_lat": selectedLaundry.lat,
                                      "branch_lng": selectedLaundry.lng,
                                      "branch_name": selectedLaundry.name,
                                      "customer_lat": selectedAddress.lat!,
                                      "customer_lng": selectedAddress.lng!,
                                      "category_id": selectedCategory!.id!,
                                      "service_timing_id": serviceTiming!.id!,
                                      'total_price': 0,
                                      "delivery_type":
                                          selecteddeliveryType.deliveryType,
                                    
                                      "items": items
                                          .map((e) => {
                                                "item_variation_id": e.id,
                                                "price": e.price,
                                                "quantity": e.quantity
                                              })
                                          .toList(),
                                          
                                    };
                                  } else {
                                    data = {
                                      "user_id": userId,
                                      "service_id": selectedService.id,
                                      "shop_address":
                                          selectedLaundryByArea.branch!.address,
                                      "customer_address":
                                          selectedAddress!.googleMapAddress,
                                      "payment_method":
                                          selectedPaymentMethod.name,
                                      "item_total_price": total,
                                      "total_items": count,
                                      "delivery_fee":
                                          selectedService.deliveryFee,
                                      "operation_fee":
                                          selectedService.operationFee,
                                      "country": selectedAddress.country,
                                      "city": selectedAddress.city,
                                      "area": selectedAddress.district,
                                      "branch_lat":
                                          selectedLaundryByArea.branch!.lat,
                                      "branch_lng":
                                          selectedLaundryByArea.branch!.lng,
                                      "branch_name": selectedLaundryByArea.name,
                                      "customer_lat": selectedAddress.lat!,
                                      "customer_lng": selectedAddress.lng!,
                                      "category_id": selectedCategory!.id!,
                                      "service_timing_id": serviceTiming!.id!,
                                      'branch_id': selectedLaundryByArea.id,
                                      'total_price': 0,
                                      "delivery_type":
                                          selecteddeliveryType.deliveryType,
                                      "items": items
                                          .map((e) => {
                                                "item_variation_id": e.id,
                                                "price": e.price,
                                                "quantity": e.quantity
                                              })
                                          .toList(),
                                    };
                                  }

                                  ref
                                      .read(orderReviewProvider.notifier)
                                      .roundTripOrder(
                                          context: context,
                                          data: data,
                                          ref: ref);
                                }
                              })
                    ],
                  ),
                );
        }),
      ),
    );
  }

  Card _recording() {
    return Card(
      color: ColorManager.silverWhite,
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
                            icon:
                                Icon(Icons.mic, color: ColorManager.blueColor)),
                        5.pw,
                        Text(
                          'Record your Order instructions.',
                          style:
                              getSemiBoldStyle(color: ColorManager.blackColor),
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
                          style:
                              getSemiBoldStyle(color: ColorManager.blackColor),
                        )
                      ],
                    )
            ],
          ),
          audioFile?.path != null
              ? Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  10.ph,
                  VoiceMessageView(
                    backgroundColor: ColorManager.whiteColor,
                    activeSliderColor: ColorManager.primaryColor,
                    circlesColor: ColorManager.primaryColor,
                    controller: voiceController = VoiceController(
                        audioSrc: audioFile!.path.toString(),
                        maxDuration: const Duration(seconds: 90),
                        isFile: true,
                        onComplete: () {},
                        onPause: () {},
                        onPlaying: () {}),
                    innerPadding: 12,
                    cornerRadius: 20,
                    size: 38,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: AppPadding.p10),
                    child: OutlinedButton(
                        style: ButtonStyle(
                            overlayColor: WidgetStateColor.resolveWith(
                                (states) =>
                                    ColorManager.redColor.withOpacity(0.1)),
                            textStyle: WidgetStateProperty.resolveWith(
                              (states) => getSemiBoldStyle(
                                  color: ColorManager.blackColor),
                            ),
                            side: WidgetStateBorderSide.resolveWith((states) =>
                                BorderSide(color: ColorManager.redColor))),
                        onPressed: () {
                          audioFile = null;
                          stopRecording();
                          voiceController.dispose();
                          setState(() {});
                        },
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.delete,
                                color: ColorManager.redColor,
                              ),
                              Text(
                                'Delete',
                                style: getSemiBoldStyle(
                                    color: ColorManager.blackColor),
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
    );
  }
}

