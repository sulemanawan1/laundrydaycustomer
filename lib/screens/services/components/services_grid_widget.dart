import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laundryday/provider/user_notifier.dart';
import 'package:laundryday/screens/services/model/services_model.dart' as s;
import 'package:laundryday/utils/constants/sized_box.dart';

class ServicesGrid extends ConsumerWidget {
  final s.ServiceModel services;

  const ServicesGrid({
    super.key,
    required this.services,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider).userModel;

    log("------------------------");
    log("User Id ${user!.user!.id.toString()}");
    log("------------------------");
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 15.0,
            mainAxisSpacing: 15.0,
            mainAxisExtent: 220),
        itemCount: services.data?.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              // showModalBottomSheet<void>(
              //   context: context,
              //   shape: const RoundedRectangleBorder(
              //       borderRadius: BorderRadius.only(
              //           topLeft: Radius.circular(8),
              //           topRight: Radius.circular(8))),
              //   builder: (BuildContext context) {
              //     return Consumer(builder: (context, reff, child) {
              //       // final selectedIndex = reff.watch(serviceProvider);
              //       return AddressBottomSheetWidget(
              //         servicesModel: services.data![index],
              //       );
              //     });
              //   },
              // );
            },
            child: Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: Column(
                children: [
                  GridTile(
                    child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(12),
                            topRight: Radius.circular(12)),
                        child: Image.network(
                          width: double.infinity,
                          height: 155,
                          services.data![index].serviceImage.toString(),
                          fit: BoxFit.cover,
                        )),
                  ),
                  14.ph,
                  Text(
                    services.data![index].serviceName.toString(),
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600, fontSize: 18),
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
