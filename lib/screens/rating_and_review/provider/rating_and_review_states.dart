import 'package:image_picker/image_picker.dart';

class RatingAndReviewStates {
  double? branchRating;
  double? agentRating;
  List<XFile?> branchreviewImages;
  RatingAndReviewStates({
    this.branchRating,
   required this.branchreviewImages,
    this.agentRating,
  });

  RatingAndReviewStates copyWith({
    double? branchRating,
    double? agentRating,  List<XFile?>? branchreviewImages,
  }) {
    return RatingAndReviewStates(
      branchreviewImages: branchreviewImages??this.branchreviewImages,
      branchRating: branchRating ?? this.branchRating,
      agentRating: agentRating ?? this.agentRating,
    );
  }
}
