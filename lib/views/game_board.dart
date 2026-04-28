

// import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
// import 'package:logger/logger.dart';
import 'package:flutter/semantics.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:multi_finger_gesture_detector/multi_finger_gesture_detector.dart';

import '../ParameterValues.dart';
import '../models/lgame_data.dart';
import '../LoggerDef.dart';
// import 'utils/uniquegestructurehandler.dart';

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

/*
class Disposer extends StatefulWidget {
  final void Function() dispose;
  const Disposer({super.key, required this.dispose});

  @override
  DisposerState createState() {
    return DisposerState();
  }
}

class DisposerState extends State<Disposer> {
  @override
  Widget build(BuildContext context) {
    return SizedBox.shrink();
  }

  @override
  void dispose() {
    widget.dispose();
    super.dispose();
  }
}
 */
class StackGridContainer extends StatelessWidget {
  final int containerIndex = 16; // To differentiate containers
  final List<Widget?> listContainers;
  const StackGridContainer({super.key, required this.listContainers});

  @override
  Widget build(BuildContext context) {
    ObjectKey objectKey = ObjectKey(DateTime.now());
    return /* RepaintBoundary(
      child: */ SizedBox(key: objectKey,
        width: ScreenValues.containerWidth * 4,
        height: ScreenValues.containerWidth * 4,
        child: /* Container(
          color: Colors.black,
          child: */ GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.all(0.5),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            childAspectRatio: 1.0,
          ),
          itemCount: containerIndex,
          itemBuilder: (context, index) {
            return listContainers[index] ?? SizedBox.shrink();
          },
     //   ),
     //   ),
      ),
    );
  }
}

class StackRepaintBoundary extends StatelessWidget {
  const StackRepaintBoundary({super.key, required this.child});
  final Stack child;

  @override
  Widget build(BuildContext context)
  {
   // print("StackRepaintBoundary painted at: ${DateTime.now()}");
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

/*
class StackColumnRows extends StatelessWidget {
  const StackColumnRows({super.key, required this.listBoardStack});
  final List<Widget?> listBoardStack;

  @override
  Widget build(BuildContext context) {
    return Column(
      // mainAxisAlignment: MainAxisAlignment.center,
      // padding: EdgeInsets.all(8.0),
      children: [
        Row(
          //    mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            listBoardStack[0]!,
            listBoardStack[1]!,
            listBoardStack[2]!,
            listBoardStack[3]!,
          ],),
        Row(
          // mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            listBoardStack[4]!,
            listBoardStack[5]!,
            listBoardStack[6]!,
            listBoardStack[7]!,
          ],),
        Row(
          // mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            listBoardStack[8]!,
            listBoardStack[9]!,
            listBoardStack[10]!,
            listBoardStack[11]!,
          ],),
        Row(
          //  mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            listBoardStack[12]!,
            listBoardStack[13]!,
            listBoardStack[14]!,
            listBoardStack[15]!,
          ],)
      ],
      // ),
    );
  }
}
*/

/*
class EarlierStackWidgets {
  static List<Widget> earlierListBoardStack =
      List<Widget>.empty(growable: true);
}
 */

class LGameBoard extends StatelessWidget {
  LGameBoard({super.key, required this.lGameSession,
    required this.bScreenReaderIsUsed,
    required this.minusDynamicContainerSize,
    required this.isUpdated,
    required this.gestureDetectedCallBack,
   // required this.notifier,
  });
  bool bScreenReaderIsUsed;
  LGameSession lGameSession;
  int minusDynamicContainerSize;
  bool isUpdated;
  void Function(ButtonPressed)? gestureDetectedCallBack;
 // final ValueNotifier<bool>? notifier;

  static int lastGestureOccurTime = 0;
  static int oneTab_lastGestureOccurTime = 0;
  int lastGestureOccurTime_intervalMs = 500;
 // Widget? _gameBoardGrid;
  late List<Container> _listBoardSquares;
  late final List<Widget> _listScreenReader = List<Widget>.empty(growable: true);
 // late StackGridContainer _stackGridContainerOfListBoardSquares;
  late List<Container?> _listBoardPieces = List.empty(growable: true);
 // late StackGridContainer _stackGridContainerOfListBoardPieces;

  // var _listBoardPieces = List<Container>.empty(growable: true);
//  List<Container> _listMovePieceShadowContainers = List<Container>.empty(growable: true);
//  List<Container> _listMovePieceShadowCenterContainers = List<Container>.empty(growable: true);
  late List<Container> _listMoveBorderSquares = List<Container>.empty(growable: true);
  late StackGridContainer? _stackMoveBorderSquares;
  late StackGridContainer? _stackMoveSquares;
  late StackGridContainer? _stackBoardSquares;
  late StackGridContainer? _stackScreenReader;
  late StackGridContainer? _stackBoardPieces;
  late List<Border?>  _listMoveBorders;
  BorderInnerSquarePosition? innerSquarePosition;
  late List<Container?> _listMoveSquares = List<Container?>.empty(growable: true);
  late List<String> _iArrScreenReaderSquareText;
  late List<Widget> _listScreenReaderSquares;
  final Color player1Color = Colors.redAccent;
  final Color player2Color = Colors.blueAccent;
  final Color neutralColor = Colors.black;
  final Color moveFrameColor = Colors.black54;
//  double containerWidth = 80;
//  double containerHeight = 80;
  BuildContext? thisContext;
  bool bChangeScreenReaderTextIntoTop = false;
  bool callInit = true;
  bool bDoNotCallInitState = false;
  late ButtonStyle buttonStyleScreenReader;
//  bool listBoardPiecesUpdated = false;
//  bool listMovePiecesUpdated = false;


 void updateParams(bool p_bScreenReaderIsUsed,
  LGameSession p_lGameSession, int p_minusDynamicContainerSize,
  bool p_isUpdated)
  {
    bScreenReaderIsUsed = p_bScreenReaderIsUsed;
    lGameSession = p_lGameSession;
    minusDynamicContainerSize = p_minusDynamicContainerSize;
    isUpdated = p_isUpdated;
    callInit = true;
    bDoNotCallInitState = true;
    // listBoardStack = buildGameBoard();
  }

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
      return _getBoardSquaresContainer(index);
    });

