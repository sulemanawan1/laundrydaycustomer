import 'package:flutter/material.dart';
import 'package:laundryday/screens/auth/signup/signup.dart';
import 'package:laundryday/utils/utils.dart';
import 'package:laundryday/utils/sized_box.dart';
import 'package:laundryday/utils/value_manager.dart';
import 'package:laundryday/widgets/my_app_bar.dart';
import 'package:laundryday/widgets/my_button.dart';
import 'package:laundryday/widgets/heading.dart';
import 'package:laundryday/widgets/my_textform_field.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: 'Edit Profile'),
      body: Column(
        children: [
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppPadding.p10),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Heading(title: 'Profile Information'),
              10.ph,
              HeadingMedium(title: 'Full Name'),
              10.ph,
              MyTextFormField(hintText: 'Full Name', labelText: ''),
              10.ph,
              MyButton(
                title: 'Update Profile',
                onPressed: () {
                  Utils.showToast(msg: 'Profile Updaed');
                },
              ),
              40.ph,
            ]),
          ),
        ],
      ),
    );
  }
}
