import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laundryday/models/address_model.dart';
import 'package:laundryday/screens/services/components/customer_on_going_order_card.dart';
import 'package:laundryday/screens/services/components/services_shimmer_effect.dart';
import 'package:laundryday/screens/services/components/services_card.dart';
import 'package:laundryday/screens/services/model/services_model.dart';
import 'package:laundryday/services/google_service.dart';
import 'package:laundryday/widgets/my_loader.dart';
import 'package:laundryday/screens/services/components/address_bottom_sheet_widget.dart';
import 'package:laundryday/screens/services/model/customer_order_model.dart';
import 'package:laundryday/screens/services/provider/addresses_notifier.dart';
import 'package:laundryday/screens/services/provider/services_notifier.dart';
import 'package:laundryday/resources/colors.dart';
import 'package:laundryday/resources/sized_box.dart';
import 'package:laundryday/screens/more/addresses/my_addresses/model/my_addresses_model.dart'
    as myaddressmodel;
import 'package:laundryday/resources/value_manager.dart';
import 'package:laundryday/config/theme/styles_manager.dart';

class Services extends ConsumerStatefulWidget {
  const Services({super.key});

  @override
  ConsumerState<Services> createState() => _ServicesState();
}

class _ServicesState extends ConsumerState<Services> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final customerOrders = ref.watch(customerOrderProvider);
    final services = ref.watch(servicesProvider);
    myaddressmodel.Address? selectedAddress =
        ref.watch(selectedAddressProvider);

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: ColorManager.primaryColor, size: 24),
        elevation: 0,
        backgroundColor: const Color.fromRGBO(241, 240, 245, 1),
        leadingWidth: MediaQuery.of(context).size.width * .8,
        leading: GestureDetector(
          onTap: () {
            showModalBottomSheet<void>(
              useSafeArea: true,
              isDismissible: false,
              isScrollControlled: true,
              context: context,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8))),
              builder: (BuildContext context) {
                return const AddressBottomSheetWidget();
              },
            );
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: ColorManager.whiteColor,
                    borderRadius: BorderRadius.circular(8)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      3.ph,
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Delivered to",
                                style: getMediumStyle(
                                    color: ColorManager.blackColor)),
                            const Icon(
                              Icons.keyboard_arrow_down,
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        child: Text(
                          selectedAddress?.addressDetail == 'my-current-address'
                              ? 'Current Location'
                              : selectedAddress?.googleMapAddress ??
                                  "Current Location",
                          overflow: TextOverflow.ellipsis,
                          style: getRegularStyle(
                            fontSize: 13,
                            color: selectedAddress?.addressDetail ==
                                    'my-current-address'
                                ? ColorManager.amber
                                : ColorManager.blackColor,
                          ),
                        ),
                      ),
                      3.ph,
                    ],
                  ),
                )),
          ),
        ),
        actions: [
          10.pw,
          GestureDetector(
            onTap: () {},
            child: Container(
              width: 50,
              decoration: BoxDecoration(
                  color: ColorManager.whiteColor,
                  borderRadius: BorderRadius.circular(8)),
              child: const Center(
                child: Icon(
                  Icons.notifications_outlined,
                ),
              ),
            ),
          ),
          10.pw,
        ],
      ),
      body: RefreshIndicator(
        color: ColorManager.nprimaryColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppPadding.p10),
          child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Cutomer on going Orders
                    customerOrders.when(
                        data: (data) {
                          return data.fold((l) {
                            return Text(l);
                          }, (r) {
                            List<Order> orders = r.order!;
                            return CustomerOnGoingOrderCard(orders: orders);
                          });
                        },
                        error: (e, err) => Text(e.toString()),
                        loading: () => Loader()),

                    // Services
                    services.when(
                        data: (data) {
                          return data.fold((l) {
                            return ServiceShimmerEffect();
                          }, (r) {
                            List<Datum>? serviceModel = r.data;
                            return ServicesCard(serviceModel: serviceModel);
                          });
                        },
                        error: (e, err) => ServiceShimmerEffect(),
                        loading: () => ServiceShimmerEffect())
                  ])),
        ),
        onRefresh: () => Future.wait([
          ref.refresh(servicesProvider.future),
          ref.refresh(customerOrderProvider.future)
        ]),
      ),
    );
  }
}
