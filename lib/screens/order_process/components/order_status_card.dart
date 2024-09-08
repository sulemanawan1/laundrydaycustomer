import 'package:flutter/widgets.dart';
import 'package:laundryday/config/resources/colors.dart';
import 'package:laundryday/config/resources/font_manager.dart';
import 'package:laundryday/config/resources/sized_box.dart';
import 'package:laundryday/config/resources/value_manager.dart';
import 'package:laundryday/config/theme/styles_manager.dart';
import 'package:laundryday/helpers/order_helper.dart';
import 'package:laundryday/screens/order_process/view/order_process.dart';
import 'package:laundryday/screens/order_review/data/models/order_model.dart'
    as ordermodel;

class OrderStatuesCard extends StatelessWidget {
  final DateTime? countDownStart;
  final DateTime? countDownEnd;
  final String status;
  final String type;
  final List<ordermodel.OrderStatus>? orderStatuses;

  OrderStatuesCard(
      {super.key,
      this.countDownStart,
      this.countDownEnd,
      this.orderStatuses,
      required this.type,
      required this.status});

  @override
  Widget build(BuildContext context) {
    OrderType orderType = getOrderType(orderType: type);
    return Container(
      width: MediaQuery.sizeOf(context).width * 0.85,
      decoration: BoxDecoration(
          border: Border.all(color: Color(0xffDCE2EF)),
          borderRadius: BorderRadius.circular(AppSize.s6)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppPadding.p11_03),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (orderType == OrderType.pickup) ...[
              17.ph,
              Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: orderStatuses!
                      .where((e) => e.type == 'pickup')
                      .map((e) => (e.status ==
                                      getPickupStatus(
                                          orderStatus:
                                              OrderStatusesList.pending) ||
                                  e.status ==
                                      getPickupStatus(
                                          orderStatus:
                                              OrderStatusesList.accepted)) ||
                              e.status ==
                                  getPickupStatus(
                                      orderStatus:
                                          OrderStatusesList.received) ||
                              e.status ==
                                  getPickupStatus(
                                      orderStatus:
                                          OrderStatusesList.atCustomer) ||
                              e.status ==
                                  getPickupStatus(
                                      orderStatus: OrderStatusesList.delivered)
                          ? Expanded(
                              flex: status == e.status ? 2 : 1,
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(right: AppPadding.p6),
                                child: Container(
                                  height: AppSize.s5,
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(AppSize.s4),
                                      color: status == e.status
                                          ? Color(0xFF7862EB).withOpacity(0.3)
                                          : Color(0xFF7862EB)),
                                ),
                              ),
                            )
                          : Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(right: AppPadding.p6),
                                child: Container(
                                  width: AppSize.s30,
                                  height: AppSize.s5,
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(AppSize.s4),
                                      color: Color(0xFFD9D9D9)),
                                ),
                              ),
                            ))
                      .toList()),
              13.ph,
              Row(
                children: [
                  Expanded(
                    flex: 5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          getPickupOrderStatusMessage(status: status),
                          style: getSemiBoldStyle(
                              color: ColorManager.nprimaryColor,
                              fontSize: FontSize.s16),
                        ),
                        5.ph,
                        Text(
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          getOrderDescription(status: status),
                          style: getlightStyle(
                              color: ColorManager.nlightGreyColor,
                              fontSize: FontSize.s12),
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  if (countDownStart != null && countDownEnd != null) ...[
                    Expanded(
                      child: TimerWidget(
                        countDownEnd: countDownEnd!,
                        countDownStart: countDownStart!,
                      ),
                    )
                  ]
                ],
              ),
              17.ph
            ] else if (orderType == OrderType.roundTrip) ...[
              17.ph,

              // Text(orderStatuses!.map((e) => e.status).toList().toString()),
              Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: orderStatuses!
                      .where((e) => e.type == 'delivery-to-store')
                      .map((e) => (e.status ==
                                      getRoundTripStatus(
                                          orderStatus:
                                              OrderStatusesList.pending) ||
                                  e.status ==
                                      getRoundTripStatus(
                                          orderStatus:
                                              OrderStatusesList.accepted)) ||
                              e.status ==
                                  getRoundTripStatus(
                                      orderStatus: OrderStatusesList
                                          .collectingFromCustomer) ||
                              e.status ==
                                  getRoundTripStatus(
                                      orderStatus: OrderStatusesList.delivered)
                          ? Expanded(
                              flex: status == e.status ? 2 : 1,
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(right: AppPadding.p6),
                                child: Container(
                                  height: AppSize.s5,
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(AppSize.s4),
                                      color: status == e.status
                                          ? Color(0xFF7862EB).withOpacity(0.3)
                                          : Color(0xFF7862EB)),
                                ),
                              ),
                            )
                          : Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(right: AppPadding.p6),
                                child: Container(
                                  width: AppSize.s30,
                                  height: AppSize.s5,
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(AppSize.s4),
                                      color: Color(0xFFD9D9D9)),
                                ),
                              ),
                            ))
                      .toList()),
              13.ph,
              Row(
                children: [
                  Expanded(
                    flex: 5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          getRoundTripOrderStatusMessage(status: status),
                          style: getSemiBoldStyle(
                              color: ColorManager.nprimaryColor,
                              fontSize: FontSize.s16),
                        ),
                        5.ph,
                        Text(
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          getRoundTripOrderDescription(status: status),
                          style: getlightStyle(
                              color: ColorManager.nlightGreyColor,
                              fontSize: FontSize.s12),
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  if (countDownStart != null && countDownEnd != null) ...[
                    Expanded(
                      child: TimerWidget(
                        countDownEnd: countDownEnd!,
                        countDownStart: countDownStart!,
                      ),
                    )
                  ]
                ],
              ),
              17.ph
            ]
          ],
        ),
      ),
    );
  }
}
