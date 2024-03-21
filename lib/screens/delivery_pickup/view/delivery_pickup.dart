import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:laundryday/Widgets/my_heading/heading.dart';
import 'package:laundryday/models/blankets_model.dart';
import 'package:laundryday/models/laundry_model.dart';
import 'package:laundryday/models/services_model.dart';
import 'package:laundryday/screens/auth/signup/signup.dart';
import 'package:laundryday/screens/delivery_pickup/provider/delivery_pickup_notifier.dart';
import 'package:laundryday/screens/delivery_pickup/provider/image_picker_notifier.dart';
import 'package:laundryday/screens/delivery_pickup/provider/delivery_pickup_item_notifier.dart';
import 'package:laundryday/screens/delivery_pickup/provider/selected_delivery_pickup_item_notifer.dart';
import 'package:laundryday/screens/delivery_pickup/provider/quantity_notifier.dart';
import 'package:laundryday/screens/delivery_pickup/services/delivery_pickup_services.dart';
import 'package:laundryday/screens/order_review/order_review.dart';
import 'package:laundryday/utils/colors.dart';
import 'package:laundryday/utils/routes/route_names.dart';
import 'package:laundryday/utils/sized_box.dart';
import 'package:laundryday/utils/value_manager.dart';
import 'package:laundryday/widgets/my_app_bar/my_app_bar.dart';
import 'package:laundryday/widgets/my_button/my_button.dart';
import 'package:laundryday/widgets/reusable_laundry_detail_card.dart';

enum BestTutorSite { outsidedoor, dooroftheapartment }

final imagePickerProvider =
    StateNotifierProvider.autoDispose<ImagePickerNotifier, XFile?>(
        (ref) => ImagePickerNotifier());

final deliveryPickupRepositoryProvider =
    Provider.autoDispose<DeliveryPickupRepository>((ref) {
  return DeliveryPickupRepository();
});

final _controllerListProvider = StateNotifierProvider.family
    .autoDispose<DeliveryPickupNotifier, List<LaundryItemModel?>, int>(
        (ref, serviceId) =>
            DeliveryPickupNotifier(ref: ref, serviceId: serviceId));

final deliveryPickupItemNotifierProvider = StateNotifierProvider.autoDispose<
    DeliveryPickupItemNotifier,
    LaundryItemModel?>((ref) => DeliveryPickupItemNotifier());

final quantityNotifier =
    StateNotifierProvider.autoDispose<QuantityNotifier, int>(
        (ref) => QuantityNotifier());

final selectedDeliveryPickupItemProvider = StateNotifierProvider.autoDispose<
    SelectedDeliveryPickupItemNotifer,
    List<LaundryItemModel>>((ref) => SelectedDeliveryPickupItemNotifer());

class DeliveryPickup extends ConsumerStatefulWidget {
  final Arguments? arguments;

  const DeliveryPickup({super.key, required this.arguments});

  @override
  ConsumerState<DeliveryPickup> createState() => _DeliveryPickupState();
}

