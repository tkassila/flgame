
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
// import 'package:logger/logger.dart';
import 'package:flutter/semantics.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../ParameterValues.dart';
import '../models/lgame_data.dart';
import '../LoggerDef.dart';

/*
var logger = Logger(
  printer: PrettyPrinter(),
);
mi
var loggerNoStack = Logger(
  printer: PrettyPrinter(methodCount: 0),
);
 */

enum INNERCORNERPOSITION {
  TOPRIGHTCORNER, TOPLEFTCORNER, BOTTOMLEFTCORNER, BOTTOMRIGHTCORNER
}

enum SHADOWBOXPOSITION {
  TOPSHADOWBOX, LEFTSHADOWBOX, BOTTOMSHADOWBOX, RIGHTSHADOWBOX
}

class StackWidget extends StatelessWidget {
  const StackWidget({super.key, required this.child});
  final Stack child;

  @override
  Widget build(BuildContext context)
  {
    return RepaintBoundary(child: child);
  }
}

class BorderInnerSquarePosition {
  INNERCORNERPOSITION? innerCornerPosition;
  int iInnerSquareBorder = -1;
  BorderInnerSquarePosition(INNERCORNERPOSITION p_innerCornerPosition,
      int p_iInnerSquareBorder)
  {
    iInnerSquareBorder = p_iInnerSquareBorder;
    innerCornerPosition = p_innerCornerPosition;
  }
}

class LGameBoard extends StatelessWidget {
  LGameBoard({super.key, required this.lGameSession,
  required this.bScreenReaderIsUsed,
  required this.minusDynamicContainerSize
  });
  final bool bScreenReaderIsUsed;
  final LGameSession lGameSession;
  final int minusDynamicContainerSize;

  Widget? _gameBoardGrid;
  late List<Container> _listBoardSquares;
  late List<Container>  _listBoardPieces;
  // var _listBoardPieces = List<Container>.empty(growable: true);
//  List<Container> _listMovePieceShadowContainers = List<Container>.empty(growable: true);
//  List<Container> _listMovePieceShadowCenterContainers = List<Container>.empty(growable: true);
  late List<Container> _listMoveBorderSquares;
  late List<Border?>  _listMoveBorders;
  BorderInnerSquarePosition? innerSquarePosition;
  late List<Container>  _listMoveSquares;
  late List<String> _iArrScreenReaderSquareText;
  late List<Widget> _listScreenReaderSquares;
  final Color player1Color = Colors.redAccent;
  final Color player2Color = Colors.blueAccent;
  final Color neutralColor = Colors.black;
//  double containerWidth = 80;
//  double containerHeight = 80;
  BuildContext? thisContext;
  bool bChangeScreenReaderTextIntoTop = false;
  bool callInit = true;
  late ButtonStyle buttonStyleScreenReader;
  final ValueNotifier<bool> _notifier = ValueNotifier(true);
//  bool listBoardPiecesUpdated = false;
//  bool listMovePiecesUpdated = false;

  /*
  @override
  */
  void initState() {
   // super.initState();
    buttonStyleScreenReader = ElevatedButton.styleFrom(textStyle: TextStyle(fontSize: ScreenUtil().setSp(12),
        fontWeight: FontWeight.bold),
        backgroundColor: Colors.transparent);
    if (Loggerdef.isLoggerOn) {
      Loggerdef.logger.i("containerWidth=$ScreenValues.containerWidth");
    }

    _listBoardSquares = List.generate(16,  (index) {
      return getBoardSquaresContainer(index);
    });
    _listMoveBorders = List.generate(16,  (index) {
      return null;
    });

    /*
    _listMovePieceShadowContainers = List.generate(16,  (index) {
      return Container(
        //    duration: const Duration(seconds: 1),
        //  padding: const EdgeInsets.all(8),
        color: Colors.transparent,
        width: containerWidth,
        height: containerHeight,
      );
    });
     */

    /*
    _listMovePieceShadowCenterContainers = List.generate(16,  (index) {
      return Container(
        //    duration: const Duration(seconds: 1),
        //  padding: const EdgeInsets.all(8),
        color: Colors.transparent,
        width: containerWidth,
        height: containerHeight,
      );
    });
     */
    callInit = false;
}


Border
  getMoveDecorationBorderWithBorderSidesForCol(int index,
      List<GameBoardPosition>? l3SeriesList,
      GameBoardPosition forthLPieceGp,
      Color boxDecorationColor)
  {
     Object? objRet = _getPrivateMoveDecorationBorderWithBorderSidesForCol(index,
               l3SeriesList, forthLPieceGp, boxDecorationColor, false);
     if (objRet != null) {
       return objRet as Border;
     } else {
       objRet = Border.all(
         color: boxDecorationColor,
         width: 7,
       );
     }
     return objRet as Border;
  }

