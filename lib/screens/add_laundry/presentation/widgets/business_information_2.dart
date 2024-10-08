import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:laundryday/helpers/validation_helper.dart';
import 'package:laundryday/screens/add_laundry/presentation/provider/add_laundry_notifier.dart';
import 'package:laundryday/screens/add_laundry/presentation/provider/add_laundry_states.dart';
import 'package:laundryday/resources/colors.dart';
import 'package:laundryday/resources/sized_box.dart';
import 'package:laundryday/resources/value_manager.dart';
import 'package:laundryday/config/theme/styles_manager.dart';
import 'package:laundryday/widgets/heading.dart';
import 'package:laundryday/widgets/my_textform_field.dart';

GlobalKey<FormState> businessInformation2Formkey = GlobalKey<FormState>();

Widget businessInformation2Widget(BuildContext context,
    AddLaundryNotifier laundryNotifier, AddLaundryStates states) {
  var image = states.image;
  return Form(
    key: businessInformation2Formkey,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Heading(title: 'Documents'),
        8.ph,
        MyTextFormField(
          textInputType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly,
          ],
          validator: AppValidator.emptyStringValidator,
          hintText: 'Branches',
          labelText: 'Branches',
          controller: laundryNotifier.branchesController,
        ),
        8.ph,
        MyTextFormField(
          textInputType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly,
          ],
          validator: AppValidator.emptyStringValidator,
          hintText: '8477474747474747727',
          labelText: 'Tax Number',
          controller: laundryNotifier.taxNumberController,
        ),
        8.ph,
        MyTextFormField(
          textInputType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly,
          ],
          validator: AppValidator.emptyStringValidator,
          hintText: '8477474747474747727',
          labelText: 'Commercial registration no.',
          controller: laundryNotifier.commercialRegoNoController,
        ),
        8.ph,
        Card(
          color: ColorManager.whiteColor,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppPadding.p16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                20.ph,
                Heading(title: 'Commercial Registration Image'),
                20.ph,
                Card(
                  color: ColorManager.silverWhite,
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        10.ph,
                        image == null
                            ? Icon(
                                Icons.receipt,
                                size: 100,
                              )
                            : Image.file(
                                fit: BoxFit.contain,
                                height: 100,
                                File(image.path.toString())),
                        10.ph,
                        TextButton(
                            onPressed: () {
                              laundryNotifier.pickImage(
                                  imageSource: ImageSource.gallery);
                            },
                            child: Text(
                              'Add Image',
                              style: getMediumStyle(
                                  color: ColorManager.blackColor),
                            )),
                        10.ph,
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        8.ph,
      ],
    ),
  );
}
