import 'package:audioplayers/audioplayers.dart';

class AudioPlayerService {
  AudioPlayer? player;

  iniializeAudioPlayer() async {
    player = AudioPlayer();
  }

  playAssetSound({required String audioPath}) async {
    await player?.play(AssetSource(audioPath));
  }
}
