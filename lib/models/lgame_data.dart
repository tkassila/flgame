import 'package:flutter/semantics.dart';
import 'package:collection/collection.dart';
import 'package:hive/hive.dart';

part 'lgame_data.g.dart';

Function unOrdDeepEq = const DeepCollectionEquality.unordered().equals;

  // This widget is the root of your application.

@HiveType(typeId: 2)
enum GamePlayerTurn {
  @HiveField(0)
  player1,
  @HiveField(1)
  player2,
}

@HiveType(typeId: 3)
enum LGamePieceInMove {
  @HiveField(0)
  LPiece,
  @HiveField(1)
  neutral,
}

enum ButtonPressed {
  up,
  down,
  left,
  right,
  wrap,
  turn90Degree,
  moveDone,
  swiftIntoNextNeutral,
}

class  GameBoardPositionSeries {
  int iRow = 0;
  int iCol = 0;
  List<GameBoardPosition> series = List.empty(growable: true) ;
}

class GameBoardPosition {
  final int iRow;
  final int iCol;
  final int iPos;

  const GameBoardPosition( this.iRow, this.iCol, this.iPos);

}

class GameBoardPositionValidate {
  final GameBoardPosition gPos;
  GameBoardPositionValidate(this.gPos);

  int iPossibleRow = -1;
  int iPossibleCol = -1;
  bool bPossibleMove = false;

  bool  calculatePossibleMove(ButtonPressed pressed) {
    bool ret = false;
    iPossibleRow = gPos.iRow;
    iPossibleCol = gPos.iCol;
    if (pressed == ButtonPressed.left) {
      iPossibleCol = iPossibleCol - 1;
      validate();
    }
    else
    if (pressed == ButtonPressed.right) {
      iPossibleCol = iPossibleCol + 1;
      validate();
    }
    else
    if (pressed == ButtonPressed.up) {
      iPossibleRow = iPossibleRow - 1;
      validate();
    }
    else
    if (pressed == ButtonPressed.down) {
      iPossibleRow = iPossibleRow + 1;
      validate();
    }

    ret = bPossibleMove;
    return ret;
  }

  bool validate() {
    bPossibleMove = true;
    if (iPossibleCol < 0) {
      bPossibleMove = false;
    }
    else if (iPossibleCol > 3) {
      bPossibleMove = false;
    }
    else {
      bPossibleMove = true;
    }

    if (bPossibleMove && iPossibleRow < 0) {
      bPossibleMove = false;
    }
    else if (bPossibleMove && iPossibleRow > 3) {
      bPossibleMove = false;
    }
    else if (bPossibleMove) {
      bPossibleMove = true;
    }
    return bPossibleMove;
  }
}

@HiveType(typeId: 0) //typeId should be unique for each model
class LGameSessionData extends HiveObject {
  String? error;

  @HiveField(0) // unique id for each field
  String name1 = "";

  @HiveField(1)
  String name2 = "";

  @HiveField(2)
  String? startedAt;

  @HiveField(3)
  bool isLocal = true;

  @HiveField(4)
  String? remoteUser;

  @HiveField(5)
  int oldIActiveNeutral = 0;

  @HiveField(6)
  List<int>? oldIArrPlayer1Pieces;

  @HiveField(7)
  List<int>? oldIArrPlayer2Pieces;

  @HiveField(8)
  int oldIPlayerNeutral1Piece = -1;

  @HiveField(9)
  int oldIPlayerNeutral2Piece = -1;

  @HiveField(10)
  List<int>? oldIPlayerMovePieces;

  @HiveField(11)
  GamePlayerTurn? oldPlayerTurn;

  @HiveField(12)
  LGamePieceInMove? oldInMovingPiece;

  @HiveField(13)
  int? oldIPlayerMove;

  @HiveField(14)
  bool bGameOver = false;

  @HiveField(15)
  List<int>? oldIArrPlayerPossibleMovePieces;

  @HiveField(16)
  int? oldIPlayerNeutral1PieceInBeginningMove;

  @HiveField(17)
  int? oldIPlayerNeutral2PieceInBeginningMove;

  @HiveField(18)
  DateTime? modifiedAt;
}

@HiveType(typeId: 1) //typeId should be unique for each model
class HiveLGameSessionData extends HiveObject {
  String? error;

  @HiveField(0) // unique id for each field
  DateTime? saveTime = DateTime.now();

  @HiveField(1)
  List<LGameSessionData>? unFinishedGames;

  @HiveField(2) //uinque id for each field
  List<LGameSessionData>? finishedGames;

  /*
  HiveLGameSessionData({
    required this.saveTime,
    required this.unFinishedGames,
    required this.finishedGames,
  });
   */
}

class SelectedLGameSessionData {
  final selectedAtTime = DateTime.now().toString();
  final LGameSessionData? gameSessionData;
  SelectedLGameSessionData(this.gameSessionData);
}

class LGameSession {
  LGameSession();
  LGameSession.fromLGamaSessionData(LGameSessionData oldData)
  {
    setStartGameAfterOldGame(oldData);
    // this.buttonStartGamePressed();
  }

  // var freeElements;
  bool bScreenReaderIsUsed = false;
  void setScreenReaderIsUsed(bool bValue)
  {
    bScreenReaderIsUsed = bValue;
  }

  String name1 = "";
  String name2 = "";
  bool bInitGameBoard = true;
  final startIArrPlayer1Pieces = [5,9,13,14];
  final startIArrPlayer2Pieces = [1,2,6,10];
  List<int>? iArrPlayer1Pieces;
  List<int>? iArrPlayer2Pieces;
  List<int>? iArrPlayerMovePieces;
  List<int>? iArrPlayerPossibleMovePieces;
  List<GameBoardPosition>? arrBoardSquares;
  int? iPlayerMove;
  int iActiveNeutral = 1;
  final int startIPlayerNeutral1Piece = 0;
  final int startIPlayerNeutral2Piece = 15;

  bool bButtonUpEnabled = false;
  bool bButtonDownEnabled = false;
  bool bButtonRightEnabled = false;
  bool bButtonLeftEnabled = false;
  bool bButtonWrapUpEnabled = false;
  bool bButtonSwitchNeutralEnabled = false;
  bool bButtonTurn90DegreeEnabled = false;
  bool bButtonMoveDoneEnabled = false;
  bool bButtonStartGameEnabled = true;
  bool bGameStarted = false;
  bool bButtonHelpEnabled = true;

  LGamePieceInMove? inMovingPiece;
  GamePlayerTurn? playerTurn;

  List<int>? iPlayerPresentPos;
  List<int>? iPlayerOpponentPresentPos;

  String _strMsg = "";
  int iNextFortLPosition = 0;
  int? iPlayerNeutral1Piece;
  int? iPlayerNeutral1PieceInBeginningMove;
  int? iPlayerNeutral2PieceInBeginningMove;
  int? iPlayerNeutral2Piece;
  bool bGameIsOver = false;
  String? startedAt;
  DateTime? modifiedAt;
  /*
  Color player1Color = Colors.redAccent;
  Color player2Color = Colors.blueAccent;
  Color neutralColor = Colors.black;
   */

  set msg(String pMsg)
  {
     _strMsg = pMsg;
     _screenReaderAnnounce(pMsg);
  }

  _screenReaderAnnounce(String msg)
  {
    if (bScreenReaderIsUsed && _strMsg.isNotEmpty)
    {
      SemanticsService.announce(_strMsg, TextDirection.ltr);
    }
  }

  String get msg => _strMsg;

