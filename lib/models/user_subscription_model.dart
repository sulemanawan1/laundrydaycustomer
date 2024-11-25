// To parse this JSON data, do
//
//     final userSubscriptionModel = userSubscriptionModelFromJson(jsonString);

import 'dart:convert';

UserSubscriptionModel userSubscriptionModelFromJson(String str) =>
    UserSubscriptionModel.fromJson(json.decode(str));

String userSubscriptionModelToJson(UserSubscriptionModel data) =>
    json.encode(data.toJson());

class UserSubscriptionModel {
  bool? success;
  String? message;
  Data? data;

  UserSubscriptionModel({
    this.success,
    this.message,
    this.data,
  });

  UserSubscriptionModel copyWith({
    bool? success,
    String? message,
    Data? data,
  }) =>
      UserSubscriptionModel(
        success: success ?? this.success,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory UserSubscriptionModel.fromJson(Map<String, dynamic> json) =>
      UserSubscriptionModel(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data?.toJson(),
      };
}

class Data {
  int? id;
  int? userId;
  double? subscriptionPlanAmount;
  String? currency;
  String? type;
  int? durationInMonths;
  DateTime? created;
  DateTime? startTime;
  DateTime? endTime;
  DateTime? trailEnd;
  String? status;
  int? subscriptionPlanId;
  DateTime? cancelledAt;
  DateTime? createdAt;
  DateTime? updatedAt;
  SubscriptionPlan? subscriptionPlan;
  SubscriptionDetail? subscriptionDetail;

  Data({
    this.id,
    this.userId,
    this.subscriptionPlanAmount,
    this.currency,
    this.type,
    this.durationInMonths,
    this.created,
    this.startTime,
    this.endTime,
    this.trailEnd,
    this.status,
    this.subscriptionPlanId,
    this.cancelledAt,
    this.createdAt,
    this.updatedAt,
    this.subscriptionPlan,
    this.subscriptionDetail,
  });

  Data copyWith({
    int? id,
    int? userId,
    double? subscriptionPlanAmount,
    String? currency,
    String? type,
    int? durationInMonths,
    DateTime? created,
    DateTime? startTime,
    DateTime? endTime,
    DateTime? trailEnd,
    String? status,
    int? subscriptionPlanId,
    DateTime? cancelledAt,
    DateTime? createdAt,
    DateTime? updatedAt,
    SubscriptionPlan? subscriptionPlan,
    SubscriptionDetail? subscriptionDetail,
  }) =>
      Data(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        subscriptionPlanAmount:
            subscriptionPlanAmount ?? this.subscriptionPlanAmount,
        currency: currency ?? this.currency,
        type: type ?? this.type,
        durationInMonths: durationInMonths ?? this.durationInMonths,
        created: created ?? this.created,
        startTime: startTime ?? this.startTime,
        endTime: endTime ?? this.endTime,
        trailEnd: trailEnd ?? this.trailEnd,
        status: status ?? this.status,
        subscriptionPlanId: subscriptionPlanId ?? this.subscriptionPlanId,
        cancelledAt: cancelledAt ?? this.cancelledAt,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        subscriptionPlan: subscriptionPlan ?? this.subscriptionPlan,
        subscriptionDetail: subscriptionDetail ?? this.subscriptionDetail,
      );

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        userId: json["user_id"],
        subscriptionPlanAmount: json["subscription_plan_amount"]?.toDouble(),
        currency: json["currency"],
        type: json["type"],
        durationInMonths: json["duration_in_months"],
        created:
            json["created"] == null ? null : DateTime.parse(json["created"]),
        startTime: json["start_time"] == null
            ? null
            : DateTime.parse(json["start_time"]),
        endTime:
            json["end_time"] == null ? null : DateTime.parse(json["end_time"]),
        trailEnd: json["trail_end"] == null
            ? null
            : DateTime.parse(json["trail_end"]),
        status: json["status"],
        subscriptionPlanId: json["subscription_plan_id"],
        cancelledAt: json["cancelled_at"] == null
            ? null
            : DateTime.parse(json["cancelled_at"]),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        subscriptionPlan: json["subscription_plan"] == null
            ? null
            : SubscriptionPlan.fromJson(json["subscription_plan"]),
        subscriptionDetail: json["subscription_detail"] == null
            ? null
            : SubscriptionDetail.fromJson(json["subscription_detail"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "subscription_plan_amount": subscriptionPlanAmount,
        "currency": currency,
        "type": type,
        "duration_in_months": durationInMonths,
        "created": created?.toIso8601String(),
        "start_time": startTime?.toIso8601String(),
        "end_time": endTime?.toIso8601String(),
        "trail_end": trailEnd?.toIso8601String(),
        "status": status,
        "subscription_plan_id": subscriptionPlanId,
        "cancelled_at": cancelledAt?.toIso8601String(),
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "subscription_plan": subscriptionPlan?.toJson(),
        "subscription_detail": subscriptionDetail?.toJson(),
      };
}

class SubscriptionDetail {
  int? userSubscriptionId;
  double? userLat;
  double? userLng;
  dynamic userAddress;
  String? branchName;
  double? branchLat;
  double? branchLng;
  String? branchAddress;
  int? branchEditCount;
  int? totalVisits;
  int? remainingVisits;

