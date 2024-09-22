import 'package:flutter/material.dart';
import 'package:laundryday/services/resources/colors.dart';
import 'package:laundryday/services/resources/sized_box.dart';
import 'package:laundryday/services/resources/value_manager.dart';
import 'package:laundryday/config/theme/styles_manager.dart';

class AttentionWidget extends StatelessWidget {
  final String message;
  final void Function()? onTap;
  AttentionWidget({super.key, required this.message, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.amber.withOpacity(0.1),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppPadding.p8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              10.ph,
              Row(
                children: [
                  Expanded(
                    child: Text(
                      message,
                      style: getSemiBoldStyle(
                          color: ColorManager.blackColor, fontSize: 10),
                    ),
                  ),
                  Icon(
                    Icons.info,
                    color: Colors.amber.shade600,
                  ),
                ],
              ),
              10.ph,
            ],
          ),
        ),
      ),
    );
  }
}