  String getScreenReaderSquareLabel(int index)
  {
    GameBoardPosition? pos = getGameBoardPosition(index);
    if (pos == null) {
      return "";
    }
    return 'Row: ' + (pos!.iRow+1).toString() + ' column: '
        +(pos!.iCol+1).toString() ;
  }

  String getScreenReaderSquareValue(int index)
  {
    /*
    Set freeSquares = calculateFreeElements();
    if (freeSquares.contains(index)) {
      return "Free";
    }
     */

    String strBottom = "";
    String strTop = "";
    Set iArrPlayer1PieceSet = iArrPlayer1Pieces!.toSet();
    if (iArrPlayer1PieceSet.contains(index)) {
      strBottom = " moved: L1";
    }
    Set iArrPlayer2PieceSet = iArrPlayer2Pieces!.toSet();
    if (iArrPlayer2PieceSet.contains(index)) {
      strBottom = " moved: L2";
    }
    else {
      if (iPlayerNeutral1Piece != null && iPlayerNeutral1Piece! == index) {
        strBottom = " moved: N1";
      }
      else if (iPlayerNeutral2Piece != null && iPlayerNeutral2Piece! == index) {
        strBottom = " moved: N2";
      }
    }

    /*
    bool isIn1List = lGameSession.iArrPlayer1Pieces == null ? false :
    lGameSession.iArrPlayer1Pieces!.contains(index);
    bool isIn2List = lGameSession.iArrPlayer2Pieces == null ? false :
    lGameSession.iArrPlayer2Pieces!.contains(index);

    if (index != lGameSession.iPlayerNeutral1Piece
        && index != lGameSession.iPlayerNeutral2Piece &&
        !isIn1List && !isIn2List) {
      return null;
    }

     */

    Set? iArrPlayerPossibleMovePiecesSet;
    if (iArrPlayerMovePieces != null) {
      iArrPlayerPossibleMovePiecesSet = iArrPlayerMovePieces!.toSet();
      if (iArrPlayerPossibleMovePiecesSet.contains(index)) {
        String player = "1";
        String strMoving = "L";
        if (playerTurn == GamePlayerTurn.player2) {
          player = "2";
        }
        if (inMovingPiece == LGamePieceInMove.neutral) {
          strMoving = "N";
        }
        strTop = " moving: $strMoving$player";
      }
    }

    if (strBottom.isEmpty && strTop.isEmpty) {
      return "Free";
    }
    if (strBottom.isEmpty) {
      strBottom = "bottom: Free";
    }

    return "$strTop\n$strBottom";
  }

  disAbleButtonsForGameOver()
  {
    bButtonUpEnabled = false;
    bButtonDownEnabled = false;
    bButtonRightEnabled = false;
    bButtonLeftEnabled = false;
    bButtonWrapUpEnabled = false;
    bButtonSwitchNeutralEnabled = false;
    bButtonTurn90DegreeEnabled = false;
    bButtonMoveDoneEnabled = false;
    bButtonStartGameEnabled = true;
    bButtonHelpEnabled = true;
  }

  bool? switchTurn(bool bStartNewGame)
   {
    bButtonSwitchNeutralEnabled = false;
    bButtonTurn90DegreeEnabled = true;
    if (bStartNewGame || playerTurn == null) {
      bInitGameBoard = false;
      playerTurn = GamePlayerTurn.player1;
      inMovingPiece = LGamePieceInMove.LPiece;
      bButtonWrapUpEnabled = true;
      iArrPlayerMovePieces = [... iArrPlayer1Pieces!];
      iPlayerMove = 1;
      iActiveNeutral = 1;
      msg = "Player 1: move L piece";
    }
    else
    if (playerTurn == GamePlayerTurn.player1)
      {
        playerTurn = GamePlayerTurn.player2;
        inMovingPiece = LGamePieceInMove.LPiece;
        bButtonWrapUpEnabled = true;
        iArrPlayerMovePieces = [... iArrPlayer2Pieces!];
        msg = "Player 2: move L piece";
        iActiveNeutral = 1;
        iPlayerMove = 2;

        if (!bInitGameBoard && inMovingPiece == LGamePieceInMove.LPiece
            && noLPieceFreePositions())
        {
          msg =
            "There is no free positions for L piece. You had lost this game!";
          bGameIsOver = true;
          disAbleButtonsForGameOver();
          return true;
        }

      }
    else
      {
      playerTurn = GamePlayerTurn.player1;
      inMovingPiece = LGamePieceInMove.LPiece;
      bButtonWrapUpEnabled = true;
      iArrPlayerMovePieces = [... iArrPlayer1Pieces!];
      msg = "Player 1: move L piece";
      iActiveNeutral = 1;
      iPlayerMove = 1;

      if (!bInitGameBoard && inMovingPiece == LGamePieceInMove.LPiece
          && noLPieceFreePositions())
      {
        msg =
            "There is no free positions for L piece. You had lost this game!";
        disAbleButtonsForGameOver();
        bGameIsOver = true;
        return true;
      }

      }
      return true;
  }

  LGameSessionData getGamePositionsForSaveGame()
  {

    LGameSessionData data = LGameSessionData();
    data.name1 = name1;
    data.name2 = name2;
    data.oldIActiveNeutral = iActiveNeutral;
    data.oldIArrPlayer1Pieces = iArrPlayer1Pieces;
    data.oldIArrPlayer2Pieces = iArrPlayer2Pieces;
    data.oldIPlayerMovePieces = iArrPlayerMovePieces;
//    iArrPlayerMovePieces = [... startIArrPlayer2Pieces];
    data.oldIPlayerNeutral1Piece = iPlayerNeutral1Piece!;
    data.oldIPlayerNeutral2Piece = iPlayerNeutral2Piece!;
    data.oldPlayerTurn = playerTurn;
    data.oldInMovingPiece = inMovingPiece;
    data.oldIPlayerMove = iPlayerMove;
    data.startedAt = startedAt;
    data.bGameOver = bGameIsOver;
    data.oldIArrPlayerPossibleMovePieces = iArrPlayerPossibleMovePieces;
    data.oldIPlayerNeutral1PieceInBeginningMove = iPlayerNeutral1PieceInBeginningMove;
    data.oldIPlayerNeutral2PieceInBeginningMove = iPlayerNeutral2PieceInBeginningMove;
    data.modifiedAt = modifiedAt;

    return data;
  }

