import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:laundryday/config/theme/styles_manager.dart';
import 'package:laundryday/screens/more/addresses/my_addresses/provider/my_addresses_notifier.dart';
import 'package:laundryday/screens/services/provider/addresses_notifier.dart';
import 'package:laundryday/config/resources/colors.dart';
import 'package:laundryday/config/resources/sized_box.dart';
import 'package:laundryday/config/routes/route_names.dart';
import 'package:laundryday/core/widgets/heading.dart';
import 'package:laundryday/core/widgets/my_app_bar.dart';
import 'package:laundryday/core/widgets/my_button.dart';
import 'package:laundryday/screens/more/addresses/my_addresses/model/my_addresses_model.dart'
    as myaddressmodel;

class MyAddresses extends ConsumerWidget {
  const MyAddresses({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(myAddresesProvider).addressModel;
    myaddressmodel.Address? selectedAddress =
        ref.watch(selectedAddressProvider);
    return Scaffold(
      appBar: MyAppBar(title: 'My Addresses'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Heading(title: "My addresses"),
              data == null
                  ? SizedBox()
                  : (data.addresses!.length == 0)
                      ? SizedBox()
                      : TextButton.icon(
                          style: ButtonStyle(
                            iconColor: WidgetStateColor.resolveWith(
                              (Set<WidgetState> states) {
                                return ColorManager
                                    .primaryColor; // Cor quando focado
                                // Cor padrão
                              },
                            ),
                          ),
                          label: Text(
                            'Add Address',
                            style: getSemiBoldStyle(
                              color: ColorManager.primaryColor,
                              fontSize: 16,
                            ),
                          ),
                          icon: Icon(Icons.add_location),
                          onPressed: () {
                            GoRouter.of(context)
                                .pushNamed(RouteNames.addNewAddress);
                          },
                        ),
            ],
          ),
          10.ph,
          data == null
              ? Center(
                  child: CircularProgressIndicator(
                  color: ColorManager.primaryColor,
                ))
              : (data.addresses!.length == 0)
                  ? Expanded(
                      child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(height: 100, 'assets/my_addresses.png'),
                            10.ph,
                            Text(
                              textAlign: TextAlign.center,
                              data.message.toString(),
                              style: getSemiBoldStyle(
                                  fontSize: 16, color: ColorManager.blackColor),
                            ),
                          ],
                        ),
                      ),
                    ))
                  : Expanded(
                      child: ListView.separated(
                        separatorBuilder: ((context, index) => 10.ph),
                        itemCount: data.addresses!.length,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(
                                    color: ColorManager.primaryColor)),
                            child: ListTile(
                              onTap: () {
                                ref
                                    .read(selectedAddressProvider.notifier)
                                    .onAddressTap(data.addresses![index]);
                              },
                              tileColor:
                                  selectedAddress == data.addresses![index]
                                      ? ColorManager.primaryColorOpacity10
                                      : null,
                              isThreeLine: false,
                              leading: Padding(
                                padding: EdgeInsets.symmetric(vertical: 10),
                                child: Icon(
                                  Icons.radio_button_checked,
                                  color: ColorManager.primaryColor,
                                ),
                              ),
                              title: Text(
                                data.addresses![index].addressName.toString(),
                                style: getSemiBoldStyle(
                                    color: ColorManager.blackColor),
                                maxLines: 1,
                              ),
                              subtitle: Text(
                                data.addresses![index].addressDetail.toString(),
                                style: getSemiBoldStyle(
                                    color: ColorManager.greyColor),
                                maxLines: 1,
                              ),
                              trailing: Wrap(children: [
                                IconButton(
                                    onPressed: () {
                                      context.pushNamed(
                                          RouteNames.updateAddress,
                                          extra: data.addresses![index]);
                                    },
                                    icon: Icon(
                                      Icons.edit,
                                      color: ColorManager.primaryColor,
                                    )),
                                IconButton(
                                    onPressed: () {
                                      showDeleteAddressDialog(
                                          context: context,
                                          ref: ref,
                                          addressId:
                                              data.addresses![index].id!);
                                    },
                                    icon: const Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ))
                              ]),
                            ),
                          );
                        },
                      ),
                    ),
          10.ph,
          data == null
              ? SizedBox()
              : (data.addresses!.length == 0)
                  ? MyButton(
                      title: "Add Address",
                      onPressed: () {
                        GoRouter.of(context)
                            .pushNamed(RouteNames.addNewAddress);
                      },
                    )
                  : MyButton(
                      title: 'Select',
                      onPressed: () {},
                    ),
          30.ph
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
