import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:laundryday/config/resources/font_manager.dart';
import 'package:laundryday/config/theme/styles_manager.dart';
import 'package:laundryday/provider/user_notifier.dart';
import 'package:laundryday/screens/auth/signup/signup.dart';
import 'package:laundryday/screens/delivery_pickup/view/delivery_pickup.dart';
import 'package:laundryday/screens/laundries/provider/laundries_notifier.dart';
import 'package:laundryday/screens/laundry_items/model/item_variation_model.dart';
import 'package:laundryday/screens/order_review/presentaion/riverpod/order_review_notifier.dart';
import 'package:laundryday/config/resources/colors.dart';
import 'package:laundryday/config/resources/sized_box.dart';
import 'package:laundryday/config/resources/value_manager.dart';
import 'package:laundryday/config/routes/route_names.dart';
import 'package:laundryday/core/widgets/my_app_bar.dart';
import 'package:laundryday/core/widgets/my_button.dart';
import 'package:laundryday/core/widgets/heading.dart';
import 'package:laundryday/core/widgets/payment_summary_widget.dart';
import 'package:laundryday/screens/order_review/presentaion/riverpod/payment_method_nofifier.dart';
import 'package:laundryday/screens/services/provider/addresses_notifier.dart';
import 'package:laundryday/screens/services/provider/services_notifier.dart';
import 'package:moyasar/moyasar.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';
import 'package:voice_message_package/voice_message_package.dart';

class OrderReview extends ConsumerStatefulWidget {
  final OrderType orderType;

  OrderReview({
    required this.orderType,
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

    if (widget.orderType == OrderType.normal) {
      ref.read(orderReviewProvider.notifier).getAllItems();
    }
  }

  @override
  Widget build(BuildContext context) {
    final cutomerId = ref.watch(userProvider).userModel!.user!.id;
    final deliveryPickupReceipt = ref.watch(deliverPickupProvider).image;
    final items = ref.watch(orderReviewProvider).items;
    final selectedService = ref.watch(serviceProvider).selectedService;
    final selectedLaundry = ref.watch(laundriessProvider).selectedLaundry;
    final selectedAddress = ref.watch(selectedAddressProvider);
    final selectedPaymentMethod =
        ref.watch(PaymentMethodProvider).selectedPaymentMethod;

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
                                                        RouteNames()
                                                            .addNewCard);
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
                        PaymentSummaryWidget(
                          service: selectedService,
                        ),
                        10.ph,
                        // PaymentMethods(),
                        MyButton(
                          title: 'Order',
                          onPressed: () async {
                            Map files = {
                              'pickup_invoice': deliveryPickupReceipt.path,
                            };

                            if (audioFile != null) {
                              files.addAll({
                                'recording': audioFile!.path,
                              });
                            }

                            var total = selectedService!.deliveryFee! +
                                selectedService.operationFee!;

                            Map data = {
                              "customer_id": cutomerId,
                              "service_id": selectedService.id,
                              "pickup_from":
                                  selectedLaundry!.destinationAddresses,
                              "delivered_to": selectedLaundry.originAddresses,
                              "payment_method": selectedPaymentMethod.name,
                              "item_total_price": 0,
                              "total_items": 0,
                              "total_price": total,
                              "delivery_fee": selectedService.deliveryFee,
                              "operation_fee": selectedService.operationFee,
                              "start_time": "2024-07-31 04:34:56",
                              "end_time": "2024-07-31 04:34:56",
                              "country": "Saudia Arabia",
                              "city": "Riyadh",
                              "area": selectedAddress!.district,
                              "branch_lat": selectedLaundry.lat,
                              "branch_lng": selectedLaundry.lng,
                              "branch_name": selectedLaundry.name,
                              "customer_lat": selectedAddress.lat!,
                              "customer_lng": selectedAddress.lng!
                            };
                            ref.read(orderReviewProvider.notifier).pickupOrder(
                                context: context,
                                data: data,
                                files: files,
                                ref: ref);
                          },
                        )
                      ]),
                )
              : SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                      // const PaymentMethodWidget(),
                      10.ph,
                      PaymentSummaryWidget(
                        service: selectedService,
                      ),
                      10.ph,
                      MyButton(
                        title: 'Order',
                        onPressed: () async {
                          context.pushNamed(RouteNames().orderProcess);
                        },
                      )
                    ],
                  ),
                );
        }),
      ),
    );
  }

  Card _recording() {
    return Card(
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

class PaymentMethods extends StatelessWidget {
  PaymentMethods({super.key});

  final paymentConfig = PaymentConfig(
    publishableApiKey: 'pk_test_zUoi76uHXmEvwcBNCqWMtdENCtTZeUZKRQM39qBT',
    amount: 1200, // SAR 257.58
    description: 'order #1324',
    metadata: {'size': '250g'},
    applePay: ApplePayConfig(
        merchantId: 'YOUR_MERCHANT_ID', label: 'YOUR_STORE_NAME', manual: true),

    creditCard: CreditCardConfig(saveCard: true, manual: false),
  );

  void onPaymentResult(result) {
    if (result is PaymentResponse) {
      switch (result.status) {
        case PaymentStatus.paid:
          // handle success.
          debugPrint(result.toString());

          debugPrint(result.status.toString());
          break;
        case PaymentStatus.failed:
          break;
        case PaymentStatus.initiated:
        // TODO: Handle this case.
        case PaymentStatus.authorized:
        // TODO: Handle this case.
        case PaymentStatus.captured:
        // TODO: Handle this case.
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ApplePay(
          config: paymentConfig,
          onPaymentResult: onPaymentResult,
        ),
        const Text("or"),
        CreditCard(
          config: paymentConfig,
          onPaymentResult: onPaymentResult,
        )
      ],
    );
  }
}