 /* String? */
  setStartGameAfterOldGame(LGameSessionData data/* )int oldIActiveNeutral,
      List<int> oldIArrPlayer1Pieces, List<int> oldIArrPlayer2Pieces,
      int oldIPlayerNeutral1Piece, int oldIPlayerNeutral2Piece */
      )
  {
    /*
    if (data.oldIArrPlayer1Pieces == null) {
      return 'data.oldIArrPlayer1Pieces == null';
    }
    if (data.oldIArrPlayer2Pieces == null) {
      return 'data.oldIArrPlayer2Pieces == null';
    }
    if (data.oldIArrPlayer1Pieces == null) {
      return 'data.oldIArrPlayer1Pieces == null';
    }
     */

   // buttonStartGamePressed();
    name1 = data.name1;
    name2 = data.name2;
    bGameIsOver = false;
    iArrPlayerPossibleMovePieces = null;
    bGameStarted = true;
    bInitGameBoard = false;
    iActiveNeutral = data.oldIActiveNeutral;
    bButtonTurn90DegreeEnabled = true;
    iArrPlayer1Pieces = [... data.oldIArrPlayer1Pieces!];
    iArrPlayer2Pieces = [... data.oldIArrPlayer2Pieces!];
   // iArrPlayerMovePieces = [... startIArrPlayer2Pieces];
    bButtonUpEnabled = true;
    bButtonDownEnabled = true;
    bButtonRightEnabled = true;
    bButtonLeftEnabled = true;
    bButtonWrapUpEnabled = true;
    //   bButtonSwitchNeutralEnabled = true;
    bButtonTurn90DegreeEnabled = true;
    bButtonMoveDoneEnabled = true;
    iPlayerNeutral1Piece = data.oldIPlayerNeutral1Piece;
    iPlayerNeutral2Piece = data.oldIPlayerNeutral2Piece;
    playerTurn = data.oldPlayerTurn;
    iArrPlayerMovePieces = data.oldIPlayerMovePieces;
    /*
    if (playerTurn == GamePlayerTurn.player2) {
      iArrPlayerMovePieces = [... data.oldIArrPlayer2Pieces!];
    }
     */

    inMovingPiece = data.oldInMovingPiece;
    iPlayerMove = data.oldIPlayerMove;
    bGameIsOver = data.bGameOver;
    startedAt = data.startedAt;
    iArrPlayerPossibleMovePieces = data.oldIArrPlayerPossibleMovePieces;
    iPlayerNeutral1PieceInBeginningMove = data.oldIPlayerNeutral1PieceInBeginningMove;
    iPlayerNeutral2PieceInBeginningMove = data.oldIPlayerNeutral2PieceInBeginningMove;
    modifiedAt = data.modifiedAt;
    if (inMovingPiece == LGamePieceInMove.neutral)
    {
      initNeutralData();
      bButtonSwitchNeutralEnabled = true;
    }
   // switchTurn(false);
  //  return null;
  }

  bool? buttonStartGamePressed()
   {
      startedAt = DateTime.now().toString();
      bGameIsOver = false;
      iArrPlayerPossibleMovePieces = null;
      bGameStarted = true;
      iActiveNeutral = 1;
      bButtonTurn90DegreeEnabled = true;
      iArrPlayer1Pieces = [... startIArrPlayer1Pieces];
      iArrPlayer2Pieces = [... startIArrPlayer2Pieces];
      iArrPlayerMovePieces = [... iArrPlayer1Pieces!];
//    iArrPlayerMovePieces = [... startIArrPlayer2Pieces];
      bButtonUpEnabled = true;
      bButtonDownEnabled = true;
      bButtonRightEnabled = true;
      bButtonLeftEnabled = true;
      bButtonWrapUpEnabled = true;
   //   bButtonSwitchNeutralEnabled = true;
      bButtonTurn90DegreeEnabled = true;
      bButtonMoveDoneEnabled = true;
     iPlayerNeutral1Piece = startIPlayerNeutral1Piece;
     iPlayerNeutral2Piece = startIPlayerNeutral2Piece;
      switchTurn(true);
      return true;
  }

  GameBoardPositionSeries?
  getPositionsOfFreePieceInSpecCol(int iCol, List<GameBoardPosition>? gpsList)
  {
    GameBoardPositionSeries? ret;
    if (gpsList != null) {
      ret = GameBoardPositionSeries();
      ret.iCol = iCol;
      GameBoardPosition gps;
      for (int i = 0; i < gpsList.length; i++ ) {
        gps = gpsList[i];
        if (gps == null) {
          continue;
        }
        if (gps.iCol == iCol) {
          ret.series.add(gps);
        }
      }
    }
    return ret;
  }

  GameBoardPositionSeries?
  getPositionsOfFreePieceInSpecRow(int iRow, List<GameBoardPosition>? gpsList) {
    GameBoardPositionSeries? ret;
    if (gpsList != null) {
      ret = GameBoardPositionSeries();
      ret.iRow = iRow;
      GameBoardPosition gps;
      for (int i = 0; i < gpsList!.length; i++) {
        gps = gpsList[i];
        if (gps == null) {
          continue;
        }
        if (gps.iRow == iRow) {
          ret.series.add(gps);
        }
      }
    }
    return ret;
  }

  List<GameBoardPosition>?
  getEnoughNextRowItemsForLPiece(GameBoardPositionSeries series)
  {
    List<GameBoardPosition>? ret;
    if (series != null)
    {
      if (series.series.length < 3) {
        return null;
      }

      List<GameBoardPosition> okItems = List.empty(growable: true);
      GameBoardPosition? gp, prevGs;
      series.series.sort(
              (a, b) => a.iCol.compareTo(b.iCol));
      bool bAdded = false;
      for (int i = 0; i < series.series.length; i++) {
        gp = series.series[i];
        bAdded = false;
        if (gp == null) {
          continue;
        }
        if (prevGs != null)
        {
           if ((prevGs.iCol +1) == gp.iCol)
           {
             okItems.add(prevGs);
             bAdded = true;
           }
        }
        prevGs = gp;
      }
      if (bAdded)
      {
        prevGs = okItems.last;
        if (prevGs != null && gp != null && (prevGs!.iCol +1) == gp!.iCol)
        {
          okItems.add(gp);
        }
      }
      ret = okItems;
    }
    return ret;
  }

  List<GameBoardPosition>?
  getEnoughNextColItemsForLPiece(GameBoardPositionSeries series)
  {
    List<GameBoardPosition>? ret;
    if (series != null)
    {
      if (series.series.length < 3) {
        return null;
      }

      List<GameBoardPosition> okItems = List.empty(growable: true);
      GameBoardPosition? gp, prevGs;
      series.series.sort(
              (a, b) => a.iRow.compareTo(b.iRow));
      bool bAdded = false;
      for (int i = 0; i < series.series.length; i++) {
        gp = series.series[i];
        bAdded = false;
        if (gp == null) {
          continue;
        }
        if (prevGs != null)
        {
          if ((prevGs.iRow +1) == gp.iRow)
          {
            okItems.add(prevGs);
            bAdded = true;
          }
        }
        prevGs = gp;
      }
      if (bAdded)
      {
        prevGs = okItems.last;
        if (prevGs != null && gp != null && (prevGs.iRow +1) == gp.iRow)
        {
          okItems.add(gp);
        }
      }
      ret = okItems;
    }
    return ret;
  }

  GameBoardPosition?
  getGameBoardPositionOfFreeForRow(int iRow, int iCol,
      List<GameBoardPositionSeries>? allSeries)
  {

    GameBoardPositionSeries? gps;
    if (allSeries != null) {
      for (int i = 0; i < allSeries.length; i++) {
        gps = allSeries[i];
        if (gps == null) {
          continue;
        }
        if (gps.iRow == iRow) {
          GameBoardPosition gp;
          for (int j = 0; j < gps.series.length; j++) {
            gp = gps.series[j];
            if (gp == null) {
              continue;
            }
            if (gp.iCol == iCol) {
              return gp;
            }
          }
        }
      }
    }
    return null;
  }

  GameBoardPosition?
  getGameBoardPositionOfFreeForCol(int iRow, int iCol,
      List<GameBoardPositionSeries>? allSeries)
  {

    GameBoardPositionSeries? gps;
    if (allSeries != null) {
      for (int i = 0; i < allSeries.length; i++) {
        gps = allSeries[i];
        if (gps == null) {
          continue;
        }
        if (gps.iCol == iCol) {
          GameBoardPosition gp;
          for (int j = 0; j < gps.series.length; j++) {
            gp = gps.series[j];
            if (gp == null) {
              continue;
            }
            if (gp.iRow == iRow) {
              return gp;
            }
          }
        }
      }
    }
    return null;
  }

