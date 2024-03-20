import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laundryday/Widgets/my_heading/heading.dart';
import 'package:laundryday/app_services/api_services.dart';
import 'package:laundryday/models/laundry_model.dart';
import 'package:laundryday/models/services_model.dart';
import 'package:laundryday/screens/delivery_pickup/view/delivery_pickup.dart';
import 'package:laundryday/utils/colors.dart';
import 'package:laundryday/utils/routes/route_names.dart';
import 'package:laundryday/utils/sized_box.dart';
import 'package:laundryday/utils/utils.dart';
import 'package:laundryday/utils/value_manager.dart';
import 'package:laundryday/widgets/my_app_bar/my_app_bar.dart';
import 'package:laundryday/widgets/my_button/my_button.dart';
import 'package:laundryday/widgets/my_loader/my_loader.dart';
import 'package:laundryday/widgets/reusable_laundry_tile.dart/reuseable_laundry_tile.dart';
import 'package:laundryday/widgets/reusable_order_now_card.dart';

final laundriesApiProvider = Provider<ApiServices>((ref) => ApiServices());

final laundriesProvider =
    FutureProvider.family<List<LaundryModel>, int>((ref, serviceId) {
  return ref.read(laundriesApiProvider).getAllLaundries(serviceId: serviceId);
});

// ignore: must_be_immutable
class BlanketAndLinenServiceDetail extends ConsumerStatefulWidget {
  ServicesModel? services;

  BlanketAndLinenServiceDetail({super.key, required this.services});

  @override
  ConsumerState<BlanketAndLinenServiceDetail> createState() =>
      _BlanketAndLinenServiceDetailState();
}

class _BlanketAndLinenServiceDetailState
    extends ConsumerState<BlanketAndLinenServiceDetail> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: widget.services!.name.toString(),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppPadding.p10),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          ReusableOrderNowCard(
            onPressed: () {},
          ),
          10.ph,
          const Heading(text: 'Recieving from the Laundries'),
          10.ph,
          ref.watch(laundriesProvider(widget.services!.id)).when(
              data: (laundries) {
            return Expanded(
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: laundries.length,
                itemBuilder: (BuildContext context, int index) {
                  return ResuableLaundryTile(
                    onTap: () {
                      if (laundries[index].status == 'closed') {
                        Utils.showResuableBottomSheet(
                            context: context,
                            widget: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                10.ph,
                                Text(
                                  '${laundries[index].name} is currently closed.',
                                  style: GoogleFonts.poppins(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500),
                                ),
                                5.ph,
                                Text(
                                  'Oops! It look like ${laundries[index].name} is taking a break right now. Please choose another laundry.',
                                  style: GoogleFonts.poppins(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: ColorManager.greyColor),
                                ),
                                10.ph,
                                MyButton(
                                  name: 'Find another Laundry',
                                  onPressed: () {
                                    context.pop();
                                  },
                                ),
                                30.ph,
                              ],
                            ),
                            title: 'Closed');
                      } else {
                        if (laundries[index].type == 'deliverypickup') {
                          GoRouter.of(context)
                              .pushNamed(RouteNames().deliveryPickup,
                                  extra: Arguments(
                                    laundryModel: laundries[index],
                                  ));
                        } else {
                          GoRouter.of(context).pushNamed(
                              RouteNames().blanketsCategory,
                              extra: laundries[index]);
                        }
                      }
                    },
                    laundry: laundries[index],
                  );
                },
              ),
            );
          }, error: (error, stackTrace) {
            return const Loader();
          }, loading: () {
            return const Loader();
          }),
        ]),
      ),
    );
  }
}
