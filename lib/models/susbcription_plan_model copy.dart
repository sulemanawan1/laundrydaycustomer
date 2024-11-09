// To parse this JSON data, do
//
//     final subscriptionPlanModel = subscriptionPlanModelFromJson(jsonString);

import 'dart:convert';

SubscriptionPlanModel subscriptionPlanModelFromJson(String str) =>
    SubscriptionPlanModel.fromJson(json.decode(str));

String subscriptionPlanModelToJson(SubscriptionPlanModel data) =>
    json.encode(data.toJson());

class SubscriptionPlanModel {
  String? message;
  List<Datum>? data;

  SubscriptionPlanModel({
    this.message,
    this.data,
  });

  SubscriptionPlanModel copyWith({
    String? message,
    List<Datum>? data,
  }) =>
      SubscriptionPlanModel(
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory SubscriptionPlanModel.fromJson(Map<String, dynamic> json) =>
      SubscriptionPlanModel(
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  int? id;
  String? name;
  String? arabicName;
  String? hyperPayId;
  double? amount;
  String? type;
  int? durationInMonths;
  String? subscriptionType;
  int? trialDays;
  int? status;
  DateTime? createdAt;
  DateTime? updatedAt;

  Datum({
    this.id,
    this.name,
    this.arabicName,
    this.hyperPayId,
    this.amount,
    this.type,
    this.durationInMonths,
    this.subscriptionType,
    this.trialDays,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  Datum copyWith({
    int? id,
    String? name,
    String? arabicName,
    String? hyperPayId,
    double? amount,
    String? type,
    int? durationInMonths,
    String? subscriptionType,
    int? trialDays,
    int? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      Datum(
        id: id ?? this.id,
        name: name ?? this.name,
        arabicName: arabicName ?? this.arabicName,
        hyperPayId: hyperPayId ?? this.hyperPayId,
        amount: amount ?? this.amount,
        type: type ?? this.type,
        durationInMonths: durationInMonths ?? this.durationInMonths,
        subscriptionType: subscriptionType ?? this.subscriptionType,
        trialDays: trialDays ?? this.trialDays,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"],
        arabicName: json["arabic_name"],
        hyperPayId: json["hyper_pay_id"],
        amount: json["amount"]?.toDouble(),
        type: json["type"],
        durationInMonths: json["duration_in_months"],
        subscriptionType: json["subscription_type"],
        trialDays: json["trial_days"],
        status: json["status"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "arabic_name": arabicName,
        "hyper_pay_id": hyperPayId,
        "amount": amount,
        "type": type,
        "duration_in_months": durationInMonths,
        "subscription_type": subscriptionType,
        "trial_days": trialDays,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
