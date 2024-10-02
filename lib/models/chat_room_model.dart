import 'dart:convert';

import 'package:flutter/foundation.dart';

class ChatRoomModel {
  String? chatRoomId;
  Map<String, dynamic>? participents;
  String? lastMessage;
  ChatRoomModel({
    this.chatRoomId,
    this.participents,
    this.lastMessage,
  });

  ChatRoomModel copyWith({
    ValueGetter<String?>? chatRoomId,
    ValueGetter<Map<String, dynamic>?>? participents,
    ValueGetter<String?>? lastMessage,
  }) {
    return ChatRoomModel(
      chatRoomId: chatRoomId != null ? chatRoomId() : this.chatRoomId,
      participents: participents != null ? participents() : this.participents,
      lastMessage: lastMessage != null ? lastMessage() : this.lastMessage,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'chatRoomId': chatRoomId,
      'participents': participents,
      'lastMessage': lastMessage,
    };
  }

  factory ChatRoomModel.fromMap(Map<String, dynamic> map) {
    return ChatRoomModel(
      chatRoomId: map['chatRoomId'],
      participents: Map<String, dynamic>.from(map['participents']),
      lastMessage: map['lastMessage'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ChatRoomModel.fromJson(String source) =>
      ChatRoomModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'ChatRoomModel(chatRoomId: $chatRoomId, participents: $participents, lastMessage: $lastMessage)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ChatRoomModel &&
        other.chatRoomId == chatRoomId &&
        mapEquals(other.participents, participents) &&
        other.lastMessage == lastMessage;
  }

  @override
  int get hashCode =>
      chatRoomId.hashCode ^ participents.hashCode ^ lastMessage.hashCode;
}
