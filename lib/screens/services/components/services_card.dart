import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laundryday/config/theme/styles_manager.dart';
import 'package:laundryday/constants/api_routes.dart';
import 'package:laundryday/constants/colors.dart';
import 'package:laundryday/constants/sized_box.dart';
import 'package:laundryday/constants/value_manager.dart';
import 'package:laundryday/screens/services/components/address_bottom_sheet_widget.dart';
import 'package:laundryday/widgets/custom_cache_netowork_image.dart';

import '../../../models/services_model.dart';

class ServicesCard extends ConsumerWidget {
  final List<Datum>? serviceModel;
  ServicesCard({super.key, required this.serviceModel});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    ;
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
        itemCount: serviceModel!.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
            
              showModalBottomSheet<void>(
                isDismissible: false,
                useSafeArea: true,
                isScrollControlled: true,
                context: context,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(AppSize.s8),
                        topRight: Radius.circular(AppSize.s8))),
                builder: (BuildContext context) {
                  return AddressBottomSheetWidget(
                    servicesModel: serviceModel![index],
                  );
                },
              );
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
                        child: CustomCacheNetworkImage(
                          fit: BoxFit.cover,
                          imageUrl:
                              "${Api.imageUrl}${serviceModel![index].serviceImage.toString()}",
                          height: 155,
                        )),
                  ),
                  14.ph,
                  Text(
                    serviceModel![index].serviceName.toString(),
                    style: getSemiBoldStyle(
                        color: ColorManager.blackColor, fontSize: 18),
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