  Object?
  _getPrivateMoveDecorationBorderWithBorderSidesForCol(int index,
      List<GameBoardPosition>? l3SeriesList,
      GameBoardPosition forthLPieceGp,
      Color boxDecorationColor,
      bool isCalledFromBorderMoveContainer)
  {
    Object? ret = Border.all(
      color: Colors.black,
      width: 7,
    );
    if (isCalledFromBorderMoveContainer) {
      ret = null;
    }

    if (l3SeriesList == null) {
      return ret;
    }

    l3SeriesList.sort(
            (a, b) => a.iRow.compareTo(b.iRow));
    GameBoardPosition leftGp = l3SeriesList.first;
    GameBoardPosition rightGp = l3SeriesList.last;
    GameBoardPosition betweenGp = l3SeriesList[1];
    GameBoardPosition? neighbour;
    bool? neighBorIsLeftGp;
    if (leftGp.iRow == forthLPieceGp.iRow)
    {
      neighBorIsLeftGp = true;
      neighbour = leftGp;
    }
    else
    if (rightGp.iRow == forthLPieceGp.iRow)
    {
      neighbour = rightGp;
      neighBorIsLeftGp = false;
    }
    if (Loggerdef.isLoggerOn) {
      Loggerdef.logger.i("neighBorIsLeftGp $neighBorIsLeftGp");
    }

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

      if (neighBorIsLeftGp != null && leftGp.iRow == forthLPieceGp.iRow
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

      if (neighBorIsLeftGp != null && leftGp.iRow == forthLPieceGp.iRow
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

      if (neighBorIsLeftGp != null && rightGp.iRow == forthLPieceGp.iRow
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

      if (neighBorIsLeftGp != null && rightGp.iRow == forthLPieceGp.iRow
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

      if (neighBorIsLeftGp != null
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

      if (neighBorIsLeftGp != null
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
    Object? objRet = _getPrivateMoveDecorationBorder(index, boxDecorationColor,
        false) ;
    if (objRet != null) {
      return objRet as Border;
    } else {
      objRet = Border.all(
        color: boxDecorationColor,
        width: 7,
      );
    }
    return objRet as Border;
  }

  Object?
  _getPrivateMoveDecorationBorder(int index, Color boxDecorationColor,
      bool isCalledFromBorderMoveContainer)
  {
    Object? ret = Border.all(
      color: boxDecorationColor,
      width: 7,
    );

    if (isCalledFromBorderMoveContainer) {
      ret = null;
    }

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

        if (Loggerdef.isLoggerOn) {
          Loggerdef.logger.i("rowSeries gps ${gps.length}");
        }
        GameBoardPositionSeries? rowSeries =
        lGameSession.getPositionsOfFreePieceInSpecRow(
            iHorizontalRow, gps);
        if (rowSeries == null) {
          return ret;
        }
        if (Loggerdef.isLoggerOn) {
          Loggerdef.logger.i("rowSeries ${rowSeries.series.length}");
        }
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
        if (Loggerdef.isLoggerOn) {
          Loggerdef.logger.i("rowSeries forthLPieceGp ${forthLPieceGp!.iPos}");
        }
        if(forthLPieceGp == null) {
          return ret;
        }

        if (!isCalledFromBorderMoveContainer) {
          ret = getMoveDecorationBorderWithBorderSidesForRow(
                  index, rowSeries.series, forthLPieceGp, boxDecorationColor);
        } else {
          ret = _getPrivateMoveDecorationBorderWithBorderSidesForRow(
              index, rowSeries.series, forthLPieceGp, boxDecorationColor, true);
        }

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

        if (Loggerdef.isLoggerOn) {
          Loggerdef.logger.i("colSeries gps ${gps.length}");
        }
        GameBoardPositionSeries? colSeries =
        lGameSession.getPositionsOfFreePieceInSpecCol(
            iHorizontalCol, gps);
        if (colSeries == null) {
          return ret;
        }
        if (Loggerdef.isLoggerOn) {
          Loggerdef.logger.i("colSeries ${colSeries.series.length}");
        }
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

        if (Loggerdef.isLoggerOn) {
          Loggerdef.logger.i("colSeries forthLPieceGp ${forthLPieceGp!.iPos}");
        }
        if(forthLPieceGp == null) {
          return ret;
        }

        if (!isCalledFromBorderMoveContainer) {
          ret = getMoveDecorationBorderWithBorderSidesForCol(
                index, colSeries.series, forthLPieceGp, boxDecorationColor);
        } else {
          ret = _getPrivateMoveDecorationBorderWithBorderSidesForCol(
              index, colSeries.series, forthLPieceGp, boxDecorationColor, true);
        }
      }
    }

    if (isCalledFromBorderMoveContainer && ret != null && ret.runtimeType == Border) {
      ret = null;
    }

    return ret;
  }

  Border
  getMoveDecorationBorderWithBorderSidesForRow(int index,
      List<GameBoardPosition>? l3SeriesList,
      GameBoardPosition forthLPieceGp,
      Color boxDecorationColor)
  {
       Object? objRet = _getPrivateMoveDecorationBorderWithBorderSidesForRow(index,
           l3SeriesList, forthLPieceGp, boxDecorationColor, false) as Border;
       if (objRet != null) {
         return objRet as Border;
       } else {
         objRet = Border.all(
           color: boxDecorationColor,
           width: 7,
         );
       }
       return objRet as Border;

  }

  Object?
  _getPrivateMoveDecorationBorderWithBorderSidesForRow(int index,
      List<GameBoardPosition>? l3SeriesList,
      GameBoardPosition forthLPieceGp,
      Color boxDecorationColor,
      bool isCalledFromBorderMoveContainer)
  {
    Object? ret = Border.all(
      color: Colors.black,
      width: 7,
    );
    if (isCalledFromBorderMoveContainer) {
      ret = null;
    }

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
    if (Loggerdef.isLoggerOn) {
      Loggerdef.logger.i("neighBourIsLeftGp $neighBourIsLeftGp");
    }

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

      if (neighBourIsLeftGp != null && !neighBourIsLeftGp
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

      if (neighBourIsLeftGp != null && !neighBourIsLeftGp
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
      ret = Colors.white10;
    } else
    if (lGameSession.iPlayerMove == 2) {
      ret = Colors.white10 /* Colors.white60 */;
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

    Color textColor = Colors.black;
    bool isIn1List = lGameSession.iArrPlayer1Pieces == null ? false :
           lGameSession.iArrPlayer1Pieces!.contains(index);
    bool isIn2List = lGameSession.iArrPlayer2Pieces == null ? false :
           lGameSession.iArrPlayer2Pieces!.contains(index);
    if ((!isIn2List && !isIn1List) && index == lGameSession.iPlayerNeutral1Piece
        || index == lGameSession.iPlayerNeutral2Piece) {
      textColor = Colors.yellow;
    }

    Widget text = Text(
        "${lGameSession.iPlayerMove}",
        textAlign: TextAlign.left,
        style: TextStyle(fontSize: ScreenUtil().setSp(27), color: textColor,
            fontWeight: FontWeight.bold)
    );

    if (modeColor == Colors.white10) {
      modeColor = Colors.transparent;
    }
    /*
    else
    if (modeColor != Colors.transparent) {
      {
        print("Kissa");
      }
    }
     */

    Widget ret = Container(
      // padding: const EdgeInsets.all(8),
      color: modeColor /* modeColor.withOpacity(0.1) */,
      width: ScreenValues.containerWidth,
      height: ScreenValues.containerWidth,
      child: /** textWidget ?? */ text,
    );
    return ret;
  }

  bool isInnerCornerOfContainer(int index)
  {
    bool isInMoveList = lGameSession.iArrPlayerMovePieces == null ? false :
                        lGameSession.iArrPlayerMovePieces!.contains(index);
    if (!isInMoveList) {
      return false;
    }
    bool? bValue = lGameSession.moveArrayIsInHorizontal(
        lGameSession.iArrPlayerMovePieces);
    if (bValue == null) {
      return false;
    }

    return false;
  }

  Alignment? getCornerContainerAlignment(int index)
  {
     var ret;
     /*
     if (isInnerCornerOfContainer(index)) {
         ret = _getMoveDecorationBorder(index, boxDecorationColor, true);
     };

      */
     return ret;
  }

  Container getBorderMoveContainer(int index)
  {
    // Container ret = _getPrivateMoveContainer(index, true);
    Widget? modeContainerChild;
    /*
    if (/* lGameSession.inMovingPiece == LGamePieceInMove.LPiece
        && */ lGameSession.iArrPlayerMovePieces != null
        && lGameSession.iArrPlayerMovePieces!.contains(index)) {

     */
      Object? objAlignment; // _getPrivateMoveDecorationBorder(index,
      // boxDecorationColor, true) as Alignment?;
      if (innerSquarePosition?.iInnerSquareBorder == index) {
        if (innerSquarePosition?.innerCornerPosition ==
            INNERCORNERPOSITION.TOPRIGHTCORNER) {
          objAlignment = Alignment.topRight;
        }
        else if (innerSquarePosition?.innerCornerPosition ==
            INNERCORNERPOSITION.TOPLEFTCORNER) {
          objAlignment = Alignment.topLeft;
        }
        else if (innerSquarePosition?.innerCornerPosition ==
            INNERCORNERPOSITION.BOTTOMRIGHTCORNER) {
          objAlignment = Alignment.bottomRight;
        }
        else if (innerSquarePosition?.innerCornerPosition ==
            INNERCORNERPOSITION.BOTTOMLEFTCORNER) {
          objAlignment = Alignment.bottomLeft;
        }

        if (objAlignment !=
            null /* && objAlignment.runtimeType is Alignment */) {
          Alignment alignment = objAlignment as Alignment;
          double dRadius = 0.0;
          modeContainerChild = Align(
            alignment: alignment,
            child: Container(
              height: 7,
              width: 7,
              color: Colors.black /* boxDecorationColor */,
            ),
          );
        }
      }
   // }

    Container ret = Container(
      //  padding: const EdgeInsets.all(8),
      color: Colors.transparent,
      width: ScreenValues.containerWidth,
      height: ScreenValues.containerWidth,
      child: modeContainerChild,
    );
     /*
     Container? ret = Container(color: Colors.transparent,);
     Alignment? alignment = getCornerContainerAlignment(index);
     if (alignment != null) {
       double dRadius = 0.0;
       Color boxDecorationColor = getBoxDecorationColor();

       ret = Container(
         color: Colors.transparent,
         child: Align(
           alignment: alignment!,
           child: Container(
             height: 7,
             width: 7,
             color: boxDecorationColor,
           ),
         ),
       );
     }
      */
     return ret;
  }

  Container getMoveContainer(int index) {
    return _getPrivateMoveContainer(index, false);
  }

  Container _getPrivateMoveContainer(int index,
      bool isCalledFromBorderMoveContainer)
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

    if (/* lGameSession.inMovingPiece == LGamePieceInMove.LPiece
        && */ lGameSession.iArrPlayerMovePieces != null
        && lGameSession.iArrPlayerMovePieces!.contains(index)) {
      Border? boxBorder;
      if (!isCalledFromBorderMoveContainer)
      {
        boxBorder = getMoveDecorationBorder(index, boxDecorationColor);
        _listMoveBorders[index] = boxBorder;
      //  logger.i("_listMoveBorders[" +index.toString() +"]=" +(boxBorder == null ? "null" : "boxBorder" ));
      }

      boxDecoration = BoxDecoration(
        color: modeColor,
        border: boxBorder /* Border.all(
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
    if (lGameSession.inMovingPiece == LGamePieceInMove.neutral
        && (boxDecorationColor == Colors.white
        || (lGameSession.iArrPlayerMovePieces != null
                && lGameSession.iArrPlayerMovePieces!.contains(index)))) {
      if (lGameSession.iArrPlayerMovePieces != null &&
          lGameSession.iArrPlayerMovePieces!.contains(index)) {
        boxDecorationColor = modeColor; // Colors.white;
      }

      Color borderColor = lGameSession.playerTurn == GamePlayerTurn.player1 ?
      player1Color : player2Color /* Colors.black */ ;
      if (lGameSession.inMovingPiece == LGamePieceInMove.neutral)
      {
          if (lGameSession.iArrPlayerMovePieces!.contains(index)
          && lGameSession.iArrPlayer1Pieces!.contains(index))
          {
            if (lGameSession.playerTurn == GamePlayerTurn.player1) {
              borderColor = Colors.black;
            }
          }
          else
          if (lGameSession.iArrPlayerMovePieces!.contains(index)
          && lGameSession.iArrPlayer2Pieces!.contains(index))
          {
            if (lGameSession.playerTurn == GamePlayerTurn.player2) {
              borderColor = Colors.black;
            }
          }
      }

      boxDecoration = BoxDecoration(
        color: boxDecorationColor,
        border: Border.all(
          color: borderColor,
          width: 7,
        ),

        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(neutralRadius),
            topRight: Radius.circular(neutralRadius),
            bottomLeft: Radius.circular(neutralRadius),
            bottomRight: Radius.circular(neutralRadius)),

      );
    }

    /*
    if (isCalledFromBorderMoveContainer) {
      modeColor = Colors.transparent;
      modeContainerChild = null;

      if (lGameSession.inMovingPiece == LGamePieceInMove.LPiece
          && lGameSession.iArrPlayerMovePieces != null
          && lGameSession.iArrPlayerMovePieces!.contains(index)) {
        Object? objAlignment = null; // _getPrivateMoveDecorationBorder(index,
           // boxDecorationColor, true) as Alignment?;
        if (innerSquarePosition?.iInnerSquareBorder == index) {
            if (innerSquarePosition?.innerCornerPosition ==
                INNERCORNERPOSITION.TOPRIGHTCORNER) {
              objAlignment = Alignment.topRight;
            }
            else if (innerSquarePosition?.innerCornerPosition ==
                INNERCORNERPOSITION.TOPLEFTCORNER) {
              objAlignment = Alignment.topLeft;
            }
            else
            if (innerSquarePosition?.innerCornerPosition ==
                INNERCORNERPOSITION.BOTTOMRIGHTCORNER) {
              objAlignment = Alignment.bottomRight;
            }
            else
            if (innerSquarePosition?.innerCornerPosition ==
                INNERCORNERPOSITION.BOTTOMLEFTCORNER) {
              objAlignment = Alignment.bottomLeft;
            }
        }
        if (objAlignment != null ?* && objAlignment.runtimeType is Alignment *?) {
          Alignment alignment = objAlignment as Alignment;
          double dRadius = 0.0;
          modeContainerChild = Align(
            alignment: alignment,
            child: Container(
              height: 7,
              width: 7,
              color: Colors.black /* boxDecorationColor */,
            ),
          );
        }
      }

      container = Container(
        //  padding: const EdgeInsets.all(8),
        color: modeColor,
        width: containerWidth,
        height: containerHeight,
        child: modeContainerChild,
      );

      return container!;
    }
     */

    if (modeContainerChild == null) {
      container = Container(
        //  padding: const EdgeInsets.all(8),
        color: modeColor,
        width: ScreenValues.containerWidth,
        height: ScreenValues.containerWidth,
        child: modeContainerChild,
      );
    } else {
      container = Container(
        //   padding: const EdgeInsets.all(8),
        decoration: boxDecoration,
        width: ScreenValues.containerWidth,
        height: ScreenValues.containerWidth,
        child: modeContainerChild,
      );
    }
    return container;
  }

