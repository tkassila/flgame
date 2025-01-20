
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:collection/collection.dart';
import 'package:flutter/services.dart';
// import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:platform/platform.dart';
import 'package:flutter_exit_app/flutter_exit_app.dart';
import 'package:intl/intl.dart';
//import 'package:intl/date_symbol_data_file.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'views/utils/util_dialog.dart';
import 'views/help_route.dart';
import 'views/loading_screen.dart';
import 'views/game_board.dart';
import './models/lgame_data.dart';
import './views/oldgames_route.dart';
import './views/remote_game.dart';
import '../models/LGameDataService.dart';
import './di.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// part 'lgame_data.g.dart';
var localPlatform = const LocalPlatform();

var logger = Logger(
   printer: PrettyPrinter(),
);

var loggerNoStack = Logger(
   printer: PrettyPrinter(methodCount: 0),
);

Function unOrdDeepEq = const DeepCollectionEquality.unordered().equals;

// This is the type used by the popup menu below.
enum MenuButtonSelected { /* remoteGames, */ oldUnFinishedGames,
  editPlayerNames, finishedGames, exitGame }

void main() async {
  Intl.defaultLocale = 'fi_FI';
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);
  // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await setupDi();
  await di<LGameDataService>().checkInit();
 // FlutterNativeSplash.remove();
  initializeDateFormatting('fi_FI', "yyyy-mm-dd hh:mm:ss").then((_) =>
      runApp(const MyApp()));
}

const String strAppTitle = 'LGame for creativity';
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);
    bool bScreenReaderIsUsed = false;
    if (mediaQueryData.accessibleNavigation) {
      bScreenReaderIsUsed = true;
      logger.i("bScreenReaderIsUsed = true");
    } else {
      bScreenReaderIsUsed = false;
    }

    return ScreenUtilInit(
        designSize: const Size(448, 998), // Size(360, 690),
    minTextAdapt: true,
      enableScaleWH: ()=>true,
      enableScaleText: ()=>true,
    splitScreenMode: true,
    // Use builder only if you need to use library outside ScreenUtilInit context
    builder: (_ , child) {
    return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: strAppTitle,
    // You can use the library anywhere in the app even in theme
    theme: ThemeData(
    primarySwatch: Colors.blue,
    ),
    home: child,
    );
    },
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      title: strAppTitle,
      initialRoute: '/',
   //   navigatorKey: navigatorKey, // important
      routes: {
        '/': (context) => const LoadingScreen(),
        '/lgamefor2': (context) => MyHomePage(title: strAppTitle, bScreenReaderIsUsed: bScreenReaderIsUsed),
        '/help': (context) => const HelpRoute(),
        '/oldgames': (context) => const OldGamesRoute(),
        '/finishedgames': (context) => const FinishedGamesRoute(),
        '/remotegames': (context) => const RemoteGamesRoute(),
      },
      theme: ThemeData(
        useMaterial3: true, colorScheme: ColorScheme.fromSeed(seedColor: 
      Colors.deepPurple).copyWith(surface: Colors.blueGrey),
      ),
    ),
     // home: const MyHomePage(title: strAppTitle),
    );
  }
}

class MyHomePage extends StatefulWidget {

/// iArrPlayerPossibleMovePieces
 // final Function() notifyParent;
  // ChildWidget({Key key, @required this.notifyParent}) : super(key: key);
  const MyHomePage({super.key,
    required this.title, required this.bScreenReaderIsUsed /*, @required this.notifyParent} */});
  final String title;
  final bool bScreenReaderIsUsed;

  @override
  State<MyHomePage> createState() => _LGamePageState();

}

