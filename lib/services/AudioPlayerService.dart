library;
import 'package:audioplayers/audioplayers.dart';
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
  final AudioPlayer player = AudioPlayer();
  late PlayerState? _playerState;
  Source? source;
  bool get _isPlaying => _playerState == PlayerState.playing;
  bool get _isPaused => _playerState == PlayerState.paused;
  late AudioSource? currentSound;
  var currentSound2 = AssetSource('assets/audio/errbeep.mp3');

  /// load the audio file
  void initState() async
  {
    if (ScreenValues.isWeb) {
      _playerState = player.state;
      // Set the release mode to keep the source after playback has completed.
      player.setReleaseMode(ReleaseMode.stop);
      // Start the player as soon as the app is displayed.WidgetsBinding.instance.addPostFrameCallback((_) async {
    //  print('AssetSource=' +AssetSource('audio/errbeep.mp3').toString());
        await player.setSource(AssetSource('audio/errbeep.mp3'));
        source = player.source;
        // print("currentSound2=" +currentSound2.toString());
        await player.resume();
     // });
      return;
    }
    if (!ScreenValues.isWeb) {
      await SoLoud.instance.init();
      currentSound = await SoLoud.instance
          .loadAsset('assets/audio/errbeep.mp3');
      print("currentSound=$currentSound");
    }
  }

  Future<void> _play() async {
    await player.resume();
    _playerState = PlayerState.playing;
  //  await player.play(source!);
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
        _play();
        if (Loggerdef.isLoggerOn) {
          Loggerdef.logger.i("after beed: beep_error");
        }
       // return;
      }
      // audioPlayer.play(AssetSource('audio/errbeep.mp3'));
      /// play it
      if (!ScreenValues.isWeb) {
        var soundHandle = SoLoud.instance.play(currentSound!);
      }
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
    if (!ScreenValues.isWeb) {
      SoLoud.instance.deinit();
      audioPlayerService.dispose();
      SoLoud.instance.deinit();
    }
 //   _audioPlayer?.dispose();
  //  _audioPlayer = null;
  }
}

AudioPlayerService audioPlayerService = AudioPlayerService();

