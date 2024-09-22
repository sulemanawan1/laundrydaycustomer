import 'dart:convert';

class ChatModel {
  String? id;
  String? chatRoomId;
  String? senderId;
  String? chatType;
  String? content;
  DateTime? sentAt;
  bool? seen;
  ChatModel({
    this.id,
    this.chatRoomId,
    this.senderId,
    this.chatType,
    this.content,
    this.sentAt,
    this.seen,
  });

  ChatModel copyWith({
    String? id,
    String? chatRoomId,
    String? senderId,
    String? chatType,
    String? contentType,
    DateTime? sentAt,
    bool? seen,
  }) {
    return ChatModel(
      id: id?? this.id,
      chatRoomId: chatRoomId ?? this.chatRoomId,
      senderId: senderId ??this.senderId,
      chatType: chatType ??this.chatType,
      content: content ?? this.content,
      sentAt: sentAt ?? this.sentAt,
      seen: seen ??this.seen,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'chatRoomId': chatRoomId,
      'senderId': senderId,
      'chatType': chatType,
      'content': content,
      'sentAt': sentAt?.millisecondsSinceEpoch,
      'seen': seen,
    };
  }

  factory ChatModel.fromMap(Map<String, dynamic> map) {
    return ChatModel(
      id: map['id'],
      chatRoomId: map['chatRoomId'],
      senderId: map['senderId'],
      chatType: map['chatType'],
      content: map['content'],
      sentAt: map['sentAt'] != null ? DateTime.fromMillisecondsSinceEpoch(map['sentAt']) : null,
      seen: map['seen'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ChatModel.fromJson(String source) => ChatModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ChatModel(id: $id, chatRoomId: $chatRoomId, senderId: $senderId, chatType: $chatType, contentType: $content, sentAt: $sentAt, seen: $seen)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is ChatModel &&
      other.id == id &&
      other.chatRoomId == chatRoomId &&
      other.senderId == senderId &&
      other.chatType == chatType &&
      other.content == content &&
      other.sentAt == sentAt &&
      other.seen == seen;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      chatRoomId.hashCode ^
      senderId.hashCode ^
      chatType.hashCode ^
      content.hashCode ^
      sentAt.hashCode ^
      seen.hashCode;
  }
}
