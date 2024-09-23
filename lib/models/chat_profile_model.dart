import 'dart:convert';

class ChatProfileModel {
  final String chatRoomId;
  final int receiverId;

  final String firstName;
  final String lastName;
  final String? image;

  ChatProfileModel({
    required this.chatRoomId,
    required this.receiverId,
    required this.firstName,
    required this.lastName,
    this.image,
  });

  ChatProfileModel copyWith({
    String? chatRoomId,
    int? receiverId,
    String? firstName,
    String? lastName,
    String? image,
  }) {
    return ChatProfileModel(
      chatRoomId: chatRoomId ?? this.chatRoomId,
      receiverId: receiverId ?? this.receiverId,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      image: image ?? this.image,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'chatRoomId': chatRoomId,
      'receiverId': receiverId,
      'firstName': firstName,
      'lastName': lastName,
      'image': image,
    };
  }

  factory ChatProfileModel.fromMap(Map<String, dynamic> map) {
    return ChatProfileModel(
      chatRoomId: map['chatRoomId'] ?? '',
      receiverId: map['receiverId']?.toInt() ?? 0,
      firstName: map['firstName'] ?? '',
      lastName: map['lastName'] ?? '',
      image: map['image'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ChatProfileModel.fromJson(String source) =>
      ChatProfileModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ChatProfileModel(chatRoomId: $chatRoomId, receiverId: $receiverId, firstName: $firstName, lastName: $lastName, image: $image)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ChatProfileModel &&
        other.chatRoomId == chatRoomId &&
        other.receiverId == receiverId &&
        other.firstName == firstName &&
        other.lastName == lastName &&
        other.image == image;
  }

  @override
  int get hashCode {
    return chatRoomId.hashCode ^
        receiverId.hashCode ^
        firstName.hashCode ^
        lastName.hashCode ^
        image.hashCode;
  }
}
