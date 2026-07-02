
import 'package:flgame/ParameterValues.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:flutter/services.dart';
// import 'package:flutter/foundation.dart' show ValueNotifier;
// import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:platform/platform.dart';
import 'package:flutter_exit_app/flutter_exit_app.dart';
import 'package:intl/intl.dart';
//import 'package:intl/date_symbol_data_file.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:rounded_background_text/rounded_background_text.dart';
// import 'package:logger/logger.dart';
import 'package:flutter_soloud/flutter_soloud.dart';
import './di.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:content_resolver/content_resolver.dart';
// import 'package:audioplayers/audioplayers.dart';

import 'views/utils/util_dialog.dart';
import 'views/help_route.dart';
import 'views/loading_screen.dart';
import 'views/game_board.dart';
import './models/lgame_data.dart';
import './views/oldgames_route.dart';
import './views/finished_games_route.dart';
import './views/remote_game.dart';
import '../models/LGameDataService.dart';
import './services/navigation_service.dart';
// import 'package:flutter/services.dart';
import './views/about_game.dart';
import './LoggerDef.dart';
import 'services/AudioPlayerService.dart'; // as myAudioPlayerService;

// part 'lgame_data.g.dart';
import './l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

// ... existing imports ...
var localPlatform = const LocalPlatform();

enum MenuButtonSelected {
  oldUnFinishedGames,
  editPlayerNames,
  finishedGames,
  exitGame,
  aboutGame,
  selectLanguage
}

final ValueNotifier<Locale> localeNotifier = ValueNotifier(const Locale('en'));

void main() async {

  if (Loggerdef.isLoggerOn) {
    Loggerdef.startTime = DateTime.now();
    Loggerdef.logger.i("start: time 0");
  }
  WidgetsFlutterBinding.ensureInitialized();
  Intl.defaultLocale = 'fi_FI';
//  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  /*
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);
   is deprecated api calls!
   */
  // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await setupDi();
  await di<LGameDataService>().checkInit();
 // FlutterNativeSplash.remove();
  await initializeDateFormatting(null, null);
  LGameSessionData? active = di<LGameDataService>().getActiveGame();
  if (active != null) {
    String? strLocale = active.userSelectedLanguage;
    if (strLocale != null) {
       localeNotifier.value = Locale(strLocale);
    }
  }
  runApp(const MyApp());
}

const String strAppTitle = 'LGame for creativity';
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
ParameterValues? parameterValues;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    parameterValues = ParameterValues.of(context);
    final mediaQueryData = MediaQuery.of(context);
    bool bScreenReaderIsUsed = false;
    if (mediaQueryData.accessibleNavigation) {
      bScreenReaderIsUsed = true;
      if (Loggerdef.isLoggerOn) {
        Loggerdef.logger.i("bScreenReaderIsUsed = true");
      }
    } else {
      bScreenReaderIsUsed = false;
    }

// Device width
    double deviceWidth = 500.0;
    if (!ScreenValues.isWeb) {
      deviceWidth = MediaQuery.of(context).size.width;
    } else {
      deviceWidth = 500.0;
    }
// Subtract paddings to calculate available dimensions
    final paddingRight = MediaQuery.of(context).padding.right;
    final paddingLeft = MediaQuery.of(context).padding.left;
//    final ScreenValues screenValues = new ScreenValues();

    final double availableWidth = deviceWidth - paddingRight - paddingLeft;
