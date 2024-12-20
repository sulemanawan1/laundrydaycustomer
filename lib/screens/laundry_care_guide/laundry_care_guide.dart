import 'package:flutter/material.dart';
import 'package:laundryday/constants/sized_box.dart';
import 'package:laundryday/constants/value_manager.dart';
import 'package:laundryday/widgets/my_app_bar.dart';

class LaundryCareGuilde extends StatelessWidget {
  const LaundryCareGuilde({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: MyAppBar(
        title: 'Laundry Care Guide',
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppPadding.p10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [20.ph, Image.asset('assets/laundry_care_guide.JPG')],
        ),
      ),
    );
  }
}