  Container getBoardSquaresContainer(int index)
  {
    return Container(
      padding: const EdgeInsets.all(1),
      width: ScreenValues.containerWidth,
      height: ScreenValues.containerWidth,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.blue, Colors.green],
        ),
      ),
      child: Container(
      // padding: const EdgeInsets.all(8),

      width: ScreenValues.containerWidth -20,
      height: ScreenValues.containerWidth -20,
      decoration: BoxDecoration(
        color: Colors.orange[200],
        border: Border.all(
          color: Colors.black,
          width: 0,
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
    ),
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
      if (isBoardPiece) {
        fontColor = Colors.yellowAccent;
        if (isIn1List) {
          fontColor = Colors.white;
        }
      }
      else {
        fontColor = Colors.white;
      }
    } else if (isIn2List) {
      strText = "2";
      if (isBoardPiece) {
        fontColor = Colors.yellowAccent;
        if (isIn2List) {
          fontColor = Colors.white;
        }
      }
    } else {
      strText = "0";
      fontColor = Colors.white;
      if (!isBoardPiece) {
        fontColor = Colors.black;
      }
      else {
        fontColor = Colors.white;
      }
    }

    if (index == lGameSession.iPlayerNeutral1Piece
        || index == lGameSession.iPlayerNeutral2Piece) {
      fontColor = Colors.white;
    }

    /*
    if (isBoardPiece && index == lGameSession.iPlayerNeutral2Piece
        && lGameSession.iActiveNeutral == 2
        && lGameSession.inMovingPiece == index)
      {
        fontColor = Colors.yellow;
      }
    else
    if (isBoardPiece && index == lGameSession.iPlayerNeutral1Piece
        && lGameSession.iActiveNeutral == 1
        && lGameSession.inMovingPiece == index)
    {
      fontColor = Colors.yellow;
    }
     */

    return Center(child: AutoSizeText(strText,
      // This is some text that will resize based on the screen size.,
      style: TextStyle(fontSize: ScreenUtil().setSp(30), color: fontColor,
          fontWeight: FontWeight.bold),
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
          style: TextStyle(fontSize: ScreenUtil().setSp(12),
              color: Colors.transparent,
              fontWeight: FontWeight.bold
            /* Colors.grey */),
      ),
     // ),
    );
  }

  String getChangeScreenReaderText(int i, bool bInit)
  {
    if (bInit || bScreenReaderIsUsed) {
      String strLabel = "";
      if (bChangeScreenReaderTextIntoTop) {
        strLabel = lGameSession.getScreenReaderSquareLabel(i);
        String strExpr = "Position $strLabel";
        return strExpr;
      }
      else {
        return lGameSession.getScreenReaderSquareValue(i);
      }
    }
    return "";
  }

  void showSnapBar(int i)
  {
    if (bScreenReaderIsUsed) {
      String strLabel = lGameSession.getScreenReaderSquareLabel(i);
      String strExpr = "Position $strLabel";
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

  Future<void> _screenReaderAnnounce(String msg) async
  {
    if (bScreenReaderIsUsed && msg.isNotEmpty)
    {
      await SemanticsService.announce(msg, TextDirection.ltr);
    }
  }

  BorderInnerSquarePosition? _getInnerSquareBorder()
  {
    BorderInnerSquarePosition? ret;
    INNERCORNERPOSITION? position;
    BorderStyle? topColor, bottomColor, leftColor, rightColor;
    /* const */ BorderStyle TRANSPARENT = BorderStyle.none;
     Border? border;
     for (int i = 0; i < _listMoveBorders.length; i++ ) {
       border = _listMoveBorders[i];
       if (border == null) {
         continue;
       }
       topColor = border.top.style;
       bottomColor = border.bottom.style;
       leftColor = border.left.style;
       rightColor = border.right.style;
       if ((topColor == TRANSPARENT
           || bottomColor == TRANSPARENT)
           && (leftColor == TRANSPARENT
           || rightColor == TRANSPARENT)) {

         if (topColor == TRANSPARENT
             && rightColor == TRANSPARENT) {
           position = INNERCORNERPOSITION.TOPRIGHTCORNER;
         } else
         if (topColor == TRANSPARENT
             && leftColor == TRANSPARENT) {
           position = INNERCORNERPOSITION.TOPLEFTCORNER;
         }
         else
         if (bottomColor == TRANSPARENT
             && leftColor == TRANSPARENT) {
           position = INNERCORNERPOSITION.BOTTOMLEFTCORNER;
         }
         else
         if (bottomColor == TRANSPARENT
             && rightColor == TRANSPARENT) {
           position = INNERCORNERPOSITION.BOTTOMRIGHTCORNER;
         }
         if (position != null) {
           ret = BorderInnerSquarePosition(position, i);
         }
       }
     }

     return ret;
  }

  Container
  getMovePieceShadowContainer(int index)
  {
      Decoration? decoration =
           getMovePieceShadowContainerShadowDecoration(index);
      Container? ret;
      Color containerColor = getBoardPieceColor(index);

      if (decoration != null) {
        ret = Container(
        //    duration: const Duration(seconds: 1),
        //  padding: const EdgeInsets.all(8),
       // color: Colors.transparent,
        width: ScreenValues.containerWidth,
        clipBehavior: Clip.none,
        height: ScreenValues.containerWidth,
        decoration: decoration,
            child: Opacity(
        opacity: 1.0,
          child: Container(child: null, color: Colors.transparent,),
        ),
          /*
            decoration: BoxDecoration(
            color: Colors.orange[200],
            border: Border.all(
            color: Colors.black,
            width: 1,
        ),
        ),
           */
      );
      } else {
        ret = Container(
          //    duration: const Duration(seconds: 1),
          //  padding: const EdgeInsets.all(8),
          color: Colors.transparent,
          width: ScreenValues.containerWidth,
          height: ScreenValues.containerWidth,
        );
      }
      return ret;
  }

  BoxShadow?
  getBoxShadowOf(BorderStyle borderStyle, SHADOWBOXPOSITION shadowPosition)
  {
    BoxShadow? ret;

    Offset? offset = Offset(0,0);
    Color color = Colors.grey.shade600;
    if (borderStyle == BorderStyle.none)
      {
        ret =  BoxShadow(
          // color: Colors.green,
            color: Colors.transparent, /* Colors.grey.shade300, */
            offset: offset,
            spreadRadius: 0,
            blurRadius: 0,
        );
        return ret;
      }

      if (shadowPosition == SHADOWBOXPOSITION.BOTTOMSHADOWBOX)
      {
        offset = Offset(0,-5);
      }
      else
      if (shadowPosition == SHADOWBOXPOSITION.TOPSHADOWBOX)
      {
        offset = Offset(0,5); // Offset(5,0);
      }
      else
      if (shadowPosition == SHADOWBOXPOSITION.LEFTSHADOWBOX)
      {
        offset = Offset(-5,0);
      }
      else
      if (shadowPosition == SHADOWBOXPOSITION.RIGHTSHADOWBOX)
      {
        offset = Offset(5,0);
      }

    if (borderStyle == BorderStyle.none)
    {
      color = Colors.transparent;
      offset = Offset(0,0);
      return null;
    }

    ret =  BoxShadow(
      // color: Colors.green,
      color: color, /* Colors.grey.shade300, */
      offset: offset,
        spreadRadius: 1,
        blurRadius: 5
    );

    return ret;
  }

  Decoration?
  getMovePieceShadowContainerShadowDecoration(int index)
  {
    Decoration? ret;
    INNERCORNERPOSITION? position;
    BorderStyle? topStyle, bottomStyle, leftStyle, rightStyle;
    /* const */ BorderStyle borderstyleNone = BorderStyle.none;
    Border? border = _listMoveBorders[index];
    if (border == null) {
      return null;
    }

    topStyle = border.top.style;
    bottomStyle = border.bottom.style;
    leftStyle = border.left.style;
    rightStyle = border.right.style;
    if (topStyle == borderstyleNone && bottomStyle == borderstyleNone
        && leftStyle == borderstyleNone && rightStyle == borderstyleNone) {
      return null;
    }

    List<BoxShadow> shadows =  List<BoxShadow>.empty(growable: true);
    BoxShadow? shadow = getBoxShadowOf(leftStyle, SHADOWBOXPOSITION.LEFTSHADOWBOX);
    if (shadow != null) {
      shadows.add(shadow);
    }

    /*
    if (rightStyle != BORDERSTYLE_NONE)
      {
        print("kissa");
      }
     */
    shadow = getBoxShadowOf(rightStyle, SHADOWBOXPOSITION.RIGHTSHADOWBOX);
    if (shadow != null) {
      shadows.add(shadow);
    }

    shadow = getBoxShadowOf(topStyle, SHADOWBOXPOSITION.TOPSHADOWBOX);
    if (shadow != null) {
      shadows.add(shadow);
    }
    /*
    shadow = getBoxShadowOf(bottomStyle, SHADOWBOXPOSITION.BOTTOMSHADOWBOX);
    if (shadow != null)
      shadows.add(shadow);
    */

    /*
        getBoxShadowOf(rightStyle, SHADOWBOXPOSITION.RIGHTSHADOWBOX),
        getBoxShadowOf(topStyle, SHADOWBOXPOSITION.TOPSHADOWBOX),
        getBoxShadowOf(bottomStyle,
            SHADOWBOXPOSITION.BOTTOMSHADOWBOX),
       */

    double dRadius = 0.0;
    ret = BoxDecoration(
      color: Colors.transparent,
      border: border,
      /*
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(dRadius /* 30.0 */),
              topRight: Radius.circular(dRadius /* 30.0 */),
              bottomLeft: Radius.circular(dRadius /* 30.0 */),
              bottomRight: Radius.circular(dRadius /* 30.0 */)),
          boxShadow: const [
            BoxShadow(
              blurRadius: 5,
              color: Colors.black,
              offset: Offset(0, 15), // changes position of shadow
            ),
            BoxShadow(
              // color: Colors.green,
              color: Colors.black,
              offset: Offset(-5, 5),
            ),
            BoxShadow(
              // color: Colors.green,
              color: Colors.black,
              offset: Offset(5, 5),
            ),
          ],
           */
         boxShadow: shadows,
    );

    /*
    for (int i = 0; i < _listMoveBorders.length; i++ ) {
        border = _listMoveBorders[i];
        if (border == null)
          continue;
        if (i != index)
          continue;

        topStyle = border.top.style;
        bottomStyle = border.bottom.style;
        leftStyle = border.left.style;
        rightStyle = border.right.style;
        if (topStyle != BORDERSTYLE_NONE && bottomStyle != BORDERSTYLE_NONE
            && leftStyle != BORDERSTYLE_NONE && rightStyle != BORDERSTYLE_NONE) {
          continue;
        }

        Border? lborder = _listMoveBorders[index];
        if (lborder == null) {
          return null;
        }

        double dRadius = 0.0;
        ret = BoxDecoration(
          color: Colors.greenAccent,
          border: lborder,
          /*
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(dRadius /* 30.0 */),
              topRight: Radius.circular(dRadius /* 30.0 */),
              bottomLeft: Radius.circular(dRadius /* 30.0 */),
              bottomRight: Radius.circular(dRadius /* 30.0 */)),
          boxShadow: const [
            BoxShadow(
              blurRadius: 5,
              color: Colors.black,
              offset: Offset(0, 15), // changes position of shadow
            ),
            BoxShadow(
              // color: Colors.green,
              color: Colors.black,
              offset: Offset(-5, 5),
            ),
            BoxShadow(
              // color: Colors.green,
              color: Colors.black,
              offset: Offset(5, 5),
            ),
          ],
           */
          boxShadow: [
            getBoxShadowOf(bottomStyle,
                SHADOWBOXPOSITION.BOTTOMSHADOWBOX),
            getBoxShadowOf(leftStyle, SHADOWBOXPOSITION.LEFTSHADOWBOX),
            getBoxShadowOf(rightStyle, SHADOWBOXPOSITION.RIGHTSHADOWBOX),
            getBoxShadowOf(bottomStyle, SHADOWBOXPOSITION.TOPSHADOWBOX),
          ],

        );
        break;
    }
    */

    /*
    ret ??= BoxDecoration(
          color: Colors.transparent,
        );
    */

      return ret;
  }

  Container getMovePieceShadowCenterContainer(index)
  {
    Container ret = Container(
      //    duration: const Duration(seconds: 1),
      //  padding: const EdgeInsets.all(8),
      color: Colors.transparent,
      width: ScreenValues.containerWidth,
      height: ScreenValues.containerWidth,
    );
    bool isInMoveList = lGameSession.iArrPlayerMovePieces == null ? false :
                    lGameSession.iArrPlayerMovePieces!.contains(index);
    if (!isInMoveList) {
      return ret;
    }
    ret = Container(
      //    duration: const Duration(seconds: 1),
      //  padding: const EdgeInsets.all(8),
      color: Colors.yellow[200],
      width: ScreenValues.containerWidth,
      height: ScreenValues.containerWidth,
    );
    return ret;
  }

  List<Widget>
  buildGameBoard()
  {
 //  if (_listBoardPieces.isEmpty || lGameSession.listBoardPiecesUpdated) {
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
        width: ScreenValues.containerWidth,
        height: ScreenValues.containerWidth,
        decoration: listBoxDecoration,
        child: getTextChild(index, true),
      );
    });
