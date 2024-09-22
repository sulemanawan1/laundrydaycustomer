import 'package:flutter/material.dart';
import 'package:laundryday/services/resources/colors.dart';

class Loader extends StatelessWidget {
  const Loader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
              child: CircularProgressIndicator(
            color: ColorManager.nprimaryColor,
          )),
        ],
      ),
    );
  }
}
