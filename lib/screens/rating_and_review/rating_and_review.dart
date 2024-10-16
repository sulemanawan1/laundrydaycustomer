import 'dart:developer';
import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laundryday/config/theme/styles_manager.dart';
import 'package:laundryday/helpers/validation_helper.dart';
import 'package:laundryday/resources/assets_manager.dart';
import 'package:laundryday/resources/font_manager.dart';
import 'package:laundryday/resources/colors.dart';
import 'package:laundryday/resources/sized_box.dart';
import 'package:laundryday/resources/value_manager.dart';
import 'package:laundryday/screens/rating_and_review/provider/rating_and_review_notifier.dart';
import 'package:laundryday/widgets/my_app_bar.dart';
import 'package:laundryday/widgets/my_button.dart';

class RatingAndReview extends ConsumerWidget {
  const RatingAndReview({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final branchRating = ref.watch(ratingAndReviewProvider).branchRating;
    final agentRating = ref.watch(ratingAndReviewProvider).agentRating;
    final controller = ref.watch(ratingAndReviewProvider.notifier);
    final branchreviewImages =
        ref.watch(ratingAndReviewProvider).branchreviewImages;

    return Scaffold(
      backgroundColor: ColorManager.silverWhite,
      appBar: MyAppBar(
        title: 'Add raing & review',
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              50.ph,
              Container(
                alignment: Alignment.center,
                width: 400,
                child: Stack(
                  clipBehavior: Clip.none,
                  alignment: AlignmentDirectional.topCenter,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: AppPadding.p10),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: ColorManager.whiteColor,
                          borderRadius: BorderRadius.circular(AppSize.s8)),
                      child: Column(
                        children: [
                          40.ph,
                          Text(
                            "How was your service from Laundry?",
                            style: getSemiBoldStyle(
                                color: ColorManager.blackColor,
                                fontSize: FontSize.s16),
                          ),
                          10.ph,
                          Text(
                            "Total Rating",
                            style: getSemiBoldStyle(
                                color: ColorManager.blackColor,
                                fontSize: FontSize.s14),
                          ),
                          10.ph,
                          RatingBar(
                            onRatingUpdate: (rating) {
                              ref
                                  .read(ratingAndReviewProvider.notifier)
                                  .selectBranchRating(rating: rating);
                            },
                            ignoreGestures: false,
                            initialRating: 0.0,
                            itemSize: 38,
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
                              empty: Icon(
                                Icons.star,
                                color: ColorManager.silverWhite,
                              ),
                            ),
                            itemPadding:
                                const EdgeInsets.symmetric(horizontal: 4.0),
                          ),
                          20.ph,
                          TextFormField(
                            maxLines: 4,
                            maxLength: 100,
                            controller: controller.branchReview,
                            validator: AppValidator.emptyStringValidator,
                            decoration: InputDecoration(
                                fillColor: ColorManager.silverWhite,
                                filled: true,
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: ColorManager.tranparentColor),
                                    borderRadius: BorderRadius.circular(8)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: ColorManager.tranparentColor),
                                    borderRadius: BorderRadius.circular(8)),
                                hintText:
                                    '(Required) Please tell us what went wrong.',
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: ColorManager.tranparentColor),
                                    borderRadius: BorderRadius.circular(8))),
                          ),
                          20.ph,
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                GestureDetector(
                                  onTap: () async {
                                    if (branchreviewImages.length >= 9) {
                                      BotToast.showNotification(
                                          leading: (le) => Icon(Icons.info),
                                          backgroundColor:
                                              ColorManager.redColor,
                                          title: (t) => Text(
                                                'You can select up to 9 Images.',
                                                style: getRegularStyle(
                                                    color:
                                                        ColorManager.whiteColor,
                                                    fontSize: FontSize.s14),
                                              ));
                                    } else {
                                      ref
                                          .read(
                                              ratingAndReviewProvider.notifier)
                                          .selectBranchReviewImages();
                                    }
                                  },
                                  child: Container(
                                    width: 80,
                                    height: 80,
                                    padding: EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: ColorManager.silverWhite),
                                    child: Center(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(Icons.add_a_photo),
                                          5.ph,
                                          Text(
                                            textAlign: TextAlign.center,
                                            'Add a picture',
                                            style: getRegularStyle(
                                                color: ColorManager.blackColor,
                                                fontSize: FontSize.s8),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                if (branchreviewImages.isNotEmpty) ...[
                                  for (int i = 0;
                                      i < branchreviewImages.length;
                                      i++)
                                    Center(
                                      child: Container(
                                        child: Stack(
                                          alignment: Alignment.topRight,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Container(
                                                width: 80,
                                                height: 80,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                    color: ColorManager
                                                        .silverWhite),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Stack(
                                                    children: [
                                                      Image.file(File(
                                                          branchreviewImages[i]!
                                                              .path)),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            IconButton(
                                                onPressed: () {
                                                  ref
                                                      .read(
                                                          ratingAndReviewProvider
                                                              .notifier)
                                                      .removeBranchImage(
                                                          path:
                                                              branchreviewImages[
                                                                      i]!
                                                                  .path);
                                                },
                                                icon: Icon(Icons.close)),
                                          ],
                                        ),
                                      ),
                                    )
                                ]
                              ],
                            ),
                          ),
                          20.ph,
                          Text(branchreviewImages.length.toString())
                        ],
                      ),
                    ),
                    Positioned(
                      top: -30,
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black
                                    .withOpacity(0.2), // Shadow color
                                spreadRadius: 0.2, // How wide the shadow is
                                blurRadius: 10, // How soft the shadow is
                                offset: Offset(0, 5), // X and Y offset
                              ),
                            ],
                            color: ColorManager.silverWhite,
                            borderRadius: BorderRadius.circular(8)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset(
                            AssetImages.laundry,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              MyButton(
                title: 'Rate',
                onPressed: () {
                  log(branchRating.toString());
                  // context.pop();
                },
              ),
              40.ph,
            ],
          ),
        ),
      ),
    );
  }
}
