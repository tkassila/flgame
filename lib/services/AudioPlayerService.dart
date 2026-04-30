library;
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_soloud/flutter_soloud.dart';
// import 'package:logger/logger.dart';
import '../LoggerDef.dart';
import '../ParameterValues.dart';

// import 'package:flutter_beep/flutter_beep.dart';

// set default values for the initial run
/*
var logger = Logger(
  printer: PrettyPrinter(),
);
 */

class AudioPlayerService {
 // static AudioPlayer? _audioPlayer;
  late AudioPlayer player = AudioPlayer();
  AudioSource? currentSound;
  var currentSound2;

  /// load the audio file
  void initState() async
  {
    if (ScreenValues.isWeb) {
      player = AudioPlayer();
      // Set the release mode to keep the source after playback has completed.
      player.setReleaseMode(ReleaseMode.stop);
      // Start the player as soon as the app is displayed.
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        await player.setSource(AssetSource('assets/sounds/errbeep.mp3'));
        await player.resume();
      });
      return;
    }
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
      if (Loggerdef.isLoggerOn) {
        Loggerdef.logger.i("before beed: beep_error");
      }
      if (ScreenValues.isWeb) {
        player.play(currentSound2);
        if (Loggerdef.isLoggerOn) {
          Loggerdef.logger.i("after beed: beep_error");
        }
        return;
      }
      // audioPlayer.play(AssetSource('sounds/errbeep.mp3'));
      /// play it
      await SoLoud.instance.play(currentSound!);
      if (Loggerdef.isLoggerOn) {
        Loggerdef.logger.i("after beed: beep_error");
      }
    }catch(e)
    {
      Loggerdef.logger.i("Audio error: $e");
    }
  }

  void dispose() {
    if (ScreenValues.isWeb) {
      // Release all sources and dispose the player.
      player.dispose();
      return;
    }
    SoLoud.instance.deinit();
 //   _audioPlayer?.dispose();
  //  _audioPlayer = null;
  }
}

AudioPlayerService audioPlayerService = AudioPlayerService();

