// To parse this JSON data, do
//
//     final tokenModel = tokenModelFromJson(jsonString);

import 'dart:convert';

TokenModel tokenModelFromJson(String str) =>
    TokenModel.fromJson(json.decode(str));

String tokenModelToJson(TokenModel data) => json.encode(data.toJson());

class TokenModel {
  bool? success;
  List<String>? tokens;

  TokenModel({
    this.success,
    this.tokens,
  });

  TokenModel copyWith({
    bool? success,
    List<String>? tokens,
  }) =>
      TokenModel(
        success: success ?? this.success,
        tokens: tokens ?? this.tokens,
      );

  factory TokenModel.fromJson(Map<String, dynamic> json) => TokenModel(
        success: json["success"],
        tokens: json["tokens"] == null
            ? []
            : List<String>.from(json["tokens"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "tokens":
            tokens == null ? [] : List<dynamic>.from(tokens!.map((x) => x)),
      };
}
