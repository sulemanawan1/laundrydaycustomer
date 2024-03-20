import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laundryday/Widgets/my_textForm%20_field/my_textform_field.dart';
import 'package:laundryday/utils/colors.dart';
import 'package:laundryday/utils/routes/route_names.dart';
import 'package:laundryday/utils/sized_box.dart';
import 'package:laundryday/utils/value_manager.dart';
import 'package:laundryday/widgets/my_button/my_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:laundryday/widgets/my_heading/heading.dart';

class Signup extends StatelessWidget {
  const Signup({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppPadding.p10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Heading(
            text: "What's your Full Name?",
          ),
          20.ph,
          const HeadingSmall(title: 'Name'),
          10.ph,
          MyTextFormField(
            hintText: 'Enter your Full Name.',
            labelText: '',
            autofillHints: const [AutofillHints.name],
          ),
          20.ph,
          MyButton(
            onPressed: () {
              GoRouter.of(context).pushNamed(RouteNames().home);
            },
            name: AppLocalizations.of(context)!.login,
          ),
          40.ph,
        ],
      ),
    ));
  }
}

// ignore: must_be_immutable
class HeadingMedium extends StatelessWidget {
  final String title;
  Color? color;
  TextAlign? textAlign;

  HeadingMedium({super.key, required this.title, this.color, this.textAlign});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: GoogleFonts.poppins(
          fontWeight: FontWeight.w400,
          fontSize: 15,
          color: color ?? ColorManager.blackColor),
      textAlign: textAlign,
    );
  }
}

class HeadingSmall extends StatelessWidget {
  final String title;

  final Color? color;
  const HeadingSmall({super.key, required this.title, this.color});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textAlign: TextAlign.center,
      style: GoogleFonts.poppins(
        fontWeight: FontWeight.w500,
        fontSize: 13,
        color: color ?? ColorManager.blackColor,
      ),
    );
  }
}

