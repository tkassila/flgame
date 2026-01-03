
// import 'package:injectable/injectable.dart';
import 'dart:async';
import 'dart:io';
import 'package:flgame/LoggerDef.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;
// import 'package:logger/logger.dart';

import './lgame_data.dart';
// import 'package:your_app/models/person_model.dart';

/*
var logger = Logger(
  printer: PrettyPrinter(),
);

var loggerNoStack = Logger(
  printer: PrettyPrinter(methodCount: 0),
);
 */

class LGameDateServiceProvider {
  // Local Source For Home
  final LGameDataService _lGameDateService;

  LGameDateServiceProvider(this._lGameDateService,) {
    _lGameDateService.initHive();
  }
}

class LGameDataService {
  static bool bInitHasDone = false;
  static LGameDataService? _instance;

//  LGameDateService._();

//  factory LGameDateService() => _instance ??= LGameDateService._();
  LGameSessionData? selectedLGameSessionData;
  static const String _nameHiveDataBox = "hivelgamesessiondatabox";
 // static const String _nameDataBox = "lgamesessiondatabox";
  HiveLGameSessionData? hiveLGameSessionData;
  Box? _boxSessionHiveData;
//  static Box? _boxSessionData;

  static String getHiveDataBoxName() {
    return _nameHiveDataBox;
  }

  /*
  static String getDataBoxName() {
    return _nameDataBox;
  }
  */

  /*
  setPrivateHiveDataBox(Box box) {
    // box.deleteFromDisk();
    _boxSessionHiveData = box;
  }

  static setHiveDataBox(Box box) {
    _service.setPrivateHiveDataBox(box);
  }

  setPrivateDataBox(Box box) {
    // box.deleteFromDisk();
    _boxSessionData = box;
  }

  static setDataBox(Box box) {
    _service.setPrivateDataBox(box);
  }
   */

  Future<void> closeHive() async
  {
    if (_boxSessionHiveData!.isEmpty) {
      await _boxSessionHiveData!.put(_nameHiveDataBox, hiveLGameSessionData!);
    } else {
      await _boxSessionHiveData!.put(_nameHiveDataBox, hiveLGameSessionData!);
    }
    if (_boxSessionHiveData != null) {
      await _boxSessionHiveData!.close();
    }
    /*
    if (_boxSessionData != null) {
      await _boxSessionData!.close();
    }
     */
  }

  Future<void> initHive() async
  {
    var path = Directory.current.path;
    if (Loggerdef.isLoggerOn) {
      Loggerdef.logger.i("var path = Directory.current.path: $path");
    }
    Directory directory = await pathProvider.getApplicationDocumentsDirectory();
//  hiveDb = Directory('${appDir. path}/chosenPath');
    if (Loggerdef.isLoggerOn) {
      Loggerdef.logger.i(".current.path: ${directory.path}");
    }
    await Hive.initFlutter();
    /*
    var hiveInterface = await Hive
      ..init(directory.path);

     */
    // ..init(path)
    Hive.registerAdapter(GamePlayerTurnAdapter());
    Hive.registerAdapter(LGamePieceInMoveAdapter());
    Hive.registerAdapter(LGameSessionDataAdapter());
    Hive.registerAdapter(HiveLGameSessionDataAdapter());
   // LGameDateService.setDataBox(await Hive.openBox(LGameDateService.getDataBoxName()));
    _boxSessionHiveData = await Hive.openBox(LGameDataService.getHiveDataBoxName());

    // _sessionDataBox =  (await
    //   Hive.openBox<HiveLGameSessionData>('data/' +_boxName));
    hiveLGameSessionData =
        _boxSessionHiveData!.get(_nameHiveDataBox); // as HiveLGameSessionData;
    if (hiveLGameSessionData == null) {
      hiveLGameSessionData = HiveLGameSessionData();
  //    if (_boxSessionData != null) {
        hiveLGameSessionData!.unFinishedGames = List.empty(growable: true);
        // HiveList(_boxSessionData!);
        hiveLGameSessionData!.finishedGames = List.empty(growable: true);
    //  }
    }
    else
      {
        if (hiveLGameSessionData!.unFinishedGames == null) {
          hiveLGameSessionData!.unFinishedGames = List.empty(growable: true);
        }
        if (hiveLGameSessionData!.finishedGames == null) {
          hiveLGameSessionData!.finishedGames = List.empty(growable: true);
        }
      }
    bInitHasDone = true;
  }