//Inside Build function since we need context.
// This is device height
    final deviceHeight = !ScreenValues.isWeb ?
         MediaQuery.of(context).size.height :
         MediaQuery.of(context).size.height -100;
    final availableHeight = deviceHeight - AppBar().preferredSize.height -
        MediaQuery.of(context).padding.top
        - MediaQuery.of(context).padding.bottom;
    /*
    ScreenValues.screenValues.bScreenReaderIsUsed = bScreenReaderIsUsed;
    ScreenValues.screenValues.availableHeight = availableHeight;
    ScreenValues.screenValues.availableWidth = availableWidth;
    ScreenValues.screenValues.padding_left =  padding_left;
    ScreenValues.screenValues.padding_right = padding_right;
    */

    return ValueListenableBuilder<Locale>(
      valueListenable: localeNotifier,
      builder: (context, locale, child) {
        Intl.defaultLocale = locale.toLanguageTag();
        return ScreenUtilInit(
          designSize: Size(availableHeight * .4, availableWidth * .5),
          minTextAdapt: true,
          enableScaleWH: () => true,
          enableScaleText: () => true,
          splitScreenMode: true,
          builder: (_, __) {
            return ParameterValues(
              screenValues: ScreenValues(
                  bScreenReaderIsUsed: bScreenReaderIsUsed,
                  deviceWidth: deviceWidth,
                  padding_left: paddingLeft,
                  padding_right: paddingRight,
                  availableWidth: availableWidth,
                  deviceHeight: deviceHeight,
                  availableHeight: availableHeight),
              child: MaterialApp(
                debugShowCheckedModeBanner: false,
                title: strAppTitle,
                navigatorKey: NavigationService.navigatorKey,
                locale: locale,
                localizationsDelegates: AppLocalizations.localizationsDelegates,
                supportedLocales: AppLocalizations.supportedLocales,
                initialRoute: '/',
                routes: {
                  '/': (context) => const LoadingScreen(),
                  '/lgamefor2': (context) => LGamePage(
                        title: strAppTitle,
                        bScreenReaderIsUsed: bScreenReaderIsUsed,
                      ),
                  '/help': (context) => const HelpRoute(),
                  '/about': (context) => const AboutRoute(),
                  '/oldgames': (context) => const OldGamesRoute(),
                  '/finishedgames': (context) => const FinishedGamesRoute(),
                  '/remotegames': (context) => const RemoteGamesRoute(),
                },
                theme: ThemeData(
                  useMaterial3: true,
                  colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple)
                      .copyWith(surface: Colors.blueGrey),
                  useSystemColors: true,
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class LGamePage extends StatefulWidget {

/// iArrPlayerPossibleMovePieces
 // final Function() notifyParent;
  // ChildWidget({Key key, @required this.notifyParent}) : super(key: key);
  const LGamePage({super.key,
    required this.title, required this.bScreenReaderIsUsed,
   // required this.screenValues, /*, @required this.notifyParent} */
  });
  final String title;
  final bool bScreenReaderIsUsed;
//  final ScreenValues screenValues;


  @override
  State<LGamePage> createState() => _LGamePageState();

}

class _LGamePageState extends State<LGamePage>
    with WidgetsBindingObserver /*, AutomaticKeepAliveClientMixin */
{

  bool get wantKeepAlive => true;

  final int minusDynamicContainerSizeOfLGame = 18;
  LGameBoard? lGameBoard;
  DateTime? lGameBoardCalculatedTime;
 // late AudioPlayer player = AudioPlayer();
  final double buttonBetweenWidth = 5;
  Widget? editOrButtonContainer;
  ParameterValues? parameterValues;
  /*
  Future beep(bool bValue) async {
    if (!bValue) {
      logger.i("beep");
      await player.play(AssetSource('errbeep.mp3'));
    }
  }
   */

  Future<void> saveSession() async
  {
    if (ScreenValues.isWeb)
    {
      saveSessionFromBuildGameBoard();
      di<LGameDataService>().closeHive();
    }
  }

  Future<void> saveSessionFromBuildGameBoard() async
  {
    if (ScreenValues.isWeb)
    {
      LGameSessionData obj = lGameSession.getGamePositionsForSaveGame();
      di<LGameDataService>().setActiveGame(obj);
      di<LGameDataService>().saveLGameSessionData(obj);
    }
  }

  @override
  void dispose() {
    if (Loggerdef.isLoggerOn) {
      Loggerdef.logger.i("dispose");
    }
    saveSession();
    lGameSession.dispose();
   // myAudioPlayerService.audioPlayerService.dispose();
    di<AudioPlayerService>().dispose();
    WidgetsBinding.instance.removeObserver(this);
    _textFieldName1Controller.dispose();
    _textFieldName2Controller.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (ScreenValues.isWeb) {
      return;
    }
    switch (state) {
      case AppLifecycleState.inactive:
        if (Loggerdef.isLoggerOn) {
          Loggerdef.logger.i("inactive");
        }
        var obj = lGameSession.getGamePositionsForSaveGame();
        di<LGameDataService>().setActiveGame(obj);
        di<LGameDataService>().saveLGameSessionData(obj);
        if (!ScreenValues.isWeb) {
          di<LGameDataService>().closeHive();
        }
        break;
      case AppLifecycleState.resumed:
        if (Loggerdef.isLoggerOn) {
          Loggerdef.logger.i("resumed");
        }
        var obj = lGameSession.getGamePositionsForSaveGame();
        di<LGameDataService>().setActiveGame(obj);
        di<LGameDataService>().saveLGameSessionData(obj);
      //  if (!ScreenValues.isWeb) {
          di<LGameDataService>().closeHive();
      //  }
        break;
      case AppLifecycleState.paused:
        if (Loggerdef.isLoggerOn) {
          Loggerdef.logger.i("paused");
        }
          var obj = lGameSession.getGamePositionsForSaveGame();
          di<LGameDataService>().setActiveGame(obj);
          di<LGameDataService>().saveLGameSessionData(obj);
        if (!ScreenValues.isWeb) {
          di<LGameDataService>().closeHive();
        }
        break;
      default:
        break;
    }
  }

  bool bGameIsFormat = true;
  String ? oldMsg;
 // BuildContext? thisContext;
  LGameSession lGameSession = LGameSession();
  SelectedLGameSessionData? selectedLGameSessionData;
  SelectedLGameSessionData? oldSelectedLGameSessionData;

  Widget? _buttonSaveSession;
  Widget? _buttonsRow0;
  Widget? _buttonsRow1;
  Widget? _buttonsRow2;
  Widget? _buttonsRow3;
  Widget? _buttonsRow4;
  Widget? _buildBoard; // unused widget, part of function that rebuild now null"
  Widget? _buttonsEditRow1;
  Widget? _textFieldName1, _textFieldName2;
  Widget? _buttonSaveEdit, _buttonReturnFromEdit;
  final TextEditingController _textFieldName1Controller = TextEditingController();
  final TextEditingController _textFieldName2Controller = TextEditingController();

  MenuButtonSelected? selectedMenuButton;
  bool bEditPlayerNames = false;
//  List<Stack> _listBoardStack = List<Stack>.empty(growable: true);
  final double containerWidth = 200;
  final double containerHeight = 200;
  bool bInitGameBoard = true;
  bool _bUpdateUI = false;
 // final ValueNotifier<bool> _notifier = ValueNotifier(false);

  Widget? buttonUp;
  Widget? buttonDown;
  Widget? buttonWrapUp;
  Widget? buttonSwitchNeutral;
  Widget? buttonSwitchNeutralScreenReader;
  Widget? buttonLeft;
  Widget? buttonRight;
  Widget? buttonStartGame;
  Widget? buttonTurn90Degree;
  Widget? buttonMoveDone;
  Widget? buttonMoveDoneScreenReader;
  Widget? buttonHelp;
  Widget? textMessage;
  // bool bScreenReaderIsUsed = true;

  final player1Color = Colors.redAccent;
  final player2Color = Colors.blueAccent;
  final neutralColor = Colors.black;
  // final buttonFontSize = !ScreenValues.isWeb ? 13 : 5;
  ButtonStyle buttonStyle =
         ElevatedButton.styleFrom(textStyle:
         TextStyle(fontSize: ScreenUtil().setSp(!ScreenValues.isWeb ? 13 : 5),
             fontWeight: FontWeight.bold),
         backgroundColor: Colors.amberAccent);

  Future<bool> showStartNewGameDialog() async {
    bool bCancelReturnValue = true;
    bool bContinueReturnValue = false;
    // showYesNoDialog
      return showYesNoDialogWithContext(
          AppLocalizations.of(context)!.newLGame,
          AppLocalizations.of(context)!.cancel,
          AppLocalizations.of(context)!.continue_,
          AppLocalizations.of(context)!.startNewGameQuery,
          bCancelReturnValue,
          bContinueReturnValue);
  }

  Future<void> buttonStartGamePressed() async
  {
    if (Loggerdef.isLoggerOn) {
      Loggerdef.logger.i("buttonStartGamePressed");
    }
    if (lGameSession.bGameStarted)
    {
      bool stopToStartNewGame = await showStartNewGameDialog();
      if (stopToStartNewGame) {
        return;
      }
    }

    LGameSessionData obj = lGameSession.getGamePositionsForSaveGame();
    di<LGameDataService>().setActiveGame(obj);
    di<LGameDataService>().saveLGameSessionData(obj);
   // for test finished games: di<LGameDataService>().saveIntoFinishedGamesList(obj);
    bool? bValue = lGameSession.buttonStartGamePressed();
    /*
    if (bValue == null) {
      return ;
    }
     */
di<LGameDataService>().setActiveGame(lGameSession.getGamePositionsForSaveGame());
//  di<LGameDataService>().setActiveGame(lGameSession.getGamePositionsForSaveGame()) (bValue) {
      setState(() {
        _bUpdateUI = true;
        bInitGameBoard = true;
        lGameSession.msg = AppLocalizations.of(context)!.newGameCreated;
        lGameSession.setListBoardPiecesUpdated(true);
        lGameSession.bGameStarted = true;
        lGameSession.currentButtonPressed = ButtonPressed.newGame;
        _buildBoard = buildGameBoard();
     //   _notifier.value = _bUpdateUI;
      //  ScreenValues.notifier = _notifier;
    });
  }
 // }

  List<GameBoardPosition>?
  getGameBoardPositionList(List<int>? lGamePieceArray)
  {
    List<GameBoardPosition>? ret;
    GameBoardPosition? gp;
    if (lGamePieceArray != null && lGamePieceArray.isNotEmpty)
    {
        ret = List.empty(growable: true);
        int iValue;
        for (int i = 0; i < lGamePieceArray.length; i++ ) {
          iValue = lGamePieceArray[i];
          gp = lGameSession.arrBoardSquares![iValue];
          ret.add(gp);
        }
        // arrBoardSquares
        // GameBoardPosition
    }
    return ret;
  }

  bool? moveArrayIsInHorizontal(List<int>? lGamePieceArray) {
    bool? ret;
    if (lGamePieceArray != null && lGamePieceArray.isNotEmpty) {
      ret = false;
      List<GameBoardPosition>? gps;
      gps = getGameBoardPositionList(lGamePieceArray);
      int? iValue;
      if (gps != null && gps.isNotEmpty) {
        if (gps.length < 2) {
          return false;
        }

        GameBoardPosition gp;
        List<int> iArrFoundRightRow = List.empty(growable: true);
        iArrFoundRightRow.add(0);
        iArrFoundRightRow.add(0);
        iArrFoundRightRow.add(0);
        iArrFoundRightRow.add(0);
        for (int i = 0; i < gps.length; i++) {
          gp = gps[i];
          iArrFoundRightRow[(gp.iRow)] = iArrFoundRightRow[(gp.iRow)] +1;
          /*
            if (iValue == null) {
              iValue = gp.iRow;
              iFoundRightRow++;
              if (iFoundRightRow >= 3)
                {
                  break;
                }
              continue;
            }
            if (iValue != gp.iRow) {
              return false;
            }
            iFoundRightRow++;
            if (iFoundRightRow >= 3)
            {
              break;
            }
          }
          ret = true;
          */
        }
        iValue = 0;
        for (int i = 0; i < iArrFoundRightRow.length; i++) {
          iValue = iArrFoundRightRow[i];
          if (iValue == 3) {
            return true;
          }
        }
        return false;
      }
      return ret;
    }
    return null;
  }

  int getNextFortLPosition(bool bHorizontal)
  {
    int ret = 10;
       if ( lGameSession.iNextFortLPosition > 3) {
         lGameSession.iNextFortLPosition = 0;
       }

       if (lGameSession.iNextFortLPosition == 0)
       {
         lGameSession.iNextFortLPosition++;
          if (bHorizontal) {
            return 10;
          } else {
            return 10;
          }
       }
       else
       if (lGameSession.iNextFortLPosition == 1)
       {
         lGameSession.iNextFortLPosition++;
         if (bHorizontal) {
           return 2;
         } else {
           return 8;
         }
       }
       else
       if (lGameSession.iNextFortLPosition == 2)
       {
         lGameSession.iNextFortLPosition++;
         if (bHorizontal) {
           return 8;
         } else {
           return 2;
         }
       }
       else
       if (lGameSession.iNextFortLPosition == 3)
       {
         lGameSession.iNextFortLPosition++;
         if (bHorizontal) {
           return 0;
         } else {
           return 0;
         }
       }
    return ret;
  }

  List<int>? getNewMovePositions(List<GameBoardPositionValidate>? validateItems)
  {
    List<int>? ret = List<int>.empty(growable: true);
    GameBoardPositionValidate? item;
    int iNewIndex = -1;
    if (validateItems != null && validateItems.isNotEmpty )
      {
        for (int i = 0; i < validateItems.length; i++ ) {
          item = validateItems[i];
          if (!item.bPossibleMove || !item.validate()) {
            continue;
          }
          iNewIndex = getNewGamePositionAfterValidatedItem(item);
          if (iNewIndex == -1) {
            continue;
          }
          ret.add(iNewIndex);
        }
      }
    if (ret.isEmpty) {
      return null;
    }
    return ret;
  }

  int getNewGamePositionAfterValidatedItem(GameBoardPositionValidate item)
  {
     int ret = -1;
     GameBoardPosition gp;
     GameBoardPosition? gpNew;
     for (int i = 0; i < lGameSession.arrBoardSquares!.length; i++ ) {
        gp = lGameSession.arrBoardSquares![i];
        if (gp.iCol == item.iPossibleCol && gp.iRow == item.iPossibleRow)
          {
            gpNew = gp;
            break;
          }
     }
     if (gpNew == null) {
       return -1;
     }
     ret = gpNew.iPos;
     return ret;
  }

  bool moveDone()
  {
      bool bValue = lGameSession.moveDone();
      if (bValue) {
        setState(() {
          _bUpdateUI = true;
          _buildBoard = buildGameBoard();
       //   _notifier.value = _bUpdateUI;
         // ScreenValues.notifier = _notifier;
        });
        return true;
      }
      else {
        return false;
      }
  }

  Future<void> buttonMoveDonePressed() async {
    if (Loggerdef.isLoggerOn) {
      Loggerdef.logger.i("buttonMoveDonePressed");
    }
    bool? bValue = await lGameSession.calculatePossibleMovePieces(ButtonPressed.moveDone);
    if (!bValue && lGameSession.bGameIsOver) {
      LGameSessionData obj = lGameSession.getGamePositionsForSaveGame();
      di<LGameDataService>().deleteUnFinishedGameSessionData(obj);
      // di<LGameDataService>().setActiveGame(obj);
      // di<LGameDataService>().saveLGameSessionData(obj);
    }
    /*
    if (bValue)
      {
     */
        setState(() {
          _bUpdateUI = true;
          lGameSession.setListBoardPiecesUpdated(true);
          _buildBoard = buildGameBoard();
      //    _notifier.value = _bUpdateUI;
        //  ScreenValues.notifier = _notifier;
       });
   // }
  }

  void buttonHelpEnabledPressed()
  {
    if (Loggerdef.isLoggerOn) {
      Loggerdef.logger.i("buttonHelpEnabledPressed");
    }
    var obj = lGameSession.getGamePositionsForSaveGame();
    di<LGameDataService>().setActiveGame(obj);
    di<LGameDataService>().saveLGameSessionData(obj);
    Navigator.pushNamed(context, "/help");
    /*
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HelpRoute()),
    );
     */
  }

  void buttonSaveEditPressed()
  {
    setState(() {
      lGameSession.name1 = _textFieldName1Controller.text;
      lGameSession.name2 = _textFieldName2Controller.text;
      bEditPlayerNames = false;
      _bUpdateUI = true;
      _buildBoard = buildGameBoard();
    //  _notifier.value = _bUpdateUI;
     // ScreenValues.notifier = _notifier;
    });
  }

  void buttonReturnFromEditPressed()
  {
    setState(()  {
      bEditPlayerNames = false;
      _bUpdateUI = true;
      _buildBoard = buildGameBoard();
  //    _notifier.value = _bUpdateUI;
    //  ScreenValues.notifier = _notifier;
   });
  }

  Future<void> buttonTurn90DegreePressed() async
  {
    if (Loggerdef.isLoggerOn) {
      Loggerdef.logger.i("buttonTurn90GradePressed");
    }
    bool? bValue = await lGameSession.calculatePossibleMovePieces(ButtonPressed.turn90Degree);
    if (!bValue! && lGameSession.bGameIsOver) {
      LGameSessionData obj = lGameSession.getGamePositionsForSaveGame();
      di<LGameDataService>().deleteUnFinishedGameSessionData(obj);
      // di<LGameDataService>().setActiveGame(obj);
      // di<LGameDataService>().saveLGameSessionData(obj);
    }
    /*
    if (bValue)
    {
     */
     setState(() {
        _bUpdateUI = true;
      //  lGameSession.setListMovePiecesUpdated(true);
        _buildBoard = buildGameBoard();
      //  _notifier.value = _bUpdateUI;
       // ScreenValues.notifier = _notifier;
     });
  //  }
  }

  Future<void> buttonUpPressed() async
  {
    if (Loggerdef.isLoggerOn) {
      Loggerdef.logger.i("buttonUpPressed");
    }
     bool? bValue = await lGameSession.calculatePossibleMovePieces(ButtonPressed.up);
    if (!bValue! && lGameSession.bGameIsOver) {
      LGameSessionData obj = lGameSession.getGamePositionsForSaveGame();
      di<LGameDataService>().deleteUnFinishedGameSessionData(obj);
      // di<LGameDataService>().setActiveGame(obj);
      // di<LGameDataService>().saveLGameSessionData(obj);
    }
     /*
     if (bValue)
     {
      */
      setState(() {
         _bUpdateUI = true;
    //     lGameSession.setListMovePiecesUpdated(true);
         _buildBoard = buildGameBoard();
       //  _notifier.value = _bUpdateUI;
        // ScreenValues.notifier = _notifier;
      });
    // }
  }

  Future<void> buttonDownPressed() async
  {
    if (Loggerdef.isLoggerOn) {
      Loggerdef.logger.i("buttonDownPressed");
    }
     bool? bValue = await lGameSession.calculatePossibleMovePieces(ButtonPressed.down);
    if (!bValue! && lGameSession.bGameIsOver) {
      LGameSessionData obj = lGameSession.getGamePositionsForSaveGame();
      di<LGameDataService>().deleteUnFinishedGameSessionData(obj);
      // di<LGameDataService>().setActiveGame(obj);
      // di<LGameDataService>().saveLGameSessionData(obj);
    }
     /*
     if (bValue)
     {
      */
      setState(() {
         _bUpdateUI = true;
     //    lGameSession.setListMovePiecesUpdated(true);
         _buildBoard = buildGameBoard();
      //   _notifier.value = _bUpdateUI;
        // ScreenValues.notifier = _notifier;
      });
    // }
  }

  Future<void> buttonLeftPressed() async
  {
    if (Loggerdef.isLoggerOn) {
      Loggerdef.logger.i("buttonLeftPressed");
    }
     bool? bValue = await lGameSession.calculatePossibleMovePieces(ButtonPressed.left);
    if (!bValue! && lGameSession.bGameIsOver) {
      LGameSessionData obj = lGameSession.getGamePositionsForSaveGame();
      di<LGameDataService>().deleteUnFinishedGameSessionData(obj);
      // di<LGameDataService>().setActiveGame(obj);
      // di<LGameDataService>().saveLGameSessionData(obj);
    }
     /*
     if (bValue)
     {
      */
      setState(() {
         _bUpdateUI = true;
   //      lGameSession.setListMovePiecesUpdated(true);
         _buildBoard = buildGameBoard();
      //   _notifier.value = _bUpdateUI;
        // ScreenValues.notifier = _notifier;
      });
    // }
  }

  Future<void> buttonRightPressed() async
  {
    if (Loggerdef.isLoggerOn) {
      Loggerdef.logger.i("buttonRightPressed");
    }
     bool? bValue = await lGameSession.calculatePossibleMovePieces(ButtonPressed.right);
    if (!bValue! && lGameSession.bGameIsOver) {
      LGameSessionData obj = lGameSession.getGamePositionsForSaveGame();
      di<LGameDataService>().deleteUnFinishedGameSessionData(obj);
      // di<LGameDataService>().setActiveGame(obj);
      // di<LGameDataService>().saveLGameSessionData(obj);
    }
     /*
     if (bValue)
     {
      */
      setState(() {
         _bUpdateUI = true;
       //  lGameSession.setListMovePiecesUpdated(true);
         _buildBoard = buildGameBoard();
      //   _notifier.value = _bUpdateUI;
        // ScreenValues.notifier = _notifier;
      });
    // }
  }

  Future<void> buttonWrapUpPressed() async
  {
    if (Loggerdef.isLoggerOn) {
      Loggerdef.logger.i("buttonWrapUpPressed");
    }
     bool? bValue = await lGameSession.calculatePossibleMovePieces(ButtonPressed.wrap);
    if (!bValue! && lGameSession.bGameIsOver) {
      LGameSessionData obj = lGameSession.getGamePositionsForSaveGame();
      di<LGameDataService>().deleteUnFinishedGameSessionData(obj);
      // di<LGameDataService>().setActiveGame(obj);
      // di<LGameDataService>().saveLGameSessionData(obj);
    }
     /*
     if (bValue)
     {
      */
      setState(() {
         _bUpdateUI = true;
     //    lGameSession.setListMovePiecesUpdated(true);
         _buildBoard = buildGameBoard();
      //   _notifier.value = _bUpdateUI;
       //  ScreenValues.notifier = _notifier;
      });
    // }
  }

  Future<void> buttonSwitchNeutralPressed() async
  {
    if (Loggerdef.isLoggerOn) {
      Loggerdef.logger.i("buttonSwitchNeutralPressed");
    }
     bool? bValue = await lGameSession.
          calculatePossibleMovePieces(ButtonPressed.swiftIntoNextNeutral);
    if (!bValue && lGameSession.bGameIsOver) {
      LGameSessionData obj = lGameSession.getGamePositionsForSaveGame();
      di<LGameDataService>().deleteUnFinishedGameSessionData(obj);
      // di<LGameDataService>().setActiveGame(obj);
      // di<LGameDataService>().saveLGameSessionData(obj);
    }
     /*
     if (bValue)
     {
      */
      setState(() {
         _bUpdateUI = true;
         lGameSession.setListBoardPiecesUpdated(true);
         _buildBoard = buildGameBoard();
      //   _notifier.value = _bUpdateUI;
        // ScreenValues.notifier = _notifier;
      });
     // }
  }

  GameBoardPosition? getGameBoardPosition(int index)
  {
    GameBoardPosition? ret;
    if (lGameSession.arrBoardSquares != null && index > -1 && index < 16)
    {
       ret = lGameSession.arrBoardSquares![index];
    }
    return ret;
  }

  Future<void> getLastDataSession() async
  {
    LGameSessionData? active = di<LGameDataService>().getActiveGame();
    List<LGameSessionData>? cList =
         di<LGameDataService>().getLGameSessionDataUnfinished();
    bool bCreatedJustNow = false;
    if ((cList == null || cList.isEmpty) && active == null) {
      bool? bValue = lGameSession.buttonStartGamePressed();
        if (bValue == null) {
          return;
        }
        bCreatedJustNow = true;
        active ??= lGameSession.getGamePositionsForSaveGame();
        cList ??= List.empty(growable: true);
      }

    if (!bCreatedJustNow && active == null && cList != null && cList.isNotEmpty ) {
      lGameSession.setStartGameAfterOldGame(cList.first);
    } else {
      if (active != null) {
        lGameSession.setStartGameAfterOldGame(active);
      }
    }
     setState(() {
        _bUpdateUI = true;
        _buildBoard = buildGameBoard();
       // _notifier.value = _bUpdateUI;
       // ScreenValues.notifier = _notifier;
     });
  }

  Future<void> initAudioService() async {
    if (ScreenValues.isWeb) {
      await SoLoud.instance.init();
      return;
    }
   // myAudioPlayerService.audioPlayerService = myAudioPlayerService.AudioPlayerService();
   // myAudioPlayerService.audioPlayerService.initState();
    di<AudioPlayerService>().initState();
  }

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
    initAudioService();
    if (Loggerdef.isLoggerOn) {
      Loggerdef.logger.i("padding_right=$ScreenValues.padding_right");
      Loggerdef.logger.i("padding_left=$ScreenValues.padding_left");
      Loggerdef.logger.i("widget.availableWidth=$ScreenValues.availableWidth");
    }

    /*
    // Create the audio player.
    player = AudioPlayer();
    // Set the release mode to keep the source after playback has completed.
    player.setReleaseMode(ReleaseMode.stop);
    lGameSession.setCallBeep(this);
     */
    lGameSession.initState();
    getLastDataSession();
   //   _buildBoard = buildGameBoard();
  }

  final double buttonRowBetweenHeight = 40;
  final double buttonIconSize = 35.0;

  /*
  void setListMovePiecesUpdated(bool bValue)
  {
     lGameSession.setListMovePiecesUpdated(bValue);
  }
   */

  void setListBoardPiecesUpdated(bool bValue)
  {
    lGameSession.setListBoardPiecesUpdated(bValue);
  }

  /*
  Future<Widget?> buildGameBoard2() async {
    final Widget? ret = await Isolate.run(buildGameBoard2);
    return ret;
  }
   */

  void gestureDetectedCallBack(ButtonPressed buttonPressed) async {
     if (Loggerdef.isLoggerOn) {
       Loggerdef.logger.i("gestureDetectedCallBack");
     }
     if (lGameSession.bGameIsOver)
       {
         return;
       }

     if (buttonPressed == ButtonPressed.left && lGameSession.bButtonLeftEnabled) {
       buttonLeftPressed();
     }
     else
     if (buttonPressed == ButtonPressed.right && lGameSession.bButtonRightEnabled) {
       buttonRightPressed();
     }
     else
     if (buttonPressed == ButtonPressed.up && lGameSession.bButtonUpEnabled) {
       buttonUpPressed();
     }
     else
     if (buttonPressed == ButtonPressed.down && lGameSession.bButtonDownEnabled) {
       buttonDownPressed();
     }
     else
     if (buttonPressed == ButtonPressed.wrap && lGameSession.bButtonWrapUpEnabled) {
       buttonWrapUpPressed();
     }
     else
     if (buttonPressed == ButtonPressed.turn90Degree && lGameSession.bButtonTurn90DegreeEnabled) {
       buttonTurn90DegreePressed();
     }
     else
     if (buttonPressed == ButtonPressed.moveDone && lGameSession.bButtonMoveDoneEnabled) {
       buttonMoveDonePressed();
     }
     else
     if (buttonPressed == ButtonPressed.swiftIntoNextNeutral && lGameSession.bButtonSwitchNeutralEnabled) {
       buttonSwitchNeutralPressed();
     }

  }

  Widget buildGameBoard2()
  {
     return Container(child: null,);
     /*
   // lGameSession.setListBoardPiecesUpdated(false);
   // lGameSession.setListMovePiecesUpdated(false);
    return LGameBoard(lGameSession: lGameSession,
    bScreenReaderIsUsed: widget.bScreenReaderIsUsed,
     // notifier: _notifier,
      minusDynamicContainerSize: ScreenValues.minusDynamicContainerSizeOfLGame,
      isUpdated: _bUpdateUI,
      gestureDetectedCallBack: gestureDetectedCallBack,
    );
      */
  }

  Widget? buildGameBoard()
  {
    if (ScreenValues.isWeb)
      {
        saveSessionFromBuildGameBoard();
      }
    /*
    DateTime now = DateTime.now();
    if (Loggerdef.isLoggerOn) {
      Loggerdef.logger.i("buildGameBoard = $now");
    }
     */

     /*
    _listBoardSquares = List.generate(16,  (index) {
      return getBoardSquaresContainer(index);
    });
      */

    buttonStartGame = Semantics(
      readOnly: true,
      label: AppLocalizations.of(context)!.startGame,
      hint: AppLocalizations.of(context)!.startGameButtonHint,
      child: Tooltip(message: AppLocalizations.of(context)!.startGameTooltip,
        child: ElevatedButton(
      style: buttonStyle,
      onPressed: lGameSession.bButtonStartGameEnabled ? buttonStartGamePressed : null,
      child: Text(AppLocalizations.of(context)!.startGame),
      ),
      ),
    );

    buttonUp = Semantics(
      readOnly: true,
      label: AppLocalizations.of(context)!.up,
      hint: AppLocalizations.of(context)!.upButtonHint,
      child: Tooltip(message: AppLocalizations.of(context)!.upTooltip,
        child: ElevatedButton.icon(
      style: buttonStyle,
      /*
      style: ElevatedButton.styleFrom(
        shape: StadiumBorder(),
      ),
       */
      onPressed: lGameSession.bButtonUpEnabled ? buttonUpPressed : null,
      icon: Icon(Icons.arrow_upward, size: buttonIconSize,),
      label: Text(AppLocalizations.of(context)!.up),
      ),
      ),
    );
    /* Container(
          margin: const EdgeInsets.all(1.0),
          decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black12,
              ),
              shape: BoxShape.rectangle,
              color: Colors.amberAccent,
              borderRadius: const BorderRadius.all(Radius.circular(30))
          ),

          child: Row(
          mainAxisSize: MainAxisSize.min,
            children: <Widget>[
        IconButton(
          style: IconButton.styleFrom(backgroundColor: Colors.amberAccent),
          icon: const Icon(Icons.arrow_upward),
          tooltip: 'Up',
            onPressed: lGameSession.bButtonUpEnabled ? buttonUpPressed : null,
        ),
        Container(color: Colors.amberAccent,
            child: const Text('Up', style: TextStyle(fontSize: ScreenUtil().setSp(20)))),
  ],
        ),

        );

    */

    buttonDown = Semantics(
      readOnly: true,
      label: AppLocalizations.of(context)!.down,
      hint: AppLocalizations.of(context)!.downButtonHint,
      child: Tooltip(message: AppLocalizations.of(context)!.downTooltip,
        child: ElevatedButton.icon(
      style: buttonStyle,
      onPressed: lGameSession.bButtonDownEnabled ? buttonDownPressed : null,
      icon: Icon(Icons.arrow_downward, size: buttonIconSize,),
      label: Text(AppLocalizations.of(context)!.down),
    ),
      ),
    );

    buttonLeft = Semantics(
      readOnly: true,
      label: AppLocalizations.of(context)!.left,
      hint: AppLocalizations.of(context)!.leftButtonHint,
      child: Tooltip(message: AppLocalizations.of(context)!.leftTooltip,
        child: ElevatedButton.icon(
      style: buttonStyle,
      onPressed: lGameSession.bButtonLeftEnabled ? buttonLeftPressed : null,
      icon: Icon(Icons.arrow_back, size: buttonIconSize,),
      label: Text(AppLocalizations.of(context)!.left),
    ),
      ),
    );

    buttonRight = Semantics(
      readOnly: true,
      label: AppLocalizations.of(context)!.right,
      hint: AppLocalizations.of(context)!.rightButtonHint,
      child: Tooltip(message: AppLocalizations.of(context)!.rightTooltip,
        child: ElevatedButton.icon(
      style: buttonStyle,
      onPressed: lGameSession.bButtonRightEnabled ? buttonRightPressed : null,
      icon: Icon(Icons.arrow_forward, size: buttonIconSize,),
      label: Text(AppLocalizations.of(context)!.right),
    ),
      ),
    );

    buttonWrapUp = Semantics(
      readOnly: true,
        label: AppLocalizations.of(context)!.wrap,
        hint: AppLocalizations.of(context)!.wrapButtonHint,
        child: Tooltip(message: AppLocalizations.of(context)!.wrapTooltip,
          child: ElevatedButton.icon(
      style: buttonStyle,
      onPressed: lGameSession.bButtonWrapUpEnabled ? buttonWrapUpPressed : null,
      icon: Icon(Icons.autorenew, size: buttonIconSize,),
      label: Text(AppLocalizations.of(context)!.wrap),
    ),
        ),
    );

    String strNeutral;
    if (lGameSession.iActiveNeutral == 2) {
      strNeutral = AppLocalizations.of(context)!.selectNeutral(1);
    } else {
      strNeutral = AppLocalizations.of(context)!.selectNeutral(2);
    }

    buttonSwitchNeutral = Semantics(
      readOnly: true,
    label: strNeutral,
  hint: AppLocalizations.of(context)!.neutralButtonHint(strNeutral),
  child: Tooltip(message: AppLocalizations.of(context)!.neutralTooltip,
    child: ElevatedButton(
      style: buttonStyle,
      onPressed: lGameSession.bButtonSwitchNeutralEnabled ? buttonSwitchNeutralPressed : null,
      child: Text(strNeutral),
    ),
  ),
  );

    buttonSwitchNeutralScreenReader = null;
    if (widget.bScreenReaderIsUsed) {
      buttonSwitchNeutralScreenReader = Semantics(
        readOnly: true,
        label: strNeutral,
        hint: AppLocalizations.of(context)!.neutralButtonHint(strNeutral),
        child: Tooltip(message: AppLocalizations.of(context)!.neutralTooltip,
          child: ElevatedButton(
          style: buttonStyle,
          onPressed: lGameSession.bButtonSwitchNeutralEnabled ? () {} : null,
          onLongPress: lGameSession.bButtonSwitchNeutralEnabled
              ? buttonSwitchNeutralPressed
              : null,
          child: Text(strNeutral),
        ),
        ),
      );
    }

    buttonTurn90Degree = Semantics(
      readOnly: true,
  label: AppLocalizations.of(context)!.turn90,
  hint: AppLocalizations.of(context)!.turn90ButtonHint,
  child: Tooltip(message: AppLocalizations.of(context)!.turn90Tooltip,
    child: ElevatedButton.icon(
      style: buttonStyle,
      onPressed: lGameSession.bButtonTurn90DegreeEnabled ? buttonTurn90DegreePressed : null,
      icon: Icon(Icons.subdirectory_arrow_right, size: buttonIconSize,),
      label: Text(AppLocalizations.of(context)!.turn90),
    ),
  ),
  );

     buttonHelp = Semantics(
       readOnly: true,
       label: AppLocalizations.of(context)!.help,
       hint: AppLocalizations.of(context)!.helpButtonHint,
       child: Tooltip(message: AppLocalizations.of(context)!.helpTooltip,
         child: ElevatedButton(
       style: buttonStyle,
       onPressed: lGameSession.bButtonHelpEnabled ? buttonHelpEnabledPressed : null,
       child: Text(AppLocalizations.of(context)!.help),
      ),
       ),
     );

     buttonMoveDone = Semantics(
       readOnly: true,
         label: AppLocalizations.of(context)!.moveDone,
         hint: AppLocalizations.of(context)!.moveDoneButtonHint,
         child: Tooltip(message: AppLocalizations.of(context)!.moveDoneTooltip,
          child: ElevatedButton(
         style: buttonStyle,
       onPressed: lGameSession.bButtonMoveDoneEnabled ? buttonMoveDonePressed : null,
       child: Text(AppLocalizations.of(context)!.moveDone),
       ),
       ),
     );

     buttonMoveDoneScreenReader = null;
   if (widget.bScreenReaderIsUsed) {
      buttonMoveDoneScreenReader = Semantics(
      readOnly: true,
      label: AppLocalizations.of(context)!.moveDone,
      hint: AppLocalizations.of(context)!.moveDoneButtonHint,
      child: Tooltip(message: AppLocalizations.of(context)!.moveDoneScreenReaderTooltip,
        child: ElevatedButton(
        style: buttonStyle,
        onPressed: lGameSession.bButtonMoveDoneEnabled ? (){}
              : null,
        onLongPress: lGameSession.bButtonMoveDoneEnabled ? buttonMoveDonePressed : null,
        child: Text(AppLocalizations.of(context)!.moveDone),
      ),
      ),
    );
   }

     if (lGameSession.bGameIsOver)
     {
       textMessage = /* Text(lGameSession.msg,
         style: TextStyle(color: Colors.black, fontSize: ScreenUtil().setSp(15),
             backgroundColor: Colors.yellowAccent),
       );
       */
       Semantics(
           readOnly: true,
           label: AppLocalizations.of(context)!.messageLabel,
           hint: AppLocalizations.of(context)!.messageLabelHint,
           child: Tooltip(message: AppLocalizations.of(context)!.messageTooltip,
             child: RoundedBackgroundText(
         lGameSession.msg,
         style: TextStyle(fontWeight: FontWeight.bold, fontSize: ScreenUtil().setSp( !ScreenValues.isWeb ? 15 : 3)),
         backgroundColor: Colors.yellowAccent,
       ),
           ),
       );
     }
     else {
       textMessage = Tooltip(message: AppLocalizations.of(context)!.messageTooltip,
           child: Text(lGameSession.msg,
         style: TextStyle(color: Colors.black, fontSize: ScreenUtil().setSp( !ScreenValues.isWeb ? 15 : 3)),
           ),
       );
     }

     if (bEditPlayerNames) {
       /*
     Widget? _editRow0, _editRow1, _buttonsEditRow1;
     TextField? _textFieldName1, _textFieldName2;
     ElevatedButton? _buttonSaveEdit, _buttonReturnFromEdit;
      */

       _buttonSaveEdit = Semantics(
         readOnly: true,
         label: AppLocalizations.of(context)!.saveNames,
         hint: AppLocalizations.of(context)!.saveNamesButtonHint,
         child: Tooltip(message: AppLocalizations.of(context)!.saveNamesTooltip,
           child: ElevatedButton(
         style: buttonStyle,
         onPressed: bEditPlayerNames ? buttonSaveEditPressed : null,
         child: Text(AppLocalizations.of(context)!.saveNames),
         ),
         ),
       );

       _buttonReturnFromEdit = Semantics(
         readOnly: true,
         label: AppLocalizations.of(context)!.noSave,
         hint: AppLocalizations.of(context)!.noSaveButtonHint,
         child: Tooltip(message: AppLocalizations.of(context)!.noSaveTooltip,
           child: ElevatedButton(
         style: buttonStyle,
         onPressed: bEditPlayerNames ? buttonReturnFromEditPressed : null,
         child: Text(AppLocalizations.of(context)!.noSave),
         ),
         ),
       );

       _textFieldName1Controller.text = lGameSession.name1;
       _textFieldName1 = Tooltip(message: AppLocalizations.of(context)!.playerNameTooltip,
           child: TextField(
         controller: _textFieldName1Controller,
         decoration: InputDecoration(
           label: Text.rich(
             TextSpan(
               children: <InlineSpan>[
                 WidgetSpan(
                   child: Text(
                     AppLocalizations.of(context)!.player1,
                    style: TextStyle(fontWeight: FontWeight.bold,
                        fontSize: ScreenUtil().setSp(!ScreenValues.isWeb ? 15 : 5), color: Colors.red),
                   ),
                 ),
                 WidgetSpan(
                   child: Text(
                     '*',
                     style: TextStyle(fontWeight: FontWeight.bold,
                         fontSize: ScreenUtil().setSp(!ScreenValues.isWeb ? 15 : 5),),
                   ),
                 ),
               ],
             ),
           ),
         ),
           ),
       );

       if (widget.bScreenReaderIsUsed) {
         _textFieldName1 = Semantics( readOnly: false,
             label: AppLocalizations.of(context)!.player1, hint: AppLocalizations.of(context)!.player1TextFieldHint,
             child: _textFieldName1);
       }

       _textFieldName2Controller.text = lGameSession.name2;

       _textFieldName2 = Tooltip(message: AppLocalizations.of(context)!.playerNameTooltip,
           child: TextField(
         controller: _textFieldName2Controller,
         decoration: InputDecoration(
           label: Text.rich(
             TextSpan(
               children: <InlineSpan>[
                 WidgetSpan(
                   child: Text(
                     AppLocalizations.of(context)!.player2,
                     style: TextStyle(fontWeight: FontWeight.bold,
                       fontSize: ScreenUtil().setSp(!ScreenValues.isWeb ? 15 : 5), color: Colors.blue),
                   ),
                 ),
                 WidgetSpan(
                   child: Text(
                     '*',
                     style: TextStyle(fontWeight: FontWeight.bold,
                         fontSize: ScreenUtil().setSp(!ScreenValues.isWeb ? 15 : 5), ),
                   ),
                 ),
               ],
             ),
           ),
         ),
           ),
       );

       if (widget.bScreenReaderIsUsed) {
         _textFieldName2 = Semantics( readOnly: false,
       label: AppLocalizations.of(context)!.player2, hint: AppLocalizations.of(context)!.player2TextFieldHint,
       child: _textFieldName2);
       }

       /*
       _editRow1 = Row(children: [
         _textFieldName2!,
       ],
       );
        */

       _buttonsEditRow1 = Row(children: [
         _buttonSaveEdit!,
          SizedBox(height: 40, width: buttonBetweenWidth,),
         _buttonReturnFromEdit!,
       ],
       );
     } // end of bEdit controls

    _buttonSaveSession = Semantics(
      readOnly: true,
      label: AppLocalizations.of(context)!.saveGameDataLabel,
      hint: AppLocalizations.of(context)!.saveGameDataHint,
      child: Tooltip(message: AppLocalizations.of(context)!.saveGameDataTooltip,
        child: ElevatedButton(
          style: buttonStyle,
          onPressed: true ? (){}
              : null,
          onLongPress: saveSession,
          child: Text(AppLocalizations.of(context)!.saveGameDataLabel),
        ),
      ),
    );

     _buttonsRow0 = Row(children: [
       Expanded(
       child: buttonStartGame!,
       ),
      SizedBox(height: buttonRowBetweenHeight, width: buttonBetweenWidth,),
       Expanded(
         child: buttonMoveDone!,
       ),
    ],
    );

    _buttonsRow1 = Row(children: [
      buttonUp!,
      SizedBox(height: buttonRowBetweenHeight, width: buttonBetweenWidth,),
      buttonDown!,
    //  const SizedBox(height: 2, width: buttonBetweenWidth,),
    ],
    );

    _buttonsRow2 = Row(children: [
      buttonLeft!,
      SizedBox(height: buttonRowBetweenHeight, width: buttonBetweenWidth,),
      buttonRight!,
    ],
    );

    _buttonsRow3 = Row(children: [
      buttonWrapUp!,
      SizedBox(height: buttonRowBetweenHeight, width: buttonBetweenWidth,),
      Expanded(
        child: buttonSwitchNeutral!,
      )
    ],
    );

     _buttonsRow4 = Row(children: [
        buttonTurn90Degree!,
        SizedBox(height: buttonRowBetweenHeight, width: buttonBetweenWidth,),
        buttonHelp!,
     ],
     );

    /*
    _listBoardPieces = List.generate(16,  (index) {
      BoxDecoration? listBoxDecoration;
      Color containerColor = getBoardPieceColor(index);
      Color? cColor;
       if (containerColor == Colors.black) {
        listBoxDecoration = BoxDecoration(
          color: containerColor,
          shape: BoxShape.circle,
        );
        cColor = null;
      }
      else {
          cColor = containerColor;
        }

       return Container(
        //    duration: const Duration(seconds: 1),
      //  padding: const EdgeInsets.all(8),
        color: cColor,
        width: containerWidth,
        height: containerHeight,
        decoration: listBoxDecoration,
        child: getTextChild(index, true),

       );
    });

    _listMoveSquares = List.generate(16,  (index) {
      return getMoveContainer(index);
    });
    */

    /*
     _listMoveSquares2 = List.generate(16,  (index) {
       return getMoveContainer2(index);
     });
    */

     /*
     //  _listBoard, Pieces[0].color!(Colors.green);
    List<Stack> listBoardStack = List<Stack>.empty(growable: true);
    //_listBoardStack.clear();
    for (int i = 0; i < _listBoardSquares.length; i++ ) {
      listBoardStack.add(Stack(children: [_listBoardSquares[i],
        _listBoardPieces[i], _listMoveSquares[i]]),);
    }

    _gameBoardGrid = GridView.count(
        //  childAspectRatio: 3/2,
          primary: false,
          mainAxisSpacing: 0,
          crossAxisSpacing: 0,
          padding: EdgeInsets.zero,
          // mainAxisSpacing: 1.0,
          // crossAxisSpacing: 1.0,
          // Create a grid with 2 columns. If you change the scrollDirection to
          // horizontal, this produces 2 rows.
          crossAxisCount: 4,
          // padding: const EdgeInsets.all(20),
          children: listBoardStack,
        );
    */
     editOrButtonContainer = null;
     if (bEditPlayerNames)
     {
       editOrButtonContainer = Container(
           margin: EdgeInsets.all(8.0),
           child: Column(children: [
             SizedBox(height: 15,),
         _textFieldName1!, _textFieldName2!,
             SizedBox(height: 15,),
             _buttonsEditRow1!,
         SizedBox(height: 15,)
       ],),);
     }
     else
       {
         editOrButtonContainer = Column(children: [
         _buttonsRow0!,  _buttonsRow1!, _buttonsRow2!, _buttonsRow3!,
           _buttonsRow4!
        ],);
       }

    lGameBoardCalculatedTime = DateTime.now();
    if (lGameBoard == null || bInitGameBoard) {
      lGameBoard = LGameBoard(lGameSession: lGameSession,
          bScreenReaderIsUsed: widget.bScreenReaderIsUsed,
         // notifier: _notifier,
          minusDynamicContainerSize:
          ScreenValues.minusDynamicContainerSizeOfLGame -20,
          isUpdated: _bUpdateUI,
        isCalledFromList: lGameBoard == null ? true : bInitGameBoard,
          gestureDetectedCallBack: gestureDetectedCallBack,
          calculatedTimeCallBack:  calculatedTimeCallBack,
          /*  minusDynamicContainerSize: minusDynamicContainerSizeOfLGame */);
    //   lGameSession.setListBoardPiecesUpdated(false);
     //  lGameSession.setListMovePiecesUpdated(false);
    //  lGameBoardCalculatedTime = lGameSession.calculatedTime!;
    }
    else
      {
       /*
        lGameBoard!.updateParams(widget.bScreenReaderIsUsed,
          lGameSession, ScreenValues.minusDynamicContainerSizeOfLGame -20,
          _bUpdateUI,);
          */
        lGameBoard = LGameBoard(lGameSession: lGameSession,
          bScreenReaderIsUsed: widget.bScreenReaderIsUsed,
          // notifier: _notifier,
          minusDynamicContainerSize:
          ScreenValues.minusDynamicContainerSizeOfLGame -20,
          isUpdated: _bUpdateUI,
          isCalledFromList: lGameBoard == null ? true : bInitGameBoard,
          gestureDetectedCallBack: gestureDetectedCallBack,
          calculatedTimeCallBack:  calculatedTimeCallBack,
          /*  minusDynamicContainerSize: minusDynamicContainerSizeOfLGame */);
        //   lGameSession.setListBoardPiecesUpdated(false);
        //  lGameSession.setListMovePiecesUpdated(false);
       // lGameBoardCalculatedTime = lGameSession.calculatedTime!;
      }

    final Widget mobileScreenLayout = Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        /* Expanded( // wrap in Expanded
          child: */ if (!bEditPlayerNames) lGameBoard! /* buildGameBoard2() */,
        /* _gameBoardGrid!, */
        // ),
//        SizedBox(height: 20,),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 0, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const SizedBox(height: 40),
              Center(child: Semantics(
                liveRegion: true,
                child: textMessage!,),
              ),
              //  if (!bEditPlayerNames) SizedBox(height: 30, ),
              if (!bEditPlayerNames) editOrButtonContainer!,
            ],),
        ),
        if (isSystemNavigateMenu) const SizedBox(height: 30,),
      ],
    );

    Widget? ret;
    if (!ScreenValues.isWeb) {
      ret = mobileScreenLayout;
    }
    else      {
        ret = Row (
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            /* Expanded( // wrap in Expanded
          child: */ !bEditPlayerNames ?  AbsorbPointer(
              absorbing: (lGameSession.bGameIsOver ||
              lGameSession.bisRemoteGameAndAnotherPlayersTurn),
                child: lGameBoard! )
                : SizedBox.shrink()
            /* buildGameBoard2() */,
            /* _gameBoardGrid!, */
            // ),
//        SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 0, 20),
              child: Column (
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  // const SizedBox(height: 40),
                  Center( child: Semantics(
                    liveRegion: true,
                    child: textMessage!,),
                  ),
                  //  if (!bEditPlayerNames) SizedBox(height: 30, ),
                  if (!bEditPlayerNames) editOrButtonContainer!,
                ],),
            ),
            if (isSystemNavigateMenu) const SizedBox(height: 30, ),
          ],
        );
      }
    /*
    String duration = DateTime.now().difference(now).toString();
    if (Loggerdef.isLoggerOn) {
      Loggerdef.logger.i("buildGameBoard = $duration");
    }
     */
   // lGameSession.setListBoardPiecesUpdated(false);
   // lGameSession.setListMovePiecesUpdated(false);
   return ret; // Column(children: <Widget>[_gameBoardGrid!, ],);
  }


  bool calculatedTimeCallBack()
  {
    bool ret = lGameBoardCalculatedTime == null;
    if (!ret)
      {
        DateTime? calculatedTime = lGameSession.calculatedTime;
        if (calculatedTime == null) {
          ret = false;
          return ret;
        } else
        if (lGameBoardCalculatedTime! != calculatedTime) {
          ret = true;
          lGameBoardCalculatedTime = calculatedTime;
        }
      }
    return ret;
  }

  Color getMovePieceColor(int index)
  {
    Color ret = Colors.transparent;
    if (lGameSession.iPlayerMove == null) {
      return ret;
    }

    bool isInMoveList = lGameSession.iArrPlayerMovePieces == null ? false :
                lGameSession.iArrPlayerMovePieces!.contains(index);
    if (!isInMoveList) {
      return ret;
    }

    if (lGameSession.iPlayerMove == 1) {
      ret = Colors.white60;
    } else
    if (lGameSession.iPlayerMove == 2) {
      ret = Colors.white60;
    }
    return ret;
  }

  String _getPlayerName()
  {
     String ret = "";
     if (lGameSession.iPlayerMove == null) {
       return "";
     }
     if (lGameSession.playerTurn == GamePlayerTurn.player1) {
       if (lGameSession.name1.isEmpty) {
         ret = AppLocalizations.of(context)!.player1;
       } else {
         ret = lGameSession.name1;
       }
     } else
     if (lGameSession.playerTurn == GamePlayerTurn.player2) {
       if (lGameSession.name2.isEmpty) {
         ret = AppLocalizations.of(context)!.player2;
       } else {
         ret = lGameSession.name2;
       }
     }
     return ret;
  }

  void callOldUnFinishedGames() async
  {
    Object? navRet = await Navigator.pushNamedAndRemoveUntil(
        context, "/oldgames", ModalRoute.withName('/lgamefor2'));
    if (navRet == null) {
      return;
    }
    selectedLGameSessionData = navRet as SelectedLGameSessionData;
    if (selectedLGameSessionData != null)
    {
      /*
      if (oldSelectedLGameSessionData != null)
      {
        if (oldSelectedLGameSessionData!.selectedAtTime.contains(
            selectedLGameSessionData!.selectedAtTime)
            || oldSelectedLGameSessionData!.gameSessionData!.
            startedAt!.contains(
                selectedLGameSessionData!.gameSessionData!.
                startedAt!))
        {
          if(selectedLGameSessionData!.gameSessionData != null) {
            await di<LGameDateService>().setActiveGame(selectedLGameSessionData!.gameSessionData);
          }
          return;
        }
      }
       */

      bool bSaved = di<LGameDataService>().saveLGameSessionData(
        lGameSession.getGamePositionsForSaveGame(),
      );
      if (!bSaved)
      {
       setState(() {
          _bUpdateUI = true;
          lGameSession.msg = "Cannot save the current game.";
          _buildBoard = buildGameBoard();
       //   _notifier.value = _bUpdateUI;
         // ScreenValues.notifier = _notifier;
        });
        return;
      }

      di<LGameDataService>().deleteUnFinishedGameSessionData(selectedLGameSessionData!.gameSessionData!);
      if (!lGameSession.bGameIsOver) {
        di<LGameDataService>().saveIntoUnFinishedGamesList(lGameSession.getGamePositionsForSaveGame());
      } else {
        di<LGameDataService>().deleteUnFinishedGameSessionData(lGameSession.getGamePositionsForSaveGame());
        di<LGameDataService>().saveIntoFinishedGamesList(lGameSession.getGamePositionsForSaveGame());
      }
      di<LGameDataService>().setActiveGame(selectedLGameSessionData!.gameSessionData);
      oldSelectedLGameSessionData = selectedLGameSessionData;
      lGameSession.setStartGameAfterOldGame(
          selectedLGameSessionData!.gameSessionData!);
     setState(() {
        _bUpdateUI = true;
        _buildBoard = buildGameBoard();
      //  _notifier.value = _bUpdateUI;
       // ScreenValues.notifier = _notifier;
     });
    }
    // final result = await = Navigator.pushAndRemoveUntil(context,  MaterialPageRoute(builder: (context) =>
    //   OldGamesPage()), (route) => false);
  }

  void callExitGame()
  {
    if (ScreenValues.isWeb)
      {
       SystemChannels.platform.invokeMethod('SystemNavigator.pop');
     //   window.close();
        return;
      }
    if (localPlatform.isAndroid) {
      FlutterExitApp.exitApp();
    } else if (localPlatform.isIOS) {
      FlutterExitApp.exitApp(iosForceExit: true);
    }
  }

  void callAboutGame()
  {
    var obj = lGameSession.getGamePositionsForSaveGame();
    di<LGameDataService>().setActiveGame(obj);
    di<LGameDataService>().saveLGameSessionData(obj);
    Navigator.pushNamed(context, "/about");
  }

  void callRemoteGames() async
  {
    /*
    await Navigator.pushNamedAndRemoveUntil(
        context, "/finishedgames", ModalRoute.withName('/finishedgames'));
     */
    var obj = lGameSession.getGamePositionsForSaveGame();
    di<LGameDataService>().setActiveGame(obj);
    di<LGameDataService>().saveLGameSessionData(obj);
    Navigator.pushNamed(context, "/remotegames");
  }

  void callLanguageDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(AppLocalizations.of(context)!.selectLanguage),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Text('English'),
                onTap: () {
                  Navigator.pop(context);
                  setState(() {
                    localeNotifier.value = const Locale('en');
                  });
                },
              ),
              ListTile(
                title: const Text('Español'),
                onTap: () {
                  Navigator.pop(context);
                  setState(() {
                    localeNotifier.value = const Locale('es');
                  });
                },
              ),
              ListTile(
                title: const Text('Deutsch'),
                onTap: () {
                  Navigator.pop(context);
                  setState(() {
                    localeNotifier.value = const Locale('de');
                  });
                },
              ),
              ListTile(
                title: const Text('Svenska'),
                onTap: () {
                  Navigator.pop(context);
                  setState(() {
                    localeNotifier.value = const Locale('sv');
                  });
                },
              ),
              ListTile(
                title: const Text('Suomi'),
                onTap: () {
                  Navigator.pop(context);
                  setState(() {
                    localeNotifier.value = const Locale('fi');
                  });
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void callFinishedGames() async
  {
    /*
    await Navigator.pushNamedAndRemoveUntil(
        context, "/finishedgames", ModalRoute.withName('/finishedgames'));
     */
    var obj = lGameSession.getGamePositionsForSaveGame();
    di<LGameDataService>().setActiveGame(obj);
    di<LGameDataService>().saveLGameSessionData(obj);
    Navigator.pushNamed(context, "/finishedgames");
  }

  bool isSystemNavigateMenu = false;

  @override
  void didChangeDependencies()
  {
    super.didChangeDependencies();
    // Rebuild the board when locale or other dependencies change
    lGameSession.l10n = AppLocalizations.of(context);
    lGameSession.refreshMessage();
    _buildBoard = buildGameBoard();
  }

  Widget? initBoard(){
    var ret = _buildBoard;
    bInitGameBoard = false;
    return ret;
  }

  /*
  Widget? buildUpdatedBoard()
  {
    _bUpdateUI = false;
    return ret;
  }
   */

  bool getCurrentUpdateUI()
  {
    bool ret = _bUpdateUI;
    _bUpdateUI = false;
    return ret;
  }

  @override
  Widget build(BuildContext context) {
    lGameSession.l10n = AppLocalizations.of(context);
    lGameSession.setLanguage(Intl.defaultLocale!);
    /*
    EdgeInsets systemGestureInsets =
        MediaQuery.of(context).systemGestureInsets;
    isSystemNavigateMenu = systemGestureInsets.left > 0;
     */

    if (bGameIsFormat)
      {
        _buildBoard = buildGameBoard();
       // _notifier.value = _bUpdateUI;
       // ScreenValues.notifier = _notifier;
        bGameIsFormat = false;
      }
    else {
      // Refresh localized elements in the board on every build
      _buildBoard = buildGameBoard();
    }

    String strPlayer = _getPlayerName();
    String homeTitle = widget.title;
    if (strPlayer.isNotEmpty) {
      homeTitle = AppLocalizations.of(context)!.playerTurnLabel(strPlayer);
    }
    /*
    if (strPlayer.isNotEmpty) {
      homeTitle = "Turn: $strPlayer";
    }
     */

    final TextStyle menuTextStyle = TextStyle(fontSize: ScreenUtil().setSp(!ScreenValues.isWeb ? 16 : 3),
        fontWeight: FontWeight.bold);

    double height = MediaQuery.sizeOf(context).height;
    var padding = MediaQuery.paddingOf(context);
    final deviceHeight = MediaQuery.of(context).size.height;
    final availableHeight = deviceHeight - AppBar().preferredSize.height -
        MediaQuery.of(context).padding.top;
    final availableWidth = MediaQuery.of(context).size.width;
    /*
    ScreenValues screenValues = ScreenValues();
    screenValues.availableHeight = deviceHeight;
     */
    // double newHeight = height - padding.top - padding.bottom;
    double newHeight = availableHeight - padding.top - padding.bottom;
    Color? playerColor = lGameSession.playerTurn == null ? null :
    (lGameSession.playerTurn == GamePlayerTurn.player1 ?
    player1Color : player2Color);

    if (Loggerdef.isLoggerOn) {
      Loggerdef.endTime = DateTime.now();
      Loggerdef.logger.i("end duration: ${Loggerdef.getDurationString()}");
    }

    if (widget.bScreenReaderIsUsed && lGameSession.msg.isNotEmpty
        && lGameSession.msg != oldMsg) {
      AnnounceMessage.announceMessage(context, lGameSession.msg);
      oldMsg = lGameSession.msg;
    }

    return SafeArea(
        top: true, // applies padding at the top
        bottom: true, // applies padding at the bottom
        left: false, // no padding on the left
        right: false, // no padding on the right
        minimum: EdgeInsets.all(16), // minimum padding for all sides
        child: PopScope(
          canPop: false, // Estää automaattisen sivulta poistumisen (taaksepäin navigoinnin)
          onPopInvokedWithResult: (didPop, result) {
            if (didPop) return;

            // Sulkee Flutter-sovelluksen ja palauttaa käyttäjän Androidin kotinäyttöön
            SystemNavigator.pop();
          },
          child: Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        titleSpacing: !ScreenValues.isWeb ? 23 : 10,
        title: Padding(
            padding: EdgeInsets.all(!ScreenValues.isWeb ? 20.0 : 10),
            child: Row(children: [
              if (lGameSession.bIsRemoteGame) Row(children: [
                Semantics(
                  readOnly: true,
                  label: AppLocalizations.of(context)!.remoteGameLabel,
                  hint: AppLocalizations.of(context)!.remoteGameHint,
                  child: Tooltip(message: AppLocalizations.of(context)!.remoteGameTooltip,
                child: Icon(Icons.group,),)),
                SizedBox(width: 10,),
              ]),
              Container(
              padding: EdgeInsets.all(!ScreenValues.isWeb ? 6.0 : 2.0),
              decoration: BoxDecoration(
                color: playerColor!,
                borderRadius: BorderRadius.all(
                  Radius.circular(!ScreenValues.isWeb ? 15.0 : 5.0),
                ),
              ),
              child: Text(homeTitle, style:
            TextStyle(fontSize: ScreenUtil().setSp(!ScreenValues.isWeb ? 15 : 5),
            fontWeight: FontWeight.bold, background: Paint()
            /*
          ..strokeWidth = 12.0
          ..strokeMiterLimit = 0.0
             */
          ..color = playerColor
          // ..style = PaintingStyle.stroke
         ..strokeJoin = StrokeJoin.round,
              height: 1.7,
              letterSpacing: 1.5,
            ),),
        ),
              if (ScreenValues.isWeb) SizedBox(width: 30,),
              if (ScreenValues.isWeb) _buttonSaveSession!,
          ],
       // ),
                ),
        ),
        actions: [
          PopupMenuButton<MenuButtonSelected>(
            initialValue: selectedMenuButton,
            onSelected: (MenuButtonSelected item) {
              setState(() {
                _bUpdateUI = true;
                selectedMenuButton = item;
                if (selectedMenuButton ==
                    MenuButtonSelected.oldUnFinishedGames)
                  {
                     callOldUnFinishedGames();
                  }
                else
                if (selectedMenuButton ==
                    MenuButtonSelected.editPlayerNames)
                {
                 // setState(() {
                    _bUpdateUI = true;
                    bEditPlayerNames = true;
                    _buildBoard = buildGameBoard();
                  //  _notifier.value = _bUpdateUI;
                   // ScreenValues.notifier = _notifier;
                 // });
                }
                else
                    if (selectedMenuButton ==
                        MenuButtonSelected.finishedGames)
                    {
                      callFinishedGames();
                    }
                    /*
                  else
                    if (selectedMenuButton ==
                    MenuButtonSelected.remoteGames)
                    {
                        callRemoteGames();
                    }
                     */

                    else
                    if (selectedMenuButton ==
                        MenuButtonSelected.exitGame)
                    {
                      callExitGame();
                    }
                    else
                    if (selectedMenuButton ==
                        MenuButtonSelected.aboutGame)
                    {
                      callAboutGame();
                    }
                    else if (selectedMenuButton ==
                        MenuButtonSelected.selectLanguage) {
                      callLanguageDialog();
                    }

              });
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<MenuButtonSelected>>[
              PopupMenuItem<MenuButtonSelected>(
                value: MenuButtonSelected.oldUnFinishedGames,
                child: Text(AppLocalizations.of(context)!.selectUnfinishedGames, style: menuTextStyle,),
              ),

              /*
              PopupMenuItem<MenuButtonSelected>(
                value: MenuButtonSelected.remoteGames,
                child: Text('Remote games', style: menuTextStyle,),
              ),
               */
              PopupMenuItem<MenuButtonSelected>(
                value: MenuButtonSelected.editPlayerNames,
                child: Text(AppLocalizations.of(context)!.editPlayerNames, style: menuTextStyle,),
              ),
              PopupMenuItem<MenuButtonSelected>(
                value: MenuButtonSelected.finishedGames,
                child: Text(AppLocalizations.of(context)!.finishedGames, style: menuTextStyle,),
              ),
              PopupMenuItem<MenuButtonSelected>(
                value: MenuButtonSelected.selectLanguage,
                child: Text(AppLocalizations.of(context)!.selectLanguage, style: menuTextStyle,),
              ),
              PopupMenuItem<MenuButtonSelected>(
                value: MenuButtonSelected.exitGame,
                child: Text(AppLocalizations.of(context)!.exitGame, style: menuTextStyle,),
              ),
              PopupMenuItem<MenuButtonSelected>(
                value: MenuButtonSelected.aboutGame,
                child: Text(AppLocalizations.of(context)!.aboutGame, style: menuTextStyle,),
              ),
            ],
          ),
          /*
          ElevatedButton(
            style: buttonStyle,
            child: const Text(
              'Etc...',
            ),
            onPressed: () async {
              selectedLGameSessionData = await Navigator.pushNamedAndRemoveUntil(
                  context, "/oldgames", ModalRoute.withName('/lgamefor2'))
                  as SelectedLGameSessionData;
              if (selectedLGameSessionData != null)
                {
                   if (oldSelectedLGameSessionData != null)
                     {
                        if (oldSelectedLGameSessionData!.selectedAtTime.contains(
                            selectedLGameSessionData!.selectedAtTime)
                          || oldSelectedLGameSessionData!.gameSessionData!.
                            startedAt!.contains(
                                selectedLGameSessionData!.gameSessionData!.
                                startedAt!))
                          {
                             return;
                          }
                     }

                   bool bSaved = await
                   di<LGameDateService>().saveLGameSessionData(
                     lGameSession.getGamePositionsForSaveGame()!,
                   );
                   if (!bSaved)
                   {
                     setState(() {
                     _bUpdateUI = true;
                       lGameSession.strMsg = "Cannot save the current game.";
                       _buildBoard = buildGameBoard();
                     });
                     return;
                   }

                   oldSelectedLGameSessionData = selectedLGameSessionData;
                   setState(() {
                   _bUpdateUI = true;
                     lGameSession.setStartGameAfterOldGame(
                         selectedLGameSessionData!.gameSessionData!);
                     _buildBoard = buildGameBoard();
                   });
                }
             // final result = await = Navigator.pushAndRemoveUntil(context,  MaterialPageRoute(builder: (context) =>
               //   OldGamesPage()), (route) => false);
            },
          ), */
        ],
      ),
      backgroundColor: Colors.white70,
      body: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: /* ConstrainedBox(
            constraints: BoxConstraints(
              minWidth: MediaQuery.of(context).size.width,
              minHeight: newHeight /* MediaQuery.of(context).size.height */,
            ),
            child: IntrinsicHeight(
              child: */
          Column(children: [
            if (buttonMoveDoneScreenReader != null)
              Container(
                width: availableWidth,
             //   color: Theme.of(context).colorScheme.inversePrimary,
                  decoration: BoxDecoration(
                    color:  Theme.of(context).colorScheme.inversePrimary,
                    border: Border.all(
                      color: Theme.of(context).colorScheme.inversePrimary,
                      width: 5,
                    ),
                  ),
                child:
                Row(children: [
                buttonSwitchNeutralScreenReader!,
                buttonMoveDoneScreenReader!,
                ],
                ),
              ),
          Container(
       height: newHeight,
    decoration: BoxDecoration(
    color:  Colors.white70,
    border: Border.all(
      color: Theme.of(context).colorScheme.inversePrimary,
      width: 15,
      ),
    ),
    child:
    /* buildGameBoard() */ /* bInitGameBoard ? initBoard() : */
     /* _bUpdateUI ? */
  buildLGameContainer() /*
    LGameContainer(isSystemNavigateMenu: isSystemNavigateMenu,
        //  notifier: _notifier,
        bEditPlayerNames: bEditPlayerNames,
        editOrButtonContainer: editOrButtonContainer!,
        bScreenReaderIsUsed: widget.bScreenReaderIsUsed,
     //  lGameBoard: lGameBoard,
        lGameSession: lGameSession,
        buttonBetweenWidth: buttonBetweenWidth,
        textMessage: textMessage,
        isUpdated: getCurrentUpdateUI(),
        gestureDetectedCallBack: gestureDetectedCallBack,
        calculatedTimeCallBack: calculatedTimeCallBack,
    ) */,
     /*
       Column (
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        /* Expanded( // wrap in Expanded
          child: */
        if (bEditPlayerNames)
            //  SizedBox(height: 10, width: buttonBetweenWidth,),
            editOrButtonContainer!,
        ValueListenableBuilder<bool>(
          valueListenable: _notifier,
          builder: (BuildContext context, bool value, child) {
            return lGameBoard!;
          },
        ),
        // lGameBoard!,
         /* buildGameBoard2() */  /* _gameBoardGrid!, */

        // ),
//        SizedBox(height: 20,),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 0, 20),
          child: Center(child: Column (
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(height: 40),
              Center( child: Semantics(
                liveRegion: true,
                child: textMessage!,),
              ),
              SizedBox(height: 20, width: buttonBetweenWidth,),
              if (!bEditPlayerNames) editOrButtonContainer!,
            ],),
          ),
        ),
        if (isSystemNavigateMenu) const SizedBox(height: 30, ),
      ],
    )
      */
       /* : _buildBoard */ ),
        //   if (isSystemNavigateMenu) SizedBox(height: 30,),
          ],
      ),
      ),
      ),
      ),
      //  ),
    );
  }

  Widget buildLGameContainer()
  {
    late Widget ret;
    if (!ScreenValues.isWeb) {
      ret = Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          /* Expanded( // wrap in Expanded
          child: */
          if (bEditPlayerNames)
          //  SizedBox(height: 10, width: buttonBetweenWidth,),
            editOrButtonContainer!,
          /* RepaintBoundary(child: */ lGameBoard!,
            /* buildGameBoard2() *? ?* _gameBoardGrid!, */
            // ),
//        SizedBox(height: 20,),
          // ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 0, 20),
            child: Center(child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(height: 40),
                Center(child: Semantics(
                  liveRegion: true,
                  child: textMessage!,),
                ),
                SizedBox(height: 20, width: buttonBetweenWidth,),
                if (!bEditPlayerNames) editOrButtonContainer!,
              ],),
            ),
          ),
          if (isSystemNavigateMenu) const SizedBox(height: 30,),
        ],
      );
    }
    else {
      ret = Column(children: [
        SizedBox(height: 40),
        Center(child: Semantics(
          liveRegion: true,
          child: textMessage!,),
        ),
        SizedBox(height: 20, width: buttonBetweenWidth,),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            /* Expanded( // wrap in Expanded
          child: */
            if (bEditPlayerNames)
            //  SizedBox(height: 10, width: buttonBetweenWidth,),
              editOrButtonContainer!,
            /* RepaintBoundary(child: */ lGameBoard!,
              /* buildGameBoard2() */ /* _gameBoardGrid!, */
              // ),
//        SizedBox(height: 20,),
          //  ), // ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 0, 20),
              child: Center(child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  if (!bEditPlayerNames) editOrButtonContainer!,
                ],),
              ),
            ),
            if (isSystemNavigateMenu) const SizedBox(height: 30,),
          ],
        ),
      ],
      );
    }

    return ret;
  }
}

/*
class _PopupMenuExampleState  {
  MenuButtonSelected? selectedMenuButton;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('PopupMenuButton')),
      resizeToAvoidBottomInset : false,
      body: Center(
        child: PopupMenuButton<MenuButtonSelected>(
          initialValue: selectedMenuButton,
          onSelected: (MenuButtonSelected item) {
            setState(() {
            _bUpdateUI = true;
              selectedMenuButton = item;
            });
          },
          itemBuilder: (BuildContext context) => <PopupMenuEntry<MenuButtonSelected>>[
            const PopupMenuItem<MenuButtonSelected>(
              value: MenuButtonSelected.oldUnFinishedGames,
              child: Text('Select unfinished games'),
            ),
            const PopupMenuItem<MenuButtonSelected>(
              value: MenuButtonSelected.editPlayerNames,
              child: Text('Edit player names'),
            ),
            const PopupMenuItem<MenuButtonSelected>(
              value: MenuButtonSelected.itemThree,
              child: Text('Item 3'),
            ),
          ],
        ),
      ),
    );
  }
}

 */
