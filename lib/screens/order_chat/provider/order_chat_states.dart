import 'dart:io';

class OrderChatStates {
  File? image;
  bool isRecording;
  bool uploading;
  bool hasText;
  int recordingSeconds;
  File? audioFile;
  List<String> tokens;

  OrderChatStates(
      {this.image,
      required this.hasText,
      required this.tokens,
      required this.uploading,
      required this.recordingSeconds,
      required this.isRecording,
      this.audioFile});

  OrderChatStates copyWith({
    bool? uploading,
    File? image,
    bool? hasText,
    int? recordingSeconds,
    bool? isRecording,
    File? audioFile,
      List<String>? tokens

  }) {
    return OrderChatStates(
      tokens: tokens??this.tokens,
        hasText: hasText ?? this.hasText,
        uploading: uploading ?? this.uploading,
        audioFile: audioFile ?? this.audioFile,
        recordingSeconds: recordingSeconds ?? this.recordingSeconds,
        image: image ?? this.image,
        isRecording: isRecording ?? this.isRecording);
  }
}