    ObjectKey objectKey = ObjectKey(DateTime.now());
    _stackBoardSquares = StackGridContainer(key: objectKey, listContainers: _listBoardSquares);

    // _stackGridContainerOfListBoardSquares = StackGridContainer(listContainers: _listBoardSquares);

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
      color: moveFrameColor,
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
    GameBoardPosition? neighbor;
    bool? neighBorIsLeftGp;
    if (leftGp.iRow == forthLPieceGp.iRow)
    {
      neighBorIsLeftGp = true;
      neighbor = leftGp;
    }
    else
    if (rightGp.iRow == forthLPieceGp.iRow)
    {
      neighbor = rightGp;
      neighBorIsLeftGp = false;
    }
    if (Loggerdef.isLoggerOn) {
      Loggerdef.logger.i("neighBorIsLeftGp $neighBorIsLeftGp");
    }

    if (leftGp.iPos == index)
    {
      ret = Border(
        top: BorderSide(
            width: 7,
            color: moveFrameColor,
            style: BorderStyle.solid),
        bottom: BorderSide.none /*BorderSide(
            width: 7,
            color: Colors.transparent,
            style: BorderStyle.solid) **/,
        left: BorderSide(
            width: 7,
            color: moveFrameColor,
            style: BorderStyle.solid),
        right: BorderSide(
            width: 7,
            color: moveFrameColor,
            style: BorderStyle.solid), //BorderSide
        /* color: boxDecorationColor,
          width: 7,*/
      );

      if (neighBorIsLeftGp != null && leftGp.iRow == forthLPieceGp.iRow
          && forthLPieceGp.iCol > leftGp.iCol)
      {
        ret = Border(
          top: BorderSide(
              width: 7,
              color: moveFrameColor,
              style: BorderStyle.solid),
          bottom: BorderSide.none /* BorderSide(
              width: 7,
              color: Colors.transparent,
              style: BorderStyle.solid) */ ,
          left: BorderSide(
              width: 7,
              color: moveFrameColor,
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
        ret = Border(
          top: BorderSide(
              width: 7,
              color: moveFrameColor,
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
              color: moveFrameColor,
              style: BorderStyle.solid), //BorderSide
          /* color: boxDecorationColor,
          width: 7,*/
        );
      }
    }
    else
    if (rightGp.iPos == index)
    {
      ret = Border(
        top: BorderSide.none /* BorderSide(
            width: 7,
            color: Colors.transparent,
            style: BorderStyle.solid) */,
        bottom: BorderSide(
            width: 7,
            color: moveFrameColor,
            style: BorderStyle.solid),
        left: BorderSide(
            width: 7,
            color: moveFrameColor,
            style: BorderStyle.solid),
        right: BorderSide(
            width: 7,
            color: moveFrameColor,
            style: BorderStyle.solid), //BorderSide
        /* color: boxDecorationColor,
          width: 7,*/
      );

      if (neighBorIsLeftGp != null && rightGp.iRow == forthLPieceGp.iRow
          && forthLPieceGp.iCol > rightGp.iCol)
      {
        ret = Border(
          top: BorderSide.none /*BorderSide(
              width: 7,
              color: Colors.transparent,
              style: BorderStyle.solid) */,
          bottom: BorderSide(
              width: 7,
              color: moveFrameColor,
              style: BorderStyle.solid),
          left: BorderSide(
              width: 7,
              color: moveFrameColor,
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
        ret = Border(
          top: BorderSide.none /* BorderSide(
              width: 7,
              color: Colors.transparent,
              style: BorderStyle.solid) */,
          bottom: BorderSide(
              width: 7,
              color: moveFrameColor,
              style: BorderStyle.solid),
          left: BorderSide.none /* BorderSide(
              width: 7,
              color: Colors.transparent,
              style: BorderStyle.solid) */,
          right: BorderSide(
              width: 7,
              color: moveFrameColor,
              style: BorderStyle.solid), //BorderSide
          /* color: boxDecorationColor,
          width: 7,*/
        );
      }

    }
    else
    if (betweenGp.iPos == index)
    {
      ret = Border(
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
            color: moveFrameColor,
            style: BorderStyle.solid),
        right: BorderSide(
            width: 7,
            color: moveFrameColor,
            style: BorderStyle.solid), //BorderSide
        /* color: boxDecorationColor,
          width: 7,*/
      );
    }
    else
    if(forthLPieceGp.iPos == index)
    {
      ret = Border(
        top: BorderSide(
            width: 7,
            color: moveFrameColor,
            style: BorderStyle.solid),
        bottom: BorderSide(
            width: 7,
            color: moveFrameColor,
            style: BorderStyle.solid),
        left: BorderSide(
            width: 7,
            color: moveFrameColor,
            style: BorderStyle.solid),
        right: BorderSide(
            width: 7,
            color: moveFrameColor,
            style: BorderStyle.solid), //BorderSide
        /* color: boxDecorationColor,
          width: 7,*/
      );

      if (neighBorIsLeftGp != null
          && (( /* neighBorIsLeftGp && */ forthLPieceGp.iRow == leftGp.iRow
              && forthLPieceGp.iCol > leftGp.iCol)
              || ( /*!neighBorIsLeftGp && */ forthLPieceGp.iRow == rightGp.iRow
                  && forthLPieceGp.iCol > rightGp.iCol)))
      {
        ret = Border(
          top: BorderSide(
              width: 7,
              color: moveFrameColor,
              style: BorderStyle.solid),
          bottom: BorderSide(
              width: 7,
              color: moveFrameColor,
              style: BorderStyle.solid),
          left: BorderSide.none /* BorderSide(
              width: 7,
              color: Colors.transparent,
              style: BorderStyle.solid) */,
          right: BorderSide(
              width: 7,
              color: moveFrameColor,
              style: BorderStyle.solid), //BorderSide
          /* color: boxDecorationColor,
          width: 7,*/
        );
      }

      if (neighBorIsLeftGp != null
          && ((/* neighBorIsLeftGp && */ forthLPieceGp.iRow == leftGp.iRow
              && forthLPieceGp.iCol < leftGp.iCol)
              || (/* !neighBorIsLeftGp && */ forthLPieceGp.iRow == rightGp.iRow
                  && forthLPieceGp.iCol < rightGp.iCol)))
      {
        ret = Border(
          top: BorderSide(
              width: 7,
              color: moveFrameColor,
              style: BorderStyle.solid),
          bottom: BorderSide(
              width: 7,
              color: moveFrameColor,
              style: BorderStyle.solid),
          left: BorderSide(
              width: 7,
              color: moveFrameColor,
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
          ret = _getMoveDecorationBorderWithBorderSidesForRow(
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
  _getMoveDecorationBorderWithBorderSidesForRow(int index,
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
      color: moveFrameColor,
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
    GameBoardPosition? neighbor;
    bool? neighBorIsLeftGp;
    if (leftGp.iCol == forthLPieceGp.iCol)
    {
      neighBorIsLeftGp = true;
      neighbor = leftGp;
    }
    else
    if (rightGp.iCol == forthLPieceGp.iCol)
    {
      neighbor = rightGp;
      neighBorIsLeftGp = false;
    }
    if (Loggerdef.isLoggerOn) {
      Loggerdef.logger.i("neighBorIsLeftGp $neighBorIsLeftGp");
    }

    if (leftGp.iPos == index)
    {
      ret = Border(
        top: BorderSide(
            width: 7,
            color: moveFrameColor,
            style: BorderStyle.solid),
        bottom: BorderSide(
            width: 7,
            color: moveFrameColor,
            style: BorderStyle.solid),
        left: BorderSide(
            width: 7,
            color: moveFrameColor,
            style: BorderStyle.solid),
        right: BorderSide.none /* BorderSide(
            width: 7,
            color: Colors.transparent,
            style: BorderStyle.solid) */, //BorderSide
        /* color: boxDecorationColor,
          width: 7,*/
      );

      if (neighBorIsLeftGp != null && leftGp.iCol == forthLPieceGp.iCol
          && forthLPieceGp.iRow > leftGp.iRow)
      {
        ret = Border(
          top: BorderSide(
              width: 7,
              color: moveFrameColor,
              style: BorderStyle.solid),
          bottom: BorderSide.none  /* BorderSide(
              width: 7,
              color: Colors.transparent,
              style: BorderStyle.solid) */,
          left: BorderSide(
              width: 7,
              color: moveFrameColor,
              style: BorderStyle.solid),
          right: BorderSide.none /* BorderSide(
              width: 7,
              color: Colors.transparent,
              style: BorderStyle.solid) */, //BorderSide
          /* color: boxDecorationColor,
          width: 7,*/
        );
      }

      if (neighBorIsLeftGp != null && leftGp.iCol == forthLPieceGp.iCol
          && forthLPieceGp.iRow < leftGp.iRow)
      {
        ret = Border(
          top: BorderSide.none /* BorderSide(
              width: 7,
              color: Colors.transparent,
              style: BorderStyle.solid) */,
          bottom: BorderSide(
              width: 7,
              color: moveFrameColor,
              style: BorderStyle.solid),
          left: BorderSide(
              width: 7,
              color: moveFrameColor,
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
      ret = Border(
        top: BorderSide(
            width: 7,
            color: moveFrameColor,
            style: BorderStyle.solid),
        bottom: BorderSide(
            width: 7,
            color: moveFrameColor,
            style: BorderStyle.solid),
        left: BorderSide.none /* BorderSide(
            width: 7,
            color: Colors.transparent,
            style: BorderStyle.solid) */,
        right: BorderSide(
            width: 7,
            color: moveFrameColor,
            style: BorderStyle.solid), //BorderSide
        /* color: boxDecorationColor,
          width: 7,*/
      );

      if (neighBorIsLeftGp != null && !neighBorIsLeftGp
          && forthLPieceGp.iRow > rightGp.iRow)
      {
        ret = Border(
          top: BorderSide(
              width: 7,
              color: moveFrameColor,
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
              color: moveFrameColor,
              style: BorderStyle.solid), //BorderSide
          /* color: boxDecorationColor,
          width: 7,*/
        );
      }

      if (neighBorIsLeftGp != null && !neighBorIsLeftGp
          && forthLPieceGp.iRow < rightGp.iRow)
      {
        ret = Border(
          top: BorderSide.none /* BorderSide(
              width: 7,
              color: Colors.transparent,
              style: BorderStyle.solid) */,
          bottom: BorderSide(
              width: 7,
              color: moveFrameColor,
              style: BorderStyle.solid),
          left: BorderSide.none /* BorderSide(
              width: 7,
              color: Colors.transparent,
              style: BorderStyle.solid) */,
          right: BorderSide(
              width: 7,
              color: moveFrameColor,
              style: BorderStyle.solid), //BorderSide
          /* color: boxDecorationColor,
          width: 7,*/
        );
      }

    }
    else
    if (betweenGp.iPos == index)
    {
      ret = Border(
        top: BorderSide(
            width: 7,
            color: moveFrameColor,
            style: BorderStyle.solid),
        bottom: BorderSide(
            width: 7,
            color: moveFrameColor,
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
      ret = Border(
        top: BorderSide(
            width: 7,
            color: moveFrameColor,
            style: BorderStyle.solid),
        bottom: BorderSide(
            width: 7,
            color: moveFrameColor,
            style: BorderStyle.solid),
        left: BorderSide(
            width: 7,
            color: moveFrameColor,
            style: BorderStyle.solid),
        right: BorderSide(
            width: 7,
            color: moveFrameColor,
            style: BorderStyle.solid), //BorderSide
        /* color: boxDecorationColor,
          width: 7,*/
      );

      if (neighBorIsLeftGp != null
          && ((neighBorIsLeftGp && forthLPieceGp.iCol == leftGp.iCol
              && forthLPieceGp.iRow > leftGp.iRow)
              || (!neighBorIsLeftGp && forthLPieceGp.iCol == rightGp.iCol
                  && forthLPieceGp.iRow > rightGp.iRow)))
      {
        ret = Border(
          top: BorderSide.none /* BorderSide(
              width: 7,
              color: Colors.transparent,
              style: BorderStyle.solid) */,
          bottom: BorderSide(
              width: 7,
              color: moveFrameColor,
              style: BorderStyle.solid),
          left: BorderSide(
              width: 7,
              color: moveFrameColor,
              style: BorderStyle.solid),
          right: BorderSide(
              width: 7,
              color: moveFrameColor,
              style: BorderStyle.solid), //BorderSide
          /* color: boxDecorationColor,
          width: 7,*/
        );
      }

      if (neighBorIsLeftGp != null
          && ((neighBorIsLeftGp && forthLPieceGp.iCol == leftGp.iCol
              && forthLPieceGp.iRow < leftGp.iRow)
              || (!neighBorIsLeftGp && forthLPieceGp.iCol == rightGp.iCol
                  && forthLPieceGp.iRow < rightGp.iRow)))
      {
        ret = Border(
          top: BorderSide(
              width: 7,
              color: moveFrameColor,
              style: BorderStyle.solid),
          bottom: BorderSide.none /* BorderSide(
              width: 7,
              color: Colors.transparent,
              style: BorderStyle.solid) */,
          left: BorderSide(
              width: 7,
              color: moveFrameColor,
              style: BorderStyle.solid),
          right: BorderSide(
              width: 7,
              color: moveFrameColor,
              style: BorderStyle.solid), //BorderSide
          /* color: boxDecorationColor,
          width: 7,*/
        );
      }

    }

    return ret;
  }

  Color _getMovePieceColor(int index)
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

  Widget? _getMoveChild(int index)
  {
    Color modeColor = _getMovePieceColor(index);
    if (modeColor == Colors.transparent) {
      return null;
    }

   // Widget? textWidget = _getTextChild(index, false);

    Color textColor = moveFrameColor;
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

  bool _isInnerCornerOfContainer(int index)
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

  Alignment? _getCornerContainerAlignment(int index)
  {
     var ret;
     /*
     if (isInnerCornerOfContainer(index)) {
         ret = _getMoveDecorationBorder(index, boxDecorationColor, true);
     };

      */
     return ret;
  }

  Container _getBorderMoveContainer(int index)
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
              color: moveFrameColor /* boxDecorationColor */,
            ),
          );
        }
      }
   // }

    String objID = "borderMoveContainer$index";
    Container ret = Container(key: ObjectKey(objID),
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

  Container? _getMoveContainer(int index) {
    return _getPrivateMoveContainer(index, false);
  }

  Container? _getPrivateMoveContainer(int index,
      bool isCalledFromBorderMoveContainer)
  {
    double dRadius = 0.0;
    Widget? modeContainerChild = _getMoveChild(index);
    if (modeContainerChild == null) {
      return null;
    }
    Color boxDecorationColor = _getBoxDecorationColor();
    Color modeColor = _getMovePieceColor(index);
    late Container? container;

    BoxDecoration boxDecoration =
    BoxDecoration(
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
      container = null;
      /*
      container = Container(
        //  padding: const EdgeInsets.all(8),
        color: modeColor,
        width: ScreenValues.containerWidth,
        height: ScreenValues.containerWidth,
        child: modeContainerChild,
      );
       */
    } else {
        if (!_indexInTheMiddleOfLPiece(index, lGameSession.iArrPlayerMovePieces)) {
          modeContainerChild = null;
        }

      String objID = "moveContainer$index";
      container = Container(key: ObjectKey(objID),
        //   padding: const EdgeInsets.all(8),
        decoration: boxDecoration,
        width: ScreenValues.containerWidth,
        height: ScreenValues.containerWidth,
        child: modeContainerChild,
      );
    }
    return container;
  }

  Container _getBoardSquaresContainer(int index)
  {
    String objID = "boardcontainer$index";
    return Container(key: ObjectKey(objID),
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

  Color _getBoxDecorationColor()
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


  Color _getBoardPieceColor(int index)
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


  Widget? _getTextChild(int index, bool isBoardPiece) {
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

    ObjectKey objectKey = ObjectKey(DateTime.now());
    return Center(key: objectKey, child: AutoSizeText(strText,
      // This is some text that will resize based on the screen size.,
      style: TextStyle(fontSize: ScreenUtil().setSp(30), color: fontColor,
          fontWeight: FontWeight.bold),
      overflow: TextOverflow.ellipsis,));
  }

  Widget  _getScreenReaderSquare(index)
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

  String _getChangeScreenReaderText(int i, bool bInit)
  {
    if (bInit || bScreenReaderIsUsed) {
      String strLabel = "";
      if (bInit) {
        strLabel = lGameSession.getScreenReaderSquareLabel(i);
        String strExpr = "Position  $strLabel ";
        String strExpr2 = lGameSession.getScreenReaderSquareValue(i);
        return "$strExpr\n$strExpr2";
      }
      else {
        return lGameSession.getScreenReaderSquareValue(i);
      }
    }
    return "";
  }

  void _showSnapBar(int i)
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
      // await SemanticsService.announce(msg, TextDirection.ltr);
      await SemanticsService.sendAnnouncement( View.of(thisContext!),
          msg, TextDirection.ltr);
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
  _getMovePieceShadowContainer(int index)
  {
      Decoration? decoration =
           _getMovePieceShadowContainerShadowDecoration(index);
      Container? ret;
      Color containerColor = _getBoardPieceColor(index);

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
  _getBoxShadowOf(BorderStyle borderStyle, SHADOWBOXPOSITION shadowPosition)
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
  _getMovePieceShadowContainerShadowDecoration(int index)
  {
    Decoration? ret;
    INNERCORNERPOSITION? position;
    BorderStyle? topStyle, bottomStyle, leftStyle, rightStyle;
    /* const */ BorderStyle borderStyleNone = BorderStyle.none;
    Border? border = _listMoveBorders[index];
    if (border == null) {
      return null;
    }

    topStyle = border.top.style;
    bottomStyle = border.bottom.style;
    leftStyle = border.left.style;
    rightStyle = border.right.style;
    if (topStyle == borderStyleNone && bottomStyle == borderStyleNone
        && leftStyle == borderStyleNone && rightStyle == borderStyleNone) {
      return null;
    }

    List<BoxShadow> shadows =  List<BoxShadow>.empty(growable: true);
    BoxShadow? shadow = _getBoxShadowOf(leftStyle, SHADOWBOXPOSITION.LEFTSHADOWBOX);
    if (shadow != null) {
      shadows.add(shadow);
    }

    /*
    if (rightStyle != BORDERSTYLE_NONE)
      {
        print("kissa");
      }
     */
    shadow = _getBoxShadowOf(rightStyle, SHADOWBOXPOSITION.RIGHTSHADOWBOX);
    if (shadow != null) {
      shadows.add(shadow);
    }

    shadow = _getBoxShadowOf(topStyle, SHADOWBOXPOSITION.TOPSHADOWBOX);
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

  Container _getMovePieceShadowCenterContainer(index)
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

  bool _indexInTheMiddleOfLPiece(int index, List<int>? iArrPlayerPieces)
  {
     if (iArrPlayerPieces == null) {
       return false;
     }
     if (iArrPlayerPieces.isEmpty) {
       return false;
     }
     bool ret = false;
     List<GameBoardPosition>? listGameBoardPosition = lGameSession.getGameBoardPositionList(iArrPlayerPieces);
     if (listGameBoardPosition == null || listGameBoardPosition.isEmpty || listGameBoardPosition.length < 4) {
       return false;
     }
     if (listGameBoardPosition[0].iRow == listGameBoardPosition[1].iRow
         && listGameBoardPosition[1].iRow == listGameBoardPosition[2].iRow
         && listGameBoardPosition[1].iPos == index) {
         ret = true;
       }
     else
     if (listGameBoardPosition[0].iCol == listGameBoardPosition[1].iCol
         && listGameBoardPosition[1].iCol == listGameBoardPosition[2].iCol
         && listGameBoardPosition[1].iPos == index) {
       ret = true;
     }
     else
     if (listGameBoardPosition[1].iRow == listGameBoardPosition[2].iRow
         && listGameBoardPosition[2].iRow == listGameBoardPosition[3].iRow
         && listGameBoardPosition[2].iPos == index) {
       ret = true;
     }
     else
     if (listGameBoardPosition[1].iCol == listGameBoardPosition[2].iCol
         && listGameBoardPosition[2].iCol == listGameBoardPosition[3].iCol
         && listGameBoardPosition[2].iPos == index) {
       ret = true;
     }

     return ret;
  }

  bool getUseOfEarlierStackWidgets(int index) {
   return false;
  // return lGameSession.getUseEarlierStackWidget(index);
  }

  /*
  Widget? getEarlierListBoardStack(int index)
  {
     if (index < 0 || index > 15)
       return null;
     if (EarlierStackWidgets.earlierListBoardStack.isEmpty) {
       return null;
     }
     return EarlierStackWidgets.earlierListBoardStack[index];
  }
   */

  List<Widget>
  _buildGameBoard()
  {
 //  if (_listBoardPieces.isEmpty || lGameSession.listBoardPiecesUpdated) {
    if (_listBoardPieces.isEmpty
        || lGameSession.getButtonPressed() == ButtonPressed.moveDone) {
      _listBoardPieces = List.generate(16, (index) {
        Widget? child = _getTextChild(index, true);
        if (child == null) {
          return null;
        }

        BoxDecoration? listBoxDecoration;
        Color containerColor = _getBoardPieceColor(index);
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

        bool isIn1List = lGameSession.iArrPlayer1Pieces == null ? false :
        lGameSession.iArrPlayer1Pieces!.contains(index);
        bool isIn2List = lGameSession.iArrPlayer2Pieces == null ? false :
        lGameSession.iArrPlayer2Pieces!.contains(index);
        if (isIn1List)
        {
          if (!_indexInTheMiddleOfLPiece(index, lGameSession.iArrPlayer1Pieces)) {
            child = null;
          }
        }
        else
        if (isIn2List)
        {
          if (!_indexInTheMiddleOfLPiece(index, lGameSession.iArrPlayer2Pieces)) {
            child = null;
          }
        }
        else
        {
          child = null;
        }

        String objID = index.toString();
        return Container(key: ObjectKey(objID),
          //    duration: const Duration(seconds: 1),
          //  padding: const EdgeInsets.all(8),
          color: cColor,
          width: ScreenValues.containerWidth,
          height: ScreenValues.containerWidth,
          decoration: listBoxDecoration,
          child: child,
        );
      });

      ObjectKey objectKey = ObjectKey(DateTime.now());
      _stackBoardPieces = StackGridContainer(key: objectKey, listContainers: _listBoardPieces);
    }
//   }

   // _stackGridContainerOfListBoardPieces = StackGridContainer(listContainers: _listBoardPieces);

   if (_listMoveBorders.isEmpty || lGameSession.listMovePiecesUpdated) {
      _listMoveBorders = List.generate(16,  (index) {
      return null;
    });
   }

      Container? currContainer;
    if (_listMoveSquares.isEmpty || lGameSession.listMovePiecesUpdated) {
      _listMoveSquares = List.generate(16,  (index) {
        currContainer = _getMoveContainer(index);
        return currContainer;
      });
      ObjectKey objectKey = ObjectKey(DateTime.now());
      _stackMoveSquares = StackGridContainer(key: objectKey,
          listContainers: _listMoveSquares);
    }

    innerSquarePosition = _getInnerSquareBorder();

    if (_listMoveBorderSquares.isEmpty
        || lGameSession.listMovePiecesUpdated) {
      _listMoveBorderSquares = List.generate(16, (index) {
        return _getBorderMoveContainer(index);
      });
      ObjectKey objectKey = ObjectKey(DateTime.now());
      _stackMoveBorderSquares = StackGridContainer(key: objectKey,
          listContainers: _listMoveBorderSquares);
    }

   // _stackGridContainerOfListMoveBorderSquares = StackGridContainer(listContainers: _listMoveBorderSquares);

   // listBoardStack = List<Widget>.empty(growable: true);
    listBoardStack.clear();
    bool newertrue = false;
    if (newertrue) {
      if (_iArrScreenReaderSquareText.isEmpty) {
          _iArrScreenReaderSquareText = List.generate(16,  (index) {
          return _getChangeScreenReaderText(index, true);
        });
     }
      else
        {
          _iArrScreenReaderSquareText = List.generate(16,  (index) {
            return _getChangeScreenReaderText(index, false);
          });
        }

      _listScreenReaderSquares = List.generate(16,  (index) {
        return _getScreenReaderSquare(index);
      });

      String objID;
      _listScreenReader.clear();
      _listScreenReader.addAll(_listScreenReaderSquares);


      /*
      for (int i = 0; i < _listBoardSquares.length; i++) {
        objID = DateTime.now().toString();
        /*
        if (EarlierStackWidgets.earlierListBoardStack.isNotEmpty
            && getUseOfEarlierStackWidgets(i))
          listBoardStack.add(EarlierStackWidgets.earlierListBoardStack![i]);
        else
         */
        listBoardStack.add(
          BoardSquare(
            key: ObjectKey(objID),
            detector: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {
                bChangeScreenReaderTextIntoTop =
                    !_iArrScreenReaderSquareText[i].contains("Position");
                _iArrScreenReaderSquareText[i] =
                    _getChangeScreenReaderText(i, false);
                _screenReaderAnnounce(_iArrScreenReaderSquareText[i]);
                callInit = true;
              },
              child: AbsorbPointer(
                child: Container(
                  color: Colors.transparent,
                  width: ScreenValues.containerWidth,
                  height: ScreenValues.containerWidth,
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Positioned(
                        left: 0,
                        top: 0,
                        child: _listBoardSquares[i],
                      ),
                      if (_listBoardPieces[i] != null)
                        Positioned(
                          left: 0,
                          top: 0,
                          child: _listBoardPieces[i]!,
                        ),
                      if (_listMoveSquares[i] != null)
                        Positioned(
                          left: 0,
                          top: 0,
                          child: _listMoveSquares[i]!,
                        ),
                      if (_listMoveSquares[i] != null)
                        Positioned(
                          left: 0,
                          top: 0,
                          child: _listMoveBorderSquares[i],
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
        }
      */

      ObjectKey objectKey = ObjectKey(DateTime.now());
      _stackScreenReader = StackGridContainer(key: objectKey, listContainers: _listScreenReaderSquares);

      listBoardStack.add(_stackBoardSquares!);
      listBoardStack.add(_stackBoardPieces!);
      listBoardStack.add(_stackMoveSquares!);
      listBoardStack.add(_stackMoveBorderSquares!);
     // listBoardStack.add(_stackScreenReader!);

    }
    else {

      Container currMoveBorderSquares;
      Container? currMoveSquares, currBoardPieces;

    var objID;

      listBoardStack.add(_stackBoardSquares!);
      listBoardStack.add(_stackBoardPieces!);
      listBoardStack.add(_stackMoveSquares!);
      listBoardStack.add(_stackMoveBorderSquares!);

      if (bScreenReaderIsUsed) {
        _iArrScreenReaderSquareText = List.generate(16, (index) {
          return _getChangeScreenReaderText(index, true);
        });
        _listScreenReaderSquares = List.generate(16,  (index) {
          return _getScreenReaderSquare(index);
        });
        ObjectKey objectKey = ObjectKey(DateTime.now());
        _stackScreenReader = StackGridContainer(key: objectKey, listContainers: _listScreenReaderSquares);
        listBoardStack.add(_stackScreenReader!);
      }

    /*
    for (int i = 0; i < _listBoardSquares.length; i++) {
        currBoardPieces = _listBoardPieces[i];
        currMoveSquares = _listMoveSquares[i];
        currMoveBorderSquares = _listMoveBorderSquares[i];

        objID = i.toString();
        /*
        if (EarlierStackWidgets.earlierListBoardStack.isNotEmpty &&
            getUseOfEarlierStackWidgets(i)) {
          listBoardStack.add(
              EarlierStackWidgets.earlierListBoardStack[i]);
        } else {
         */
          listBoardStack.add(
          Stack(
            key: ObjectKey(objID),
            clipBehavior: Clip.none,
            children: [
              _listBoardSquares[i],
              if (currBoardPieces != null) currBoardPieces,
              if (currMoveSquares != null) currMoveSquares,
              if (currMoveSquares != null) currMoveBorderSquares,
            ],
          ),
        );
        }
    */
    //  }
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
   // EarlierStackWidgets.earlierListBoardStack.clear();
  //  EarlierStackWidgets.earlierListBoardStack.addAll(listBoardStack);
    return listBoardStack;
  }

  late List<Widget> listBoardStack = List<Widget>.empty(growable: true);
  int iTabCounter = 0;

 @override
  Widget build(BuildContext context) {
    thisContext = context;
    lGameSession.setScreenReaderIsUsed(bScreenReaderIsUsed);
    if (callInit) {
      if (!bDoNotCallInitState) {
        initState();
      }
      listBoardStack = _buildGameBoard();
    }

    bDoNotCallInitState = false;

    Widget? ret = null;
     /* ValueListenableBuilder<bool>(
      valueListenable: ScreenValues.notifier!,
      builder: (BuildContext context, bool value, child) {
        return */ /* buildGameBoard() */
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
      /*
      MultiFingerGestureDetector(
        onGestureUpdate: (gestureType, offset) {
          debugPrint('On Gesture Update');
          debugPrint(gestureType.name);
          debugPrint('offset: x=${offset.dx} y=${offset.dy}');
          debugPrint('-------------------------');
          if (gestureType.isTwoFingerDrag)
          {
            final now = DateTime.now().millisecondsSinceEpoch;
            if ((now - lastGestureOccurTime) < lastGestureOccurTime_intervalMs) {
              return;
            }
            lastGestureOccurTime = now;
            gestureDetectedCallBack!(ButtonPressed.swiftIntoNextNeutral);
          }
          else
          if (gestureType.isThreeFingerDrag)
          {
            final now = DateTime.now().millisecondsSinceEpoch;
            if ((now - lastGestureOccurTime) < lastGestureOccurTime_intervalMs) {
              return;
            }
            lastGestureOccurTime = now;
            gestureDetectedCallBack!(ButtonPressed.moveDone);
          }
        },
        onGestureStart: (GestureType gestureType, Offset offset)
        {

        },
        onGestureEnd: (GestureType gestureType, Offset offset) {

        },
        child: */ /* GestureDetector(
         behavior: HitTestBehavior.translucent,
         */
      /*
      RawGestureDetector(
          gestures: {
            SerialTapGestureRecognizer: GestureRecognizerFactoryWithHandlers<SerialTapGestureRecognizer>(
                  () => SerialTapGestureRecognizer(),
                  (SerialTapGestureRecognizer instance) {
                instance.onSerialTapDown = (SerialTapDownDetails details) {
                  if (details.count == 4) {
                    if (Loggerdef.isLoggerOn) {
                      Loggerdef.logger.i('neljä napsautusta havaittu!');
                    }
                    if (gestureDetectedCallBack != null) {
                      gestureDetectedCallBack!(ButtonPressed.swiftIntoNextNeutral);
                    }
                  }
                  else
                  // Tarkistetaan napautusten määrä
                  if (details.count == 3) {
                    if (Loggerdef.isLoggerOn) {
                      Loggerdef.logger.i('Kolmoisnapsautus havaittu!');
                    }
                    if (gestureDetectedCallBack != null) {
                      gestureDetectedCallBack!(ButtonPressed.moveDone);
                    }
                  }
                  else
                  if (details.count == 2) {
                    if (Loggerdef.isLoggerOn) {
                      Loggerdef.logger.i('Kaksoisnapsautus havaittu!');
                    }
                    if (gestureDetectedCallBack != null) {
                      final now = DateTime
                          .now()
                          .millisecondsSinceEpoch;
                      if ((now - lastGestureOccurTime) <
                          lastGestureOccurTime_intervalMs) {
                        return;
                      }
                      lastGestureOccurTime = now;
                      gestureDetectedCallBack!(ButtonPressed.wrap);
                    }
                  }
                  else
                  if (details.count == 1) {
                    if (Loggerdef.isLoggerOn) {
                      Loggerdef.logger.i('napsautus 1 havaittu!');
                    }
                  }
                };
              },
            ),
          },
          child: */
          if (!bScreenReaderIsUsed) {
            ret =
             GestureDetector(
            behavior: HitTestBehavior.translucent,
        onDoubleTap: (){
          if (gestureDetectedCallBack != null) {
            final now = DateTime.now().millisecondsSinceEpoch;
            if ((now - lastGestureOccurTime) < lastGestureOccurTime_intervalMs) {
              return;
            }
            lastGestureOccurTime = now;
            gestureDetectedCallBack!(ButtonPressed.wrap);
          }
        },
        onLongPress:  (){
          if (gestureDetectedCallBack != null) {
            final now = DateTime.now().millisecondsSinceEpoch;
            if ((now - lastGestureOccurTime) < lastGestureOccurTime_intervalMs) {
              return;
            }
            lastGestureOccurTime = now;
            gestureDetectedCallBack!(ButtonPressed.turn90Degree);
          }
        },
        onLongPressMoveUpdate: (details){
          final now = DateTime.now().millisecondsSinceEpoch;
          if ((now - lastGestureOccurTime) < lastGestureOccurTime_intervalMs) {
            return;
          }
          lastGestureOccurTime = now;
          gestureDetectedCallBack!(ButtonPressed.moveDone);
        },
        onPanUpdate: (details) {
       // onVerticalDragUpdate: (DragUpdateDetails details) {
          // Delta dx < 0 means moving towards the left
          if (details.delta.dx < 0) {
            // print("Dragging Left");
            if (gestureDetectedCallBack != null) {
              final now = DateTime
                  .now()
                  .millisecondsSinceEpoch;
              if ((now - lastGestureOccurTime) <
                  lastGestureOccurTime_intervalMs) {
                return;
              }
              lastGestureOccurTime = now;
              gestureDetectedCallBack!(ButtonPressed.left);
            }
          } else if (details.delta.dx > 0) {
            // print("Dragging Right");
            if (gestureDetectedCallBack != null) {
              final now = DateTime
                  .now()
                  .millisecondsSinceEpoch;
              if ((now - lastGestureOccurTime) <
                  lastGestureOccurTime_intervalMs) {
                return;
              }
              lastGestureOccurTime = now;
              gestureDetectedCallBack!(ButtonPressed.right);
            }
          }
      //  },
       else
//       onHorizontalDragUpdate: (DragUpdateDetails details) {
          if (details.delta.dy < 0) {
          //  print("Dragging up");
            if (gestureDetectedCallBack != null) {
              final now = DateTime.now().millisecondsSinceEpoch;
              if ((now - lastGestureOccurTime) < lastGestureOccurTime_intervalMs) {
                return;
              }
              lastGestureOccurTime = now;
              gestureDetectedCallBack!(ButtonPressed.up);
            }
          } else if (details.delta.dy > 0) {
         //   print("Dragging down");
            if (gestureDetectedCallBack != null) {
              final now = DateTime.now().millisecondsSinceEpoch;
              if ((now - lastGestureOccurTime) < lastGestureOccurTime_intervalMs) {
                return;
              }
              lastGestureOccurTime = now;
              gestureDetectedCallBack!(ButtonPressed.down);
            }
          }
        },
          child: /* TransparentPointer(
            child: */ RepaintBoundary(
            child: Stack(children: listBoardStack,)) /* StackGridContainer(listContainers: listBoardStack,
          ) */,
     //   ),
       // ),
      );
          }
          else
          {
            ret = RepaintBoundary(
                child: Stack(children: listBoardStack,));
          }

      /*
          Column(
           // mainAxisAlignment: MainAxisAlignment.center,
       // padding: EdgeInsets.all(8.0),
      children: [
           Row(
         //    mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
        listBoardStack[0],
        listBoardStack[1],
        listBoardStack[2],
        listBoardStack[3],
           ],),
        Row(
         // mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            listBoardStack[4],
            listBoardStack[5],
            listBoardStack[6],
            listBoardStack[7],
        ],),
        Row(
         // mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            listBoardStack[8],
            listBoardStack[9],
            listBoardStack[10],
            listBoardStack[11],
        ],),
        Row(
        //  mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            listBoardStack[12],
            listBoardStack[13],
            listBoardStack[14],
            listBoardStack[15],
        ],)
        ],
        // ),
          );
       */
   //   },
    return ret!;
  }

  /*
  List<Widget> getEarlierListBoardStack()
  {
      return listBoardStack;
  }
   */
}

class BoardSquare extends StatelessWidget {
 /* const */ const BoardSquare({super.key, required this.detector});
  final GestureDetector detector;

  @override
  Widget build(BuildContext context) {
    return detector;
  }
}
