import 'package:flutter/material.dart';
import 'package:laundryday/constants/colors.dart';
import 'package:laundryday/constants/font_manager.dart';
import 'package:laundryday/config/theme/styles_manager.dart';

// ignore: must_be_immutable
class ReusableDropMenu<T> extends StatelessWidget {
  Widget? leadingIcon;
  String label;
  T? initialSelection;
  TextEditingController? controller;
  final void Function(T?)? onSelected;
  List<DropdownMenuEntry<T>> list;
  ReusableDropMenu(
      {super.key,
      this.leadingIcon,
      this.initialSelection,
      required this.label,
      required this.list,
      this.controller,
      required this.onSelected});

  @override
  Widget build(BuildContext context) {
    return DropdownMenu<T>(
        expandedInsets: EdgeInsets.symmetric(horizontal: 20),
        initialSelection: initialSelection,
        controller: controller,
        width: MediaQuery.of(context).size.width,
        leadingIcon: leadingIcon,
        inputDecorationTheme: InputDecorationTheme(
          errorStyle: getMediumStyle(
              color: ColorManager.redColor, fontSize: FontSize.s8),
          labelStyle: getMediumStyle(
              color: ColorManager.blackColor, fontSize: FontSize.s11),
          hintStyle: getSemiBoldStyle(
              color: ColorManager.blackColor, fontSize: FontSize.s11),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide:
                BorderSide(color: ColorManager.primaryColor, width: 1.5),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(color: Color(0xffEEEEEE), width: 1.5),
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
          constraints: const BoxConstraints(maxHeight: 40, minHeight: 40),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        label: Text(label),
        textStyle: getMediumStyle(
            color: ColorManager.blackColor, fontSize: FontSize.s11),
        menuStyle: MenuStyle(
            backgroundColor: WidgetStateColor.resolveWith(
                (states) => ColorManager.whiteColor)),
        onSelected: onSelected,
        dropdownMenuEntries: list);
  }
}
