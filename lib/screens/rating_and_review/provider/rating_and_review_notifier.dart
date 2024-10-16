import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:laundryday/screens/rating_and_review/provider/rating_and_review_states.dart';
import 'package:laundryday/services/image_picker_service.dart';

final ratingAndReviewProvider =
    StateNotifierProvider<RatingAndReviewNotifier, RatingAndReviewStates>(
        (ref) => RatingAndReviewNotifier());

class RatingAndReviewNotifier extends StateNotifier<RatingAndReviewStates> {
  RatingAndReviewNotifier()
      : super(RatingAndReviewStates(branchreviewImages: []));

  TextEditingController branchReview = TextEditingController();
  TextEditingController agentReview = TextEditingController();

  selectBranchRating({required double rating}) {
    state = state.copyWith(branchRating: rating);
  }

  selectAgentRating({required double rating}) {
    state = state.copyWith(agentRating: rating);
  }

  selectBranchReviewImages() async {
    List<XFile?> images = await ImagePickerService.pickMultipleImages();

    if (images.isNotEmpty) {
      List<XFile?> img = images.take(9).toList();
      state.branchreviewImages.addAll(img);
      state = state.copyWith(branchreviewImages: state.branchreviewImages);
    }
  }

  removeBranchImage({required String path}) async {
    state.branchreviewImages.removeWhere((e) => e!.path == path);
    state = state.copyWith(branchreviewImages: state.branchreviewImages);
  }
}
