import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laundryday/utils/colors.dart';

class TypeWidget extends StatelessWidget {
  const TypeWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownMenu(
        inputDecorationTheme: InputDecorationTheme(
          errorStyle: GoogleFonts.poppins(
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w400,
            fontSize: 10,
          ),
          labelStyle: GoogleFonts.poppins(
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w400,
              fontSize: 15,
              color: const Color(0xff555555)),
          hintStyle: const TextStyle(
            fontWeight: FontWeight.w400,
            color: Color(0xff555555),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide:
                BorderSide(color: ColorManager.primaryColor, width: 1.5),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide:
                const BorderSide(color: Color(0xffEEEEEE), width: 1.5),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(color: Colors.red, width: 1.5),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide:
                BorderSide(color: ColorManager.primaryColor, width: 1.0),
          ),
          fillColor: ColorManager.whiteColor,
          filled: true,
          isDense: true,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
          constraints: const BoxConstraints(maxHeight: 44, minHeight: 44),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        width: MediaQuery.of(context).size.width * 0.9,
        hintText: 'Select the Type',
        label: const Text('Type'),
        textStyle: GoogleFonts.poppins(
          fontWeight: FontWeight.w500,
          fontSize: 15,
        ),
        menuStyle: MenuStyle(
            backgroundColor: MaterialStateColor.resolveWith(
                (states) => ColorManager.whiteColor)),
        onSelected: (val) {},
        dropdownMenuEntries: const [
          DropdownMenuEntry(value: 'Laundry', label: 'Laundry'),
          DropdownMenuEntry(
              value: 'Central Laundry', label: 'Central Laundry')
        ]);
  }
}