class _LGamePageState extends State<MyHomePage>
    with WidgetsBindingObserver
{

  @override
  void dispose() {
    logger.i("dispose");
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    switch (state) {
      case AppLifecycleState.resumed:
        logger.i("resumed");
        break;
      case AppLifecycleState.paused:
        logger.i("paused");
          var obj = lGameSession.getGamePositionsForSaveGame();
          di<LGameDataService>().setActiveGame(obj);
          di<LGameDataService>().saveLGameSessionData(obj);
          di<LGameDataService>().closeHive();
        break;
      default:
        break;
    }
  }

  bool bGameIsFormat = true;
  BuildContext? thisContext;
  LGameSession lGameSession = LGameSession();
  SelectedLGameSessionData? selectedLGameSessionData;
  SelectedLGameSessionData? oldSelectedLGameSessionData;

  Widget? _buttonsRow0;
  Widget? _buttonsRow1;
  Widget? _buttonsRow2;
  Widget? _buttonsRow3;
  Widget? _buildBoard;
  Widget? _buttonsEditRow1;
  TextField? _textFieldName1, _textFieldName2;
  ElevatedButton? _buttonSaveEdit, _buttonReturnFromEdit;
  final TextEditingController _textFieldName1Controller = TextEditingController();
  final TextEditingController _textFieldName2Controller = TextEditingController();

  MenuButtonSelected? selectedMenuButton;
  bool bEditPlayerNames = false;
//  List<Stack> _listBoardStack = List<Stack>.empty(growable: true);
  final double containerWidth = 200;
  final double containerHeight = 200;
  bool bInitGameBoard = true;

  Widget? buttonUp;
  Widget? buttonDown;
  Widget? buttonWrapUp;
  ElevatedButton? buttonSwitchNeutral;
  Widget? buttonLeft;
  Widget? buttonRight;
  ElevatedButton? buttonStartGame;
  ElevatedButton? buttonTurn90Degree;
  ElevatedButton? buttonMoveDone;
  ElevatedButton? buttonHelp;
  Text? textMessage;
  // bool bScreenReaderIsUsed = true;

  Color player1Color = Colors.redAccent;
  Color player2Color = Colors.blueAccent;
  Color neutralColor = Colors.black;
  final ButtonStyle buttonStyle =
         ElevatedButton.styleFrom(textStyle: TextStyle(fontSize: ScreenUtil().setSp(20),
             fontWeight: FontWeight.bold),
         backgroundColor: Colors.amberAccent);

  Future<bool> showStartNewGameDialog() async {
    bool bCancelReturnValue = true;
    bool bContinueReturnValue = false;
      return showYesNoDialog(thisContext!, "New L game", "Cancel", "Continue",
          "Would you like to start a new L game?", bCancelReturnValue,
          bContinueReturnValue);
  }

  buttonStartGamePressed()
  async {
    logger.i("buttonStartGamePressed");
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
    bool? bValue = lGameSession.buttonStartGamePressed();
    if (bValue == null) {
      return ;
    }
    di<LGameDataService>().setActiveGame(lGameSession.getGamePositionsForSaveGame());
    if (bValue) {
      setState(() {
      _buildBoard = buildGameBoard();
    });
    }
  }

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
          if (gp == null) {
            continue;
          }
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
          if (gp == null) {
            continue;
          }
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
          if (item == null) {
            continue;
          }
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
        if (gp == null) {
          continue;
        }
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
          _buildBoard = buildGameBoard();
        });
        return true;
      }
      else {
        return false;
      }
  }

  buttonMoveDonePressed() async {
    logger.i("buttonMoveDonePressed");
    bool? bValue = await lGameSession.calculatePossibleMovePieces(ButtonPressed.moveDone);
    if (bValue == null) {
      return;
    }
    /*
    if (bValue)
      {
     */
        setState(() {
          _buildBoard = buildGameBoard();
        });
   // }
  }

  buttonHelpEnabledPressed()
  {
    logger.i("buttonHelpEnabledPressed");
    Navigator.pushNamed(context, "/help");
    /*
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HelpRoute()),
    );
     */
  }

  buttonSaveEditPressed()
  {
    setState(() {
      lGameSession.name1 = _textFieldName1Controller.text;
      lGameSession.name2 = _textFieldName2Controller.text;
      bEditPlayerNames = false;
      _buildBoard = buildGameBoard();
    });
  }

  buttonReturnFromEditPressed()
  {
    setState(() {
      bEditPlayerNames = false;
      _buildBoard = buildGameBoard();
    });
  }

  buttonTurn90DegreePressed() async
  {
    logger.i("buttonTurn90GradePressed");
    bool? bValue = await lGameSession.calculatePossibleMovePieces(ButtonPressed.turn90Degree);
    if (bValue == null) {
      return;
    }
    /*
    if (bValue)
    {
     */
      setState(() {
        _buildBoard = buildGameBoard();
      });
  //  }
  }

  buttonUpPressed() async
  {
     logger.i("buttonUpPressed");
     bool? bValue = await lGameSession.calculatePossibleMovePieces(ButtonPressed.up);
     if (bValue == null) {
       return;
     }
     /*
     if (bValue)
     {
      */
       setState(() {
         _buildBoard = buildGameBoard();
       });
    // }
  }

  buttonDownPressed() async
  {
     logger.i("buttonDownPressed");
     bool? bValue = await lGameSession.calculatePossibleMovePieces(ButtonPressed.down);
     if (bValue == null) {
       return;
     }
     /*
     if (bValue)
     {
      */
       setState(() {
         _buildBoard = buildGameBoard();
       });
    // }
  }

  buttonLeftPressed() async
  {
     logger.i("buttonLeftPressed");
     bool? bValue = await lGameSession.calculatePossibleMovePieces(ButtonPressed.left);
     if (bValue == null) {
       return;
     }
     /*
     if (bValue)
     {
      */
       setState(() {
         _buildBoard = buildGameBoard();
       });
    // }
  }

  buttonRightPressed() async
  {
     logger.i("buttonRightPressed");
     bool? bValue = await lGameSession.calculatePossibleMovePieces(ButtonPressed.right);
     if (bValue == null) {
       return;
     }
     /*
     if (bValue)
     {
      */
       setState(() {
         _buildBoard = buildGameBoard();
       });
    // }
  }

  buttonWrapUpPressed() async
  {
     logger.i("buttonWrapUpPressed");
     bool? bValue = await lGameSession.calculatePossibleMovePieces(ButtonPressed.wrap);
     if (bValue == null) {
       return;
     }
     /*
     if (bValue)
     {
      */
       setState(() {
         _buildBoard = buildGameBoard();
       });
    // }
  }

  buttonSwitchNeutralPressed() async
  {
     logger.i("buttonSwitchNeutralPressed");
     bool? bValue = await lGameSession.
          calculatePossibleMovePieces(ButtonPressed.swiftIntoNextNeutral);
     if (bValue == null) {
       return;
     }
     /*
     if (bValue)
     {
      */
       setState(() {
         _buildBoard = buildGameBoard();
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

  getLastDataSession() async
  {
    LGameSessionData? active = await di<LGameDataService>().getActiveGame();
    List<LGameSessionData>? cList =
        await di<LGameDataService>().getLGameSessionDataUnfinished();
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
        _buildBoard = buildGameBoard();
      });
  }

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();

    lGameSession.initState();
    getLastDataSession();
   //   _buildBoard = buildGameBoard();
  }

  Widget buildGameBoard()
  {

     logger.i("buildGameBoard");

     /*
    _listBoardSquares = List.generate(16,  (index) {
      return getBoardSquaresContainer(index);
    });
      */

    buttonStartGame =  ElevatedButton(
      style: buttonStyle,
      onPressed: lGameSession.bButtonStartGameEnabled ? buttonStartGamePressed : null,
      child: const Text('Start game'),
    );

    buttonUp = ElevatedButton.icon(
      style: buttonStyle,
      /*
      style: ElevatedButton.styleFrom(
        shape: StadiumBorder(),
      ),
       */
      onPressed: lGameSession.bButtonUpEnabled ? buttonUpPressed : null,
      icon: const Icon(Icons.arrow_upward, size: 30.0,),
      label: const Text("Up"),
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

    buttonDown = ElevatedButton.icon(
      style: buttonStyle,
      onPressed: lGameSession.bButtonDownEnabled ? buttonDownPressed : null,
      icon: const Icon(Icons.arrow_downward, size: 30.0,),
      label: const Text('Down'),
    );

    buttonLeft = ElevatedButton.icon(
      style: buttonStyle,
      onPressed: lGameSession.bButtonLeftEnabled ? buttonLeftPressed : null,
      icon: const Icon(Icons.arrow_back, size: 30.0,),
      label: const Text('Left'),
    );

    buttonRight =   ElevatedButton.icon(
      style: buttonStyle,
      onPressed: lGameSession.bButtonRightEnabled ? buttonRightPressed : null,
      icon: const Icon(Icons.arrow_forward, size: 30.0,),
      label: const Text('Right'),
    );

    buttonWrapUp = ElevatedButton(
      style: buttonStyle,
      onPressed: lGameSession.bButtonWrapUpEnabled ? buttonWrapUpPressed : null,
      child: const Text('Wrap'),
    );

    String strNeutral;
    if (lGameSession.iActiveNeutral == 2) {
      strNeutral = "Select 1' neutral";
    } else {
      strNeutral = "Select 2' neutral";
    }

    buttonSwitchNeutral = ElevatedButton(
      style: buttonStyle,
      onPressed: lGameSession.bButtonSwitchNeutralEnabled ? buttonSwitchNeutralPressed : null,
      child: Text(strNeutral),
    );

    buttonTurn90Degree = ElevatedButton(
      style: buttonStyle,
      onPressed: lGameSession.bButtonTurn90DegreeEnabled ? buttonTurn90DegreePressed : null,
      child: const Text('Turn 90º'),
    );

     buttonHelp = ElevatedButton(
       style: buttonStyle,
       onPressed: lGameSession.bButtonHelpEnabled ? buttonHelpEnabledPressed : null,
       child: const Text('Help'),
     );

     buttonMoveDone = ElevatedButton(
       style: buttonStyle,
       onPressed: lGameSession.bButtonMoveDoneEnabled ? buttonMoveDonePressed : null,
       child: const Text('Move Done'),
     );

     if (lGameSession.bGameIsOver)
     {
       textMessage = Text(lGameSession.msg,
         style: TextStyle(color: Colors.black, fontSize: ScreenUtil().setSp(25),
             backgroundColor: Colors.yellowAccent),
       );
     }
     else {
       textMessage = Text(lGameSession.msg,
         style: TextStyle(color: Colors.black, fontSize: ScreenUtil().setSp(25)),
       );
     }

     const double buttonBetweenWidth = 20;

     if (bEditPlayerNames) {
       /*
     Widget? _editRow0, _editRow1, _buttonsEditRow1;
     TextField? _textFieldName1, _textFieldName2;
     ElevatedButton? _buttonSaveEdit, _buttonReturnFromEdit;
      */

       _buttonSaveEdit = ElevatedButton(
         style: buttonStyle,
         onPressed: bEditPlayerNames ? buttonSaveEditPressed : null,
         child: const Text('Save names'),
       );

       _buttonReturnFromEdit = ElevatedButton(
         style: buttonStyle,
         onPressed: bEditPlayerNames ? buttonReturnFromEditPressed : null,
         child: const Text('No save'),
       );

       _textFieldName1Controller.text = lGameSession.name1;

       _textFieldName1 = TextField(
         controller: _textFieldName1Controller,
         decoration: const InputDecoration(
           label: Text.rich(
             TextSpan(
               children: <InlineSpan>[
                 WidgetSpan(
                   child: Text(
                     'Player 1',
                   ),
                 ),
                 WidgetSpan(
                   child: Text(
                     '*',
                     style: TextStyle(color: Colors.red),
                   ),
                 ),
               ],
             ),
           ),
         ),
       );

       _textFieldName2Controller.text = lGameSession.name2;

       _textFieldName2 = TextField(
         controller: _textFieldName2Controller,
         decoration: const InputDecoration(
           label: Text.rich(
             TextSpan(
               children: <InlineSpan>[
                 WidgetSpan(
                   child: Text(
                     'Player 2',
                   ),
                 ),
                 WidgetSpan(
                   child: Text(
                     '*',
                     style: TextStyle(color: Colors.red),
                   ),
                 ),
               ],
             ),
           ),
         ),
       );

       /*
       _editRow1 = Row(children: [
         _textFieldName2!,
       ],
       );
        */

       _buttonsEditRow1 = Row(children: [
         _buttonSaveEdit!,
         const SizedBox(height: 40, width: buttonBetweenWidth,),
         _buttonReturnFromEdit!,
       ],
       );
     } // end of bEdit controls

     _buttonsRow0 = Row(children: [
      buttonStartGame!,
      const SizedBox(height: 40, width: buttonBetweenWidth,),
      buttonMoveDone!,
    ],
    );

    _buttonsRow1 = Row(children: [
      buttonUp!,
  //    const SizedBox(height: 2, width: buttonBetweenWidth,),
      buttonDown!,
    //  const SizedBox(height: 2, width: buttonBetweenWidth,),
      buttonTurn90Degree!
    ],
    );

    _buttonsRow2 = Row(children: [
      buttonLeft!,
   //   const SizedBox(height: 2, width: buttonBetweenWidth,),
      buttonRight!,
     // const SizedBox(height: 2, width: buttonBetweenWidth,),
      buttonHelp!,
    ],
    );

    _buttonsRow3 = Row(children: [
      buttonWrapUp!,
      const SizedBox(height: 30, width: buttonBetweenWidth,),
      buttonSwitchNeutral!,
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
    Column? editOrButtonContainer;
     if (bEditPlayerNames)
     {
       editOrButtonContainer = Column(children: [
         _textFieldName1!, _textFieldName2!, _buttonsEditRow1!,
       ],);
     }
     else
       {
         editOrButtonContainer = Column(children: [
         _buttonsRow0!,  _buttonsRow1!, _buttonsRow2!, _buttonsRow3!,
        ],);
       }


    Widget ret = Column (
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Expanded( // wrap in Expanded
          child: LGameBoard(lGameSession: lGameSession,
              bScreenReaderIsUsed: widget.bScreenReaderIsUsed) /* _gameBoardGrid! */,
        ),
//        SizedBox(height: 20,),
    Padding(
    padding: const EdgeInsets.fromLTRB(20, 0, 0, 20),
    child: Column (
     crossAxisAlignment: CrossAxisAlignment.center,
     mainAxisSize: MainAxisSize.min,
     children: <Widget>[
      Center( child: Semantics(
        liveRegion: true,
        child: textMessage!,),
       ),
       const SizedBox(height: 20, width: buttonBetweenWidth,),
       editOrButtonContainer,
    ],),
    ),
    ],
    );

   return ret; // Column(children: <Widget>[_gameBoardGrid!, ],);
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
       ret = "Player 1";
     } else
     if (lGameSession.playerTurn == GamePlayerTurn.player2) {
       ret = "Player 2";
     }
     return ret;
  }

  callOldUnFinishedGames() async
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
          lGameSession.msg = "Cannot save the current game.";
          _buildBoard = buildGameBoard();
        });
        return;
      }

      di<LGameDataService>().setActiveGame(selectedLGameSessionData!.gameSessionData);
      oldSelectedLGameSessionData = selectedLGameSessionData;
      lGameSession.setStartGameAfterOldGame(
          selectedLGameSessionData!.gameSessionData!);
      setState(() {
        _buildBoard = buildGameBoard();
      });
    }
    // final result = await = Navigator.pushAndRemoveUntil(context,  MaterialPageRoute(builder: (context) =>
    //   OldGamesPage()), (route) => false);
  }

  callExitGame()
  {
    if (localPlatform.isAndroid) {
      FlutterExitApp.exitApp();
    } else if (localPlatform.isIOS) {
      FlutterExitApp.exitApp(iosForceExit: true);
    }
  }

  callRemoteGames() async
  {
    /*
    await Navigator.pushNamedAndRemoveUntil(
        context, "/finishedgames", ModalRoute.withName('/finishedgames'));
     */
    Navigator.pushNamed(context, "/remotegames");
  }

  callFinishedGames() async
  {
    /*
    await Navigator.pushNamedAndRemoveUntil(
        context, "/finishedgames", ModalRoute.withName('/finishedgames'));
     */
    Navigator.pushNamed(context, "/finishedgames");
  }

  @override
  Widget build(BuildContext context) {
    thisContext = context;
    if (bGameIsFormat)
      {
        _buildBoard = buildGameBoard();
        bGameIsFormat = false;
      }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("${widget.title}: ${_getPlayerName()}"),
        actions: [
          PopupMenuButton<MenuButtonSelected>(
            initialValue: selectedMenuButton,
            onSelected: (MenuButtonSelected item) {
              setState(() {
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
                  setState(() {
                    bEditPlayerNames = true;
                    _buildBoard = buildGameBoard();
                  });
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

              });
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<MenuButtonSelected>>[
              const PopupMenuItem<MenuButtonSelected>(
                value: MenuButtonSelected.oldUnFinishedGames,
                child: Text('Select unfinished games'),
              ),
              /*
              const PopupMenuItem<MenuButtonSelected>(
                value: MenuButtonSelected.remoteGames,
                child: Text('Remote games'),
              ),

               */
              const PopupMenuItem<MenuButtonSelected>(
                value: MenuButtonSelected.editPlayerNames,
                child: Text('Edit player names'),
              ),
              const PopupMenuItem<MenuButtonSelected>(
                value: MenuButtonSelected.finishedGames,
                child: Text('Finished games'),
              ),
              const PopupMenuItem<MenuButtonSelected>(
                value: MenuButtonSelected.exitGame,
                child: Text('Exit game'),
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
                       lGameSession.strMsg = "Cannot save the current game.";
                       _buildBoard = buildGameBoard();
                     });
                     return;
                   }

                   oldSelectedLGameSessionData = selectedLGameSessionData;
                   setState(() {
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
      body: Container(
    decoration: BoxDecoration(
    color: Colors.white70,
    border: Border.all(
    color: Theme.of(context).colorScheme.inversePrimary,
    width: 15,
    ),
    ),
    child: /* buildGameBoard() */ _buildBoard ,
      ),
    );
  }
}

/*
class _PopupMenuExampleState  {
  MenuButtonSelected? selectedMenuButton;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('PopupMenuButton')),
      body: Center(
        child: PopupMenuButton<MenuButtonSelected>(
          initialValue: selectedMenuButton,
          onSelected: (MenuButtonSelected item) {
            setState(() {
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
