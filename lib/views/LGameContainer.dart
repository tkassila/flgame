import 'package:flutter/material.dart';

import '../ParameterValues.dart';
import '../models/lgame_data.dart';
import 'game_board.dart';

/*
 This class does not optimize under runtime, delay is about
 12ms/frame! The code is as comments line
 the main.dart.
 */
class LGameContainer extends StatelessWidget {
  const LGameContainer({super.key,
    required this.isSystemNavigateMenu,
    required this.bEditPlayerNames,
    required this.editOrButtonContainer,
 //   required this.lGameBoard,
    required this.textMessage,
  //  required this.notifier,
    required this.buttonBetweenWidth,
    required this.lGameSession,
    required this.bScreenReaderIsUsed,
    required this.isUpdated,
    required this.gestureDetectedCallBack,
  });
  final bool isSystemNavigateMenu;
  final bool bEditPlayerNames;
  final Widget editOrButtonContainer;
 // final ValueNotifier<bool> notifier;
  // final LGameBoard? lGameBoard;
  final LGameSession lGameSession;
  final bool bScreenReaderIsUsed;
  final Widget? textMessage;
  final double buttonBetweenWidth;
  final bool isUpdated;
  final Function(ButtonPressed)? gestureDetectedCallBack;

  @override
  Widget build(BuildContext context) {
    Widget? ret = null;
    if (!ScreenValues.isWeb) {
      ret = Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          /* Expanded( // wrap in Expanded
          child: */
          if (bEditPlayerNames)
          //  SizedBox(height: 10, width: buttonBetweenWidth,),
            editOrButtonContainer,
          /* RepaintBoundary(child: */ LGameBoard(lGameSession: lGameSession,
            bScreenReaderIsUsed: bScreenReaderIsUsed,
            gestureDetectedCallBack: gestureDetectedCallBack,
            // notifier: _notifier,
            minusDynamicContainerSize: ScreenValues
                .minusDynamicContainerSizeOfLGame - 20,
            isUpdated: isUpdated,
            /*  minusDynamicContainerSize: minusDynamicContainerSizeOfLGame */
            // lGameBoard!,
            /* buildGameBoard2() */ /* _gameBoardGrid!, */

            // ),
//        SizedBox(height: 20,),
          ), // ),
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
            editOrButtonContainer,
          /* RepaintBoundary(child: */ LGameBoard(lGameSession: lGameSession,
            bScreenReaderIsUsed: bScreenReaderIsUsed,
            gestureDetectedCallBack: gestureDetectedCallBack,
            // notifier: _notifier,
            minusDynamicContainerSize: ScreenValues
                .minusDynamicContainerSizeOfLGame - 20,
            isUpdated: isUpdated,
            /*  minusDynamicContainerSize: minusDynamicContainerSizeOfLGame */
            // lGameBoard!,
            /* buildGameBoard2() */ /* _gameBoardGrid!, */

            // ),
//        SizedBox(height: 20,),
          ), // ),
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
    // : _buildBoard */ ),;
  }
}