  SubscriptionDetail({
    this.userSubscriptionId,
    this.userLat,
    this.userLng,
    this.userAddress,
    this.branchName,
    this.branchLat,
    this.branchLng,
    this.branchAddress,
    this.branchEditCount,
    this.totalVisits,
    this.remainingVisits,
  });

  SubscriptionDetail copyWith({
    int? userSubscriptionId,
    double? userLat,
    double? userLng,
    dynamic userAddress,
    String? branchName,
    double? branchLat,
    double? branchLng,
    String? branchAddress,
    int? branchEditCount,
    int? totalVisits,
    int? remainingVisits,
  }) =>
      SubscriptionDetail(
        userSubscriptionId: userSubscriptionId ?? this.userSubscriptionId,
        userLat: userLat ?? this.userLat,
        userLng: userLng ?? this.userLng,
        userAddress: userAddress ?? this.userAddress,
        branchName: branchName ?? this.branchName,
        branchLat: branchLat ?? this.branchLat,
        branchLng: branchLng ?? this.branchLng,
        branchAddress: branchAddress ?? this.branchAddress,
        branchEditCount: branchEditCount ?? this.branchEditCount,
        totalVisits: totalVisits ?? this.totalVisits,
        remainingVisits: remainingVisits ?? this.remainingVisits,
      );

  factory SubscriptionDetail.fromJson(Map<String, dynamic> json) =>
      SubscriptionDetail(
        userSubscriptionId: json["user_subscription_id"],
        userLat: json["user_lat"]?.toDouble(),
        userLng: json["user_lng"]?.toDouble(),
        userAddress: json["user_address"],
        branchName: json["branch_name"],
        branchLat: json["branch_lat"]?.toDouble(),
        branchLng: json["branch_lng"]?.toDouble(),
        branchAddress: json["branch_address"],
        branchEditCount: json["branch_edit_count"],
        totalVisits: json["total_visits"],
        remainingVisits: json["remaining_visits"],
      );

  Map<String, dynamic> toJson() => {
        "user_subscription_id": userSubscriptionId,
        "user_lat": userLat,
        "user_lng": userLng,
        "user_address": userAddress,
        "branch_name": branchName,
        "branch_lat": branchLat,
        "branch_lng": branchLng,
        "branch_address": branchAddress,
        "branch_edit_count": branchEditCount,
        "total_visits": totalVisits,
        "remaining_visits": remainingVisits,
      };
}

class SubscriptionPlan {
  int? id;
  String? name;
  String? subscriptionType;

  SubscriptionPlan({
    this.id,
    this.name,
    this.subscriptionType,
  });

  SubscriptionPlan copyWith({
    int? id,
    String? name,
    String? subscriptionType,
  }) =>
      SubscriptionPlan(
        id: id ?? this.id,
        name: name ?? this.name,
        subscriptionType: subscriptionType ?? this.subscriptionType,
      );

  factory SubscriptionPlan.fromJson(Map<String, dynamic> json) =>
      SubscriptionPlan(
        id: json["id"],
        name: json["name"],
        subscriptionType: json["subscription_type"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "subscription_type": subscriptionType,
      };
}
