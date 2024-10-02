import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:laundryday/config/routes/route_names.dart';
import 'package:laundryday/config/theme/styles_manager.dart';
import 'package:laundryday/resources/api_routes.dart';
import 'package:laundryday/resources/colors.dart';
import 'package:laundryday/resources/sized_box.dart';
import 'package:laundryday/screens/laundries/model/services_timings_model.dart';
import 'package:laundryday/screens/laundries/provider/laundries_notifier.dart';
import 'package:laundryday/screens/services/provider/services_notifier.dart';
import 'package:laundryday/widgets/custom_cache_netowork_image.dart';
import 'package:laundryday/screens/services/model/services_model.dart'
    as servicemodel;
import 'package:laundryday/widgets/my_loader.dart';

class ServiceTimingDialog extends ConsumerWidget {
  const ServiceTimingDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final serviceTimings = ref.watch(serviceTimingProvider);
    final service = ref.read(serviceProvider).selectedService;

    return serviceTimings.when(data: (data) {
      return data.fold((l) {
        return Text(l.toLowerCase());
      }, (r) {
        return _buildServiceTimingList(
            ref: ref,
            serviceTimingList: r.data!,
            context: context,
            service: service!);
      });
    }, error: (e, s) {
      return Text(e.toString());
    }, loading: () {
      return Loader();
    });
  }

  Widget _buildServiceTimingList(
      {required WidgetRef ref,
      required List<Datum> serviceTimingList,
      required BuildContext context,
      required servicemodel.Datum service}) {

    return Column(
      children: List.generate(serviceTimingList.length, (int index) {
        var serviceTiming = serviceTimingList[index];

        return GestureDetector(
          onTap: () async {
            ref
                .read(laundriessProvider.notifier)
                .selectedServiceTiming(serviceTiming: serviceTiming);

            if (service.serviceName!.toLowerCase() == 'clothes') {
              
              context.pushNamed(RouteNames.laundryItems, extra: service);
              context.pop();
            }

            if (service.serviceName!.toLowerCase() == 'blankets') {
              context.pushNamed(RouteNames.laundryItems, extra: service);
              context.pop();
            }

            if (service.serviceName!.toLowerCase() == 'carpets') {
              context.pushNamed(RouteNames.laundryItems, extra: service);
              context.pop();
            }
          },
          child: SizedBox(
            width: 200,
            child: Card(
              color: ColorManager.purpleColorOpacity10,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      10.ph,
                      CustomCacheNetworkImage(
                          imageUrl: "${Api.imageUrl}${serviceTiming.image}",
                          height: 60),
                      10.ph,
                      Text(
                        serviceTiming.name!,
                        style: getSemiBoldStyle(color: ColorManager.blackColor),
                      ),
                      10.ph,
                      Text(
                        textAlign: TextAlign.center,
                        serviceTiming.description!,
                        style: getRegularStyle(color: ColorManager.blackColor),
                      ),
                      10.ph,
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
