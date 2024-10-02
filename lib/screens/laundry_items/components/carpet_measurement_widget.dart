import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:laundryday/helpers/db_helper.dart';
import 'package:laundryday/screens/auth/signup/signup.dart';
import 'package:laundryday/resources/colors.dart';
import 'package:laundryday/resources/sized_box.dart';
import 'package:laundryday/screens/laundry_items/model/item_variation_size_model.dart';
import 'package:laundryday/screens/laundry_items/provider/laundry_items.notifier.dart';
import 'package:laundryday/widgets/heading.dart';
import 'package:laundryday/widgets/my_button.dart';
import 'package:laundryday/widgets/my_loader.dart';
import 'package:laundryday/screens/laundry_items/model/item_variation_size_model.dart'
    as itemv;

class CarpetMeasurementWidget extends ConsumerWidget {
  final int itemVariationId;
  CarpetMeasurementWidget({super.key, required this.itemVariationId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itemVariationSizefetch =
        ref.watch(itemvariationSizeProvider(itemVariationId));
    var itemSize = ref.watch(laundryItemProver).itemVariationSize;

    return itemVariationSizefetch.when(
        data: (data) {
          return data.fold((l) {
            return Text(l.toString());
          }, (r) {
            Future.delayed(Duration(seconds: 0), () async {
              ref.read(laundryItemProver.notifier).setItemVariationSize(
                  itemVariationSize: r.itemVariationSize!);
            });

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
                            initialValueSmallList: itemSize!.prefixLength!,
                            initialValueLargeList: itemSize.postfixLength!,
                            prefixSelectedItemChanged: (v) {
                              log("Prefix Length $v");

                              ref
                                  .read(laundryItemProver.notifier)
                                  .setPrefixLength(prefixLength: v);
                            },
                            postfixSelectedItemChanged: (v) {
                              log("Postfix Length $v");
                              ref
                                  .read(laundryItemProver.notifier)
                                  .setPostFixLength(postFixLength: v);
                            },
                            smallList: 4,
                            largeList: 100),
                        myWheelListScroller(
                            initialValueSmallList: itemSize.prefixWidth!,
                            initialValueLargeList: itemSize.postfixWidth!,
                            title: "Width",
                            prefixSelectedItemChanged: (v) {
                              log("PreFix Width $v");

                              ref
                                  .read(laundryItemProver.notifier)
                                  .setPrefixWidth(prefixWidth: v);
                            },
                            postfixSelectedItemChanged: (v) {
                              log("PostFix Width $v");

                              ref
                                  .read(laundryItemProver.notifier)
                                  .setPostFixWidth(postFixWidth: v);
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
                              "(${itemSize.prefixLength}.${itemSize.postfixLength.toString().padLeft(2, '0')})m",
                          color: ColorManager.primaryColor,
                        ),
                        Heading(
                          title:
                              "(${itemSize.prefixWidth}.${itemSize.postfixWidth.toString().padLeft(2, '0')})m",
                          color: ColorManager.primaryColor,
                        ),
                      ],
                    ),
                    20.ph,
                    MyButton(
                      title: 'Ok',
                      onPressed: () async {
                        int result = await DatabaseHelper.instance
                            .insertOrUpdateItemVariationSize(
                                ItemVariationSizeModel(
                                    success: true,
                                    message: 'item size updated successfully',
                                    itemVariationSize: itemSize));

                        if (result == 1) {
                          log('Size updated');
                          context.pop();
                        }
                      },
                    ),
                    10.ph,
                    MyButton(
                      title: 'Cancel',
                      onPressed: () async {
                        itemv.ItemVariationSize? itemVariationSize =
                            await DatabaseHelper.instance
                                .getItemVariationSize(itemVariationId);

                        log(itemVariationSize!.postfixLength.toString());
                        GoRouter.of(context).pop();
                      },
                      isBorderButton: true,
                    ),
                    10.ph,
                  ],
                ),
              ),
            );
          });
        },
        error: (e, s) => Text(e.toString()),
        loading: () => Loader());
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
