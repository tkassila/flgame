/*
import 'dart:convert';
import 'dart:html';

import 'package:flutter/material.dart';
// import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter/services.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
*/
import 'dart:async';
// import 'dart:ffi';
// import 'dart:nativewrappers/_internal/vm/lib/internal_patch.dart';
// import 'dart:js_interop_unsafe';
import 'package:flgame/views/OldGamesPage.dart';

import '../models/LGameDataService.dart';
import 'package:intl/intl.dart';
import 'package:flgame/models/lgame_data.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
// import 'package:flutter_html/flutter_html.dart';
import '../di.dart';

import 'listgamesessions.dart';
import './utils/util_dialog.dart';
import '../ParameterValues.dart';


/*
class OldGamesPage extends StatelessWidget {
  final Widget child;
  final Color? color;

  const OldGamesPage({super.key,
    required this.child,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      minimum: const EdgeInsets.all(16.0),
      child: Container(
      // width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 20),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Theme.of(context).dividerColor)),
        color: color,
      ),
      child: child,
      ),
    );
  }
}
*/

TextStyle textStyle = TextStyle(fontSize: ScreenUtil().setSp(20),
    color: Colors.orangeAccent, backgroundColor: Colors.black);

class OldGamesRoute extends StatefulWidget {
  const OldGamesRoute({super.key});

  @override
  State<OldGamesRoute> createState() => _OldGamesState();
}

class _OldGamesState extends State<OldGamesRoute> {

  List<LGameSessionData>? listDataSessions;
 // List<LGameSessionTitle>? _dataTitles;
  LGameSessionData? selectedSessionData;
  ExpansibleController? selectedExpansionTile;
  List<ExpansibleController>? expansionControllers;
  bool bUnderCollapse = false;
  SelectedLGameSessionData? selectedLGameSessionData;
  bool bScreenReaderIsUsed = false;
  ParameterValues? parameterValues;

  @override
  void initState() {
    super.initState();
    listDataSessions = di<LGameDataService>().getLGameSessionDataUnfinished();
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
        bScreenReaderIsUsed: bScreenReaderIsUsed,
        bCalledFromFinishedGames: false,
     //   screenValues: ScreenValues.screenValues
    );

  }

    Future<bool> showDeleteOldGameDialog(BuildContext thisContext) async {
      bool bCancelReturnValue = false;
      bool bContinueReturnValue = true;
      return showYesNoDialogWithContext("Delete old game", "Cancel", "Continue",
          "Would you like to delete an old L game?", bCancelReturnValue,
          bContinueReturnValue);
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

    int getModified(LGameSessionData a, LGameSessionData b)
    {
      DateTime modifiedAtA = DateTime.parse(a.startedAt!);
      DateTime modifiedAtB = DateTime.parse(b.startedAt!);
      return modifiedAtA.compareTo(modifiedAtB);
    }

    List<LGameSessionTitle> getSteps()
    {
      List<LGameSessionTitle> ret = List.empty(growable: true);
      if (listDataSessions != null) {
        listDataSessions!.sort((b, a) => getModified(a, b));
        LGameSessionData data;
        for (int i = 0; i < listDataSessions!.length; i++) {
          data = listDataSessions![i];
          if (data == null) {
            continue;
          }
          ret.add(LGameSessionTitle(/* i, */ data.modifiedAt != null ?
                  data.modifiedAt!.toString()
              : data.startedAt!, data));
        }
      }
      return ret;
    }

    Future<void> setInitDataList() async
    {
   //   _dataTitles = null;
      setState(() {
        listDataSessions = di<LGameDataService>().getLGameSessionDataUnfinished();
      });
      //
    }

    void initControls()
    {
    //  listDataSessions = di<LGameDataService>().getLGameSessionDataUnfinished();
      setInitDataList();
    }

    void lGameSessionRemoveFunctionCallback(LGameSessionData removeThis) async
    {
       if (listDataSessions != null && listDataSessions!.isNotEmpty) {
         setState(() {
           di<LGameDataService>().deleteUnFinishedGameSessionData(
               removeThis);
          listDataSessions!.remove(removeThis);
          selectedSessionData = null;
        });
       }
    }

    String strDeleteTitle = "Delete old game";
    String strDeleteAsk = "Would you like to delete an old L game?";

  }
