// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../ParameterValues.dart';
import '../models/lgame_data.dart';

enum INNERCORNERPOSITION {
  TOPRIGHTCORNER, TOPLEFTCORNER, BOTTOMLEFTCORNER, BOTTOMRIGHTCORNER
}

enum SHADOWBOXPOSITION {
  TOPSHADOWBOX, LEFTSHADOWBOX, BOTTOMSHADOWBOX, RIGHTSHADOWBOX
}

/*
class StackGridContainer extends StatelessWidget {
  final int containerIndex = 16; // To differentiate containers
  final List<Widget?> listContainers;
  const StackGridContainer({super.key, required this.listContainers});

  @override
  Widget build(BuildContext context) {
    return /* RepaintBoundary(child: */ SizedBox(
        width: ScreenValues.containerWidth * 4,
        height: ScreenValues.containerWidth * 4,
        child: GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.all(0.5),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            childAspectRatio: 1.0,
          ),
          itemCount: containerIndex,
          itemBuilder: (context, index) {
            return listContainers[index] ?? const SizedBox.shrink();
          },
      ),
    // ),
    );
  }
}
 */

class StackGridContainer extends StatelessWidget {
  final int containerIndex = 16; // To differentiate containers
  final List<Widget?> listContainers;
  const StackGridContainer({super.key, required this.listContainers});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: ScreenValues.containerWidth * 4,
      height: ScreenValues.containerWidth * 4,
      child: Stack(
        children: [
          for (int i = 0; i < listContainers.length; i++)
            if (listContainers[i] != null)
              Positioned(
                left: (i % 4) * ScreenValues.containerWidth,
                top: (i ~/ 4) * ScreenValues.containerWidth,
                width: ScreenValues.containerWidth,
                height: ScreenValues.containerWidth,
                child: listContainers[i]!,
              ),
        ],
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
    return RepaintBoundary(child: child);
  }
}

class ChildRepaintBoundary extends StatelessWidget {
  const ChildRepaintBoundary({super.key, required this.child});
  final Widget child;

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

class LGameBoard extends StatefulWidget {
  const LGameBoard({super.key, required this.lGameSession,
    required this.bScreenReaderIsUsed,
    required this.minusDynamicContainerSize,
    required this.isUpdated,
    required this.isCalledFromList,
    required this.gestureDetectedCallBack,
    required this.calculatedTimeCallBack,
  });
  final bool bScreenReaderIsUsed;
  final LGameSession lGameSession;
  final int minusDynamicContainerSize;
  final bool isUpdated;
  final bool isCalledFromList;
  final void Function(ButtonPressed)? gestureDetectedCallBack;
  final bool Function()? calculatedTimeCallBack;

  @override
  State<LGameBoard> createState() => _LGameBoardState();
}

class _LGameBoardState extends State<LGameBoard> {
  static int lastGestureOccurTime = 0;
  static int oneTab_lastGestureOccurTime = 0;
  final int lastGestureOccurTime_intervalMs = 500;

  late List<Container> _listBoardSquares;
  final List<Widget> _listScreenReader = List<Widget>.empty(growable: true);
  late List<Container?> _listBoardPieces = List.empty(growable: true);
  late List<Container?> _listMoveBorderSquares = List.empty(growable: true);
  late List<Container?> _list2BaseSquares = List.empty(growable: true);
  late List<Widget?> _list3FrameSquares = List.empty(growable: true);

  StackGridContainer? _stackMoveBorderSquares;
  StackGridContainer? _stackMoveSquares;
  StackGridContainer? _stackBoardSquares;
  StackGridContainer? _stackScreenReader;
  StackGridContainer? _stackBoardPieces;

  late List<Border?> _listMoveBorders;
  BorderInnerSquarePosition? innerSquarePosition;
  late List<Widget?> _listMoveSquares = List<Widget?>.empty(growable: true);
  List<String> _iArrScreenReaderSquareText = [];
  List<Widget> _listScreenReaderSquares = [];

  final Color player1Color = Colors.redAccent;
  final Color player2Color = Colors.blueAccent;
  final Color neutralColor = Colors.black;
  final Color moveFrameColor = Colors.black54;

  late ButtonStyle buttonStyleScreenReader;
  late List<Widget> listBoardStack = [];

  @override
  void initState() {
    super.initState();
    buttonStyleScreenReader = ElevatedButton.styleFrom(
        textStyle: TextStyle(fontSize: ScreenUtil().setSp(!ScreenValues.isWeb ? 12 : 6),
        fontWeight: FontWeight.bold),
        backgroundColor: Colors.transparent);

    _listBoardSquares = List.generate(16, (index) {
      return _getBoardSquaresContainer(index);
    });

    _stackBoardSquares = StackGridContainer(listContainers: _listBoardSquares);
    _listMoveBorders = List.generate(16, (index) => null);

    _buildGameBoard();
  }

/*
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
*/

