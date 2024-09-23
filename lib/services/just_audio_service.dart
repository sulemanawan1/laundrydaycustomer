import 'package:just_audio/just_audio.dart';

Future<int?> getAudioDurationInSeconds(String audioPath) async {
  final AudioPlayer audioPlayer = AudioPlayer();

  try {
    // Load audio from the file path
    await audioPlayer.setFilePath(audioPath);

    // Get the duration of the loaded audio in seconds
    Duration? duration = audioPlayer.duration;
    return duration?.inSeconds; // Return duration in seconds
  } catch (e) {
    print("Error loading audio: $e");
    return null; // Return null in case of an error
  } finally {
    // Dispose of the audio player
    audioPlayer.dispose();
  }
}