  /*
  Future<Box<LGameSessionData>> get _box async =>
      await Hive.openBox<LGameSessionData>(_boxName);
  */

  LGameSessionData? getActiveGame()
  {
    return hiveLGameSessionData!.activeGame;
  }

  void setActiveGame(LGameSessionData? active)
  {
      hiveLGameSessionData!.activeGame = active;
  }

  List<LGameSessionData>? getLGameSessionDataUnfinished() {
    /*
     List<LGameSessionData> ret = List.empty(growable: true);
     LGameSessionData gs1 = LGameSessionData();
     gs1.name1  = "Kissa1";
     gs1.name2  = "Kissa2";
     gs1.startedAt = DateTime.now().toString();
     gs1.isLocal = true;
     gs1.oldIActiveNeutral = 3;
     gs1.oldIArrPlayer1Pieces = [4,5,6,8];
     gs1.oldIArrPlayer2Pieces = [9,10,11,7];
     gs1.oldIPlayerNeutral1Piece = 12;
     gs1.oldIPlayerNeutral2Piece = 3;
     gs1.oldIPlayerMovePieces = gs1.oldIArrPlayer1Pieces;
     gs1.oldPlayerTurn = GamePlayerTurn.player1;
     gs1.oldInMovingPiece = LGamePieceInMove.LPiece;
     gs1.oldIPlayerMove = 2;

     ret.add(gs1);

     LGameSessionData gs2 = LGameSessionData();
     gs2.name1  = "Kissa3";
     gs2.name2  = "Kissa4";
     gs2.startedAt = DateTime.now().toString();
     gs2.isLocal = true;
     gs2.oldIActiveNeutral = 2;
     gs2.oldIArrPlayer1Pieces = [9,10,11,7];
     gs2.oldIArrPlayer2Pieces = [4,5,6,8];
     gs2.oldIPlayerNeutral1Piece = 2;
     gs2.oldIPlayerNeutral2Piece = 13;
     gs2.oldIPlayerMovePieces = [ 13 ]; // gs2.oldIArrPlayer1Pieces;
     gs2.oldPlayerTurn = GamePlayerTurn.player2;
     gs2.oldInMovingPiece = LGamePieceInMove.neutral;
     gs2.oldIPlayerMove = 2;
     ret.add(gs2);
     return ret;
     */

    // checkInit();

    if (hiveLGameSessionData == null) {
      return null;
    }
    if (hiveLGameSessionData!.unFinishedGames == null
    || hiveLGameSessionData!.unFinishedGames!.isEmpty) {
      return null;
    }

    /*
    List<LGameSessionData> ret = List<LGameSessionData>.empty(growable: true);
    var hiveList = hiveLGameSessionData!.unFinishedGames!.toList()
        .reversed.toList();
    for (int i = 0; i < hiveList.length; i++) {
      ret.add(hiveList[i] as LGameSessionData);
    }
     */
    List<LGameSessionData> ret = hiveLGameSessionData!.unFinishedGames!.toList()
        .reversed.toList();
    return ret;
  }

  Future<void> checkInit() async {
    if (!bInitHasDone) {
      initHive();
    }
  }