  bool
  isThereEnoughRowItemsForLPieceEnd(GameBoardPosition mayLRow,
      List<GameBoardPosition>? foundedMayLPiece,
      List<GameBoardPositionSeries>? allSeries) {
    bool ret = false;

    if (allSeries != null) {
      int iPrevRow = mayLRow.iRow - 1;
      int iNextRow = mayLRow.iRow + 1;
      if ((iPrevRow < 0 || iPrevRow > 3) && (iNextRow < 0 || iNextRow > 3)) {
        return false; // it should not be possible
      }
      if (!(iPrevRow < 0)) {
        GameBoardPosition? gp = getGameBoardPositionOfFreeForRow(
            iPrevRow, mayLRow.iCol, allSeries);
        if (gp != null) {
          if (isSamePositionsThanCurrentLPiece(gp, foundedMayLPiece)) {
            return false;
          }
          return true;
        }
      }
      if (!(iNextRow > 3)) {
        GameBoardPosition? gp = getGameBoardPositionOfFreeForRow(
            iNextRow, mayLRow.iCol, allSeries);
        if (gp != null) {
          if (isSamePositionsThanCurrentLPiece(gp, foundedMayLPiece)) {
            return false;
          }
          return true;
        }
      }
    }
    return ret;
  }

  bool
  isSamePositionsThanCurrentLPiece(GameBoardPosition gpParent,
      List<GameBoardPosition>? foundedMayLPiece)
  {
    bool ret = false;
    if (foundedMayLPiece != null)
      {
         GameBoardPosition? gp;
         List<int>? foundedNumbers = List.empty(growable: true);
         for (int i = 0; i < foundedMayLPiece.length; i++) {
            gp = foundedMayLPiece[i];
            if (gp == null) {
              continue;
            }
            foundedNumbers.add(gp.iPos);
         }
         foundedNumbers.add(gpParent.iPos);

         List<int>? currentLPiece = iArrPlayer1Pieces;
         if (playerTurn == GamePlayerTurn.player2) {
           currentLPiece = iArrPlayer2Pieces;
         }
         Set currentLPieceSet = currentLPiece!.toSet();
         Set foundedNumbersSet = foundedNumbers.toSet();
         if (currentLPieceSet.containsAll(foundedNumbersSet)) {
           return true;
         }
      }
    return ret;
  }

  bool
  isThereEnoughColItemsForLPieceEnd(GameBoardPosition mayLCol,
      List<GameBoardPosition>? foundedMayLPiece,
      List<GameBoardPositionSeries>? allSeries) {
    bool ret = false;

    if (allSeries != null) {
      int iPrevCol = mayLCol.iCol - 1;
      int iNextCol = mayLCol.iCol + 1;
      if ((iPrevCol < 0 || iPrevCol > 3) && (iNextCol < 0 || iNextCol > 3)) {
        return false; // it should not be possible
      }
      if (!(iPrevCol < 0)) {
        GameBoardPosition? gp = getGameBoardPositionOfFreeForCol(
            mayLCol.iRow, iPrevCol, allSeries);
        if (gp != null) {
          if (isSamePositionsThanCurrentLPiece(gp, foundedMayLPiece)) {
            return false;
          }
          return true;
        }
      }
      if (!(iNextCol > 3)) {
        GameBoardPosition? gp = getGameBoardPositionOfFreeForCol(
            mayLCol.iRow, iNextCol, allSeries);
        if (gp != null) {
          if (isSamePositionsThanCurrentLPiece(gp, foundedMayLPiece)) {
            return false;
          }
          return true;
        }
      }
    }
    return ret;
  }

  bool
  isThereEnoughRowItemsForLPiece(GameBoardPositionSeries? series,
      List<GameBoardPosition>? lMayRow,
      List<GameBoardPositionSeries>? allSeries)
  {
    bool ret = false;
    if (series != null && lMayRow != null && allSeries != null && lMayRow.length > 2) {
      GameBoardPosition first = lMayRow.first;
      GameBoardPosition last = lMayRow.last;
      GameBoardPosition? between;
      List<GameBoardPosition> foundedMayLPiece = List.empty(growable: true);
      if(first != null && last != null && first != last)
        {
          bool bSecondCalls = false;
          between = lMayRow[1];
          if (lMayRow.length > 3) {
            last = lMayRow[2];
            bSecondCalls = true;
          }
          foundedMayLPiece.add(first);
          foundedMayLPiece.add(between);
          foundedMayLPiece.add(last);
          if (isThereEnoughRowItemsForLPieceEnd(first, foundedMayLPiece, allSeries))
          {
            return true;
          }
          if (isThereEnoughRowItemsForLPieceEnd(last, foundedMayLPiece, allSeries))
          {
            return true;
          }
          if (bSecondCalls && lMayRow.length > 3) {
              last = lMayRow.last;
              first = lMayRow[1];
              between = lMayRow[2];
              foundedMayLPiece.clear();
              foundedMayLPiece.add(first);
              foundedMayLPiece.add(between);
              foundedMayLPiece.add(last);
              if (isThereEnoughRowItemsForLPieceEnd(first, foundedMayLPiece, allSeries))
              {
                return true;
              }
              if (isThereEnoughRowItemsForLPieceEnd(last, foundedMayLPiece, allSeries))
              {
                return true;
              }
          }
        }
    }
    return ret;
  }

  bool
  isThereEnoughColItemsForLPiece(GameBoardPositionSeries? series,
      List<GameBoardPosition>? lMayRow,
      List<GameBoardPositionSeries>? allSeries)
  {
    bool ret = false;
    if (series != null && lMayRow != null && allSeries != null && lMayRow.length > 2) {
      GameBoardPosition first = lMayRow.first;
      GameBoardPosition last = lMayRow.last;
      GameBoardPosition? between;
      List<GameBoardPosition> foundedMayLPiece = List.empty(growable: true);
      if(first != null && last != null && first != last)
      {
        between = lMayRow[1];
        bool bSecondCalls = false;
        if (lMayRow.length > 3) {
          last = lMayRow[2];
          bSecondCalls = true;
        }
        foundedMayLPiece.add(first);
        foundedMayLPiece.add(between);
        foundedMayLPiece.add(last);
        if (isThereEnoughColItemsForLPieceEnd(first, foundedMayLPiece, allSeries))
        {
          return true;
        }
        if (isThereEnoughColItemsForLPieceEnd(last, foundedMayLPiece, allSeries))
        {
          return true;
        }
        if (bSecondCalls && lMayRow.length > 3) {
          last = lMayRow.last;
          first = lMayRow[1];
          between = lMayRow[2];
          foundedMayLPiece.clear();
          foundedMayLPiece.add(first);
          foundedMayLPiece.add(between);
          foundedMayLPiece.add(last);
          if (isThereEnoughColItemsForLPieceEnd(first, foundedMayLPiece, allSeries))
          {
            return true;
          }
          if (isThereEnoughColItemsForLPieceEnd(last, foundedMayLPiece, allSeries))
          {
            return true;
          }
        }
      }
    }
    return ret;
  }

