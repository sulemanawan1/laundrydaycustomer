import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laundryday/screens/auth/signup/signup.dart';
import 'package:laundryday/utils/colors.dart';
import 'package:laundryday/utils/constants/sized_box.dart';
import 'package:laundryday/utils/constants/value_manager.dart';
import 'package:laundryday/utils/routes/route_names.dart';
import 'package:laundryday/widgets/my_app_bar.dart';
import 'package:laundryday/widgets/my_button.dart';
import 'package:laundryday/widgets/heading.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: "Profile",
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppPadding.p10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            30.ph,
            const Heading(title: 'Personal Information'),
            30.ph,
            Row(
              children: [
                Icon(
                  Icons.person_2,
                  color: ColorManager.greyColor,
                ),
                10.pw,
                HeadingMedium(title: "Full Name"),
              ],
            ),
            10.ph,
            Text(
              "Suleman Abrar",
              style: GoogleFonts.poppins(),
            ),
            const Divider(),
            10.ph,
            Row(
              children: [
                Icon(
                  Icons.phone_android,
                  color: ColorManager.greyColor,
                ),
                10.pw,
                HeadingMedium(title: "Mobile Number"),
              ],
            ),
            10.ph,
            Text(
              "+96633247474",
              style: GoogleFonts.poppins(),
            ),
            const Divider(),
            const Spacer(),
            MyButton(
              title: 'Edit Profile',
              onPressed: () {
                GoRouter.of(context).pushNamed(RouteNames().editProfile);
              },
            ),
            40.ph,
          ],
        ),
      ),
    );
  }
}
