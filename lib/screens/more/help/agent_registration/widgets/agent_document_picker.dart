import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:laundryday/config/theme/styles_manager.dart';
import 'package:laundryday/constants/colors.dart';

class AgentDocumentPicker extends StatelessWidget {

 final void Function()? onTap;

 final XFile? imageFile;

 final String? title;

   AgentDocumentPicker({super.key,this.imageFile,this.title,this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title ?? "",
            style: getSemiBoldStyle(
                fontSize: 14,
                color: imageFile?.path == null
                    ? Colors.blue
                    : ColorManager.primaryColor),
          ),
          Icon(
            imageFile?.path == null ? Icons.upload : Icons.check,
            color: imageFile?.path == null
                ? ColorManager.greyColor
                : ColorManager.primaryColor,
          )
        ],
      ),
    );
    ;
  }
}