  List<LGameSessionData>? getLGameSessionDataFinished() {
  //  checkInit();
    List<LGameSessionData> ret = List<LGameSessionData>.empty(growable: true);
    var hiveList = hiveLGameSessionData!.finishedGames!.toList()
        .reversed.toList();
    for (int i = 0; i < hiveList.length; i++) {
      ret.add(hiveList[i]);
    }
    return ret;
  }

  bool /* Future<bool> */ saveLGameSessionData(LGameSessionData ds) /* async */
  {
   // checkInit();
    getSavingGamesList(ds);
    /*
    if (_boxSessionHiveData!.isEmpty) {
      await _boxSessionHiveData!.put(_nameHiveDataBox, hiveLGameSessionData!);
    } else {
      await _boxSessionHiveData!.put(_nameHiveDataBox, hiveLGameSessionData!);
    }
     */
    return true;
  }

  LGameSessionData getNewFreshGame()
  {
    LGameSessionData gs2 = LGameSessionData();
    gs2.name1  = "";
    gs2.name2  = "";
    gs2.startedAt = DateTime.now().toString();
    gs2.isLocal = true;
    gs2.oldIActiveNeutral = 1;
    gs2.bGameOver = false;
    gs2.oldIArrPlayer1Pieces = [5,9,13,14];
    gs2.oldIArrPlayer2Pieces = [1,2,6,10];
    gs2.oldIPlayerNeutral1Piece = 0;
    gs2.oldIPlayerNeutral2Piece = 15;
    gs2.oldIPlayerMovePieces = gs2.oldIArrPlayer1Pieces;
    gs2.oldPlayerTurn = GamePlayerTurn.player1;
    gs2.oldInMovingPiece = LGamePieceInMove.LPiece;
    gs2.oldIPlayerMove = 1;
    return gs2;
  }

//  List<LGameSessionData>?
  void getSavingGamesList(LGameSessionData ds) {
   // checkInit();
    bool founded = false;
    List<LGameSessionData> listGames = hiveLGameSessionData!.unFinishedGames!;
    List<LGameSessionData> unfinishedGames = hiveLGameSessionData!.unFinishedGames!;
    bool bUnFinishedGamesExists = false;

    bool ActiveTheSame = hiveLGameSessionData!.activeGame == null ? false :
        ds.startedAt == hiveLGameSessionData!.activeGame!.startedAt;
    if (ActiveTheSame) {
      hiveLGameSessionData!.activeGame = ds;
    }

    saveIntoUnFinishedGamesList(ds);
    /*
    bUnFinishedGamesExists = unfinishedGames.any((listItem) =>
         listItem.startedAt == ds.startedAt);

    if (bUnFinishedGamesExists) {
      unfinishedGames.remove(ds);
    }
    unfinishedGames.add(getNewFreshGame());
    hiveLGameSessionData!.unFinishedGames = unfinishedGames;
    */
  }

  void saveIntoUnFinishedGamesList(LGameSessionData ds)
  {
    List<LGameSessionData> listGames = hiveLGameSessionData!.unFinishedGames!;
    listGames ??= List<LGameSessionData>.empty(growable: true);
//    checkInit();

    bool bExists = false; // listGames.isNotEmpty;
    /*
    bExists = listGames.contains(ds);
    if (bExists) {
     */
      LGameSessionData? data;
      bool founded =  false;
      int iFounded = -1;
      for (int i = 0; i < listGames.length; i++) {
        data = listGames[i];
        if (data == null) {
          continue;
        }
        if (data.startedAt == ds.startedAt) {
          listGames[i] = ds;
          iFounded = i;
          founded = true;
          break;
        }
      }
   // }
      if (!founded) {
        listGames.add(ds);
      }
    hiveLGameSessionData!.unFinishedGames = listGames;
  }

