// To parse this JSON data, do
//
//     final walletModel = walletModelFromJson(jsonString);

import 'dart:convert';

WalletModel walletModelFromJson(String str) =>
    WalletModel.fromJson(json.decode(str));

String walletModelToJson(WalletModel data) => json.encode(data.toJson());

class WalletModel {
  String? message;
  double? balance;

  WalletModel({
    this.message,
    this.balance,
  });

  WalletModel copyWith({
    String? message,
    double? balance,
  }) =>
      WalletModel(
        message: message ?? this.message,
        balance: balance ?? this.balance,
      );

  factory WalletModel.fromJson(Map<String, dynamic> json) => WalletModel(
        message: json["message"],
        balance: json["balance"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "balance": balance,
      };
}
