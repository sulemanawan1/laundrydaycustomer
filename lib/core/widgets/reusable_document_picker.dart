import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:laundryday/core/constants/colors.dart';

class ResuableDocumentPicker extends StatelessWidget {

final   void Function()? onTap;
final XFile? imageFile;

final String? title;

  const ResuableDocumentPicker({super.key, this.onTap, this.imageFile, this.title});


  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title ?? "",
            style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
                fontSize: 14,
                color: imageFile?.path == null
                    ? ColorManager.blackColor
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
  }
}