  Future<void> saveIntoFinishedGamesList(LGameSessionData ds) async
  {
    List<LGameSessionData> listGames = hiveLGameSessionData!.finishedGames!;
    listGames ??= List<LGameSessionData>.empty(growable: true);
   // checkInit();

    bool bExists = false; // listGames.isNotEmpty;
    /*
    bExists = listGames.contains(ds);
    if (bExists) {
     */
      LGameSessionData? data;
      bool founded =  false;
      int iFounded = -1;
      for (int i = 0; i < listGames.length; i++) {
        data = listGames[i];
        if (data == null) {
          continue;
        }
        if (data.startedAt == ds.startedAt) {
          listGames[i] = ds;
          iFounded = i;
          founded = true;
          break;
        }
      }
      if (!founded) {
        listGames.add(ds);
      }
    // }
    hiveLGameSessionData!.finishedGames = listGames;
  }

  bool deleteFinishedGameSessionData(LGameSessionData ds) {
    List<LGameSessionData> listGames = hiveLGameSessionData!.finishedGames!;
    listGames ??= List<LGameSessionData>.empty(growable: true);
  //  checkInit();

    bool bExists = false; // listGames.isNotEmpty;
    // .put(ds.startedAt, ds);
    LGameSessionData? data;
    bool founded =  false;
    int iFounded = -1;
    for (int i = 0; i < listGames.length; i++) {
      data = listGames[i];
      if (data == null) {
        continue;
      }
      if (data.startedAt == ds.startedAt) {
        listGames[i] = ds;
        iFounded = i;
        founded = true;
        break;
      }
    }
    if (!founded)
      {
        return false;
      }
      listGames.removeAt(iFounded);
      hiveLGameSessionData!.finishedGames = listGames;
      return true;
  }

  bool deleteUnFinishedGameSessionData(LGameSessionData ds) {
    List<LGameSessionData> listGames = hiveLGameSessionData!.unFinishedGames!;
    listGames ??= List<LGameSessionData>.empty(growable: true);
  //  checkInit();

    bool bExists = false; // listGames.isNotEmpty;
      // .put(ds.startedAt, ds);
    LGameSessionData? data;
    bool founded =  false;
    int iFounded = -1;
   for (int i = 0; i < listGames.length; i++) {
     data = listGames[i];
     if (data == null) {
       continue;
     }
     if (data.startedAt == ds.startedAt) {
       listGames[i] = ds;
       iFounded = i;
       founded = true;
       break;
     }
   }
     if (!founded)
     {
        return false;
      }
     listGames.removeAt(iFounded);
     hiveLGameSessionData!.unFinishedGames = listGames;
     return true;
  }

  Future<bool?> deleteUnFinishedLGameSessionData(LGameSessionData ds) async
  {
 //   checkInit();
    if (!ds.bGameOver) {
      deleteUnFinishedGameSessionData(ds);
      /*
      if (_boxSessionHiveData!.isEmpty) {
        await _boxSessionHiveData!.put(_nameHiveDataBox, hiveLGameSessionData!);
      } else {
        await _boxSessionHiveData!.put(_nameHiveDataBox, hiveLGameSessionData!);
      }
       */
      return true;
    }
    return null;
  }

  Future<bool?> deleteFinishedLGameSessionData(LGameSessionData ds) async
  {
 //   checkInit();
    if (!ds.bGameOver) {
      deleteFinishedGameSessionData(ds);
      /*
      if (_boxSessionHiveData!.isEmpty) {
        await _boxSessionHiveData!.put(_nameHiveDataBox, hiveLGameSessionData!);
      } else {
        await _boxSessionHiveData!.put(_nameHiveDataBox, hiveLGameSessionData!);
      }
       */
      return true;
    }
    return null;
  }

/*
    void setSelectedLGameSessionData(
        SelectedLGameSessionData p_selectedLGameSessionData) {
      selectedLGameSessionData = p_selectedLGameSessionData;
    }

    SelectedLGameSessionData? getSelectedLGameSessionData()
    {
      return selectedLGameSessionData;
    }
    */

    /*
  static Future<Box<LGameSessionData>> get async
  {
    return _servie.box.get();
  }
  */
}