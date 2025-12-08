library my_project.global;
// import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_soloud/flutter_soloud.dart';
import 'package:logger/logger.dart';
import 'dart:isolate';

// import 'package:flutter_beep/flutter_beep.dart';

// set default values for the initial run
var logger = Logger(
  printer: PrettyPrinter(),
);

class AudioPlayerService {
 // static AudioPlayer? _audioPlayer;
  AudioSource? currentSound;

  /// load the audio file
  void initState() async
  {
    currentSound = await SoLoud.instance
        .loadAsset('assets/sounds/errbeep.mp3');
  }

  /*
  static AudioPlayer get audioPlayer {
    bool bIsNotSet = _audioPlayer == null;
    _audioPlayer ??= AudioPlayer();
    if (bIsNotSet)
      // Set the release mode to keep the source after playback has completed.
      _audioPlayer!.setReleaseMode(ReleaseMode.stop);

    return _audioPlayer!;
  }
   */

  Future beepError() async {
    // var _aplayer = _audioPlayer;
    try {
      logger.i("before beed: beep_error");
      // audioPlayer.play(AssetSource('sounds/errbeep.mp3'));
      /// play it
      await SoLoud.instance.play(currentSound!);
     logger.i("after beed: beep_error");
    }catch(e)
    {
      logger.i("Audio error: " +e.toString());
    }
  }

  void dispose() {
    SoLoud.instance.deinit();
 //   _audioPlayer?.dispose();
  //  _audioPlayer = null;
  }
}

AudioPlayerService audioPlayerService = AudioPlayerService();

