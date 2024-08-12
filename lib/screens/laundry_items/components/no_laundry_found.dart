import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:laundryday/config/resources/colors.dart';
import 'package:laundryday/config/theme/styles_manager.dart';

class NoLaundryFound extends StatelessWidget {
  const NoLaundryFound({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/icons/no_data.png',
              width: 100,
            ),
            Text(
              "No Laundry Found",
              style:
                  getMediumStyle(color: ColorManager.blackColor, fontSize: 14),
            ),
            OutlinedButton(
                onPressed: () {
                  context.pop();
                },
                child: Text(
                  "Go to Home Screen",
                  style: getMediumStyle(color: ColorManager.purpleColor),
                ))
          ],
        ),
      ),
    );
  }
}