  @override
  void didUpdateWidget(covariant LGameBoard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.lGameSession.calculatedTime == null ||
        widget.lGameSession.calculatedTime!
        != oldWidget.lGameSession.calculatedTime! ||
      (widget.calculatedTimeCallBack != null
            && widget.calculatedTimeCallBack!()) ||
        widget.isUpdated != oldWidget.isUpdated ||
        widget.bScreenReaderIsUsed != oldWidget.bScreenReaderIsUsed) {
      _buildGameBoard();
    }
  /*
    else
      _buildGameBoard();
     */
   // _buildGameBoard();
  }

  Border getMoveDecorationBorderWithBorderSidesForCol(int index,
      List<GameBoardPosition>? l3SeriesList,
      GameBoardPosition forthLPieceGp,
      Color boxDecorationColor) {
    Object? objRet = _getPrivateMoveDecorationBorderWithBorderSidesForCol(index,
        l3SeriesList, forthLPieceGp, boxDecorationColor, false);
    if (objRet != null) {
      return objRet as Border;
    } else {
      return Border.all(
        color: boxDecorationColor,
        width: 7,
      );
    }
  }

  Object? _getPrivateMoveDecorationBorderWithBorderSidesForCol(int index,
      List<GameBoardPosition>? l3SeriesList,
      GameBoardPosition forthLPieceGp,
      Color boxDecorationColor,
      bool isCalledFromBorderMoveContainer) {
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

    l3SeriesList.sort((a, b) => a.iRow.compareTo(b.iRow));
    GameBoardPosition leftGp = l3SeriesList.first;
    GameBoardPosition rightGp = l3SeriesList.last;
    GameBoardPosition? neighbor;
    bool? neighBorIsLeftGp;
    if (leftGp.iRow == forthLPieceGp.iRow) {
      neighBorIsLeftGp = true;
      neighbor = leftGp;
    } else if (rightGp.iRow == forthLPieceGp.iRow) {
      neighbor = rightGp;
      neighBorIsLeftGp = false;
    }

    if (leftGp.iPos == index) {
      ret = Border(
        top: const BorderSide(width: 7, color: Colors.black54, style: BorderStyle.solid),
        bottom: BorderSide.none,
        left: const BorderSide(width: 7, color: Colors.black54, style: BorderStyle.solid),
        right: const BorderSide(width: 7, color: Colors.black54, style: BorderStyle.solid),
      );

      if (neighBorIsLeftGp != null && leftGp.iRow == forthLPieceGp.iRow && forthLPieceGp.iCol > leftGp.iCol) {
        ret = const Border(
          top: BorderSide(width: 7, color: Colors.black54, style: BorderStyle.solid),
          bottom: BorderSide.none,
          left: BorderSide(width: 7, color: Colors.black54, style: BorderStyle.solid),
          right: BorderSide.none,
        );
      }

      if (neighBorIsLeftGp != null && leftGp.iRow == forthLPieceGp.iRow && forthLPieceGp.iCol < leftGp.iCol) {
        ret = const Border(
          top: BorderSide(width: 7, color: Colors.black54, style: BorderStyle.solid),
          bottom: BorderSide.none,
          left: BorderSide.none,
          right: BorderSide(width: 7, color: Colors.black54, style: BorderStyle.solid),
        );
      }
    } else if (rightGp.iPos == index) {
      ret = const Border(
        top: BorderSide.none,
        bottom: BorderSide(width: 7, color: Colors.black54, style: BorderStyle.solid),
        left: BorderSide(width: 7, color: Colors.black54, style: BorderStyle.solid),
        right: BorderSide(width: 7, color: Colors.black54, style: BorderStyle.solid),
      );

      if (neighBorIsLeftGp != null && rightGp.iRow == forthLPieceGp.iRow && forthLPieceGp.iCol > rightGp.iCol) {
        ret = const Border(
          top: BorderSide.none,
          bottom: BorderSide(width: 7, color: Colors.black54, style: BorderStyle.solid),
          left: BorderSide(width: 7, color: Colors.black54, style: BorderStyle.solid),
          right: BorderSide.none,
        );
      }

      if (neighBorIsLeftGp != null && rightGp.iRow == forthLPieceGp.iRow && forthLPieceGp.iCol < rightGp.iCol) {
        ret = const Border(
          top: BorderSide.none,
          bottom: BorderSide(width: 7, color: Colors.black54, style: BorderStyle.solid),
          left: BorderSide.none,
          right: BorderSide(width: 7, color: Colors.black54, style: BorderStyle.solid),
        );
      }
    } else if (l3SeriesList[1].iPos == index) {
      ret = const Border(
        top: BorderSide.none,
        bottom: BorderSide.none,
        left: BorderSide(width: 7, color: Colors.black54, style: BorderStyle.solid),
        right: BorderSide(width: 7, color: Colors.black54, style: BorderStyle.solid),
      );
    } else if (forthLPieceGp.iPos == index) {
      ret = const Border(
        top: BorderSide(width: 7, color: Colors.black54, style: BorderStyle.solid),
        bottom: BorderSide(width: 7, color: Colors.black54, style: BorderStyle.solid),
        left: BorderSide(width: 7, color: Colors.black54, style: BorderStyle.solid),
        right: BorderSide(width: 7, color: Colors.black54, style: BorderStyle.solid),
      );

      if (neighBorIsLeftGp != null &&
          ((forthLPieceGp.iRow == leftGp.iRow && forthLPieceGp.iCol > leftGp.iCol) ||
              (forthLPieceGp.iRow == rightGp.iRow && forthLPieceGp.iCol > rightGp.iCol))) {
        ret = const Border(
          top: BorderSide(width: 7, color: Colors.black54, style: BorderStyle.solid),
          bottom: BorderSide(width: 7, color: Colors.black54, style: BorderStyle.solid),
          left: BorderSide.none,
          right: BorderSide(width: 7, color: Colors.black54, style: BorderStyle.solid),
        );
      }

      if (neighBorIsLeftGp != null &&
          ((forthLPieceGp.iRow == leftGp.iRow && forthLPieceGp.iCol < leftGp.iCol) ||
              (forthLPieceGp.iRow == rightGp.iRow && forthLPieceGp.iCol < rightGp.iCol))) {
        ret = const Border(
          top: BorderSide(width: 7, color: Colors.black54, style: BorderStyle.solid),
          bottom: BorderSide(width: 7, color: Colors.black54, style: BorderStyle.solid),
          left: BorderSide(width: 7, color: Colors.black54, style: BorderStyle.solid),
          right: BorderSide.none,
        );
      }
    }

    return ret;
  }

