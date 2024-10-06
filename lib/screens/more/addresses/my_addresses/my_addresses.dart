import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:laundryday/config/theme/styles_manager.dart';
import 'package:laundryday/resources/font_manager.dart';
import 'package:laundryday/screens/more/addresses/my_addresses/model/my_addresses_model.dart';
import 'package:laundryday/screens/more/addresses/my_addresses/provider/my_addresses_notifier.dart';
import 'package:laundryday/screens/services/provider/addresses_notifier.dart';
import 'package:laundryday/resources/colors.dart';
import 'package:laundryday/resources/sized_box.dart';
import 'package:laundryday/config/routes/route_names.dart';
import 'package:laundryday/widgets/my_app_bar.dart';
import 'package:laundryday/widgets/my_loader.dart';

class MyAddresses extends ConsumerWidget {
  const MyAddresses({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final addresses = ref.watch(addressesProvider);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add_location),
        backgroundColor: ColorManager.nprimaryColor,
        onPressed: () {
          GoRouter.of(context).pushNamed(RouteNames.addNewAddress);
        },
      ),
      appBar: MyAppBar(title: 'My Addresses'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            'Addresses',
            style: getSemiBoldStyle(
                color: ColorManager.blackColor, fontSize: FontSize.s14),
          ),
          20.ph,
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
                            border: Border.all(color: ColorManager.greyColor)),
                        child: ListTile(
                          trailing: SizedBox(
                            width: 100,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 30,
                                  child: IconButton(
                                    onPressed: () {
                                      context.pushNamed(
                                          RouteNames.updateAddress,
                                          extra: adddress);
                                    },
                                    icon: Center(
                                      child: Icon(
                                        Icons.edit,
                                        color: ColorManager.purpleColor,
                                      ),
                                    ),
                                  ),
                                ),
                                20.pw,
                                SizedBox(
                                  width: 30,
                                  child: IconButton(
                                    onPressed: () {
                                      showDeleteAddressDialog(
                                          context: context,
                                          ref: ref,
                                          addressId: addresses[index].id!);
                                    },
                                    icon: Icon(
                                      Icons.delete,
                                      color: ColorManager.redColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          title: Text(
                            adddress.googleMapAddress.toString(),
                            maxLines: 2,
                          ),
                        ),
                      );
                    },
                  );
                });
              },
              error: (e, s) => Text(e.toString()),
              loading: () => Loader()),
        ]),
      ),
    );
  }

  void showDeleteAddressDialog(
      {required BuildContext context,
      required WidgetRef ref,
      required int addressId}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog.adaptive(
          title: Row(
            children: [
              Text(
                'Delete Address',
                style: getSemiBoldStyle(color: ColorManager.blackColor),
              ),
            ],
          ),
          content: Text(
            'Are you sure you want to delete the address?',
            style: getSemiBoldStyle(color: ColorManager.greyColor),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'Cancel',
                style: getSemiBoldStyle(color: ColorManager.greyColor),
              ),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
            TextButton(
              child: Text(
                'Delete',
                style: getSemiBoldStyle(color: ColorManager.redColor),
              ),
              onPressed: () {
                ref
                    .read(myAddresesProvider.notifier)
                    .deleteAddress(addressId: addressId, ref: ref);

                // Add your delete functionality here
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
          ],
        );
      },
    );
  }
}
