import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:laundryday/screens/delivery_pickup/view/delivery_pickup.dart';
import 'package:laundryday/utils/colors.dart';
import 'package:laundryday/utils/sized_box.dart';
import 'package:laundryday/widgets/heading.dart';

class ScanReceiptWidget extends ConsumerWidget {
  const ScanReceiptWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final states = ref.watch(deliverPickupProvider);
    return GestureDetector(
      onTap: () async {
        showModalBottomSheet(
            isScrollControlled: true,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12))),
            context: context,
            builder: (context) {
              return SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    10.ph,
                    const Text(
                      'Choose Photo',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
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
                          onPressed: () {
                            ref.read(deliverPickupProvider.notifier).pickImage(
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
                            await ref
                                .read(deliverPickupProvider.notifier)
                                .pickImage(
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
                child: states.image == null
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
                            title: 'Scan Recipt',
                          )
                        ],
                      )
                    : Image.file(File(states.image!.path.toString()))),
          ),
        ),
      ),
    );
  }
}
