import 'package:audioplayers/audioplayers.dart';

class AudioPlayerHandler {
  AudioPlayer? player;

  iniializeAudioPlayer() async {
    player = AudioPlayer();
  }

  playAssetSound({required String audioPath}) async {
    await player?.play(AssetSource(audioPath));
  }
}
