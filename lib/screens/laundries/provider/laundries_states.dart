import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

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

  Map<String, dynamic> toMap() {
    return {
      'index': index,
      'serviceTypesList': serviceTypesList.map((x) => x.toMap()).toList(),
    };
  }

  factory LaundriesStates.fromMap(Map<String, dynamic> map) {
    return LaundriesStates(
      index: map['index']?.toInt(),
      serviceTypesList: List<ServicesTimingModel>.from(
          map['serviceTypesList']?.map((x) => ServicesTimingModel.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory LaundriesStates.fromJson(String source) =>
      LaundriesStates.fromMap(json.decode(source));

  @override
  String toString() =>
      'LaundriesStates(index: $index, serviceTypesList: $serviceTypesList)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is LaundriesStates &&
        other.index == index &&
        listEquals(other.serviceTypesList, serviceTypesList);
  }

  @override
  int get hashCode => index.hashCode ^ serviceTypesList.hashCode;
}