  Border getMoveDecorationBorder(int index, Color boxDecorationColor) {
    Object? objRet = _getPrivateMoveDecorationBorder(index, boxDecorationColor, false);
    if (objRet != null) {
      return objRet as Border;
    } else {
      return Border.all(
        color: boxDecorationColor,
        width: 7,
      );
    }
  }

  Object? _getPrivateMoveDecorationBorder(int index, Color boxDecorationColor, bool isCalledFromBorderMoveContainer) {
    Object? ret = Border.all(
      color: boxDecorationColor,
      width: 7,
    );

    if (isCalledFromBorderMoveContainer) {
      ret = null;
    }

    if (widget.lGameSession.iArrPlayerMovePieces != null && widget.lGameSession.iArrPlayerMovePieces!.contains(index)) {
      Set freeElements = widget.lGameSession.calculateFreeElements();
      if (freeElements.isEmpty) {
        return ret;
      }
      List<int> listStatic = freeElements.cast<int>().toList();

      List<GameBoardPosition>? freeGps = widget.lGameSession.getGameBoardPositionList(listStatic);
      if (freeGps == null) {
        return ret;
      }

      List<GameBoardPosition>? gps = widget.lGameSession.getGameBoardPositionList(widget.lGameSession.iArrPlayerMovePieces!);
      if (gps == null) {
        return ret;
      }

      bool? bValue = widget.lGameSession.moveArrayIsInHorizontal(widget.lGameSession.iArrPlayerMovePieces);
      if (bValue == null) {
        return ret;
      }
      if (bValue) {
        int? iHorizontalRow = widget.lGameSession.getRowNumberInMoveArray(widget.lGameSession.iArrPlayerMovePieces);
        if (iHorizontalRow == null) {
          return ret;
        }

        GameBoardPositionSeries? rowSeries = widget.lGameSession.getPositionsOfFreePieceInSpecRow(iHorizontalRow, gps);
        if (rowSeries == null) {
          return ret;
        }

        GameBoardPosition? forthLPieceGp;
        bool bFounded = false;
        for (var gp in gps) {
          for (var seriesGp in rowSeries.series) {
            if (seriesGp.iRow != gp.iRow) {
              forthLPieceGp = gp;
              bFounded = true;
              break;
            }
          }
          if (bFounded) break;
        }

        if (forthLPieceGp == null) return ret;

        if (!isCalledFromBorderMoveContainer) {
          ret = _getMoveDecorationBorderWithBorderSidesForRow(index, rowSeries.series, forthLPieceGp, boxDecorationColor);
        } else {
          ret = _getPrivateMoveDecorationBorderWithBorderSidesForRow(index, rowSeries.series, forthLPieceGp, boxDecorationColor, true);
        }
      } else {
        int? iHorizontalCol = widget.lGameSession.getColNumberInMoveArray(widget.lGameSession.iArrPlayerMovePieces);
        if (iHorizontalCol == null) {
          return ret;
        }

        GameBoardPositionSeries? colSeries = widget.lGameSession.getPositionsOfFreePieceInSpecCol(iHorizontalCol, gps);
        if (colSeries == null) {
          return ret;
        }

        GameBoardPosition? forthLPieceGp;
        bool bFounded = false;
        for (var gp in gps) {
          for (var seriesGp in colSeries.series) {
            if (seriesGp.iCol != gp.iCol) {
              forthLPieceGp = gp;
              bFounded = true;
              break;
            }
          }
          if (bFounded) break;
        }

        if (forthLPieceGp == null) return ret;

        if (!isCalledFromBorderMoveContainer) {
          ret = getMoveDecorationBorderWithBorderSidesForCol(index, colSeries.series, forthLPieceGp, boxDecorationColor);
        } else {
          ret = _getPrivateMoveDecorationBorderWithBorderSidesForCol(index, colSeries.series, forthLPieceGp, boxDecorationColor, true);
        }
      }
    }

    if (isCalledFromBorderMoveContainer && ret is Border) {
      ret = null;
    }

    return ret;
  }

