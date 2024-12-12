import 'dart:developer';
import 'dart:io';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:laundryday/core/utils.dart';
import 'package:laundryday/helpers/date_helper.dart';
import 'package:laundryday/helpers/order_helper.dart';
import 'package:laundryday/constants/font_manager.dart';
import 'package:laundryday/config/theme/styles_manager.dart';
import 'package:laundryday/models/coupon_model.dart';
import 'package:laundryday/models/google_distance_matrix_model.dart' as d;
import 'package:laundryday/models/order_summary_model.dart';
import 'package:laundryday/screens/delivery_pickup/provider/delivery_pickup_notifier.dart';
import 'package:laundryday/screens/laundries/view/laundries.dart';
import 'package:laundryday/screens/order_review/presentaion/riverpod/coupon_notifier.dart';
import 'package:laundryday/screens/order_review/presentaion/riverpod/order_summary_notifer.dart';
import 'package:laundryday/shared/app_state.dart';
import 'package:laundryday/shared/provider/distance_details_notifier.dart';
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
import 'package:laundryday/config/routes/route_names.dart';
import 'package:laundryday/widgets/my_app_bar.dart';
import 'package:laundryday/widgets/my_button.dart';
import 'package:laundryday/widgets/heading.dart';
import 'package:laundryday/screens/order_review/presentaion/riverpod/payment_method_nofifier.dart';
import 'package:laundryday/screens/services/provider/addresses_notifier.dart';
import 'package:laundryday/screens/services/provider/services_notifier.dart';

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
  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: 0), () async {
      final userId = ref.watch(userProvider).userModel!.user!.id;
      final distanceData = ref.read(distanceDetailProvider);
      final selectedLaundryByArea =
          ref.watch(laundriessProvider).selectedLaundryByArea;
      final selectedAddress = ref.watch(selectedAddressProvider);

      if (widget.orderType == OrderScreenType.normal) {
        d.DistanceMatrixResponse? distanceMatrixResponse = await ref
            .read(orderReviewProvider.notifier)
            .fetchDistanceMatrix(
                distanceDataModel: DistanceDataModel(
                    branchLat: selectedLaundryByArea.branch!.lat,
                    branchLng: selectedLaundryByArea.branch!.lng,
                    userLat: selectedAddress!.lat!,
                    userLng: selectedAddress.lng!),
                ref: ref,
                context: context);

        if (distanceMatrixResponse != null) {
          ref.invalidate(distanceDetailProvider);

          ref.read(distanceDetailProvider.notifier).state =
              distanceMatrixResponse;
        }

        ref.read(orderReviewProvider.notifier).getAllItems();
      } else {
        Future.wait([
          ref.read(orderSummaryProvider.notifier).calulate(ref: ref, data: {
            "order_type": 'pickup_only_from_store',
            "user_id": userId,
            "distance": distanceData!.distanceInMeter,
          }),
          ref.read(couponProvider.notifier).validAllcoupons(ref: ref, data: {
            "user_id": userId,
            "eligible_for": "pickup_only_from_store"
          })
        ]);
      }
    });
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
    final orderSummary = ref.watch(orderSummaryProvider);
    final coupons = ref.watch(couponProvider);
    final distanceData = ref.read(distanceDetailProvider);

    // ref.listen<CouponStates>(couponProvider, (previous, next) {
    //   if (next.appState is AppErrorState) {
    //     showDialog(
    //       context: context,
    //       builder: (context) => AlertDialog(
    //         title: Text("Error"),
    //         content: Text((next.appState as AppErrorState).error.toString()),
    //         actions: [
    //           TextButton(
    //             onPressed: () => Navigator.of(context).pop(),
    //             child: Text("OK"),
    //           ),
    //         ],
    //       ),
    //     );
    //   }
    // });

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
                                    const Heading(
                                      title: 'Order Details',
                                    ),
                                    15.ph,
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
                                    15.ph,
                                    if (coupons.appState
                                        is AppInitialState) ...[
                                      Loader()
                                    ] else if (coupons.appState
                                        is AppLoadingState) ...[
                                      Loader()
                                    ] else if (coupons.appState
                                        is AppLoadedState) ...[
                                      BuildCouponList(
                                          items: items,
                                          orderType: 'pickup_only_from_store',
                                          couponModel: ((coupons.appState
                                                  as AppLoadedState)
                                              .data) as CouponModel)
                                    ] else if (coupons.appState
                                        is AppErrorState) ...[
                                      Text((coupons.appState as AppErrorState)
                                          .error
                                          .toString())
                                    ],
                                    15.ph,
                                    if (orderSummary.appState
                                        is AppInitialState) ...[
                                      Loader()
                                    ] else if (orderSummary.appState
                                        is AppLoadingState) ...[
                                      Loader()
                                    ] else if (orderSummary.appState
                                        is AppLoadedState) ...[
                                      OrderSummaryWidget(
                                          orderSummaryModel: (orderSummary
                                                  .appState as AppLoadedState)
                                              .data as OrderSummaryModel)
                                    ] else if (orderSummary.appState
                                        is AppErrorState) ...[
                                      Text((orderSummary.appState
                                              as AppErrorState)
                                          .error
                                          .toString())
                                    ],
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

                                  var total = selectedService!.deliveryFee! +
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
                            onTap: () async {
                              BotToast.showLoading();
                              print(distanceData!.distanceInMeter.toString());

                              ref
                                  .read(orderReviewProvider.notifier)
                                  .selectDeliveryType(
                                      deliveryTypeModel: deliveryTypes[index]);

                              log(deliveryTypes[index].deliveryType);

                              Future.wait([
                                ref
                                    .read(orderSummaryProvider.notifier)
                                    .calulate(ref: ref, data: {
                                  "order_type":
                                      deliveryTypes[index].deliveryType,
                                  "user_id": userId,
                                  "distance": distanceData.distanceInMeter,
                                  "items": items
                                      .map((e) => {
                                            "item_variation_id": e.id,
                                            "price": e.price,
                                            "quantity": e.quantity
                                          })
                                      .toList(),
                                }),
                                ref
                                    .read(couponProvider.notifier)
                                    .validAllcoupons(ref: ref, data: {
                                  "user_id": userId,
                                  "eligible_for":
                                      deliveryTypes[index].deliveryType
                                })
                              ]).then((v) {
                                Future.delayed(Duration(milliseconds: 600), () {
                                  BotToast.closeAllLoading();
                                }).onError((e, s) {
                                  Utils.showToast(msg: e.toString());

                                  BotToast.closeAllLoading();
                                });
                              });
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
                      if (coupons.appState is AppInitialState) ...[
                        SizedBox()
                      ] else if (coupons.appState is AppLoadingState) ...[
                        Loader()
                      ] else if (coupons.appState is AppLoadedState) ...[
                        BuildCouponList(
                            items: items,
                            orderType: selecteddeliveryType!.deliveryType,
                            couponModel: ((coupons.appState as AppLoadedState)
                                .data) as CouponModel)
                      ] else if (coupons.appState is AppErrorState) ...[
                        Text((coupons.appState as AppErrorState)
                            .error
                            .toString())
                      ],
                      15.ph,
                      if (orderSummary.appState is AppInitialState) ...[
                        SizedBox()
                      ] else if (orderSummary.appState is AppLoadingState) ...[
                        Loader()
                      ] else if (orderSummary.appState is AppLoadedState) ...[
                        OrderSummaryWidget(
                            orderSummaryModel:
                                (orderSummary.appState as AppLoadedState).data
                                    as OrderSummaryModel)
                      ] else if (orderSummary.appState is AppErrorState) ...[
                        Text((orderSummary.appState as AppErrorState)
                            .error
                            .toString())
                      ],
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
}

