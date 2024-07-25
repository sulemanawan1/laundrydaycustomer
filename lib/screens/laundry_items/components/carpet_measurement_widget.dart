import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:laundryday/models/item_model.dart';
import 'package:laundryday/screens/auth/signup/signup.dart';
import 'package:laundryday/core/constants/colors.dart';
import 'package:laundryday/core/constants/sized_box.dart';
import 'package:laundryday/core/widgets/heading.dart';
import 'package:laundryday/core/widgets/my_button.dart';

class CarpetMeasurementWidget extends StatelessWidget {
  ItemModel itemModel;
  CarpetMeasurementWidget({super.key, required this.itemModel});

  @override
  Widget build(BuildContext context) {
    print(itemModel.prefixLength);
    print(itemModel.postfixLength);

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
                      initialValueSmallList: itemModel.prefixLength ?? 0,
                      initialValueLargeList: itemModel.postfixLength ?? 0,
                      prefixSelectedItemChanged: (v) {
                        itemModel.prefixLength = v;

                        itemModel.length = double.parse(
                            "${itemModel.prefixLength}.${itemModel.postfixLength}");
                      },
                      postfixSelectedItemChanged: (v) {
                        String formattedNumber = v.toString().padLeft(2, '0');

                        itemModel.postfixLength = v;

                        itemModel.length = double.parse(
                            "${itemModel.prefixLength}.$formattedNumber");
                      },
                      smallList: 4,
                      largeList: 100),
                  myWheelListScroller(
                      initialValueSmallList: itemModel.prefixWidth ?? 0,
                      initialValueLargeList: itemModel.postfixWidth ?? 0,
                      title: "Width",
                      prefixSelectedItemChanged: (v) {
                        itemModel.prefixWidth = v;
                        itemModel.width = double.parse(
                            "${itemModel.prefixWidth}.${itemModel.postfixWidth}");
                      },
                      postfixSelectedItemChanged: (v) {
                        String formattedNumber = v.toString().padLeft(2, '0');

                        itemModel.postfixWidth = v;
                        itemModel.width = double.parse(
                            "${itemModel.prefixWidth}.$formattedNumber");
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
                    title:
                        "(${itemModel.prefixLength}.${itemModel.postfixLength.toString().padLeft(2, '0')})m",
                    color: ColorManager.primaryColor,
                  ),
                  Heading(
                    title:
                        "(${itemModel.prefixWidth}.${itemModel.postfixWidth.toString().padLeft(2, '0')})m",
                    color: ColorManager.primaryColor,
                  ),
                ],
              ),
              20.ph,
              MyButton(
                title: 'Ok',
                onPressed: () {
                  GoRouter.of(context).pop();
                },
              ),
              10.ph,
              MyButton(
                title: 'Cancel',
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
}

Widget myWheelListScroller({
  required title,
  void Function(int)? prefixSelectedItemChanged,
  void Function(int)? postfixSelectedItemChanged,
  required int smallList,
  required int largeList,
  required int initialValueSmallList,
  required int initialValueLargeList,
}) {
  return Column(
    children: [
      10.ph,
      Heading(title: title),
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
                                  color: ColorManager.primaryColor
                                      .withOpacity(0.1)),
                              child: Center(
                                child: HeadingMedium(
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
                                  color: ColorManager.primaryColor
                                      .withOpacity(0.1)),
                              child: Center(
                                child: HeadingMedium(
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