class _DeliveryPickupState extends ConsumerState<DeliveryPickup> {
  final formkey = GlobalKey<FormState>();
  BestTutorSite site = BestTutorSite.outsidedoor;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: 'Delivery Pickup',
      ),
      body: LayoutBuilder(builder: (context, constraints) {
        return Form(
          key: formkey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppPadding.p20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: constraints.maxHeight * 0.9,
                  child: SingleChildScrollView(
                    child: Column(children: [
                      ReuseableLaundryDetailCard(
                          laundryModel: widget.arguments!.laundryModel!),
                      10.ph,
                      _addressDetails(),
                      20.ph,
                      _buildScanRecipt(context: context),
                      20.ph,
                      ItemDetailWidget(
                        servicesModel: widget.arguments!.laundryModel!.service!,
                      ),
                      10.ph,
                      _receiptMethod(),
                      _buildDeliveryFee(
                          services: widget.arguments!.laundryModel!.service)
                    ]),
                  ),
                ),
                SizedBox(
                  height: constraints.maxHeight * 0.1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MyButton(
                        name: 'Next',
                        onPressed: () {
                          if (ref.read(imagePickerProvider.notifier).state ==
                              null) {
                            Fluttertoast.showToast(
                                msg: 'Please select Receipt.');
                          } else {
                            context.pushNamed(RouteNames().orderReview,
                                extra: Arguments(
                                  laundryModel: widget.arguments!.laundryModel,
                                ));
                          }
                        },
                      ),
                      20.ph,
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _buildScanRecipt({required BuildContext context}) {
    final image = ref.watch(imagePickerProvider);

    return GestureDetector(
      onTap: () async {
        showDialogPhoto(context);
      },
      child: DottedBorder(
        strokeWidth: 2.0,
        dashPattern: const [6, 3],
        borderType: BorderType.RRect,
        radius: const Radius.circular(12),
        padding: const EdgeInsets.all(6),
        color: ColorManager.greyColor,
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          child: Container(
            decoration: BoxDecoration(
                color: ColorManager.whiteColor,
                borderRadius: BorderRadius.circular(8)),
            height: 180,
            width: double.infinity,
            child: Center(
                child: image == null
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.receipt_long,
                            size: 30,
                            color: ColorManager.primaryColor,
                          ),
                          10.ph,
                          const Heading(
                            text: 'Scan Recipt',
                          )
                        ],
                      )
                    : Image.file(File(image.path.toString()))),
          ),
        ),
      ),
    );
  }

  Widget _buildDeliveryFee({required ServicesModel? services}) {
    return SizedBox(
      height: 100,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppPadding.p10),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            HeadingMedium(title: "Delivery Fee"),
            HeadingMedium(title: services!.deliveryFee.toString())
          ]),
        ),
      ),
    );
  }

  showDialogPhoto(BuildContext context) {
    return showModalBottomSheet(
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12), topRight: Radius.circular(12))),
        context: context,
        builder: (context) {
          return SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                10.ph,
                const Text(
                  'Choose Photo',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                20.ph,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: ColorManager.primaryColor),
                      icon: const Icon(
                        Icons.camera,
                      ),
                      onPressed: () async {
                        await ref.read(imagePickerProvider.notifier).pickImage(
                            imageSource: ImageSource.camera,
                            context: context,
                            ref: ref);
                        // ignore: use_build_context_synchronously
                        context.pop();
                      },
                      label: const Text('Camera'),
                    ),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: ColorManager.primaryColor),
                      icon: const Icon(Icons.image),
                      onPressed: () async {
                        await ref.read(imagePickerProvider.notifier).pickImage(
                            imageSource: ImageSource.gallery,
                            context: context,
                            ref: ref);
                        // ignore: use_build_context_synchronously
                        context.pop();
                      },
                      label: const Text('Gallery'),
                    ),
                  ],
                ),
                30.ph
              ],
            ),
          );
        });
  }

  Widget _receiptMethod() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Heading(text: "Method of Recieving"),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(
                'Out Side Door',
                style: GoogleFonts.poppins(fontSize: 14),
              ),
              leading: Radio(
                value: BestTutorSite.outsidedoor,
                groupValue: site,
                onChanged: (BestTutorSite? value) {
                  setState(() {
                    site = value!;
                  });
                },
              ),
            ),
            Column(
              children: [
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(
                    'Door of the Apartment',
                    style: GoogleFonts.poppins(fontSize: 14),
                  ),
                  leading: Radio(
                    value: BestTutorSite.dooroftheapartment,
                    groupValue: site,
                    onChanged: (BestTutorSite? value) {
                      setState(() {
                        site = value!;
                      });
                    },
                  ),
                ),
                site.index == 1
                    ? Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.amber.withOpacity(0.1)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "+3 SAR/exx.",
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w500, fontSize: 12),
                              ),
                              2.pw,
                              Icon(
                                Icons.warning,
                                color: ColorManager.greyColor,
                                size: 14,
                              ),
                            ],
                          ),
                        ))
                    : const SizedBox()
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _addressDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Heading(text: 'Addresss details'),
        6.ph,
        HeadingMedium(
          title: "Select the location of delievry",
          color: ColorManager.greyColor,
        ),
        6.ph,
        SizedBox(
          width: double.infinity,
          height: 80,
          child: Card(
            elevation: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppPadding.p10, vertical: AppPadding.p8),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const HeadingSmall(title: 'Deliver to'),
                    HeadingMedium(
                      title: 'RkHA, Al- Mahamid Riyadh',
                      color: ColorManager.primaryColor,
                    ),
                  ]),
            ),
          ),
        )
      ],
    );
  }
}

