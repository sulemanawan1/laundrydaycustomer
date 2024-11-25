import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:laundryday/constants/assets_manager.dart';
import 'package:laundryday/constants/colors.dart';
import 'package:laundryday/constants/font_manager.dart';
import 'package:laundryday/constants/sized_box.dart';
import 'package:laundryday/constants/value_manager.dart';
import 'package:laundryday/config/routes/route_names.dart';
import 'package:laundryday/screens/order_review/data/models/order_model.dart'
    as ordermodel;
import '../../../config/theme/styles_manager.dart';

class InvoiceAndPaymentButton extends StatelessWidget {
  const InvoiceAndPaymentButton({
    super.key,
    required this.orderModel,
  });

  final ordermodel.OrderModel orderModel;

  @override
  Widget build(BuildContext context) {
    return 
    GestureDetector(
      onTap: () {
        context.pushNamed(RouteNames.orderCheckout, extra: orderModel);
      },
      child: Container(
        child: Padding(
          padding: const EdgeInsets.only(
              left: AppPadding.p20, top: AppPadding.p12, bottom: AppPadding.p9),
          child: Row(
            children: [
              Text(
                'Invoice and Payments',
                style: getRegularStyle(
                    fontSize: FontSize.s16, color: ColorManager.whiteColor),
              ),
              Spacer(),
              Image.asset(
                AssetImages.forward,
                height: AppSize.s18,
                color: ColorManager.whiteColor,
              ),
              13.pw
            ],
          ),
        ),
        width: MediaQuery.sizeOf(context).width * 0.85,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppSize.s8),
            color: ColorManager.nprimaryColor),
      ),
    );
 
 
  }
}