  Border _getMoveDecorationBorderWithBorderSidesForRow(int index,
      List<GameBoardPosition>? l3SeriesList,
      GameBoardPosition forthLPieceGp,
      Color boxDecorationColor) {
    Object? objRet = _getPrivateMoveDecorationBorderWithBorderSidesForRow(index, l3SeriesList, forthLPieceGp, boxDecorationColor, false);
    if (objRet != null) {
      return objRet as Border;
    } else {
      return Border.all(
        color: boxDecorationColor,
        width: 7,
      );
    }
  }

  Object? _getPrivateMoveDecorationBorderWithBorderSidesForRow(int index,
      List<GameBoardPosition>? l3SeriesList,
      GameBoardPosition forthLPieceGp,
      Color boxDecorationColor,
      bool isCalledFromBorderMoveContainer) {
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

    l3SeriesList.sort((a, b) => a.iCol.compareTo(b.iCol));
    GameBoardPosition leftGp = l3SeriesList.first;
    GameBoardPosition rightGp = l3SeriesList.last;
    GameBoardPosition? neighbor;
    bool? neighBorIsLeftGp;
    if (leftGp.iCol == forthLPieceGp.iCol) {
      neighBorIsLeftGp = true;
      neighbor = leftGp;
    } else if (rightGp.iCol == forthLPieceGp.iCol) {
      neighbor = rightGp;
      neighBorIsLeftGp = false;
    }

    if (leftGp.iPos == index) {
      ret = const Border(
        top: BorderSide(width: 7, color: Colors.black54, style: BorderStyle.solid),
        bottom: BorderSide(width: 7, color: Colors.black54, style: BorderStyle.solid),
        left: BorderSide(width: 7, color: Colors.black54, style: BorderStyle.solid),
        right: BorderSide.none,
      );

      if (neighBorIsLeftGp != null && leftGp.iCol == forthLPieceGp.iCol && forthLPieceGp.iRow > leftGp.iRow) {
        ret = const Border(
          top: BorderSide(width: 7, color: Colors.black54, style: BorderStyle.solid),
          bottom: BorderSide.none,
          left: BorderSide(width: 7, color: Colors.black54, style: BorderStyle.solid),
          right: BorderSide.none,
        );
      }

      if (neighBorIsLeftGp != null && leftGp.iCol == forthLPieceGp.iCol && forthLPieceGp.iRow < leftGp.iRow) {
        ret = const Border(
          top: BorderSide.none,
          bottom: BorderSide(width: 7, color: Colors.black54, style: BorderStyle.solid),
          left: BorderSide(width: 7, color: Colors.black54, style: BorderStyle.solid),
          right: BorderSide.none,
        );
      }
    } else if (rightGp.iPos == index) {
      ret = const Border(
        top: BorderSide(width: 7, color: Colors.black54, style: BorderStyle.solid),
        bottom: BorderSide(width: 7, color: Colors.black54, style: BorderStyle.solid),
        left: BorderSide.none,
        right: BorderSide(width: 7, color: Colors.black54, style: BorderStyle.solid),
      );

      if (neighBorIsLeftGp != null && !neighBorIsLeftGp && forthLPieceGp.iRow > rightGp.iRow) {
        ret = const Border(
          top: BorderSide(width: 7, color: Colors.black54, style: BorderStyle.solid),
          bottom: BorderSide.none,
          left: BorderSide.none,
          right: BorderSide(width: 7, color: Colors.black54, style: BorderStyle.solid),
        );
      }

      if (neighBorIsLeftGp != null && !neighBorIsLeftGp && forthLPieceGp.iRow < rightGp.iRow) {
        ret = const Border(
          top: BorderSide.none,
          bottom: BorderSide(width: 7, color: Colors.black54, style: BorderStyle.solid),
          left: BorderSide.none,
          right: BorderSide(width: 7, color: Colors.black54, style: BorderStyle.solid),
        );
      }
    } else if (l3SeriesList[1].iPos == index) {
      ret = const Border(
        top: BorderSide(width: 7, color: Colors.black54, style: BorderStyle.solid),
        bottom: BorderSide(width: 7, color: Colors.black54, style: BorderStyle.solid),
        left: BorderSide.none,
        right: BorderSide.none,
      );
    } else if (forthLPieceGp.iPos == index) {
      ret = const Border(
        top: BorderSide(width: 7, color: Colors.black54, style: BorderStyle.solid),
        bottom: BorderSide(width: 7, color: Colors.black54, style: BorderStyle.solid),
        left: BorderSide(width: 7, color: Colors.black54, style: BorderStyle.solid),
        right: BorderSide(width: 7, color: Colors.black54, style: BorderStyle.solid),
      );

      if (neighBorIsLeftGp != null &&
          ((neighBorIsLeftGp && forthLPieceGp.iCol == leftGp.iCol && forthLPieceGp.iRow > leftGp.iRow) ||
              (!neighBorIsLeftGp && forthLPieceGp.iCol == rightGp.iCol && forthLPieceGp.iRow > rightGp.iRow))) {
        ret = const Border(
          top: BorderSide.none,
          bottom: BorderSide(width: 7, color: Colors.black54, style: BorderStyle.solid),
          left: BorderSide(width: 7, color: Colors.black54, style: BorderStyle.solid),
          right: BorderSide(width: 7, color: Colors.black54, style: BorderStyle.solid),
        );
      }

      if (neighBorIsLeftGp != null &&
          ((neighBorIsLeftGp && forthLPieceGp.iCol == leftGp.iCol && forthLPieceGp.iRow < leftGp.iRow) ||
              (!neighBorIsLeftGp && forthLPieceGp.iCol == rightGp.iCol && forthLPieceGp.iRow < rightGp.iRow))) {
        ret = const Border(
          top: BorderSide(width: 7, color: Colors.black54, style: BorderStyle.solid),
          bottom: BorderSide.none,
          left: BorderSide(width: 7, color: Colors.black54, style: BorderStyle.solid),
          right: BorderSide(width: 7, color: Colors.black54, style: BorderStyle.solid),
        );
      }
    }

    return ret;
  }