  bool
  isThereAFreeLPieceInRow(GameBoardPositionSeries? series, List<GameBoardPositionSeries>? allSeries)
  {
    bool ret = false;
    if (series != null && allSeries != null)
    {
      if (series.series.length < 3) {
        return false;
      }
      List<GameBoardPosition>? lMayRow = getEnoughNextRowItemsForLPiece(series);
      if (lMayRow == null || lMayRow.length < 3)
      {
        return false;
      }
      if (isThereEnoughRowItemsForLPiece(series, lMayRow, allSeries)) {
        return true;
      }
    }
    return ret;
  }

  bool
  isThereAFreeLPieceInCol(GameBoardPositionSeries? series, List<GameBoardPositionSeries>? allSeries)
  {
    bool ret = false;
    if (series != null && allSeries != null)
    {
      if (series.series.length < 3) {
        return false;
      }
      List<GameBoardPosition>? lMayCol = getEnoughNextColItemsForLPiece(series);
      if (lMayCol == null || lMayCol.length < 3)
      {
        return false;
      }
      if (isThereEnoughColItemsForLPiece(series, lMayCol, allSeries)) {
        return true;
      }
    }
    return ret;
    /*
    bool ret = false;
    if (series != null && allseries != null)
    {
      if (series.series.length < 3) {
        return false;
      }
      if (isThereNotEnoughNextColItemsForLPiece(series))
      {
        return false;
      }
      if (isThereEnoughColItemsForLPiece(series, allseries)) {
        return true;
      }
    }
    return ret;

     */
  }

  bool
  isAlmostOneFreeLPiece(List<GameBoardPosition>? gpsList)
  {
    bool ret = true;
    if (gpsList != null)
      {

        List<GameBoardPositionSeries>? allSeries = List.empty(growable: true);
          GameBoardPositionSeries? row1Series =
              getPositionsOfFreePieceInSpecRow(0, gpsList);
          GameBoardPositionSeries? row2Series =
              getPositionsOfFreePieceInSpecRow(1, gpsList);
          GameBoardPositionSeries? row3Series =
              getPositionsOfFreePieceInSpecRow(2, gpsList);
          GameBoardPositionSeries? row4Series =
              getPositionsOfFreePieceInSpecRow(3, gpsList);

          GameBoardPositionSeries? col1Series =
                getPositionsOfFreePieceInSpecCol(0, gpsList);
          GameBoardPositionSeries? col2Series =
                getPositionsOfFreePieceInSpecCol(1, gpsList);
          GameBoardPositionSeries? col3Series =
                getPositionsOfFreePieceInSpecCol(2, gpsList);
          GameBoardPositionSeries? col4Series =
                getPositionsOfFreePieceInSpecCol(3, gpsList);

          if ((row1Series == null || row1Series.series.isEmpty)
          && (row2Series == null || row2Series.series.isEmpty)
          && (row3Series == null || row3Series.series.isEmpty)
          && (row4Series == null || row4Series.series.isEmpty)
          && (col1Series == null || col1Series.series.isEmpty)
          && (col2Series == null || col2Series.series.isEmpty)
          && (col3Series == null || col3Series.series.isEmpty)
          && (col4Series == null || col4Series.series.isEmpty)) {
            return false;
          }

          if (row1Series != null && row1Series.series.isNotEmpty) {
            allSeries.add(row1Series);
          }
          if (row2Series != null && row2Series.series.isNotEmpty) {
            allSeries.add(row2Series);
          }
          if (row3Series != null && row3Series.series.isNotEmpty) {
            allSeries.add(row3Series);
          }
          if (row4Series != null && row4Series.series.isNotEmpty) {
            allSeries.add(row4Series);
          }

          if (col1Series != null && col1Series.series.isNotEmpty) {
            allSeries.add(col1Series);
          }
          if (col2Series != null && col2Series.series.isNotEmpty) {
            allSeries.add(col2Series);
          }
          if (col3Series != null && col3Series.series.isNotEmpty) {
            allSeries.add(col3Series);
          }
          if (col4Series != null && col4Series.series.isNotEmpty) {
            allSeries.add(col4Series);
          }

          bool bCalledCol1 = isThereAFreeLPieceInCol(col1Series, allSeries);
          bool bCalledCol2 = isThereAFreeLPieceInCol(col2Series, allSeries);
          bool bCalledCol3 = isThereAFreeLPieceInCol(col3Series, allSeries);
          bool bCalledCol4 = isThereAFreeLPieceInCol(col4Series, allSeries);

          bool bCalledRow1 = isThereAFreeLPieceInRow(row1Series, allSeries);
          bool bCalledRow2 = isThereAFreeLPieceInRow(row2Series, allSeries);
          bool bCalledRow3 = isThereAFreeLPieceInRow(row3Series, allSeries);
          bool bCalledRow4 = isThereAFreeLPieceInRow(row4Series, allSeries);
          if (bCalledCol1 || bCalledCol2 || bCalledCol3 || bCalledCol4
              || bCalledRow1 || bCalledRow2 || bCalledRow3 || bCalledRow4)
          {
            return true;
          }
        if (!bCalledCol1 && !bCalledCol2 && !bCalledCol3 && !bCalledCol4
            && !bCalledRow1 && !bCalledRow2 && !bCalledRow3 && !bCalledRow4)
        {
          return false;
        }
      }
    return ret;
  }

  List<GameBoardPosition>?
  getGameBoardPositionList(List<int> lGamePieceArray)
  {
    List<GameBoardPosition>? ret;
    GameBoardPosition? gp;
    if (lGamePieceArray != null && lGamePieceArray.isNotEmpty)
    {
        ret = List.empty(growable: true);
        int iValue;
        for (int i = 0; i < lGamePieceArray.length; i++ ) {
          iValue = lGamePieceArray[i];
          gp = arrBoardSquares![iValue];
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
        int iTreeLPieceInRow = -1;
        for (int i = 0; i < iArrFoundRightRow.length; i++) {
          iValue = iArrFoundRightRow[i];
          if (iValue == 3) {
            iTreeLPieceInRow = i;
            return true;
          }
        }
        return false;
      }
      return ret;
    }
    return null;
  }

  int? getRowNumberInMoveArray(List<int>? lGamePieceArray) {
    int? ret;
    if (lGamePieceArray != null && lGamePieceArray.isNotEmpty) {
      ret = null;
      List<GameBoardPosition>? gps;
      gps = getGameBoardPositionList(lGamePieceArray);
      int? iValue;
      if (gps != null && gps.isNotEmpty) {
        if (gps.length < 2) {
          return null;
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
        }
        iValue = 0;
        int iTreeLPieceInRow = -1;
        for (int i = 0; i < iArrFoundRightRow.length; i++) {
          iValue = iArrFoundRightRow[i];
          if (iValue == 3) {
            iTreeLPieceInRow = i;
            return iTreeLPieceInRow;
          }
        }
        return null;
      }
      return ret;
    }
    return null;
  }

