import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laundryday/models/google_distance_matrix_model.dart';

final distanceDetailProvider =
    StateProvider<DistanceMatrixResponse?>((ref) => null);