  Color _getMovePieceColor(int index) {
    if (widget.lGameSession.iPlayerMove == null) return Colors.transparent;

    bool isInMoveList = widget.lGameSession.iArrPlayerMovePieces?.contains(index) ?? false;
    if (!isInMoveList) return Colors.transparent;

    return Colors.white10;
  }

  Widget? _getMoveChild(int index) {
    Color modeColor = _getMovePieceColor(index);
    if (modeColor == Colors.transparent) return null;

    Color textColor = moveFrameColor;
    bool isIn1List = widget.lGameSession.iArrPlayer1Pieces?.contains(index) ?? false;
    bool isIn2List = widget.lGameSession.iArrPlayer2Pieces?.contains(index) ?? false;
    if ((!isIn2List && !isIn1List) && (index == widget.lGameSession.iPlayerNeutral1Piece || index == widget.lGameSession.iPlayerNeutral2Piece)) {
      textColor = Colors.yellow;
    }

    Widget text = Text(
        "${widget.lGameSession.iPlayerMove}",
        textAlign: TextAlign.left,
        style: TextStyle(fontSize: ScreenUtil().setSp(!ScreenValues.isWeb ? 27 : 6), color: textColor,
            fontWeight: FontWeight.bold)
    );

    if (modeColor == Colors.white10) modeColor = Colors.transparent;

    return Container(
      color: modeColor,
      width: ScreenValues.containerWidth,
      height: ScreenValues.containerWidth,
      child: text,
    );
  }

  Container? _getBorderMoveContainer(int index) {
    if (innerSquarePosition?.iInnerSquareBorder != index) return null;

    Widget? modeContainerChild;
    Alignment? alignment;
    if (innerSquarePosition?.innerCornerPosition == INNERCORNERPOSITION.TOPRIGHTCORNER) {
      alignment = Alignment.topRight;
    } else if (innerSquarePosition?.innerCornerPosition == INNERCORNERPOSITION.TOPLEFTCORNER) {
      alignment = Alignment.topLeft;
    } else if (innerSquarePosition?.innerCornerPosition == INNERCORNERPOSITION.BOTTOMRIGHTCORNER) {
      alignment = Alignment.bottomRight;
    } else if (innerSquarePosition?.innerCornerPosition == INNERCORNERPOSITION.BOTTOMLEFTCORNER) {
      alignment = Alignment.bottomLeft;
    }

    if (alignment != null) {
      modeContainerChild = Align(
        alignment: alignment,
        child: Container(
          height: 7,
          width: 7,
          color: moveFrameColor,
        ),
      );
    }

    return Container(
      color: Colors.transparent,
      width: ScreenValues.containerWidth,
      height: ScreenValues.containerWidth,
      child: modeContainerChild,
    );
  }

  Container? _getMoveContainer(int index) {
    return _getPrivateMoveContainer(index, false);
  }