  int? getColNumberInMoveArray(List<int>? lGamePieceArray) {
    int? ret;
    if (lGamePieceArray != null && lGamePieceArray.isNotEmpty) {
      ret = null;
      List<GameBoardPosition>? gps;
      gps = getGameBoardPositionList(lGamePieceArray);
      int? iValue;
      if (gps != null && gps.isNotEmpty) {
        if (gps.length < 2) {
          return null;
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
          iArrFoundRightRow[(gp.iCol)] = iArrFoundRightRow[(gp.iCol)] +1;
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
        int iTreeLPieceInRow = -1;
        for (int i = 0; i < iArrFoundRightRow.length; i++) {
          iValue = iArrFoundRightRow[i];
          if (iValue == 3) {
            iTreeLPieceInRow = i;
            return iTreeLPieceInRow;
          }
        }
        return null;
      }
      return ret;
    }
    return null;
  }

  int getNextFortLPosition(bool bHorizontal)
  {
    int ret = 10;
       if ( iNextFortLPosition > 3) {
         iNextFortLPosition = 0;
       }

       if (iNextFortLPosition == 0)
       {
          iNextFortLPosition++;
          if (bHorizontal) {
            return 10;
          } else {
            return 10;
          }
       }
       else
       if (iNextFortLPosition == 1)
       {
         iNextFortLPosition++;
         if (bHorizontal) {
           return 2;
         } else {
           return 8;
         }
       }
       else
       if (iNextFortLPosition == 2)
       {
         iNextFortLPosition++;
         if (bHorizontal) {
           return 8;
         } else {
           return 2;
         }
       }
       else
       if (iNextFortLPosition == 3)
       {
         iNextFortLPosition++;
         if (bHorizontal) {
           return 0;
         } else {
           return 0;
         }
       }
    return ret;
  }

  bool? calculatePossibleMovePieces(ButtonPressed buttonTypePressed)
  {
    bool ret = true;
    if (buttonTypePressed == ButtonPressed.moveDone)
    {
       bool bValue = moveDone();
       return bValue;
    }
    else
    if (buttonTypePressed == ButtonPressed.swiftIntoNextNeutral)
      {
          if (iActiveNeutral == 1) {
            switchIntoNeutral(2);
          }
          else
          {
            switchIntoNeutral(1);
          }

          /*
       if (playerTurn == GamePlayerTurn.player1) {
         iArrPlayerMovePieces = [ iPlayerNeutral2Piece!];
         iPlayerNeutral2PieceInBeginningMove = iPlayerNeutral2Piece!;
         iPlayerNeutral1PieceInBeginningMove = null;
         iActiveNeutral = 2;
       }
       else
       {
         iArrPlayerMovePieces = [ iPlayerNeutral1Piece!];
         iPlayerNeutral2PieceInBeginningMove = iPlayerNeutral2Piece!;
         iPlayerNeutral1PieceInBeginningMove = null;
         iActiveNeutral = 1;
       }
       */
          /*
       if (iActiveNeutral == 1) {
         iActiveNeutral = 2;
       } else {
         iActiveNeutral = 1;
       }
        */
        //  calculatePossibleMovePieces(DirectionButtonPressed.wrapDown)
        return true;
      }

    iArrPlayerPossibleMovePieces = [... iArrPlayerMovePieces! ];
    if (iArrPlayerPossibleMovePieces == null || iArrPlayerPossibleMovePieces!.isEmpty) {
      return false;
    }
    if (buttonTypePressed == ButtonPressed.turn90Degree)
    {
       if (iArrPlayerPossibleMovePieces!.length < 4) {
         return false;
       }
       bool? bHorizon = moveArrayIsInHorizontal(iArrPlayerMovePieces!);
       if (bHorizon != null) {
         /*
         if (!bHorizon) {
          */
           /*
           if (iArrPlayerMovePieces!.equals([4,5,6,10]))
           {
               iArrPlayerMovePieces = [1,5,9,10];
           }
           else {
            */
          //   iArrPlayerMovePieces = [4,5,6,10];
         //  }
         /*
         }
         else
         {
         */
           /*
           if (iArrPlayerMovePieces!.equals([1,5,9,10]))
           {
               iArrPlayerMovePieces = [4,5,6,10];
           }
           else {
            */
          ///   iArrPlayerMovePieces = [1,5,9,10];
     //      }
        // }
         Set moveLPieceSet = iArrPlayerMovePieces!.toSet();
         Set? foundedNumbersSet;
         if (playerTurn == GamePlayerTurn.player2) {
           foundedNumbersSet = iArrPlayer2Pieces!.toSet();
         } else {
           foundedNumbersSet = iArrPlayer1Pieces!.toSet();
         }
         if (moveLPieceSet.containsAll(foundedNumbersSet)) {
           if (bHorizon) {
             /*
             if (iArrPlayerMovePieces!.equals([1,5,9,10]))
             {
               iArrPlayerMovePieces = [4,5,6,10];
             }
             else {
              */
               iArrPlayerMovePieces = [1, 5, 9, 10];
         //    }
           }
           else
             {
               /*
               if (iArrPlayerMovePieces!.equals([4,5,6,10]))
               {
                 iArrPlayerMovePieces = [1,5,9,10];
               }
               else {
                */
                 iArrPlayerMovePieces = [4, 5, 6, 10];
             //  }
             }
         }
         else
         if (bHorizon) {
           iArrPlayerMovePieces = [1, 5, 9, 10];
         }
         else
         {
           iArrPlayerMovePieces = [4, 5, 6, 10];
         }
       }
       return true;
    }
    else
    if (buttonTypePressed == ButtonPressed.wrap) {
      // TODO: wrapDown implementation
      switch (iArrPlayerPossibleMovePieces!.length) {
        case < 4:
          return false;
      }
      bool? bHorizon = moveArrayIsInHorizontal(iArrPlayerMovePieces!);
      if (bHorizon != null) {
          if (bHorizon) {
            iArrPlayerMovePieces = [4, 5, 6, getNextFortLPosition(true)];
          }
          else {
            iArrPlayerMovePieces = [1, 5, 9, getNextFortLPosition(true)];
            // iArrPlayerMovePieces!.add(getNextFortLPosition(true));
          }
          Set moveLPieceSet = iArrPlayerMovePieces!.toSet();
          Set? foundedNumbersSet;
          if (playerTurn == GamePlayerTurn.player2) {
            foundedNumbersSet = iArrPlayer2Pieces!.toSet();
          } else {
            foundedNumbersSet = iArrPlayer1Pieces!.toSet();
          }
          if (moveLPieceSet.containsAll(foundedNumbersSet)) {
            if (bHorizon) {
              iArrPlayerMovePieces = [4, 5, 6, getNextFortLPosition(true)];
            }
            else
              {
                iArrPlayerMovePieces = [1, 5, 9, getNextFortLPosition(true)];
              }
          }
            return true;
      }
      return false;
    }

    GameBoardPositionValidate? validate;
    List<GameBoardPositionValidate> listBoardPieces =
              List<GameBoardPositionValidate>.empty(growable: true);
    switch (iArrPlayerPossibleMovePieces) {
      case _?:
      for (int i = 0; i < iArrPlayerPossibleMovePieces!.length; i++ ) {
        validate = getGameBoardValidate(iArrPlayerPossibleMovePieces![i]);
        if (validate == null) {
          return false;
        }
        if(!validate.calculatePossibleMove(buttonTypePressed)) {
          return false;
        }
        listBoardPieces.add(validate);
      }
    }

    if (listBoardPieces.isEmpty || listBoardPieces.length !=  iArrPlayerPossibleMovePieces!.length) {
      return false;
    }
    List<int>? iNewArrPlayerPossibleMovePieces = getNewMovePositions(listBoardPieces);
    if (iNewArrPlayerPossibleMovePieces == null || iNewArrPlayerPossibleMovePieces.isEmpty) {
      return false;
    }
      iArrPlayerMovePieces = iNewArrPlayerPossibleMovePieces;

    ret = true;
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
     for (int i = 0; i < arrBoardSquares!.length; i++ ) {
        gp = arrBoardSquares![i];
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

  switchIntoNeutral(int iParamActiveNeutral)
  {
     iActiveNeutral = iParamActiveNeutral;
     initNeutralData();
  }

  initNeutralData()
  {
    bButtonTurn90DegreeEnabled = false;
    if (iActiveNeutral == 1) {
//      iArrPlayer1Pieces = iArrPlayerMovePieces;
      iArrPlayerMovePieces = [ iPlayerNeutral1Piece!];
      iPlayerNeutral1PieceInBeginningMove = iPlayerNeutral1Piece!;
      iPlayerNeutral2PieceInBeginningMove = null;
    }
    else
    {
//      iArrPlayer1Pieces = iArrPlayerMovePieces;
      iArrPlayerMovePieces = [ iPlayerNeutral2Piece!];
      iPlayerNeutral2PieceInBeginningMove = iPlayerNeutral2Piece!;
      iPlayerNeutral1PieceInBeginningMove = null;
    }
  //  calculateFreeElements();
  }

  bool moveDone()
  {
    bool ret = false;
    msg = "";
    if (inMovingPiece == LGamePieceInMove.LPiece) {
      // calculatePossibleMovePieces(DirectionButtonPressed.turn90Grade);
      /*
      if (iArrPlayerPossibleMovePieces == null) {
          strMsg = "L position is the old one! Move into diff position.";
        return true;
      }
       */
      if (playerTurn == GamePlayerTurn.player1) {
        iPlayerPresentPos = [ ... iArrPlayer1Pieces!];
        iPlayerOpponentPresentPos = [ ... iArrPlayer2Pieces!];
      } else {
        iPlayerPresentPos = [ ... iArrPlayer2Pieces!];
        iPlayerOpponentPresentPos = [ ... iArrPlayer1Pieces!];
      }

      bool areTheSame =
      unOrdDeepEq(iArrPlayerMovePieces, iPlayerPresentPos);
      if (areTheSame) {
        msg =
          "L position and the move are the same! Move into diff position.";
        return true;
      }
      if (!newLPiecePositionsAreFreeToMove()) {
        msg = "All L positions are not free!";
        return true;
      }

        msg = "Move one neutral piece, please";
        if (playerTurn == GamePlayerTurn.player1) {
          iArrPlayer1Pieces = iArrPlayerMovePieces;
          //     initNeutralData();
        }
        else {
          iArrPlayer2Pieces = iArrPlayerMovePieces;
        }
        inMovingPiece = LGamePieceInMove.neutral;
        bButtonWrapUpEnabled = false;
        bButtonTurn90DegreeEnabled = false;
        bButtonSwitchNeutralEnabled = true;
        modifiedAt = DateTime.now();
        initNeutralData();
      return true;
    }
    else if (inMovingPiece == LGamePieceInMove.neutral) {
      // calculatePossibleMovePieces(DirectionButtonPressed.turn90Grade);
      if (iArrPlayerPossibleMovePieces == null) {
         /*
          if (iActiveNeutral == 1) {
            iArrPlayer1Pieces = iArrPlayerMovePieces;
            //     initNeutralData();
          }
          else
          {
            iArrPlayer2Pieces = iArrPlayerMovePieces;
            */
            //    initNeutralData();
            /*
            iArrPlayerMovePieces = [ iPlayerNeutral2Piece!];
            iPlayerNeutral1PieceInBeginningMove = iPlayerNeutral1Piece!;
            iPlayerNeutral2PieceInBeginningMove = null;
             */
         // }
          switchTurn(false);
       return true;
     }

      if (playerTurn == GamePlayerTurn.player1) {
        iPlayerOpponentPresentPos = List<int>.empty(growable: true);
        iPlayerOpponentPresentPos!.add(iPlayerNeutral2Piece!);
        for (int i = 0; i < iArrPlayer2Pieces!.length; i++ ) {
          iPlayerOpponentPresentPos!.add(iArrPlayer2Pieces![i]);
        }
        for (int i = 0; i < iArrPlayer1Pieces!.length; i++ ) {
          iPlayerOpponentPresentPos!.add(iArrPlayer1Pieces![i]);
        }
      } else {
        iPlayerOpponentPresentPos = List<int>.empty(growable: true);
        iPlayerOpponentPresentPos!.add(iPlayerNeutral1Piece!);
        for (int i = 0; i < iArrPlayer1Pieces!.length; i++ ) {
          iPlayerOpponentPresentPos!.add(iArrPlayer1Pieces![i]);
        }
        for (int i = 0; i < iArrPlayer2Pieces!.length; i++ ) {
          iPlayerOpponentPresentPos!.add(iArrPlayer2Pieces![i]);
        }
      }
      if (!newNeutralPositionAreFreeToMove()) {
        msg = "This neutral piece position is not free!n.";
        return true;
      }

        msg = "Move one more neutral piece, please";
        if (iPlayerNeutral1PieceInBeginningMove != null && iPlayerNeutral1Piece == iPlayerNeutral1PieceInBeginningMove) {
          iPlayerNeutral1Piece = iArrPlayerMovePieces?.first.toInt();
        }
        else {
          if (iPlayerNeutral2PieceInBeginningMove != null && iPlayerNeutral2Piece == iPlayerNeutral2PieceInBeginningMove)
          {
            iPlayerNeutral2Piece = iArrPlayerMovePieces?.first.toInt();
          }
        }
        modifiedAt = DateTime.now();
        switchTurn(false);

      ret = true;
    }
    return ret;
  }

  Set
  calculateFreeElements()
  {
    final allNodes = [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15];
    Set setAll = allNodes.toSet();
    List<int> occupied = List.empty(growable: true);
    occupied.addAll(iArrPlayer1Pieces!);
    occupied.addAll(iArrPlayer2Pieces!);
    occupied.add(iPlayerNeutral1Piece!);
    occupied.add(iPlayerNeutral2Piece!);
    // [... iArrPlayer1Pieces!, iArrPlayer2Pieces!, iPlayerNeutral1Piece!,
    // iPlayerNeutral2Piece!];
    Set setOccupied = occupied.toSet();

    // if there are only few positions, so no need to check anymore:
    var freeElements = setAll.difference(setOccupied);
    if (freeElements.isEmpty) {
      return freeElements;
    }

    // check all free positions, include:
    List<int> occupied2 = List.empty(growable: true);
    if (playerTurn == GamePlayerTurn.player2) {
      occupied2.addAll(iArrPlayer1Pieces!);
    } else {
      occupied2.addAll(iArrPlayer2Pieces!);
    }

    occupied2.add(iPlayerNeutral1Piece!);
    occupied2.add(iPlayerNeutral2Piece!);
    Set<int> setOccupied2 = occupied2.toSet();
    freeElements = setAll.difference(setOccupied2);
    return freeElements;
  }

  bool noLPieceFreePositions()
  {
    bool ret = false;
    /*
    final lists = [
      [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15],
      [... iArrPlayer1Pieces!, iArrPlayer2Pieces!, iPlayerNeutral1Piece!,
       iPlayerNeutral2Piece!],
    ];
     */

    Set freeElements = calculateFreeElements();
    if (freeElements == null) {
      return true;
    }
    if (freeElements.isEmpty) {
      return true;
    }

    /*
    if (freeElements.isEmpty) {
      return true;
    }
     */

    List<GameBoardPosition>? gps;
    List listDyn = freeElements.toList();
    List<int> listStatic = List<int>.empty(growable: true);
    int iValue;
    for (int i = 0; i < listDyn.length; i++ ) {
      iValue = listDyn[i];
      listStatic.add(iValue);
    }
    gps = getGameBoardPositionList(listStatic);
    if (isAlmostOneFreeLPiece(gps))
    {
      return false;
    }
    else
      {
        return true;
      }

    return ret;
  }

  bool newLPiecePositionsAreFreeToMove()
  {
    bool ret = false;
    if (iArrPlayerMovePieces != null /* && iPlayerPresentPos != null */
        && iPlayerOpponentPresentPos != null
        && iArrPlayerMovePieces!.isNotEmpty
    /* && iPlayerPresentPos!.isNotEmpty */
        && iPlayerOpponentPresentPos!.isNotEmpty)
      {
         bool areNotInNeutralPieces = (iArrPlayerMovePieces != null
             && !iArrPlayerMovePieces!.contains(iPlayerNeutral1Piece)
             && !iArrPlayerMovePieces!.contains(iPlayerNeutral2Piece));
         if (inMovingPiece == LGamePieceInMove.neutral) {
           if (iArrPlayerMovePieces == null) {
             areNotInNeutralPieces = false;
           } else {
             if (iActiveNeutral == 2 && iArrPlayerMovePieces!.contains(iPlayerNeutral1Piece)) {
               areNotInNeutralPieces = false;
               return false;
             }
             else
             if (iActiveNeutral == 1 && iArrPlayerMovePieces!.contains(iPlayerNeutral2Piece)){
               areNotInNeutralPieces = false;
               return false;
             }
             else
             if (iActiveNeutral == 2 && iArrPlayerMovePieces!.contains(iPlayerNeutral2Piece)
                 || (iActiveNeutral == 1 &&  iArrPlayerMovePieces!.contains(iPlayerNeutral1Piece))){
               areNotInNeutralPieces = true;
             }

             if (areNotInNeutralPieces) {
               return true;
             }
           }
           if (!areNotInNeutralPieces) {
             /*
           if (inMovingPiece == GamePieceInMove.neutral) {
             return true;
           }
            */
             return true;
           }
         }

         bool areInNeutralPieces = (iArrPlayerMovePieces != null
             && (iArrPlayerMovePieces!.contains(iPlayerNeutral1Piece)
             || iArrPlayerMovePieces!.contains(iPlayerNeutral2Piece)));

         if (areInNeutralPieces)
           {
              return false;
           }

         final lists = [
           [... iArrPlayerMovePieces! ],
           [... iPlayerOpponentPresentPos! ],
         ];
         final commonElements =
         lists.fold<Set>(
             lists.first.toSet(),
                 (a, b) => a.intersection(b.toSet()));
         bool isNotInOpponentPieces = commonElements.isEmpty;
         ret = isNotInOpponentPieces;
         /*
         if (isNotInOpponentPieces)
           {

           }
          */
      }
    return ret;
  }


  bool newNeutralPositionAreFreeToMove()
  {
    return newLPiecePositionsAreFreeToMove();
    /*
    bool ret = false;
    if (iArrPlayerMovePieces != null /* && iPlayerPresentPos != null */
        && iPlayerOpponentPresentPos != null
        && iArrPlayerMovePieces!.isNotEmpty
        /* && iPlayerPresentPos!.isNotEmpty */
        && iPlayerOpponentPresentPos!.isNotEmpty)
    {
      bool areNotInNeutralPieces = (iArrPlayerMovePieces != null
          && !iArrPlayerMovePieces!.contains(iPlayerNeutral1Piece)
          && !iArrPlayerMovePieces!.contains(iPlayerNeutral2Piece));
      if (inMovingPiece == LGamePieceInMove.neutral) {
        if (iArrPlayerMovePieces == null) {
          areNotInNeutralPieces = false;
        } else {
          if (iActiveNeutral == 2 && iArrPlayerMovePieces!.contains(iPlayerNeutral1Piece)) {
            areNotInNeutralPieces = false;
            return false;
          }
          else
          if (iActiveNeutral == 1 && iArrPlayerMovePieces!.contains(iPlayerNeutral2Piece)){
            areNotInNeutralPieces = false;
            return false;
          }
          else
          if (iActiveNeutral == 2 && iArrPlayerMovePieces!.contains(iPlayerNeutral2Piece)
              || (iActiveNeutral == 1 &&  iArrPlayerMovePieces!.contains(iPlayerNeutral1Piece))){
            areNotInNeutralPieces = true;
          }

          if (areNotInNeutralPieces) {
            return true;
          }
        }
         if (!areNotInNeutralPieces) {
            return false;
         }
      }

      final lists = [
        [... iArrPlayerMovePieces! ],
        [... iPlayerOpponentPresentPos! ],
      ];
      final commonElements =
      lists.fold<Set>(
          lists.first.toSet(),
              (a, b) => a.intersection(b.toSet()));
      bool isNotInOpponentPieces = commonElements.isEmpty;
      ret = isNotInOpponentPieces;
    }
    return ret;

     */
  }

  GameBoardPosition? getGameBoardPosition(int index)
  {
    GameBoardPosition? ret;
    if (arrBoardSquares != null && index > -1 && index < 16)
    {
       ret = arrBoardSquares![index];
    }
    return ret;
  }

  GameBoardPositionValidate? getGameBoardValidate(int index)
  {
    GameBoardPosition? gPos = getGameBoardPosition(index);
    if (gPos == null) {
      return null;
    }
    var ret = GameBoardPositionValidate(gPos);
   // ret.validate();
    return ret;
  }

  void initState() {

    iArrPlayer1Pieces = [... startIArrPlayer1Pieces];
    iArrPlayer2Pieces = [... startIArrPlayer2Pieces];
    iPlayerNeutral1Piece = startIPlayerNeutral1Piece;
    iPlayerNeutral2Piece = startIPlayerNeutral2Piece;

    // test:
//  iArrPlayerMovePieces = [... startIArrPlayer1Pieces];
//    iArrPlayerMovePieces = [... startIArrPlayer2Pieces];
    iPlayerMove = 1;

   arrBoardSquares = [const GameBoardPosition(0,0, 0),
     const GameBoardPosition(0,1, 1),
     const GameBoardPosition(0,2, 2), const GameBoardPosition(0,3, 3),

     const GameBoardPosition(1,0, 4), const GameBoardPosition(1,1, 5),
     const GameBoardPosition(1,2, 6), const GameBoardPosition(1,3, 7),

     const GameBoardPosition(2,0, 8),
     const GameBoardPosition(2,1, 9), const GameBoardPosition(2,2, 10),
     const GameBoardPosition(2,3, 11),

     const GameBoardPosition(3,0, 12), const GameBoardPosition(3,1, 13),
     const GameBoardPosition(3,2, 14), const GameBoardPosition(3,3, 15)
   ];

/*
    _listMoveSquares = List.generate(16,  (index) {
      return getMoveContainer(index);
    });

    _listBoardPieces = List.generate(16,  (index) {
      return Container(
        //    duration: const Duration(seconds: 1),
        padding: const EdgeInsets.all(8),
        color: getBoardPieceColor(index),
        width: containerWidth,
        height: containerHeight,
        child: getTextChild(index),
      );
    });

    for (int i = 0; i < _listBoardSquares.length; i++ ) {
      _listBoardStack.add(Stack(children: [_listBoardSquares[i], _listBoardPieces[i], _listMoveSquares[i]]),);
    }
    */
  }

  /*
  Container getMoveContainer2(int index)
  {
    Widget? modeContainerChild = getMoveChild(index);
    return Container(
      padding: const EdgeInsets.all(10),
      color: Colors.transparent,
      width: containerWidth,
      height: containerHeight,
      child: null,
    );
  }
   */

}