class Arguments {
  LaundryModel? laundryModel;

  Arguments({required this.laundryModel});
}

class ItemDetailWidget extends ConsumerWidget {
  ServicesModel servicesModel;
  ItemDetailWidget({super.key, required this.servicesModel});

  @override
  Widget build(BuildContext context, WidgetRef reff) {
    final pickUpItemList =
        reff.watch(_controllerListProvider(servicesModel.id));
    final selectedPickUpItem = reff.watch(deliveryPickupItemNotifierProvider);
    final quantity = reff.watch(quantityNotifier);
    final selectedPickUpItemList =
        reff.watch(selectedDeliveryPickupItemProvider);

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Heading(text: 'Item Details'),
            10.ph,
            HeadingSmall(
              title: 'Describe your courier what do you need',
              color: ColorManager.greyColor,
            ),
            10.ph,
            Padding(
              padding: const EdgeInsets.all(AppPadding.p8),
              child: Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(
                              color: ColorManager.greyColor, width: 0.4)),
                      child: DropdownButton<LaundryItemModel>(
                        padding: const EdgeInsets.only(left: AppPadding.p10),
                        underline: const SizedBox(),
                        hint: const Text('Select Item'),
                        elevation: 8,
                        isExpanded: true,
                        menuMaxHeight: 500,
                        items:
                            pickUpItemList.map((LaundryItemModel? orderItem) {
                          return DropdownMenuItem<LaundryItemModel>(
                            value: orderItem,
                            child: Text(
                              orderItem!.name.toString(),
                              overflow: TextOverflow.ellipsis,
                            ),
                          );
                        }).toList(),
                        onChanged: (LaundryItemModel? val) {
                          if (val != null) {
                            reff
                                .read(
                                    deliveryPickupItemNotifierProvider.notifier)
                                .selectBlanketItem(orderItem: val);
                          }

                          LaundryItemModel? match = selectedPickUpItemList
                              .firstWhere((element) => element.id == val!.id,
                                  orElse: () => LaundryItemModel());

                          if (match.id == null) {
                            if (val != null) {
                              reff
                                  .read(deliveryPickupItemNotifierProvider
                                      .notifier)
                                  .selectBlanketItem(orderItem: val);
                            }
                          } else {
                            reff
                                .read(
                                    deliveryPickupItemNotifierProvider.notifier)
                                .resetBlanketItem();

                            reff
                                .read(quantityNotifier.notifier)
                                .resetQuantitiy();
                            Fluttertoast.showToast(
                                msg: '${match.name} Already Added');
                          }
                        },
                        value: selectedPickUpItem,
                      ),
                    ),
                  ),
                  10.pw,
                  Expanded(
                    flex: 2,
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(
                              color: ColorManager.greyColor, width: 0.5)),
                      child: Row(
                        children: [
                          Expanded(
                            child: IconButton(
                                onPressed: () {
                                  reff
                                      .read(quantityNotifier.notifier)
                                      .removeQuantitiy();
                                },
                                icon: const Icon(
                                  Icons.remove,
                                  color: Colors.red,
                                )),
                          ),
                          Text(
                            quantity.toString(),
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500),
                          ),
                          Expanded(
                            child: IconButton(
                                onPressed: () {
                                  reff
                                      .read(quantityNotifier.notifier)
                                      .addQuantitiy(
                                          servicesModel: servicesModel);
                                },
                                icon: Icon(
                                  Icons.add,
                                  color: ColorManager.primaryColor,
                                )),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (servicesModel.id == 1) ...[
              quantity > 7
                  ? Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.amber.withOpacity(0.1)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "7 max. +0.50 SAR/ex.",
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w500, fontSize: 12),
                            ),
                            2.pw,
                            Icon(
                              Icons.warning,
                              color: ColorManager.greyColor,
                              size: 14,
                            ),
                          ],
                        ),
                      ))
                  : const SizedBox()
            ] else if (servicesModel.id == 2) ...[
              quantity > 3
                  ? Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.amber.withOpacity(0.1)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "3 max. +2 SAR/ex.",
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w500, fontSize: 12),
                            ),
                            2.pw,
                            Icon(
                              Icons.warning,
                              color: ColorManager.greyColor,
                              size: 14,
                            ),
                          ],
                        ),
                      ))
                  : const SizedBox(),
            ],
            10.ph,
            GestureDetector(
              onTap: () {
                if (selectedPickUpItem == null || quantity == 0) {
                  Fluttertoast.showToast(msg: 'Select an Item');
                } else {
                  final LaundryItemModel item = LaundryItemModel(
                      id: selectedPickUpItem.id,
                      name: selectedPickUpItem.name,
                      quantity: quantity);

                  reff
                      .read(selectedDeliveryPickupItemProvider.notifier)
                      .addItem(item: item);

                  reff.read(quantityNotifier.notifier).resetQuantitiy();

                  reff
                      .read(deliveryPickupItemNotifierProvider.notifier)
                      .resetBlanketItem();
                }
              },
              child: Row(
                children: [
                  Icon(
                    Icons.add,
                    color: ColorManager.primaryColor,
                  ),
                  10.ph,
                  Text(
                    "Add New Item",
                    style: GoogleFonts.poppins(
                        color: ColorManager.primaryColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            10.ph,
            selectedPickUpItemList.isEmpty
                ? const SizedBox()
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Heading(text: 'Order Items'),
                      10.ph,
                      ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: selectedPickUpItemList.length,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          return Card(
                            color: ColorManager.mediumWhiteColor,
                            child: Padding(
                              padding: const EdgeInsets.all(AppPadding.p8),
                              child: ListTile(
                                leading: selectedPickUpItemList[index].name ==
                                        'receipt'
                                    ? GestureDetector(
                                        onTap: () {
                                          context.pushNamed(
                                              RouteNames().viewImage,
                                              extra:
                                                  selectedPickUpItemList[index]
                                                      .image);
                                        },
                                        child: Hero(
                                          tag: 'reciept',
                                          child: Image.file(File(
                                              selectedPickUpItemList[index]
                                                  .image
                                                  .toString())),
                                        ))
                                    : null,
                                title: Text(
                                  selectedPickUpItemList[index].name.toString(),
                                ),
                                subtitle: selectedPickUpItemList[index].name ==
                                        'receipt'
                                    ? const SizedBox()
                                    : Text(
                                        'Quantity : ${selectedPickUpItemList[index].quantity}'),
                                trailing: IconButton(
                                    onPressed: () {
                                      reff
                                          .read(
                                              selectedDeliveryPickupItemProvider
                                                  .notifier)
                                          .deleteItem(
                                              id: selectedPickUpItemList[index]
                                                  .id);
                                    },
                                    icon: const Icon(
                                      Icons.delete,
                                      color: Colors.redAccent,
                                    )),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  )
          ],
        ),
      ),
    );
  }
}