class OrderSummaryWidget extends StatelessWidget {
  final OrderSummaryModel orderSummaryModel;

  const OrderSummaryWidget({super.key, required this.orderSummaryModel});

  @override
  Widget build(BuildContext context) {
    Data? orderSummary = orderSummaryModel.data;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        PaymentSummaryText(
            text1: 'Delivery Fees',
            text2: orderSummary!.deliveryFees.toString()),
        PaymentSummaryText(text1: 'Vat', text2: orderSummary.vat.toString()),
        PaymentSummaryText(
            text1: 'Delivery Fees Inc Tax',
            text2: orderSummary.deliveryFeesIncTax.toString()),
        if (orderSummary.discount != null) ...[
          if (orderSummary.discount! > 0)
            PaymentSummaryText(
                text1: 'Discount', text2: orderSummary.discount.toString()),
        ],
        if (orderSummary.totalItems != null) ...[
          if (orderSummary.totalItems! > 0)
            PaymentSummaryText(
                text2PostFix: null,
                text1: 'Total Items',
                text2: orderSummary.totalItems.toString()),
        ],
      ]),
    );
  }
}

class SmallCouponCard extends StatelessWidget {
  final String title;
  final String couponCode;
  final bool selectedCouponCode;

  const SmallCouponCard({
    Key? key,
    required this.title,
    required this.selectedCouponCode,
    required this.couponCode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
          color: ColorManager.lightGrey,
          borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: getMediumStyle(color: ColorManager.redColor, fontSize: 10),
            ),
            Text(
              'Code: $couponCode',
              style:
                  getMediumStyle(color: ColorManager.greyColor, fontSize: 12),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Container(
                child: selectedCouponCode
                    ? Text(
                        'Applied',
                        style:
                            getSemiBoldStyle(color: ColorManager.nprimaryColor),
                      )
                    : Text(
                        'Apply',
                        style: getSemiBoldStyle(color: ColorManager.blackColor),
                      )),
          ],
        ),
      ),
    );
  }
}

