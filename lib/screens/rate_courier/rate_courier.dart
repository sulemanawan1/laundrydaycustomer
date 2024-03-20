import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:go_router/go_router.dart';
import 'package:laundryday/screens/auth/signup/signup.dart';
import 'package:laundryday/utils/colors.dart';
import 'package:laundryday/utils/sized_box.dart';
import 'package:laundryday/widgets/my_app_bar/my_app_bar.dart';
import 'package:laundryday/widgets/my_button/my_button.dart';
import 'package:laundryday/widgets/my_heading/heading.dart';

class RateCourier extends StatefulWidget {
  const RateCourier({super.key});

  @override
  State<RateCourier> createState() => _RateCourierState();
}

class _RateCourierState extends State<RateCourier> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: 'Rate',
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Heading(text: 'What about your Courier'),
                    CircleAvatar(
                      radius: 24,
                      backgroundImage: AssetImage('assets/icons/user.png'),
                    ),
                  ],
                ),
                10.ph,
                RatingBar(
                  onRatingUpdate: (rating) {},
                  ignoreGestures: false,
                  initialRating: 5.0,
                  direction: Axis.horizontal,
                  allowHalfRating: false,
                  ratingWidget: RatingWidget(
                    full: const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    half: const Icon(
                      Icons.star_half,
                      color: Colors.amber,
                    ),
                    empty:  Icon(
                      Icons.star_border,
                      color: ColorManager. greyColor,
                    ),
                  ),
                  itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                ),
                20.ph,
                HeadingMedium(
                    title: 'if you want leave a comment to the courier.'),
                10.ph,
                TextFormField(
                  maxLines: 3,
                  decoration: InputDecoration(
                    fillColor: ColorManager.whiteColor,
                    filled: true,
                      enabledBorder: OutlineInputBorder(
                          borderSide:  BorderSide(color: ColorManager.greyColor),
                          borderRadius: BorderRadius.circular(8)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8)),
                      hintText: 'Type your review ',
                      border: OutlineInputBorder(
                          borderSide:  BorderSide(color: ColorManager. greyColor),
                          borderRadius: BorderRadius.circular(8))),
                ),
              ],
            ),
            Column(
              children: [
                MyButton(
                  name: 'Rate',
                  onPressed: () {
                    context.pop();
                  },
                ),
                40.ph,
              ],
            ),
          ],
        ),
      ),
    );
  }
}