  Container? _getPrivateMoveContainer(int index, bool isCalledFromBorderMoveContainer) {
    if (!(widget.lGameSession.iArrPlayerMovePieces?.contains(index) ?? false)) return null;
    Widget? modeContainerChild = _getMoveChild(index);
    if (modeContainerChild == null) return null;

    Color boxDecorationColor = _getBoxDecorationColor();
    Color modeColor = _getMovePieceColor(index);
    BoxDecoration boxDecoration;

    if (widget.lGameSession.iArrPlayerMovePieces?.contains(index) ?? false) {
      Border? boxBorder;
      if (!isCalledFromBorderMoveContainer) {
        boxBorder = getMoveDecorationBorder(index, boxDecorationColor);
        _listMoveBorders[index] = boxBorder;
      }

      boxDecoration = BoxDecoration(
        color: modeColor,
        border: boxBorder,
      );
    } else {
      boxDecoration = BoxDecoration(
        color: modeColor,
        border: Border.all(color: boxDecorationColor, width: 7),
      );
    }

    if (widget.lGameSession.inMovingPiece == LGamePieceInMove.neutral &&
       (boxDecorationColor == Colors.white || (widget.lGameSession.iArrPlayerMovePieces?.contains(index) ?? false))) {

      if (widget.lGameSession.iArrPlayerMovePieces?.contains(index) ?? false) {
        boxDecorationColor = modeColor;
      }

      Color borderColor = widget.lGameSession.playerTurn == GamePlayerTurn.player1 ? player1Color : player2Color;
      if (widget.lGameSession.inMovingPiece == LGamePieceInMove.neutral) {
          if (widget.lGameSession.iArrPlayerMovePieces!.contains(index)) {
            if ((widget.lGameSession.iArrPlayer1Pieces?.contains(index) ?? false) && widget.lGameSession.playerTurn == GamePlayerTurn.player1) {
              borderColor = Colors.black;
            } else if ((widget.lGameSession.iArrPlayer2Pieces?.contains(index) ?? false) && widget.lGameSession.playerTurn == GamePlayerTurn.player2) {
              borderColor = Colors.black;
            }
          }
      }

      boxDecoration = BoxDecoration(
        color: boxDecorationColor,
        border: Border.all(color: borderColor, width: 7),
        borderRadius: BorderRadius.circular(45.0),
      );
    }

    if (!_indexInTheMiddleOfLPiece(index, widget.lGameSession.iArrPlayerMovePieces)) {
      modeContainerChild = null;
    }

    return Container(
      decoration: boxDecoration,
      width: ScreenValues.containerWidth,
      height: ScreenValues.containerWidth,
      child: modeContainerChild,
    );
  }

  Container _getBoardSquaresContainer(int index) {
    return /* Container(
      padding: const EdgeInsets.all(1),
      width: ScreenValues.containerWidth,
      height: ScreenValues.containerWidth,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.blue, Colors.green],
        ),
      ),
      child: */ Container(
        width: ScreenValues.containerWidth - 20,
        height: ScreenValues.containerWidth - 20,
        decoration: BoxDecoration(
          color: Colors.orange[200],
          border: Border.all(color: Colors.black, width: 0),
        ),
    //  ),
    );
  }

  Color _getBoxDecorationColor() {
    Color ret = widget.lGameSession.playerTurn == GamePlayerTurn.player1 ? player1Color : player2Color;
    if (widget.lGameSession.iArrPlayerMovePieces != null && widget.lGameSession.iArrPlayerMovePieces!.length == 1) {
        int pieceIdx = widget.lGameSession.iArrPlayerMovePieces!.first;
        if ((widget.lGameSession.iActiveNeutral == 1 && pieceIdx == widget.lGameSession.iPlayerNeutral1Piece) ||
            (widget.lGameSession.iActiveNeutral == 2 && pieceIdx == widget.lGameSession.iPlayerNeutral2Piece)) {
          ret = Colors.white;
        } else {
          ret = Colors.black;
        }
    }
    return ret;
  }

  Color _getBoardPieceColor(int index) {
    if (widget.lGameSession.iArrPlayer1Pieces?.contains(index) ?? false) return player1Color;
    if (widget.lGameSession.iArrPlayer2Pieces?.contains(index) ?? false) return player2Color;
    if (index == widget.lGameSession.iPlayerNeutral1Piece || index == widget.lGameSession.iPlayerNeutral2Piece) return neutralColor;
    return Colors.transparent;
  }

