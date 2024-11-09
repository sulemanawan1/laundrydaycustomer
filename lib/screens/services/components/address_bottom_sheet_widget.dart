import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:laundryday/config/theme/styles_manager.dart';
import 'package:laundryday/screens/more/addresses/my_addresses/model/my_addresses_model.dart';
import 'package:laundryday/screens/services/provider/addresses_notifier.dart';
import 'package:laundryday/resources/colors.dart';
import 'package:laundryday/resources/sized_box.dart';
import 'package:laundryday/config/routes/route_names.dart';
import 'package:laundryday/screens/services/provider/services_notifier.dart';
import 'package:laundryday/widgets/my_button.dart';
import 'package:laundryday/screens/services/model/services_model.dart'
    as servicemodel;
import 'package:laundryday/screens/more/addresses/my_addresses/model/my_addresses_model.dart'
    as myaddressmodel;
import 'package:laundryday/widgets/my_loader.dart';

class AddressBottomSheetWidget extends ConsumerWidget {
  final servicemodel.Datum? servicesModel;
  const AddressBottomSheetWidget({super.key, this.servicesModel});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    myaddressmodel.Address? selectedAddress =
        ref.watch(selectedAddressProvider);
    final addresses = ref.watch(addressesProvider);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            10.ph,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Choose from saved addresses',
                  style: getSemiBoldStyle(color: ColorManager.blackColor),
                ),
                IconButton(
                    onPressed: () {
                      GoRouter.of(context).pop();
                    },
                    icon: Icon(
                      Icons.close,
                      color: ColorManager.greyColor,
                    ))
              ],
            ),
            10.ph,
            addresses.when(
                data: (data) {
                  return data.fold((l) => Text(l.toString()), (r) {
                    List<Address>? addresses = r.addresses;

                    return ListView.separated(
                      shrinkWrap: true,
                      reverse: true,
                      physics: NeverScrollableScrollPhysics(),
                      separatorBuilder: ((context, index) => 18.ph),
                      itemCount: addresses!.length,
                      itemBuilder: (BuildContext context, int index) {
                        Address adddress = addresses[index];

                        return Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              border:
                                  Border.all(color: ColorManager.greyColor)),
                          child: ListTile(
                              isThreeLine: true,
                              trailing: adddress.addressDetail!.toLowerCase() ==
                                      'my-current-address'
                                  ? null
                                  : IconButton(
                                      onPressed: () {
                                        context.pop();
                                        context.pushNamed(
                                            RouteNames.updateAddress,
                                            extra: adddress);
                                      },
                                      icon: Icon(
                                        Icons.edit,
                                        color: ColorManager.purpleColor,
                                      ),
                                    ),
                              tileColor: selectedAddress == adddress
                                  ? ColorManager.primaryColorOpacity10
                                  : null,
                              title: Text(
                                adddress.addressDetail.toString(),
                                style: getMediumStyle(
                                    color: Colors.black, fontSize: 14),
                              ),
                              subtitle: Text(
                                adddress.googleMapAddress.toString(),
                                maxLines: 2,
                              ),
                              onTap: () {
                                ref
                                    .read(selectedAddressProvider.notifier)
                                    .selectAddress(adddress);

                                if (servicesModel?.serviceName.toString() ==
                                    'Blankets') {
                                  ref
                                      .read(serviceProvider.notifier)
                                      .selectedService(
                                          selectedService: servicesModel!);

                                  GoRouter.of(context).pushNamed(
                                      RouteNames.laundries,
                                      extra: servicesModel);

                                  context.pop();
                                } else if (servicesModel?.serviceName
                                        .toString() ==
                                    "Carpets") {
                                  ref
                                      .read(serviceProvider.notifier)
                                      .selectedService(
                                          selectedService: servicesModel!);

                                  GoRouter.of(context).pushNamed(
                                      RouteNames.laundries,
                                      extra: servicesModel);

                                  context.pop();
                                } else if (servicesModel?.serviceName
                                        .toString() ==
                                    "Clothes") {
                                  ref
                                      .read(serviceProvider.notifier)
                                      .selectedService(
                                          selectedService: servicesModel!);

                                  GoRouter.of(context).pushNamed(
                                      RouteNames.laundries,
                                      extra: servicesModel);
                                  context.pop();
                                }
                              },
                              leading: (selectedAddress == adddress)
                                  ? Icon(
                                      Icons.check_circle_rounded,
                                      color: ColorManager.primaryColor,
                                    )
                                  : const Icon(Icons.circle_outlined)),
                        );
                      },
                    );
                  });
                },
                error: (e, s) => Text(e.toString()),
                loading: () => Loader()),
            10.ph,
            MyButton(
              title: 'Add Address',
              isBorderButton: true,
              onPressed: () {
                context.pushNamed(RouteNames.addNewAddress);

                context.pop();
              },
            ),
            20.ph
          ],
        ),
      ),
    );
  }
}
