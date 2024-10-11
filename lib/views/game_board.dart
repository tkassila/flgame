
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:logger/logger.dart';
import 'package:flutter/semantics.dart';

import '../models/lgame_data.dart';

var logger = Logger(
  printer: PrettyPrinter(),
);

var loggerNoStack = Logger(
  printer: PrettyPrinter(methodCount: 0),
);

class LGameBoard extends StatefulWidget {
  const LGameBoard({super.key, required this.lGameSession,
  required this.bScreenReaderIsUsed });
  final LGameSession lGameSession;
  final bool bScreenReaderIsUsed;

  @override
  State<LGameBoard> createState() => _LGameBoardState();
}

class _LGameBoardState extends State<LGameBoard> {
  LGameSession lGameSession = LGameSession();
  GridView? _gameBoardGrid;
  List<Container> _listBoardSquares = List<Container>.empty(growable: true);
  List<Container> _listBoardPieces = List<Container>.empty(growable: true);
  List<Container> _listMoveSquares = List<Container>.empty(growable: true);
  List<String> _iArrScreenReaderSquareText = List<String>.empty(growable: true);
  List<Widget> _listScreenReaderSquares = List<Widget>.empty(
      growable: true);
  final Color player1Color = Colors.redAccent;
  final Color player2Color = Colors.blueAccent;
  final Color neutralColor = Colors.black;
  final double containerWidth = 200;
  final double containerHeight = 200;
  BuildContext? thisContext;
  bool bChangeScreenReaderTextIntoTop = false;
  final ButtonStyle buttonStyleScreenReader =
  ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 12),
      backgroundColor: Colors.transparent);

  @override
  void initState() {
    super.initState();
    _listBoardSquares = List.generate(16,  (index) {
      return getBoardSquaresContainer(index);
    });
  }

  Border
  getMoveDecorationBorderWithBorderSidesForCol(int index,
      List<GameBoardPosition>? l3SeriesList,
      GameBoardPosition forthLPieceGp,
      Color boxDecorationColor)
  {
    Border ret = Border.all(
      color: Colors.black,
      width: 7,
    );
    if (l3SeriesList == null) {
      return ret;
    }

    l3SeriesList.sort(
            (a, b) => a.iRow.compareTo(b.iRow));
    GameBoardPosition leftGp = l3SeriesList.first;
    GameBoardPosition rightGp = l3SeriesList.last;
    GameBoardPosition betweenGp = l3SeriesList[1];
    GameBoardPosition? neighbour;
    bool? neighBourIsLeftGp;
    if (leftGp.iRow == forthLPieceGp.iRow)
    {
      neighBourIsLeftGp = true;
      neighbour = leftGp;
    }
    else
    if (rightGp.iRow == forthLPieceGp.iRow)
    {
      neighbour = rightGp;
      neighBourIsLeftGp = false;
    }
    logger.i("neighBourIsLeftGp" +neighBourIsLeftGp.toString());

    if (leftGp.iPos == index)
    {
      ret = const Border(
        top: BorderSide(
            width: 7,
            color: Colors.black,
            style: BorderStyle.solid),
        bottom: BorderSide.none /*BorderSide(
            width: 7,
            color: Colors.transparent,
            style: BorderStyle.solid) **/,
        left: BorderSide(
            width: 7,
            color: Colors.black,
            style: BorderStyle.solid),
        right: BorderSide(
            width: 7,
            color: Colors.black,
            style: BorderStyle.solid), //BorderSide
        /* color: boxDecorationColor,
          width: 7,*/
      );

      if (neighBourIsLeftGp != null && leftGp.iRow == forthLPieceGp.iRow
          && forthLPieceGp.iCol > leftGp.iCol)
      {
        ret = const Border(
          top: BorderSide(
              width: 7,
              color: Colors.black,
              style: BorderStyle.solid),
          bottom: BorderSide.none /* BorderSide(
              width: 7,
              color: Colors.transparent,
              style: BorderStyle.solid) */ ,
          left: BorderSide(
              width: 7,
              color: Colors.black,
              style: BorderStyle.solid),
          right: BorderSide.none /* BorderSide(
              width: 7,
              color: Colors.transparent,
              style: BorderStyle.solid) */ , //BorderSide
          /* color: boxDecorationColor,
          width: 7,*/
        );
      }

      if (neighBourIsLeftGp != null && leftGp.iRow == forthLPieceGp.iRow
          && forthLPieceGp.iCol < leftGp.iCol)
      {
        ret = const Border(
          top: BorderSide(
              width: 7,
              color: Colors.black,
              style: BorderStyle.solid),
          bottom: BorderSide.none /* BorderSide(
              width: 7,
              color: Colors.transparent,
              style: BorderStyle.solid) */,
          left: BorderSide.none /* BorderSide(
              width: 7,
              color: Colors.transparent,
              style: BorderStyle.solid) */,
          right: BorderSide(
              width: 7,
              color: Colors.black,
              style: BorderStyle.solid), //BorderSide
          /* color: boxDecorationColor,
          width: 7,*/
        );
      }
    }
    else
    if (rightGp.iPos == index)
    {
      ret = const Border(
        top: BorderSide.none /* BorderSide(
            width: 7,
            color: Colors.transparent,
            style: BorderStyle.solid) */,
        bottom: BorderSide(
            width: 7,
            color: Colors.black,
            style: BorderStyle.solid),
        left: BorderSide(
            width: 7,
            color: Colors.black,
            style: BorderStyle.solid),
        right: BorderSide(
            width: 7,
            color: Colors.black,
            style: BorderStyle.solid), //BorderSide
        /* color: boxDecorationColor,
          width: 7,*/
      );

      if (neighBourIsLeftGp != null && rightGp.iRow == forthLPieceGp.iRow
          && forthLPieceGp.iCol > rightGp.iCol)
      {
        ret = const Border(
          top: BorderSide.none /*BorderSide(
              width: 7,
              color: Colors.transparent,
              style: BorderStyle.solid) */,
          bottom: BorderSide(
              width: 7,
              color: Colors.black,
              style: BorderStyle.solid),
          left: BorderSide(
              width: 7,
              color: Colors.black,
              style: BorderStyle.solid),
          right: BorderSide.none /* BorderSide(
              width: 7,
              color: Colors.transparent,
              style: BorderStyle.solid) */, //BorderSide
          /* color: boxDecorationColor,
          width: 7,*/
        );
      }

      if (neighBourIsLeftGp != null && rightGp.iRow == forthLPieceGp.iRow
          && forthLPieceGp.iCol < rightGp.iCol)
      {
        ret = const Border(
          top: BorderSide.none /* BorderSide(
              width: 7,
              color: Colors.transparent,
              style: BorderStyle.solid) */,
          bottom: BorderSide(
              width: 7,
              color: Colors.black,
              style: BorderStyle.solid),
          left: BorderSide.none /* BorderSide(
              width: 7,
              color: Colors.transparent,
              style: BorderStyle.solid) */,
          right: BorderSide(
              width: 7,
              color: Colors.black,
              style: BorderStyle.solid), //BorderSide
          /* color: boxDecorationColor,
          width: 7,*/
        );
      }

    }
    else
    if (betweenGp.iPos == index)
    {
      ret = const Border(
        top: BorderSide.none /* BorderSide(
            width: 7,
            color: Colors.transparent,
            style: BorderStyle.solid) */,
        bottom: BorderSide.none /* BorderSide(
            width: 7,
            color: Colors.transparent,
            style: BorderStyle.solid) */,
        left: BorderSide(
            width: 7,
            color: Colors.black,
            style: BorderStyle.solid),
        right: BorderSide(
            width: 7,
            color: Colors.black,
            style: BorderStyle.solid), //BorderSide
        /* color: boxDecorationColor,
          width: 7,*/
      );
    }
    else
    if(forthLPieceGp.iPos == index)
    {
      ret = const Border(
        top: BorderSide(
            width: 7,
            color: Colors.black,
            style: BorderStyle.solid),
        bottom: BorderSide(
            width: 7,
            color: Colors.black,
            style: BorderStyle.solid),
        left: BorderSide(
            width: 7,
            color: Colors.black,
            style: BorderStyle.solid),
        right: BorderSide(
            width: 7,
            color: Colors.black,
            style: BorderStyle.solid), //BorderSide
        /* color: boxDecorationColor,
          width: 7,*/
      );

      if (neighBourIsLeftGp != null
          && (( /* neighBourIsLeftGp && */ forthLPieceGp.iRow == leftGp.iRow
              && forthLPieceGp.iCol > leftGp.iCol)
              || ( /*!neighBourIsLeftGp && */ forthLPieceGp.iRow == rightGp.iRow
                  && forthLPieceGp.iCol > rightGp.iCol)))
      {
        ret = const Border(
          top: BorderSide(
              width: 7,
              color: Colors.black,
              style: BorderStyle.solid),
          bottom: BorderSide(
              width: 7,
              color: Colors.black,
              style: BorderStyle.solid),
          left: BorderSide.none /* BorderSide(
              width: 7,
              color: Colors.transparent,
              style: BorderStyle.solid) */,
          right: BorderSide(
              width: 7,
              color: Colors.black,
              style: BorderStyle.solid), //BorderSide
          /* color: boxDecorationColor,
          width: 7,*/
        );
      }

      if (neighBourIsLeftGp != null
          && ((/* neighBourIsLeftGp && */ forthLPieceGp.iRow == leftGp.iRow
              && forthLPieceGp.iCol < leftGp.iCol)
              || (/* !neighBourIsLeftGp && */ forthLPieceGp.iRow == rightGp.iRow
                  && forthLPieceGp.iCol < rightGp.iCol)))
      {
        ret = const Border(
          top: BorderSide(
              width: 7,
              color: Colors.black,
              style: BorderStyle.solid),
          bottom: BorderSide(
              width: 7,
              color: Colors.black,
              style: BorderStyle.solid),
          left: BorderSide(
              width: 7,
              color: Colors.black,
              style: BorderStyle.solid),
          right: BorderSide.none /* BorderSide(
              width: 7,
              color: Colors.transparent,
              style: BorderStyle.solid) */, //BorderSide
          /* color: boxDecorationColor,
          width: 7,*/
        );
      }

    }

    return ret;
  }

  Border
  getMoveDecorationBorder(int index, Color boxDecorationColor)
  {
    Border ret = Border.all(
      color: boxDecorationColor,
      width: 7,
    );

    if (lGameSession.iArrPlayerMovePieces != null
        && lGameSession.iArrPlayerMovePieces!.contains(index))
    {
      //  lGameSession.calculateFreeElements();
      Set freeElements = lGameSession.calculateFreeElements();
      if (freeElements == null) {
        return ret;
      }
      if (freeElements.isEmpty) {
        return ret;
      }
      List listDyn = freeElements.toList();
      List<int> listStatic = List<int>.empty(growable: true);
      int iValue;
      for (int i = 0; i < listDyn.length; i++ ) {
        iValue = listDyn[i];
        listStatic.add(iValue);
      }

      List<GameBoardPosition>? freeGps =
      lGameSession.getGameBoardPositionList(listStatic);
      if (freeGps == null) {
        return ret;
      }

      List<GameBoardPosition>? gps;
      gps = lGameSession.getGameBoardPositionList(lGameSession.iArrPlayerMovePieces!);
      if (gps == null) {
        return ret;
      }

      bool? bValue = lGameSession.moveArrayIsInHorizontal(
          lGameSession.iArrPlayerMovePieces);
      if (bValue == null) {
        return ret;
      }
      if (bValue)
      {
        int? iHorizontalRow = lGameSession.getRowNumberInMoveArray(
            lGameSession.iArrPlayerMovePieces
        );
        if (iHorizontalRow == null) {
          return ret;
        }
        List<GameBoardPosition>? freePositions =
        lGameSession.getGameBoardPositionList(listStatic);
        if (freePositions == null) {
          return ret;
        }

        logger.i("rowSeries gps " +gps.length.toString());
        GameBoardPositionSeries? rowSeries =
        lGameSession.getPositionsOfFreePieceInSpecRow(
            iHorizontalRow, gps);
        if (rowSeries == null) {
          return ret;
        }
        logger.i("rowSeries " +rowSeries!.series.length.toString());
        GameBoardPosition? gp, seriesGp, forthLPieceGp;
        bool bFounded = false;
        for (int i = 0; i < gps.length; i++ ) {
          gp = gps[i];
          if (gp == null) {
            continue;
          }
          for (int j = 0; j < rowSeries.series.length; j++ ) {
            seriesGp =  rowSeries.series[j];
            if (seriesGp == null) {
              continue;
            }
            if (seriesGp.iRow == gp.iRow) {
              continue;
            }
            forthLPieceGp = gp;
            bFounded = true;
            break;
          }
          if(bFounded) {
            break;
          }
        }

        logger.i("rowSeries forthLPieceGp " +forthLPieceGp!.iPos.toString());
        if(forthLPieceGp == null) {
          return ret;
        }

        ret = getMoveDecorationBorderWithBorderSidesForRow(
            index, rowSeries.series, forthLPieceGp, boxDecorationColor);
      }
      else {
        int? iHorizontalCol = lGameSession.getColNumberInMoveArray(
            lGameSession.iArrPlayerMovePieces
        );
        if (iHorizontalCol == null) {
          return ret;
        }
        /*
            ret = Border.all(
              color: boxDecorationColor,
              width: 7,
            );
             */

        List<GameBoardPosition>? freePositions =
        lGameSession.getGameBoardPositionList(listStatic);
        if (freePositions == null) {
          return ret;
        }

        logger.i("colSeries gps " +gps.length.toString());
        GameBoardPositionSeries? colSeries =
        lGameSession.getPositionsOfFreePieceInSpecCol(
            iHorizontalCol, gps);
        if (colSeries == null) {
          return ret;
        }
        logger.i("colSeries " +colSeries!.series.length.toString());
        GameBoardPosition? gp, seriesGp, forthLPieceGp;
        bool bFounded = false;
        for (int i = 0; i < gps.length; i++ ) {
          gp = gps[i];
          if (gp == null) {
            continue;
          }
          for (int j = 0; j < colSeries.series.length; j++ ) {
            seriesGp =  colSeries.series[j];
            if (seriesGp == null) {
              continue;
            }
            if (seriesGp.iCol == gp.iCol) {
              continue;
            }
            forthLPieceGp = gp;
            bFounded = true;
            break;
          }
          if(bFounded) {
            break;
          }
        }

        logger.i("colSeries forthLPieceGp " +forthLPieceGp!.iPos.toString());
        if(forthLPieceGp == null) {
          return ret;
        }

        ret = getMoveDecorationBorderWithBorderSidesForCol(
            index, colSeries.series, forthLPieceGp, boxDecorationColor);
      }
    }

    return ret;
  }

  Border
  getMoveDecorationBorderWithBorderSidesForRow(int index,
      List<GameBoardPosition>? l3SeriesList,
      GameBoardPosition forthLPieceGp,
      Color boxDecorationColor)
  {
    Border ret = Border.all(
      color: Colors.black,
      width: 7,
    );
    if (l3SeriesList == null) {
      return ret;
    }

    l3SeriesList.sort(
            (a, b) => a.iCol.compareTo(b.iCol));
    GameBoardPosition leftGp = l3SeriesList.first;
    GameBoardPosition rightGp = l3SeriesList.last;
    GameBoardPosition betweenGp = l3SeriesList[1];
    GameBoardPosition? neighbour;
    bool? neighBourIsLeftGp;
    if (leftGp.iCol == forthLPieceGp.iCol)
    {
      neighBourIsLeftGp = true;
      neighbour = leftGp;
    }
    else
    if (rightGp.iCol == forthLPieceGp.iCol)
    {
      neighbour = rightGp;
      neighBourIsLeftGp = false;
    }
    logger.i("neighBourIsLeftGp" +neighBourIsLeftGp.toString());

    if (leftGp.iPos == index)
    {
      ret = const Border(
        top: BorderSide(
            width: 7,
            color: Colors.black,
            style: BorderStyle.solid),
        bottom: BorderSide(
            width: 7,
            color: Colors.black,
            style: BorderStyle.solid),
        left: BorderSide(
            width: 7,
            color: Colors.black,
            style: BorderStyle.solid),
        right: BorderSide.none /* BorderSide(
            width: 7,
            color: Colors.transparent,
            style: BorderStyle.solid) */, //BorderSide
        /* color: boxDecorationColor,
          width: 7,*/
      );

      if (neighBourIsLeftGp != null && leftGp.iCol == forthLPieceGp.iCol
          && forthLPieceGp.iRow > leftGp.iRow)
      {
        ret = const Border(
          top: BorderSide(
              width: 7,
              color: Colors.black,
              style: BorderStyle.solid),
          bottom: BorderSide.none  /* BorderSide(
              width: 7,
              color: Colors.transparent,
              style: BorderStyle.solid) */,
          left: BorderSide(
              width: 7,
              color: Colors.black,
              style: BorderStyle.solid),
          right: BorderSide.none /* BorderSide(
              width: 7,
              color: Colors.transparent,
              style: BorderStyle.solid) */, //BorderSide
          /* color: boxDecorationColor,
          width: 7,*/
        );
      }

      if (neighBourIsLeftGp != null && leftGp.iCol == forthLPieceGp.iCol
          && forthLPieceGp.iRow < leftGp.iRow)
      {
        ret = const Border(
          top: BorderSide.none /* BorderSide(
              width: 7,
              color: Colors.transparent,
              style: BorderStyle.solid) */,
          bottom: BorderSide(
              width: 7,
              color: Colors.black,
              style: BorderStyle.solid),
          left: BorderSide(
              width: 7,
              color: Colors.black,
              style: BorderStyle.solid),
          right: BorderSide.none  /* BorderSide(
              width: 7,
              color: Colors.transparent,
              style: BorderStyle.solid) */, //BorderSide
          /* color: boxDecorationColor,
          width: 7,*/
        );
      }
    }
    else
    if (rightGp.iPos == index)
    {
      ret = const Border(
        top: BorderSide(
            width: 7,
            color: Colors.black,
            style: BorderStyle.solid),
        bottom: BorderSide(
            width: 7,
            color: Colors.black,
            style: BorderStyle.solid),
        left: BorderSide.none /* BorderSide(
            width: 7,
            color: Colors.transparent,
            style: BorderStyle.solid) */,
        right: BorderSide(
            width: 7,
            color: Colors.black,
            style: BorderStyle.solid), //BorderSide
        /* color: boxDecorationColor,
          width: 7,*/
      );

      if (neighBourIsLeftGp != null && !neighBourIsLeftGp!
          && forthLPieceGp.iRow > rightGp.iRow)
      {
        ret = const Border(
          top: BorderSide(
              width: 7,
              color: Colors.black,
              style: BorderStyle.solid),
          bottom: BorderSide.none /* BorderSide(
              width: 7,
              color: Colors.transparent,
              style: BorderStyle.solid) */,
          left: BorderSide.none /* BorderSide(
              width: 7,
              color: Colors.transparent,
              style: BorderStyle.solid) */,
          right: BorderSide(
              width: 7,
              color: Colors.black,
              style: BorderStyle.solid), //BorderSide
          /* color: boxDecorationColor,
          width: 7,*/
        );
      }

      if (neighBourIsLeftGp != null && !neighBourIsLeftGp!
          && forthLPieceGp.iRow < rightGp.iRow)
      {
        ret = const Border(
          top: BorderSide.none /* BorderSide(
              width: 7,
              color: Colors.transparent,
              style: BorderStyle.solid) */,
          bottom: BorderSide(
              width: 7,
              color: Colors.black,
              style: BorderStyle.solid),
          left: BorderSide.none /* BorderSide(
              width: 7,
              color: Colors.transparent,
              style: BorderStyle.solid) */,
          right: BorderSide(
              width: 7,
              color: Colors.black,
              style: BorderStyle.solid), //BorderSide
          /* color: boxDecorationColor,
          width: 7,*/
        );
      }

    }
    else
    if (betweenGp.iPos == index)
    {
      ret = const Border(
        top: BorderSide(
            width: 7,
            color: Colors.black,
            style: BorderStyle.solid),
        bottom: BorderSide(
            width: 7,
            color: Colors.black,
            style: BorderStyle.solid),
        left: BorderSide.none /* BorderSide(
            width: 7,
            color: Colors.transparent,
            style: BorderStyle.solid) */,
        right: BorderSide.none /* BorderSide(
            width: 7,
            color: Colors.transparent,
            style: BorderStyle.solid) */, //BorderSide
        /* color: boxDecorationColor,
          width: 7,*/
      );
    }
    else
    if(forthLPieceGp.iPos == index)
    {
      ret = const Border(
        top: BorderSide(
            width: 7,
            color: Colors.black,
            style: BorderStyle.solid),
        bottom: BorderSide(
            width: 7,
            color: Colors.black,
            style: BorderStyle.solid),
        left: BorderSide(
            width: 7,
            color: Colors.black,
            style: BorderStyle.solid),
        right: BorderSide(
            width: 7,
            color: Colors.black,
            style: BorderStyle.solid), //BorderSide
        /* color: boxDecorationColor,
          width: 7,*/
      );

      if (neighBourIsLeftGp != null
          && ((neighBourIsLeftGp && forthLPieceGp.iCol == leftGp.iCol
              && forthLPieceGp.iRow > leftGp.iRow)
              || (!neighBourIsLeftGp && forthLPieceGp.iCol == rightGp.iCol
                  && forthLPieceGp.iRow > rightGp.iRow)))
      {
        ret = const Border(
          top: BorderSide.none /* BorderSide(
              width: 7,
              color: Colors.transparent,
              style: BorderStyle.solid) */,
          bottom: BorderSide(
              width: 7,
              color: Colors.black,
              style: BorderStyle.solid),
          left: BorderSide(
              width: 7,
              color: Colors.black,
              style: BorderStyle.solid),
          right: BorderSide(
              width: 7,
              color: Colors.black,
              style: BorderStyle.solid), //BorderSide
          /* color: boxDecorationColor,
          width: 7,*/
        );
      }

      if (neighBourIsLeftGp != null
          && ((neighBourIsLeftGp && forthLPieceGp.iCol == leftGp.iCol
              && forthLPieceGp.iRow < leftGp.iRow)
              || (!neighBourIsLeftGp && forthLPieceGp.iCol == rightGp.iCol
                  && forthLPieceGp.iRow < rightGp.iRow)))
      {
        ret = const Border(
          top: BorderSide(
              width: 7,
              color: Colors.black,
              style: BorderStyle.solid),
          bottom: BorderSide.none /* BorderSide(
              width: 7,
              color: Colors.transparent,
              style: BorderStyle.solid) */,
          left: BorderSide(
              width: 7,
              color: Colors.black,
              style: BorderStyle.solid),
          right: BorderSide(
              width: 7,
              color: Colors.black,
              style: BorderStyle.solid), //BorderSide
          /* color: boxDecorationColor,
          width: 7,*/
        );
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

  Widget? getMoveChild(int index)
  {
    Color modeColor = getMovePieceColor(index);
    if (modeColor == Colors.transparent) {
      return null;
    }
    Widget? textWidget = getTextChild(index, false);
    Widget text = Text(
        "${lGameSession.iPlayerMove}",
        textAlign: TextAlign.left,
        style: const TextStyle(fontSize: 27, color: Colors.black)
    );

    Widget ret = Container(
      // padding: const EdgeInsets.all(8),
      color: modeColor.withOpacity(0.1),
      width: containerWidth,
      height: containerHeight,
      child: /** textWidget ?? */ text,
    );
    return ret;
  }

  Container getMoveContainer(int index)
  {
    double dRadius = 0.0;
    Widget? modeContainerChild = getMoveChild(index);
    Color boxDecorationColor = getBoxDecorationColor();
    Color modeColor = getMovePieceColor(index);
    Container? container;

    BoxDecoration boxDecoration = BoxDecoration(
      color: modeColor,
      border: Border.all(
        color: boxDecorationColor,
        width: 7,
      ),
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(dRadius /* 30.0 */),
          topRight: Radius.circular(dRadius /* 30.0 */),
          bottomLeft: Radius.circular(dRadius /* 30.0 */),
          bottomRight: Radius.circular(dRadius /* 30.0 */)),
    );


    if (lGameSession.inMovingPiece == LGamePieceInMove.LPiece
        &&  lGameSession.iArrPlayerMovePieces != null && lGameSession.iArrPlayerMovePieces!.contains(index)) {
      boxDecoration = BoxDecoration(
        color: modeColor,
        border: getMoveDecorationBorder(index, boxDecorationColor) /* Border.all(
          color: boxDecorationColor,
          width: 7,
        ) */,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(dRadius /* 30.0 */),
            topRight: Radius.circular(dRadius /* 30.0 */),
            bottomLeft: Radius.circular(dRadius /* 30.0 */),
            bottomRight: Radius.circular(dRadius /* 30.0 */)),
      );
    }

    double neutralRadius = 45.0;
    if (lGameSession.inMovingPiece == LGamePieceInMove.neutral && (boxDecorationColor == Colors.white
        || (lGameSession.iArrPlayerMovePieces != null && lGameSession.iArrPlayerMovePieces!.contains(index)))) {
      if (lGameSession.iArrPlayerMovePieces != null && lGameSession.iArrPlayerMovePieces!.contains(index)) {
        boxDecorationColor = modeColor; // Colors.white;
      }
      boxDecoration = BoxDecoration(
        color: boxDecorationColor,
        border: Border.all(
          color: lGameSession.playerTurn == GamePlayerTurn.player1 ?
          player1Color : player2Color /* Colors.black */,
          width: 7,
        ),

        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(neutralRadius),
            topRight: Radius.circular(neutralRadius),
            bottomLeft: Radius.circular(neutralRadius),
            bottomRight: Radius.circular(neutralRadius)),

      );
    }

    if (modeContainerChild == null) {
      container = Container(
        //  padding: const EdgeInsets.all(8),
        color: modeColor,
        width: containerWidth,
        height: containerHeight,
        child: modeContainerChild,
      );
    } else {
      container = Container(
        //   padding: const EdgeInsets.all(8),
        decoration: boxDecoration,
        width: containerWidth,
        height: containerHeight,
        child: modeContainerChild,
      );
    }
    return container;
  }

  Container getBoardSquaresContainer(int index)
  {
    return Container(
      // padding: const EdgeInsets.all(8),

      width: containerWidth,
      height: containerHeight,
      decoration: BoxDecoration(
        color: Colors.orange[200],
        border: Border.all(
          color: Colors.black,
          width: 1,
        ),
      ),
      /*
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(dRadius /* 30.0 */),
                  topRight: Radius.circular(dRadius /* 30.0 */),
                  bottomLeft: Radius.circular(dRadius /* 30.0 */),
                  bottomRight: Radius.circular(dRadius /* 30.0 */)),
               */
      child: null,
    );
  }

  Color getBoxDecorationColor()
  {
    Color ret = lGameSession.playerTurn ==
        GamePlayerTurn.player1 ? player1Color
        : player2Color;
    if (lGameSession.iArrPlayerMovePieces != null)
    {
      if (lGameSession.iArrPlayerMovePieces!.length == 1) {
        if (lGameSession.iActiveNeutral == 1
            && lGameSession.iArrPlayerMovePieces!.first.toInt() ==
                lGameSession.iPlayerNeutral1Piece
            || lGameSession.iActiveNeutral == 2
                && lGameSession.iArrPlayerMovePieces!.first.toInt()
                    == lGameSession.iPlayerNeutral2Piece) {
          ret = Colors.white;
        } else {
          ret = Colors.black;
        }
      }
      /* else
          {

          }
         */
    }
    return ret;
  }


  Color getBoardPieceColor(int index)
  {
    Color ret = Colors.transparent;
    bool isIn1List = lGameSession.iArrPlayer1Pieces == null ? false :
    lGameSession.iArrPlayer1Pieces!.contains(index);
    bool isIn2List = lGameSession.iArrPlayer2Pieces == null ? false :
    lGameSession.iArrPlayer2Pieces!.contains(index);

    if (isIn1List) {
      ret = player1Color;
    } else
    if (isIn2List) {
      ret = player2Color;
    }
    else
    if (index == lGameSession.iPlayerNeutral1Piece) {
      ret = neutralColor;
    }
    else
    if (index == lGameSession.iPlayerNeutral2Piece) {
      ret = neutralColor;
    }

    return ret;
  }


  Widget? getTextChild(int index, bool isBoardPiece) {
    String strText = "";
    bool isIn1List = lGameSession.iArrPlayer1Pieces == null ? false :
    lGameSession.iArrPlayer1Pieces!.contains(index);
    bool isIn2List = lGameSession.iArrPlayer2Pieces == null ? false :
    lGameSession.iArrPlayer2Pieces!.contains(index);

    if (index != lGameSession.iPlayerNeutral1Piece
        && index != lGameSession.iPlayerNeutral2Piece &&
        !isIn1List && !isIn2List) {
      return null;
    }

    Color fontColor = Colors.black;
    if (isIn1List) {
      strText = "1";
    } else if (isIn2List) {
      strText = "2";
    } else {
      strText = "0";
      fontColor = Colors.white;
      if (!isBoardPiece) {
        fontColor = Colors.black;
      }
    }

    return Center(child: AutoSizeText(strText,
      // This is some text that will resize based on the screen size.,
      style: TextStyle(fontSize: 30, color: fontColor),
      overflow: TextOverflow.ellipsis,));
  }

  Widget getScreenReaderSquare(index)
  {
    return Semantics(readOnly: true,
      child: /* InkWell( /* ElevatedButton(  style: buttonStyleScreenReader, */
      onTap: () {
        setState(() {
          //   logger.i(" onTap ->");
          bChangeScreenReaderTextIntoTop = ! bChangeScreenReaderTextIntoTop;
          /*
              ! _iArrScreenReaderSquareText[i].contains("Position");
               */
          _iArrScreenReaderSquareText[index] =
              getChangeScreenReaderText(index, false);
          _screenReaderAnnounce(_iArrScreenReaderSquareText[index]);
        });
      },
      child: */ Text(_iArrScreenReaderSquareText[index],
          textAlign: TextAlign.left,
          style: const TextStyle(fontSize: 12, color: Colors.transparent /* Colors.grey */),
      ),
     // ),
    );
  }

  String getChangeScreenReaderText(int i, bool bInit)
  {
    if (bInit || widget.bScreenReaderIsUsed) {
      String strLabel = "";
      if (bChangeScreenReaderTextIntoTop) {
        strLabel = lGameSession.getScreenReaderSquareLabel(i);
        String strExpr = "Position " + strLabel;
        return strExpr;
      }
      else {
        return lGameSession.getScreenReaderSquareValue(i);
      }
    }
    return "";
  }

  showSnapBar(int i)
  {
    if (widget.bScreenReaderIsUsed) {
      String strLabel = lGameSession.getScreenReaderSquareLabel(i);
      String strExpr = "Position " +strLabel;
      final snackBar = SnackBar(content: Semantics(liveRegion: true, child:  Text(strExpr)));
      ScaffoldMessenger.of(thisContext!).showSnackBar(snackBar);
      /*
                  await SemanticsService.announce(
                  "Position " + lGameSession.getScreenReaderSquareLabel(index),
                  TextDirection.ltr, assertiveness: Assertiveness.assertive);
                  await Future.delayed(const Duration(seconds: 3));
                  */
    }
  }

  _screenReaderAnnounce(String msg) async
  {
    if (widget.bScreenReaderIsUsed && msg.isNotEmpty)
    {
      await SemanticsService.announce(msg, TextDirection.ltr);
    }
  }

  GridView
  buildGameBoard()
  {
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

    List<Widget> listBoardStack = List<Widget>.empty(growable: true);
    //_listBoardStack.clear();
    if (widget.bScreenReaderIsUsed) {
      if (_iArrScreenReaderSquareText.isEmpty) {
          _iArrScreenReaderSquareText = List.generate(16,  (index) {
          return getChangeScreenReaderText(index, true);
        });
     }
      else
        {
          _iArrScreenReaderSquareText = List.generate(16,  (index) {
            return getChangeScreenReaderText(index, false);
          });
        }

      _listScreenReaderSquares = List.generate(16,  (index) {
        return getScreenReaderSquare(index);
      });

      for (int i = 0; i < _listBoardSquares.length; i++) {
        listBoardStack.add(BoardSquare(detector: GestureDetector( behavior:
                   HitTestBehavior.translucent,
          onTap: () => setState(() {
            setState(() {
              //   logger.i(" onTap ->");
              bChangeScreenReaderTextIntoTop =
                 ! _iArrScreenReaderSquareText[i].contains("Position");
              /*
              ! _iArrScreenReaderSquareText[i].contains("Position");
               */
              _iArrScreenReaderSquareText[i] =
                  getChangeScreenReaderText(i, false);
              _screenReaderAnnounce(_iArrScreenReaderSquareText[i]);
            });
          }),
      /*
      onDoubleTap: () {
          setState(() {
            bChangeScreenReaderTextIntoTop = true;
            /*
              ! _iArrScreenReaderSquareText[i].contains("Position");
               */
            _iArrScreenReaderSquareText[i] =
                getChangeScreenReaderText(i, false);
            _screenReaderAnnounce(_iArrScreenReaderSquareText[i]);
          });
      },
       */
          child:
            /*
        onFocusChange: (hasFocus) {
            if(hasFocus) {
              bChangeScreenReaderTextIntoTop = true;
            }
          },
         */
            // onTap: () => changeScreenReaderText(i),
            // onLongPress: () => showSnapBar(i),
            // onHover:  (val) { if (val) showSnapBar(i); },
            //    onDoubleTap: () => showSnapBar(i),

          /*
     onLongPress: () async {
       if (widget.bScreenReaderIsUsed) {
         String strLabel = lGameSession.getScreenReaderSquareLabel(index);
         String strExpr = "Position " +strLabel;
         final snackBar = SnackBar(content: Semantics(liveRegion: true, child:  Text(strExpr)));
         ScaffoldMessenger.of(thisContext!).showSnackBar(snackBar);
         ?*
         await SemanticsService.announce(
             "Position " + lGameSession.getScreenReaderSquareLabel(index),
             TextDirection.ltr, assertiveness: Assertiveness.assertive);
         await Future.delayed(const Duration(seconds: 3));
          *?
       }
      }
      */
          //   ),

          AbsorbPointer(
            child: Container(
            color: Colors.transparent,
            width: containerWidth,
            height: containerHeight,
            //      decoration: listBoxDecoration,
            child: Stack(clipBehavior: Clip.none,
                children: [_listBoardSquares[i],
          _listBoardPieces[i], _listMoveSquares[i], _listScreenReaderSquares[i]
               ]
            /*
            onFocusChange: (hasFocus) {
              if(hasFocus) {
                bChangeScreenReaderTextIntoTop = true;
              }
            },
            // onTap: () => changeScreenReaderText(i),
            // onLongPress: () => showSnapBar(i),
            // onHover:  (val) { if (val) showSnapBar(i); },
            //    onDoubleTap: () => showSnapBar(i),
            ),

             */
          ),
          ),
          ),
          ),
         ),
        );
        }
    }
    else {
      for (int i = 0; i < _listBoardSquares.length; i++) {
        listBoardStack.add(
          Container( child: Stack(children: [_listBoardSquares[i],
          _listBoardPieces[i], _listMoveSquares[i]]),));
      }
   }

  _gameBoardGrid = GridView.count(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
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
    return _gameBoardGrid!;
  }

  @override
  Widget build(BuildContext context) {
    thisContext = context;
    lGameSession = widget.lGameSession;
    lGameSession.setScreenReaderIsUsed(widget.bScreenReaderIsUsed);
    return Card(child: buildGameBoard());
  }
}

class BoardSquare extends StatelessWidget {
  const BoardSquare({super.key, required this.detector});
  final GestureDetector detector;

  @override
  Widget build(BuildContext context) {
    return detector;
  }
}
