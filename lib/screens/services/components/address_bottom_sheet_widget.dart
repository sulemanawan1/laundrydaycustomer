import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:laundryday/screens/more/addresses/my_addresses/model/my_addresses_model.dart';
import 'package:laundryday/screens/services/provider/addresses_notifier.dart';
import 'package:laundryday/screens/services/provider/addresses_state.dart';
import 'package:laundryday/utils/colors.dart';
import 'package:laundryday/utils/constants/sized_box.dart';
import 'package:laundryday/utils/routes/route_names.dart';
import 'package:laundryday/widgets/my_button.dart';
import 'package:laundryday/widgets/heading.dart';
import 'package:laundryday/screens/services/model/services_model.dart'
    as servicemodel;
import 'package:laundryday/screens/more/addresses/my_addresses/model/my_addresses_model.dart'
    as myaddressmodel;

class AddressBottomSheetWidget extends ConsumerWidget {
  final servicemodel.Datum? servicesModel;
  const AddressBottomSheetWidget({super.key, this.servicesModel});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AddressesState addressesState = ref.watch(serviceAddressesProvider);

    myaddressmodel.Address? selectedAddress =
        ref.watch(selectedAddressProvider);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            10.ph,
            buildHeader(context),
            if (addressesState is AddressesInitialState) ...[
              CircularProgressIndicator()
            ] else if (addressesState is AddressesLoadingState) ...[
              
              CircularProgressIndicator()
            ] else if (addressesState is AddressesLoadedState) ...[
              
              
              buildAddressList(addressesState, selectedAddress, ref),
            ] else if (addressesState is AddressesErrorState) ...[
              Text('Something Went Wrong')
            ],
            5.ph,
            buildButton(context),
            20.ph
          ],
        ),
      ),
    );
  }

  Widget buildButton(BuildContext context) {
    return MyButton(
      title: 'Add Address',
      isBorderButton: true,
      onPressed: () {
        context.pushNamed(RouteNames().addNewAddress);

        context.pop();
      },
    );
  }

  Widget buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Heading(title: 'Choose from saved addresses'),
        IconButton(
            onPressed: () {
              GoRouter.of(context).pop();
            },
            icon: Icon(
              Icons.close,
              color: ColorManager.greyColor,
            ))
      ],
    );
  }

  Widget buildAddressList(AddressesLoadedState addressesState,
      Address? selectedAddress, WidgetRef ref) {
    return ListView.separated(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      separatorBuilder: ((context, index) => 18.ph),
      itemCount: addressesState.addressModel.addresses!.length,
      itemBuilder: (BuildContext context, int index) {
        Address adddress = addressesState.addressModel.addresses![index];

        return Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: ColorManager.greyColor)),
          child: ListTile(
              isThreeLine: true,
              trailing: IconButton(
                onPressed: () {
                  context.pop();
                  context.pushNamed(RouteNames().updateAddress,
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
              title: Text(adddress.addressName.toString()),
              subtitle: Text(
                adddress.googleMapAddress.toString(),
                maxLines: 2,
              ),
              onTap: () {
                ref
                    .read(selectedAddressProvider.notifier)
                    .onAddressTap(adddress);
                context.pop();

                if (servicesModel?.serviceName.toString() == 'Blankets') {
                  log(servicesModel!.deliveryFee.toString());

                  GoRouter.of(context)
                      .pushNamed(RouteNames().laundries, extra: servicesModel);

                  context.pop();
                } else if (servicesModel?.serviceName.toString() == "Carpets") {
                  log(servicesModel!.deliveryFee.toString());

                  GoRouter.of(context)
                      .pushNamed(RouteNames().laundries, extra: servicesModel);

                  context.pop();
                } else if (servicesModel?.serviceName.toString() == "Clothes") {
                  log(servicesModel!.id.toString());
                  log(servicesModel!.deliveryFee.toString());

                  GoRouter.of(context)
                      .pushNamed(RouteNames().laundries, extra: servicesModel);
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
  }
}