//   }

   // if (_listMoveBorders.isEmpty || lGameSession.listMovePiecesUpdated) {
      _listMoveBorders = List.generate(16,  (index) {
      return null;
    });
   // }

    // if (_listMoveSquares.isEmpty || lGameSession.listMovePiecesUpdated) {
      _listMoveSquares = List.generate(16,  (index) {
      return getMoveContainer(index);
    });
   // }

   /*
   // if (_listMovePieceShadowContainers.isEmpty || lGameSession.listMovePiecesUpdated) {
      _listMovePieceShadowContainers = List.generate(16, (index) {
        return getMovePieceShadowContainer(index);
      });
   // }
    */

     /*
//    if (_listMovePieceShadowCenterContainers.isEmpty
  //    || lGameSession.listMovePiecesUpdated) {
      _listMovePieceShadowCenterContainers = List.generate(16, (index) {
        return getMovePieceShadowCenterContainer(index);
      });
   // }
      */

    /*
    Container(
        decoration: BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.circular(20.0),
          boxShadow: const [
            BoxShadow(
              blurRadius: 5,
              color: Colors.black,
              offset: Offset(0, 15), // changes position of shadow
            ),
              BoxShadow(
                // color: Colors.green,
                color: Colors.black,
                offset: Offset(-5, 5),
              ),
              BoxShadow(
                // color: Colors.green,
                color: Colors.black,
                offset: Offset(5, 5),
              ),
          ],
        ),
      ),
     */
    innerSquarePosition = _getInnerSquareBorder();

   // if (_listMoveBorderSquares.isEmpty
     //   || lGameSession.listMovePiecesUpdated) {
      _listMoveBorderSquares = List.generate(16, (index) {
        return getBorderMoveContainer(index);
      });
   // }

   /* List<Widget> */ listBoardStack = List<Widget>.empty(growable: true);
    //_listBoardStack.clear();
    if (bScreenReaderIsUsed) {
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
          onTap: () => () {
        //    setState(() {
              //   logger.i(" onTap ->");
              bChangeScreenReaderTextIntoTop =
                 ! _iArrScreenReaderSquareText[i].contains("Position");
              /*
              ! _iArrScreenReaderSquareText[i].contains("Position");
               */
              _iArrScreenReaderSquareText[i] =
                  getChangeScreenReaderText(i, false);
              _screenReaderAnnounce(_iArrScreenReaderSquareText[i]);
              callInit = true;
              _notifier.value = true;
            //      });
          } /*)*/,
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
            width: ScreenValues.containerWidth,
            height: ScreenValues.containerWidth,
            //      decoration: listBoxDecoration,
            child: StackWidget(child:  Stack(clipBehavior: Clip.none,
           //  fit: StackFit.loose,
                children: [_listBoardSquares[i],
               //  _listMovePieceShadowContainers[i],
              //    _listMovePieceShadowCenterContainers[i],
                  _listBoardPieces[i],
                 _listMoveBorderSquares[i],
                  _listScreenReaderSquares[i]
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
         ),
        );
        }
    }
    else {
      for (int i = 0; i < _listBoardSquares.length; i++) {
        listBoardStack.add(StackWidget(child:
          Stack(clipBehavior: Clip.none,
             // fit: StackFit.loose,
              children: [_listBoardSquares[i],
      //      _listMovePieceShadowContainers[i],
      //      _listMovePieceShadowCenterContainers[i],
            _listBoardPieces[i],
            _listMoveSquares[i],
            _listMoveBorderSquares[i]
            ]), ),
        );
      }
   }

    /*
  _gameBoardGrid = GridView.count(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      //  childAspectRatio: 3/2,
      primary: false,
      mainAxisSpacing: 0,
      crossAxisSpacing: 0,
      padding: EdgeInsets.all(8.0),
      // mainAxisSpacing: 1.0,
      // crossAxisSpacing: 1.0,
      // Create a grid with 2 columns. If you change the scrollDirection to
      // horizontal, this produces 2 rows.
      crossAxisCount: 4,
      // padding: const EdgeInsets.all(20),
      children: listBoardStack,
    );
    return _gameBoardGrid!;
     */
    return listBoardStack;
  }

  late List<Widget> listBoardStack;

 @override
  Widget build(BuildContext context) {
    thisContext = context;
    lGameSession.setScreenReaderIsUsed(bScreenReaderIsUsed);
    if (callInit) {
      initState();
      listBoardStack = buildGameBoard();
    }

    return ValueListenableBuilder<bool>(
      valueListenable: _notifier,
      builder: (BuildContext context, bool value, child) {
        return /* buildGameBoard() */
      /*
      FlexibleGridViewPlus(
        shrinkWrap: true,
        axisCount: GridLayoutEnum.fourElementsInRow,
        crossAxisSpacing: 0,
        mainAxisSpacing: 0,
        padding: const EdgeInsets.all(8.0),
        children: listBoardStack,
      ) */ /*
      GridView.count(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      //  childAspectRatio: 3/2,
      primary: false,
      mainAxisSpacing: 0,
      crossAxisSpacing: 0,
      padding: const EdgeInsets.all(8.0),
      // mainAxisSpacing: 1.0,
      // crossAxisSpacing: 1.0,
      // Create a grid with 2 columns. If you change the scrollDirection to
      // horizontal, this produces 2 rows.
      crossAxisCount: 4,
      // padding: const EdgeInsets.all(20),
      children: buildGameBoard(),
    ) */
        /*  Center(child:
        */
          /*
         IntrinsicWidth(
            child: */
          Column(
           // mainAxisAlignment: MainAxisAlignment.center,
       // padding: EdgeInsets.all(8.0),
      children: [
           Row(
         //    mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
        /*  RepaintBoundary(child: */ listBoardStack[0], //),
        /*  RepaintBoundary(child: */listBoardStack[1], //),
        /*  RepaintBoundary(child: */listBoardStack[2], //),
        /*  RepaintBoundary(child: */listBoardStack[3], //),
           ],),
        Row(
         // mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            /*  RepaintBoundary(child: */listBoardStack[4], // ),
            /*  RepaintBoundary(child: */listBoardStack[5], //),
        /*  RepaintBoundary(child: */listBoardStack[6], // ),
            /*  RepaintBoundary(child: */listBoardStack[7], //),
        ],),
        Row(
         // mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            /*  RepaintBoundary(child: */listBoardStack[8], // ),
            /*  RepaintBoundary(child: */listBoardStack[9], //),
        /*  RepaintBoundary(child: */listBoardStack[10], // ),
            /*  RepaintBoundary(child: */listBoardStack[11], //),
        ],),
        Row(
        //  mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            /*  RepaintBoundary(child: */ listBoardStack[12], //),
          /*  RepaintBoundary(child: */ listBoardStack[13], //),
        /*  RepaintBoundary(child: */ listBoardStack[14], //),
        /*  RepaintBoundary(child: */ listBoardStack[15], // ),
        ],)
        ],
        // ),
          );
      },
    )
    ;
  }
}

class BoardSquare extends StatelessWidget {
 /* const */ const BoardSquare({super.key, required this.detector});
  final GestureDetector detector;

  @override
  Widget build(BuildContext context) {
    return detector;
  }
}
