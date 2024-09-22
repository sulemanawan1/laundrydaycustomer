import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:laundryday/services/resources/assets_manager.dart';
import 'package:laundryday/services/resources/font_manager.dart';
import 'package:laundryday/services/resources/sized_box.dart';
import 'package:laundryday/services/resources/value_manager.dart';
import 'package:laundryday/config/theme/styles_manager.dart';

class OrderIdButton extends StatelessWidget {
  final int orderId;
  const OrderIdButton({super.key, required this.orderId});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await Clipboard.setData(ClipboardData(text: orderId.toString()));
      },
      child: Container(
        child: Padding(
          padding: const EdgeInsets.only(
              left: AppPadding.p20, top: AppPadding.p12, bottom: AppPadding.p9),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Order Number',
                style: getRegularStyle(
                    fontSize: FontSize.s16, color: Color(0xFF1F2732)),
              ),
              Row(
                children: [
                  Text(
                    orderId.toString(),
                    style: getRegularStyle(
                        fontSize: FontSize.s16, color: Color(0xFF1F2732)),
                  ),
                  7.pw,
                  Image.asset(
                    AssetImages.clipboard,
                    height: AppSize.s18,
                  ),
                  22.92.pw
                ],
              ),
            ],
          ),
        ),
        width: MediaQuery.sizeOf(context).width * 0.85,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppSize.s8),
            color: Color(0xFFF7F7F7)),
      ),
    );
  }
}
