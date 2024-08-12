import 'package:flutter/widgets.dart';
import 'package:laundryday/config/resources/colors.dart';
import 'package:laundryday/config/resources/sized_box.dart';
import 'package:laundryday/config/theme/styles_manager.dart';

class OrderStatusInfoWidget extends StatelessWidget {
  final String image, title, description;


   const OrderStatusInfoWidget({
    super.key,required this.image,
   required this.title,
   required this.description});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
            child: Image.asset(
          image,
          height: 180,
        )),
        10.ph,
        Text(
          title,
          style: getSemiBoldStyle(fontSize: 22, color: ColorManager.blackColor),
        ),
        10.ph,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Text(
            description,
            style: getSemiBoldStyle(
                fontSize: 16,
                color: ColorManager.greyColor),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
