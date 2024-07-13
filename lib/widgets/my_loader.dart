import 'package:flutter/material.dart';
import 'package:laundryday/utils/constants/colors.dart';

class Loader extends StatelessWidget {
  const Loader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(child: CircularProgressIndicator(color: ColorManager. primaryColor,)),
      ],
    );
  }
}
