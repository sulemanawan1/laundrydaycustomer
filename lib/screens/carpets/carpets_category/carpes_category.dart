// ignore_for_file: unnecessary_brace_in_string_interps, invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laundryday/Widgets/my_heading/heading.dart';
import 'package:laundryday/helpers/db_helper.dart';
import 'package:laundryday/models/carpet.dart';
import 'package:laundryday/screens/auth/signup/signup.dart';
import 'package:laundryday/screens/carpets/carpet_service_detail/carpet_service_detail.dart';
import 'package:laundryday/utils/colors.dart';
import 'package:laundryday/utils/sized_box.dart';
import 'package:laundryday/utils/routes/route_names.dart';
import 'package:laundryday/screens/carpets/carpets_category/notifier/carpet_list_notifier.dart';
import 'package:laundryday/screens/carpets/carpets_category/notifier/quantity_notifier.dart';
import 'package:laundryday/widgets/my_app_bar/my_app_bar.dart';
import 'package:laundryday/widgets/my_button/my_button.dart';
import 'package:laundryday/widgets/reusable_checkout_card.dart';

class CarpetsCategory extends ConsumerStatefulWidget {
  final CarpetDetailsArguments? arguments;

  const CarpetsCategory({super.key, required this.arguments});

  @override
  ConsumerState<CarpetsCategory> createState() => _CarpetScreensState();
}

class _CarpetScreensState extends ConsumerState<CarpetsCategory> {
  DBHelper dbHelper = DBHelper();
  double total = 0.0;
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    dbHelper.initDatabase();

    dbHelper
        .getTotalItemsCount(laundryId: widget.arguments!.laundry!.id)
        .then((value) {
      log("First Initail ${value.toString()}");
      ref.read(quantityProvider.notifier).state = value;
    });

