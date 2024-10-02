import 'dart:convert';

class ItemSize {
  int prefixLength;
  int postfixLength;
  int prefixWidth;
  int postfixWidth;
  ItemSize({
    required this.prefixLength,
    required this.postfixLength,
    required this.prefixWidth,
    required this.postfixWidth,
  });

  ItemSize copyWith({
    int? prefixLength,
    int? postfixLength,
    int? prefixWidth,
    int? postfixWidth,
  }) {
    return ItemSize(
      prefixLength: prefixLength ?? this.prefixLength,
      postfixLength: postfixLength ?? this.postfixLength,
      prefixWidth: prefixWidth ?? this.prefixWidth,
      postfixWidth: postfixWidth ?? this.postfixWidth,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'prefixLength': prefixLength,
      'postfixLength': postfixLength,
      'prefixWidth': prefixWidth,
      'postfixWidth': postfixWidth,
    };
  }

  factory ItemSize.fromMap(Map<String, dynamic> map) {
    return ItemSize(
      prefixLength: map['prefixLength']?.toInt() ?? 0,
      postfixLength: map['postfixLength']?.toInt() ?? 0,
      prefixWidth: map['prefixWidth']?.toInt() ?? 0,
      postfixWidth: map['postfixWidth']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory ItemSize.fromJson(String source) =>
      ItemSize.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ItemSize(prefixLength: $prefixLength, postfixLength: $postfixLength, prefixWidth: $prefixWidth, postfixWidth: $postfixWidth)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ItemSize &&
        other.prefixLength == prefixLength &&
        other.postfixLength == postfixLength &&
        other.prefixWidth == prefixWidth &&
        other.postfixWidth == postfixWidth;
  }

  @override
  int get hashCode {
    return prefixLength.hashCode ^
        postfixLength.hashCode ^
        prefixWidth.hashCode ^
        postfixWidth.hashCode;
  }
}
