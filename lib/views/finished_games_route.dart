
import 'dart:async';
// import 'dart:ffi';
// import 'dart:nativewrappers/_internal/vm/lib/internal_patch.dart';
// import 'dart:js_interop_unsafe';
import 'package:flgame/views/OldGamesPage.dart';
import 'package:flutter_html/flutter_html.dart';

import '../models/LGameDataService.dart';
import 'package:intl/intl.dart';
import 'package:flgame/models/lgame_data.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// import 'package:flutter/cupertino.dart';
import 'package:flgame/models/lgame_data.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
// import 'package:flutter_html/flutter_html.dart';
import '../di.dart';

import 'listgamesessions.dart';
import 'game_board.dart';
import './utils/util_dialog.dart';
import '../ParameterValues.dart';

class FinishedGamesRoute extends StatefulWidget {
  const FinishedGamesRoute({super.key});

  @override
  State<FinishedGamesRoute> createState() => _FinishedGamesState();
}

class _FinishedGamesState extends State<FinishedGamesRoute> {

  final ButtonStyle buttonStyle =
  ElevatedButton.styleFrom(textStyle: TextStyle(fontSize: ScreenUtil().setSp(20)),
      backgroundColor: Colors.amberAccent);

  List<LGameSessionData>? listDataSessions;
  List<LGameSessionTitle>? _dataTitles;
  LGameSessionData? selectedSessionData;
  ExpansionTileController? selectedExpansionTile;
  List<ExpansionTileController>? expansionControllers;
  bool bUnderCollapse = false;
  SelectedLGameSessionData? selectedLGameSessionData;
  bool bScreenReaderIsUsed = false;
  ParameterValues? parameterValues;

  int getModified(LGameSessionData a, LGameSessionData b)
  {
    // a.modifiedAt ??= DateTime.parse(a.startedAt!);
    // b.modifiedAt ??= DateTime.parse(b.startedAt!);
    return a.modifiedAt!.compareTo(b.modifiedAt!);
  }

  void lGameSessionRemoveFunctionCallback(LGameSessionData removeThis) async
  {
    if (listDataSessions != null && listDataSessions!.isNotEmpty) {
      setState(() {
        di<LGameDataService>().deleteFinishedGameSessionData(
            removeThis);
        listDataSessions!.remove(removeThis);
        selectedSessionData = null;
      });
    }
  }

  setInitDataList() async
  {
    setState(() {
      listDataSessions = di<LGameDataService>().getLGameSessionDataFinished();
    });
    //
  }

  @override
  void initState() {
    super.initState();
    initControls();
  }

  void initControls()
  {
    listDataSessions = di<LGameDataService>().getLGameSessionDataFinished();
    //   setInitDataList();
  }

  @override
  Widget build(BuildContext context) {
    parameterValues = ParameterValues.of(context);
    final mediaQueryData = MediaQuery.of(context);
    if (mediaQueryData.accessibleNavigation) {
      bScreenReaderIsUsed = true;
    } else {
      bScreenReaderIsUsed = false;
    }

    return OldGamesPage(strDeleteTitle: strDeleteTitle,
        strDeleteAsk: strDeleteAsk,
        listDataSessions: listDataSessions,
        lGameSessionRemoveFunctionCallback: lGameSessionRemoveFunctionCallback,
        bScreenReaderIsUsed: bScreenReaderIsUsed, bCalledFromFinishedGames: true,
      //  screenValues: ScreenValues.screenValues
    );

  }
  /* SystemChrome.setSystemUIOverlayStyle(
  const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
  );
  */

  String _formatTime(DateTime dateTime) {
    return DateFormat('hh:mm:ss').format(dateTime);
  }

  String formatTitle(String title)
  {
    if (title == "") {
      return "";
    }
    // .format()
    var dt = DateTime.parse(title);
    String tmp = DateFormat('yyyy-MM-dd hh:mm:ss').format(dt).toString();
    return tmp;
  }

  String strDeleteTitle = "Delete old game";
  String strDeleteAsk = "Would you like to delete an old L game?";

}