    dbHelper
        .getItemList(laundryId: widget.arguments!.laundry!.id)
        .then((value) {
      var carpetLi = ref.watch(carpetsListProvider);

      carpetLi!.addAll(value!);
    });
  }

  @override
  Widget build(BuildContext context) {
    var count = ref.watch(quantityProvider);

    return Scaffold(
        backgroundColor: const Color.fromRGBO(247, 247, 247, 1),
        appBar: MyAppBar(title: ''),
        body: LayoutBuilder(builder: (context, constraints) {
          return ConstrainedBox(
            constraints: constraints.copyWith(
                minHeight: constraints.maxHeight, maxHeight: double.infinity),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: SingleChildScrollView(
                child: Column(children: [
                  10.ph,
                  laundryDetailCard(context),
                  20.ph,
                  carpetCategoryTabBar(),
                  10.ph,
                  if (count >= 1) ...[
                    ReusableCheckOutCard(
                        onPressed: () {
                          GoRouter.of(context).pushNamed(
                              RouteNames().carpetOrderCheckout,
                              extra: widget.arguments);
                        },
                        quantity: count.toString(),
                        total: 0.toString())
                  ]
                ]),
              ),
            ),
          );
        }));
  }

  Widget itemCard(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      return GestureDetector(
        onTap: () {
          showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (BuildContext context) {
                return StatefulBuilder(builder: (context, bottomSheetState) {
                  return addCarpetToCart(bottomSheetState);
                });
              });
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Container(
            width: MediaQuery.sizeOf(context).width,
            height: 340,
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                color:
                        ColorManager. greyColor.withOpacity(0.1), // Shadow color
                spreadRadius: 5, // Spread radius
                blurRadius: 6, // Blur radius
                offset: const Offset(0, 3), // Offset for the shadow
              ),
            ], color: ColorManager. whiteColor, borderRadius: BorderRadius.circular(20)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Container(
                width: MediaQuery.sizeOf(context).width,
                height: 250,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(20)),
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      40.ph,
                      Image.asset(
                        widget.arguments!.laundry!.carpets[selectedIndex].image
                            .toString(),
                        height: 180,
                      ),
                      20.ph,
                      Text(
                        widget.arguments!.laundry!.carpets[selectedIndex].name
                            .toString(),
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500, fontSize: 18),
                      ),
                      5.ph,
                      Text(
                        "SAR ${widget.arguments!.laundry!.carpets[selectedIndex].charges.toString()} m\u00B2",
                        style:
                            GoogleFonts.poppins(color: ColorManager.greyColor, fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    });
  }

  Widget carpetCategoryTabBar() {
    return Column(
      children: [
        SizedBox(
          height: 40,
          child: ListView.separated(
            separatorBuilder: (context, index) => 5.pw,
            physics: const NeverScrollableScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: widget.arguments!.laundry!.carpets.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  selectedIndex = index;
                  setState(() {});
                },
                child: Container(
                  height: 34,
                  width: MediaQuery.of(context).size.width * 0.47,
                  decoration: BoxDecoration(
                    color: (selectedIndex == index)
                        ? ColorManager.primaryColor.withOpacity(0.1)
                        : ColorManager. whiteColor,
                    border: Border.all(
                        width: 1,
                        color:
                            selectedIndex == index ? ColorManager. primaryColor : ColorManager. greyColor),
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: Center(
                    child: Text(
                      widget.arguments!.laundry!.carpets[index].category
                          .toString()
                          .toUpperCase(),
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: selectedIndex == index
                              ? ColorManager.primaryColor
                              : ColorManager. greyColor),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        20.ph,
        itemCard(context),
      ],
    );
  }

  Widget laundryDetailCard(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          widget.arguments!.laundry!.logo.toString(),
          height: 80,
        ),
        10.ph,
        Container(
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: ColorManager.greyColor.withOpacity(0.1), // Shadow color
                  spreadRadius: 5, // Spread radius
                  blurRadius: 6, // Blur radius
                  offset: const Offset(0, 3), // Offset for the shadow
                ),
              ],
              color: ColorManager.mediumWhiteColor,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: ColorManager.mediumWhiteColor)),
          height: 110,
          width: MediaQuery.sizeOf(context).width * 0.9,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                10.ph,
                Text(widget.arguments!.laundry!.name.toString(),
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600, fontSize: 18)),
                5.ph,
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     Icon(
                      Icons.place,
                      size: 16,
                    ),
                    5.pw,
                    Text(
                      "${widget.arguments!.laundry!.distance.toString()} km",
                      style: GoogleFonts.poppins(
                          color: ColorManager. greyColor, fontWeight: FontWeight.w400),
                    ),
                    10.pw,
                    const Icon(
                      Icons.star,
                      size: 16,
                      color: Colors.amber,
                    ),
                    5.pw,
                    Text(
                      widget.arguments!.laundry!.rating.toString(),
                      style: GoogleFonts.poppins(),
                    ),
                  ],
                ),
                10.ph,
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget addCarpetToCart(StateSetter bottomSheetState) {
    var carpetLi = ref.watch(carpetsListProvider);

    return Consumer(builder: (context, ref, child) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              10.ph,
              Row(
                children: [
                  IconButton(
                      onPressed: () {
                        context.pop();
                      },
                      icon:  Icon(
                        Icons.arrow_back_ios,
                        color: ColorManager.greyColor,
                      )),
                  Heading(
                      text: widget
                          .arguments!.laundry!.carpets[selectedIndex].name
                          .toString()),
                ],
              ),
              20.ph,
              widget.arguments!.laundry!.carpets[selectedIndex].category ==
                      'mats'
                  ? Container()
                  : GestureDetector(
                      onTap: () {
                        showDialog<void>(
                          useSafeArea: true,
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                                insetPadding: const EdgeInsets.all(10),
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                title: Center(
                                  child: Heading(
                                      text:
                                          "${widget.arguments!.laundry!.carpets[selectedIndex].name.toString()} Size"),
                                ),
                                content: StatefulBuilder(
                                    builder: (context, StateSetter set) {
                                  return carpetMeasurement(set, context);
                                }));
                          },
                        );
                      },
                      child: Container(
                        height: 50,
                        decoration:
                            BoxDecoration(color: ColorManager. primaryColor.withOpacity(0.1)),
                        child: Row(
                          children: [
                            const Icon(Icons.edit),
                            5.pw,
                            HeadingMedium(
                                title:
                                    'Select Size: ${widget.arguments!.laundry!.carpets[selectedIndex].length!}m'),
                          ],
                        ),
                      ),
                    ),
              10.ph,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  HeadingMedium(title: 'No of Items'),
                  _itemQuantityWidget(
                      onPossitive: () {
                        widget.arguments!.laundry!.carpets[selectedIndex]
                            .quantity = (widget.arguments!.laundry!
                                .carpets[selectedIndex].quantity! +
                            1);
                        bottomSheetState(() {});
                      },
                      onNegative: () {
                        if (widget.arguments!.laundry!.carpets[selectedIndex]
                                .quantity ==
                            0) {
                          widget.arguments!.laundry!.carpets[selectedIndex]
                              .quantity = 0;
                        } else {
                          widget.arguments!.laundry!.carpets[selectedIndex]
                              .quantity = (widget.arguments!.laundry!
                                  .carpets[selectedIndex].quantity! -
                              1);
                        }
                        bottomSheetState(() {});
                      },
                      val: widget
                          .arguments!.laundry!.carpets[selectedIndex].quantity
                          .toString()),
                ],
              ),
              20.ph,
              Row(
                children: [
                  const Icon(Icons.payments),
                  5.pw,
                  HeadingMedium(
                    title:
                        'SAR ${widget.arguments!.laundry!.carpets[selectedIndex].charges.toString()}/m\u00B2',
                    color: ColorManager.primaryColor,
                  )
                ],
              ),
              20.ph,
              GestureDetector(
                onTap: () async {
                  Carpet item =
                      widget.arguments!.laundry!.carpets[selectedIndex];

                  DBHelper()
                      .insert(item)
                      .then((value) => carpetLi!.add(value))
                      .onError((error, stackTrace) {
                    Fluttertoast.showToast(
                      msg: 'Already Added',
                    );
                  });
                  DBHelper()
                      .getTotalItemsCount(
                          laundryId: widget.arguments!.laundry!.id)
                      .then((value) {
                    ref.read(quantityProvider.notifier).state = value;
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Container(
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                        color: ColorManager.primaryColor,
                        borderRadius: BorderRadius.circular(12)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Center(
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Heading(
                                text:
                                    "SAR ${widget.arguments!.laundry!.carpets[selectedIndex].charges! * widget.arguments!.laundry!.carpets[selectedIndex].quantity!}",
                                color: ColorManager. whiteColor,
                              ),
                               Heading(
                                text: 'Add',
                                color: ColorManager. whiteColor,
                              )
                            ]),
                      ),
                    ),
                  ),
                ),
              ),
              30.ph
            ],
          ),
        ),
      );
    });
  }

  Widget carpetMeasurement(set, context) {
    return Consumer(builder: (context, ref, child) {
      return SizedBox(
        width: 300,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  myWheelListScroller(
                      title: "Length",
                      initialValueSmallList: widget.arguments!.laundry!
                          .carpets[selectedIndex].prefixLength,
                      initialValueLargeList: widget.arguments!.laundry!
                          .carpets[selectedIndex].postfixLength,
                      prefixSelectedItemChanged: (v) {
                        widget.arguments!.laundry!.carpets[selectedIndex]
                            .prefixLength = v;

                        widget.arguments!.laundry!.carpets[selectedIndex]
                                .length =
                            double.parse(
                                "${widget.arguments!.laundry!.carpets[selectedIndex].prefixLength}.${widget.arguments!.laundry!.carpets[selectedIndex].postfixLength}");

                        // set(() {});
                      },
                      postfixSelectedItemChanged: (v) {
                        String formattedNumber = v.toString().padLeft(2, '0');

                        widget.arguments!.laundry!.carpets[selectedIndex]
                            .postfixLength = v;

                        widget.arguments!.laundry!.carpets[selectedIndex]
                                .length =
                            double.parse(
                                "${widget.arguments!.laundry!.carpets[selectedIndex].prefixLength}.${formattedNumber}");

                        set(() {});
                      },
                      smallList: 4,
                      largeList: 100),
                  myWheelListScroller(
                      initialValueSmallList: widget.arguments!.laundry!
                          .carpets[selectedIndex].prefixWidth,
                      initialValueLargeList: widget.arguments!.laundry!
                          .carpets[selectedIndex].postfixWidth,
                      title: "Width",
                      prefixSelectedItemChanged: (v) {
                        widget.arguments!.laundry!.carpets[selectedIndex]
                            .prefixWidth = v;
                        widget.arguments!.laundry!.carpets[selectedIndex]
                                .width =
                            double.parse(
                                "${widget.arguments!.laundry!.carpets[selectedIndex].prefixWidth}.${widget.arguments!.laundry!.carpets[selectedIndex].postfixWidth}");
                        set(() {});
                      },
                      postfixSelectedItemChanged: (v) {
                        String formattedNumber = v.toString().padLeft(2, '0');

                        widget.arguments!.laundry!.carpets[selectedIndex]
                            .postfixWidth = v;
                        widget.arguments!.laundry!.carpets[selectedIndex]
                                .width =
                            double.parse(
                                "${widget.arguments!.laundry!.carpets[selectedIndex].prefixWidth}.${formattedNumber}");

                        set(() {});
                      },
                      smallList: 4,
                      largeList: 100),
                ],
              ),
              10.ph,
              const Divider(),
              10.ph,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Heading(
                    text:
                        "(${widget.arguments!.laundry!.carpets[selectedIndex].prefixLength}.${widget.arguments!.laundry!.carpets[selectedIndex].postfixLength.toString().padLeft(2, '0')})m",
                    color: ColorManager. primaryColor,
                  ),
                  Heading(
                    text:
                        "(${widget.arguments!.laundry!.carpets[selectedIndex].prefixWidth}.${widget.arguments!.laundry!.carpets[selectedIndex].postfixWidth.toString().padLeft(2, '0')})m",
                    color: ColorManager.primaryColor,
                  ),
                ],
              ),
              20.ph,
              MyButton(
                name: 'Ok',
                onPressed: () {
                  set(() {});
                  GoRouter.of(context).pop();
                },
              ),
              10.ph,
              MyButton(
                name: 'Cancel',
                onPressed: () {
                  GoRouter.of(context).pop();
                },
                isBorderButton: true,
              )
            ],
          ),
        ),
      );
    });
  }

  Widget myWheelListScroller({
    required title,
    void Function(int)? prefixSelectedItemChanged,
    void Function(int)? postfixSelectedItemChanged,
    required int smallList,
    required int largeList,
    required initialValueSmallList,
    required initialValueLargeList,
  }) {
    return Column(
      children: [
        10.ph,
        Heading(text: title),
        20.ph,
        Row(
          children: [
            SizedBox(
                width: 50,
                height: 150,
                child: ListWheelScrollView.useDelegate(
                  controller: FixedExtentScrollController(
                      initialItem: initialValueSmallList),
                  useMagnifier: true,
                  perspective: 0.001,
                  magnification: 1.3,
                  overAndUnderCenterOpacity: 0.4,
                  physics: const FixedExtentScrollPhysics(),
                  itemExtent: 38,
                  onSelectedItemChanged: prefixSelectedItemChanged,
                  childDelegate: ListWheelChildLoopingListDelegate(
                    children: List.generate(
                        smallList,
                        (index) => Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6),
                                    color: ColorManager.primaryColor.withOpacity(0.1)),
                                child: Center(
                                  child: HeadingSmall(
                                    title: index.toString(),
                                    color: ColorManager.primaryColor,
                                  ),
                                ),
                              ),
                            )),
                  ),
                )),
            10.pw,
            SizedBox(
              width: 50,
              height: 150,
              child: ListWheelScrollView.useDelegate(
                controller: FixedExtentScrollController(
                    initialItem: initialValueLargeList),
                useMagnifier: true,
                perspective: 0.001,
                magnification: 1.3,
                overAndUnderCenterOpacity: 0.4,
                physics: const FixedExtentScrollPhysics(),
                itemExtent: 38,
                onSelectedItemChanged: postfixSelectedItemChanged,
                childDelegate: ListWheelChildLoopingListDelegate(
                    children: List.generate(
                        largeList,
                        (index) => Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6),
                                    color: ColorManager.primaryColor.withOpacity(0.1)),
                                child: Center(
                                  child: HeadingSmall(
                                    title: index.toString().padLeft(2, '0'),
                                    color: ColorManager.primaryColor,
                                  ),
                                ),
                              ),
                            ))),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _itemQuantityWidget(
      {required void Function()? onPossitive,
      required void Function()? onNegative,
      required String val}) {
    return Container(
      width: MediaQuery.sizeOf(context).width * 0.45,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: ColorManager. primaryColor)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: onNegative,
            icon: const Icon(Icons.remove),
            color: Colors.red,
          ),
          Text(
            val,
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w600,
              fontSize: 18,
            ),
          ),
          IconButton(
            onPressed: onPossitive,
            icon: const Icon(Icons.add),
            color: Colors.green,
          ),
        ],
      ),
    );
  }
}
