import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laundryday/screens/delivery_pickup/components/extra_quantity_charges_widget.dart';
import 'package:laundryday/screens/delivery_pickup/view/delivery_pickup.dart';
import 'package:laundryday/widgets/heading.dart';

class RecievingMethod extends ConsumerWidget {
  RecievingMethod({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var states = ref.watch(deliverPickupProvider);
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Heading(title: "Method of Recieving"),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(
                'Out Side Door',
                style: GoogleFonts.poppins(fontSize: 14),
              ),
              leading: Radio(
                value: RecievingMethodTypes.outsidedoor,
                groupValue: states.recievingMethod,
                onChanged: (RecievingMethodTypes? value) {
                  log(value.toString());

                  ref
                      .read(deliverPickupProvider.notifier)
                      .selectRecievingMethod(recievingMethodTypes: value!);
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
                    value: RecievingMethodTypes.dooroftheapartment,
                    groupValue: states.recievingMethod,
                    onChanged: (RecievingMethodTypes? value) {
                      log(value.toString());

                      ref
                          .read(deliverPickupProvider.notifier)
                          .selectRecievingMethod(recievingMethodTypes: value!);
                    },
                  ),
                ),
                states.recievingMethod!.index == 1
                    ? const ExtraQuantityChargesWidget(title: '+3 SAR/exx.')
                    : const SizedBox()
              ],
            ),
          ],
        ),
      ),
    );
  }
}