class BuildCouponList extends ConsumerWidget {
  final CouponModel couponModel;
  final String orderType;
  final List<ItemVariation> items;

  const BuildCouponList(
      {super.key,
      required this.couponModel,
      required this.orderType,
      required this.items});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userId = ref.watch(userProvider).userModel!.user!.id;
    final distanceData = ref.read(distanceDetailProvider);
    final selectedCoupon = ref.read(couponProvider).selectedCoupon;

    return SizedBox(
      height: 100,
      child: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        scrollDirection: Axis.horizontal,
        itemCount: couponModel.coupon!.length,
        itemBuilder: (BuildContext context, int index) {
          Coupon coupon = couponModel.coupon![index];
          return GestureDetector(
            onTap: () {
              if (selectedCoupon != couponModel.coupon![index]) {
                ref
                    .read(couponProvider.notifier)
                    .selectedCoupon(coupon: coupon);

                final data = {
                  "code": coupon.code,
                  "order_type": orderType,
                  "user_id": userId,
                  "distance": distanceData!.distanceInMeter,
                  "items": items
                      .map((e) => {
                            "item_variation_id": e.id,
                            "price": e.price,
                            "quantity": e.quantity
                          })
                      .toList(),
                };
                ref
                    .read(orderSummaryProvider.notifier)
                    .calulate(ref: ref, data: data);
              } else {
                ref.read(couponProvider).selectedCoupon = null;
                final data = {
                  "order_type": orderType,
                  "user_id": userId,
                  "distance": distanceData!.distanceInMeter,
                  "items": items
                      .map((e) => {
                            "item_variation_id": e.id,
                            "price": e.price,
                            "quantity": e.quantity
                          })
                      .toList(),
                };
                ref
                    .read(orderSummaryProvider.notifier)
                    .calulate(ref: ref, data: data);
              }
            },
            child: SmallCouponCard(
                selectedCouponCode: selectedCoupon == coupon,
                title:
                    "Expired in ${DateHelper.calculateTimeUntilExpiry(coupon.expiryDate!)}",
                couponCode: coupon.code.toString()),
          );
        },
      ),
    );
  }
}