  Widget? _getTextChild(int index, bool isBoardPiece) {
    bool isIn1List = widget.lGameSession.iArrPlayer1Pieces?.contains(index) ?? false;
    bool isIn2List = widget.lGameSession.iArrPlayer2Pieces?.contains(index) ?? false;
    bool isNeutral = index == widget.lGameSession.iPlayerNeutral1Piece || index == widget.lGameSession.iPlayerNeutral2Piece;

    if (!isNeutral && !isIn1List && !isIn2List) return null;

    String strText = isIn1List ? "1" : (isIn2List ? "2" : "0");
    Color fontColor = Colors.white;
    if (!isBoardPiece && isNeutral) fontColor = Colors.black;

    return Center(
      child: Text(
        strText,
        style: TextStyle(
          fontSize: ScreenUtil().setSp(!ScreenValues.isWeb ? 30 : 6),
          color: fontColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _getScreenReaderSquare(int index) {
    return Semantics(
      readOnly: true,
      child: Text(
        _iArrScreenReaderSquareText[index],
        textAlign: TextAlign.left,
        style: TextStyle(
          fontSize: ScreenUtil().setSp(!ScreenValues.isWeb ? 12 : 6),
          color: Colors.transparent,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  String _getChangeScreenReaderText(int i, bool bInit) {
    if (bInit || widget.bScreenReaderIsUsed) {
      if (bInit) {
        String strLabel = widget.lGameSession.getScreenReaderSquareLabel(i);
        String strExpr2 = widget.lGameSession.getScreenReaderSquareValue(i);
        return "Position $strLabel\n$strExpr2";
      } else {
        return widget.lGameSession.getScreenReaderSquareValue(i);
      }
    }
    return "";
  }

  Future<void> _screenReaderAnnounce(String msg) async {
    if (widget.bScreenReaderIsUsed && msg.isNotEmpty) {
      await SemanticsService.sendAnnouncement(View.of(context), msg, TextDirection.ltr);
    }
  }

  BorderInnerSquarePosition? _getInnerSquareBorder() {
    for (int i = 0; i < _listMoveBorders.length; i++) {
      Border? border = _listMoveBorders[i];
      if (border == null) continue;

      bool topNone = border.top.style == BorderStyle.none;
      bool bottomNone = border.bottom.style == BorderStyle.none;
      bool leftNone = border.left.style == BorderStyle.none;
      bool rightNone = border.right.style == BorderStyle.none;

      if ((topNone || bottomNone) && (leftNone || rightNone)) {
        INNERCORNERPOSITION? position;
        if (topNone && rightNone) {
          position = INNERCORNERPOSITION.TOPRIGHTCORNER;
        } else if (topNone && leftNone) position = INNERCORNERPOSITION.TOPLEFTCORNER;
        else if (bottomNone && leftNone) position = INNERCORNERPOSITION.BOTTOMLEFTCORNER;
        else if (bottomNone && rightNone) position = INNERCORNERPOSITION.BOTTOMRIGHTCORNER;

        if (position != null) return BorderInnerSquarePosition(position, i);
      }
    }
    return null;
  }

  bool _indexInTheMiddleOfLPiece(int index, List<int>? iArrPlayerPieces) {
     if (iArrPlayerPieces == null || iArrPlayerPieces.length < 4) return false;

     List<GameBoardPosition>? gps = widget.lGameSession.getGameBoardPositionList(iArrPlayerPieces);
     if (gps == null || gps.length < 4) return false;

     if (gps[0].iRow == gps[1].iRow && gps[1].iRow == gps[2].iRow && gps[1].iPos == index) return true;
     if (gps[0].iCol == gps[1].iCol && gps[1].iCol == gps[2].iCol && gps[1].iPos == index) return true;
     if (gps[1].iRow == gps[2].iRow && gps[2].iRow == gps[3].iRow && gps[2].iPos == index) return true;
     if (gps[1].iCol == gps[2].iCol && gps[2].iCol == gps[3].iCol && gps[2].iPos == index) return true;

     return false;
  }

  /*
  Widget? getNewOrOldMoveSquares(int index)
  {
    Widget? currLoopWidget;
    if (_listMoveSquares.isNotEmpty) {
       currLoopWidget = _listMoveSquares[index];
    }
    if (widget.isCalledFromList
        || widget.lGameSession.getIndexChangedUnderCalculateCall(index)) {
       currLoopWidget = _getMoveContainer(index);
    }
      return currLoopWidget;
  }

  Container getNewOrOldMoveBorderSquares(int index)
  {
    Container currLoopWidget = _getBorderMoveContainer(index);
    if (!widget.isCalledFromList && (_listMoveBorderSquares.isNotEmpty &&
        !widget.lGameSession.getIndexChangedUnderCalculateCall(index))) {
      currLoopWidget = _listMoveBorderSquares[index];
    }
    return currLoopWidget;
  }
  */
  void _buildGameBoard() {
    setState(() {
      // Background Grid - Only build if necessary (here built in initState)

      // Board Pieces
      if (_listBoardPieces.isEmpty || widget.lGameSession.getButtonPressed() == ButtonPressed.moveDone
          || widget.lGameSession.getButtonPressed() == ButtonPressed.newGame) {
        _listBoardPieces = List.generate(16, (index) {
          Color? bgColor = _getBoardPieceColor(index);
          if (bgColor == Colors.transparent) return null;

          Widget? child = _getTextChild(index, true);
          BoxDecoration? deco;

          if (bgColor == Colors.black) {
            deco = const BoxDecoration(color: Colors.black, shape: BoxShape.circle);
            bgColor = null;
          }

          if (widget.lGameSession.iArrPlayer1Pieces?.contains(index) ?? false) {
            if (!_indexInTheMiddleOfLPiece(index, widget.lGameSession.iArrPlayer1Pieces)) child = null;
          } else if (widget.lGameSession.iArrPlayer2Pieces?.contains(index) ?? false) {
            if (!_indexInTheMiddleOfLPiece(index, widget.lGameSession.iArrPlayer2Pieces)) child = null;
          } else {
            child = null;
          }

          Container ret = Container(
            color: bgColor,
            width: ScreenValues.containerWidth,
            height: ScreenValues.containerWidth,
            decoration: deco,
            child: child,
          );

          if (bgColor == null)
            {
               ret = Container(
                 width: ScreenValues.containerWidth - 20,
                 height: ScreenValues.containerWidth - 20,
                 decoration: BoxDecoration(
                   color: Colors.orange[200],
                   border: Border.all(color: Colors.black, width: 0),
                 ),
                 child: ret,
               );
            }
          return ret;
        });

        _list2BaseSquares = _listBoardSquares.toList(growable: true);
        for (int i = 0; i < _listBoardPieces.length; i++) {
          if (_listBoardPieces[i] != null) {
            _list2BaseSquares[i] = _listBoardPieces[i];
          }
        }
        _stackBoardPieces = StackGridContainer(listContainers: _list2BaseSquares);
      }

      // Move Squares
      _listMoveBorders = List.generate(16, (index) => null);
      _listMoveSquares = List.generate(16, (index) => _getMoveContainer(index)
          /* getNewOrOldMoveSquares(index) */);

      _stackMoveSquares = StackGridContainer(listContainers: _listMoveSquares);

      // Move Border Squares
      innerSquarePosition = _getInnerSquareBorder();
      _listMoveBorderSquares = List.generate(16, (index) =>
          _getBorderMoveContainer(index)
          /* getNewOrOldMoveBorderSquares(index) */);

      _list3FrameSquares = _listMoveSquares.toList(growable: true);
      for (int i = 0; i < _listMoveBorderSquares.length; i++) {
        if (_listMoveBorderSquares[i] != null) {
          _list3FrameSquares[i] = Stack(children: [
            _listMoveSquares[i] as Widget,
            _listMoveBorderSquares[i] as Widget
          ]);
        }
      }

      _stackMoveBorderSquares = StackGridContainer(listContainers: _listMoveBorderSquares);
      _stackMoveSquares = StackGridContainer(listContainers: _list3FrameSquares);

      listBoardStack.clear();
     // listBoardStack.add(/* ChildRepaintBoundary(child: */ _stackBoardSquares! /* ) */);
      // listBoardStack.add(RepaintBoundary(child: _stackBoardPieces!));
      listBoardStack.add(ChildRepaintBoundary(child: _stackBoardPieces!));
      listBoardStack.add(ChildRepaintBoundary(child: _stackMoveSquares!));
//      listBoardStack.add(/* ChildRepaintBoundary(child: */ _stackMoveBorderSquares!/* ) */);

      if (widget.bScreenReaderIsUsed) {
        _iArrScreenReaderSquareText = List.generate(16, (index) => _getChangeScreenReaderText(index, true));
        _listScreenReaderSquares = List.generate(16, (index) => _getScreenReaderSquare(index));
        _stackScreenReader = StackGridContainer(listContainers: _listScreenReaderSquares);
        listBoardStack.add(_stackScreenReader!);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    widget.lGameSession.setScreenReaderIsUsed(widget.bScreenReaderIsUsed);

    Widget ret;
    if (!widget.bScreenReaderIsUsed) {
      ret = GestureDetector(
        behavior: HitTestBehavior.translucent,
        onDoubleTap: () {
          if (widget.gestureDetectedCallBack != null) {
            final now = DateTime.now().millisecondsSinceEpoch;
            if ((now - lastGestureOccurTime) < lastGestureOccurTime_intervalMs) return;
            lastGestureOccurTime = now;
      /*      Future(() {
              print('Callback executed gestureDetectedCallBack');
       */
              widget.gestureDetectedCallBack!(ButtonPressed.wrap);
         //   });
          }
        },
        onLongPress: () {
          if (widget.gestureDetectedCallBack != null) {
            final now = DateTime.now().millisecondsSinceEpoch;
            if ((now - lastGestureOccurTime) < lastGestureOccurTime_intervalMs) return;
            lastGestureOccurTime = now;
         /*   Future(() {
              print('Callback executed gestureDetectedCallBack');
          */
              widget.gestureDetectedCallBack!(ButtonPressed.turn90Degree);
          //  });
          }
        },
        onLongPressMoveUpdate: (details) {
          final now = DateTime.now().millisecondsSinceEpoch;
          if ((now - lastGestureOccurTime) < lastGestureOccurTime_intervalMs) return;
          lastGestureOccurTime = now;
       /*   Future(() {
            print('Callback executed gestureDetectedCallBack');
        */
            widget.gestureDetectedCallBack!(ButtonPressed.moveDone);
        //  });
        },
        onPanUpdate: (details) {
          final now = DateTime.now().millisecondsSinceEpoch;
          if ((now - lastGestureOccurTime) < lastGestureOccurTime_intervalMs) return;

          if (details.delta.dx < -5) {
            lastGestureOccurTime = now;
        /*    Future(() {
              print('Callback executed gestureDetectedCallBack');
         */
              widget.gestureDetectedCallBack?.call(ButtonPressed.left);
          //  });
          } else if (details.delta.dx > 5) {
            lastGestureOccurTime = now;
         /*   Future(() {
              print('Callback executed gestureDetectedCallBack');
          */
              widget.gestureDetectedCallBack?.call(ButtonPressed.right);
          //  });
          } else if (details.delta.dy < -5) {
            lastGestureOccurTime = now;
         /*   Future(() {
              print('Callback executed gestureDetectedCallBack');
          */
              widget.gestureDetectedCallBack?.call(ButtonPressed.up);
          //  });
          } else if (details.delta.dy > 5) {
            lastGestureOccurTime = now;
         /*   Future(() {
              print('Callback executed gestureDetectedCallBack');
          */
              widget.gestureDetectedCallBack?.call(ButtonPressed.down);
          //  });
          }
        },
        child: RepaintBoundary(child: Stack(children: listBoardStack) ),
      );
    } else {
      ret = RepaintBoundary(child: Stack(children: listBoardStack));
    }

    return ret;
  }
}
