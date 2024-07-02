

import 'package:laundryday/screens/laundries/model/services_timings_model.dart';

class LaundriesStates {
  int? index;
  List<ServicesTimingModel> serviceTypesList;
  LaundriesStates({
    this.index,
    required this.serviceTypesList,
  });

  LaundriesStates copyWith({
    int? index,
    List<ServicesTimingModel>? serviceTypesList,
  }) {
    return LaundriesStates(
      index: index ?? this.index,
      serviceTypesList: serviceTypesList ?? this.serviceTypesList,
    );
  }


}
