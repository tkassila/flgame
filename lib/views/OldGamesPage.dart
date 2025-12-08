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

class OldGamesPage extends StatefulWidget {
  final String strDeleteTitle;
  final String strDeleteAsk;
  final List<LGameSessionData>? listDataSessions;
  final LGameSessionFunctionCallback lGameSessionRemoveFunctionCallback;
  final bool bScreenReaderIsUsed;
  final bool bCalledFromFinishedGames;
  OldGamesPage({super.key, required this.strDeleteTitle,
    required this.strDeleteAsk,
    required this.listDataSessions,
    required this.lGameSessionRemoveFunctionCallback,
    required this.bScreenReaderIsUsed,
    required this.bCalledFromFinishedGames});

  @override
  State<OldGamesPage> createState() => _OldGamesPageState();
}

class _OldGamesPageState extends State<OldGamesPage> {

  final ButtonStyle buttonStyle =
  ElevatedButton.styleFrom(textStyle: TextStyle(fontSize: ScreenUtil().setSp(20)),
      backgroundColor: Colors.amberAccent);

  Future<Null> _fetchPartner() async {
    print('Please Wait');
  }

//  List<LGameSessionData>? listDataSessions;
  // List<LGameSessionTitle>? _dataTitles;
  LGameSessionData? selectedSessionData;
  LGameSession lGameSession = LGameSession();
  int selectedIndex = -1, prevIndexExpanded = -1;
  ExpansionTileController? selectedExpansionTile;
  List<ExpansionTileController>? expansionControllers;
  bool bUnderCollapse = false;
  SelectedLGameSessionData? selectedLGameSessionData;
  bool bScreenReaderIsUsed = false;
  int indexBackgroundColor = -1;

  @override
  void initState() {
    super.initState();
    lGameSession.initState();
    if (widget.listDataSessions != null && widget.listDataSessions!.isNotEmpty)
    {
      LGameSessionData dataItem = widget.listDataSessions!.first;
      lGameSession.setStartGameAfterOldGame(dataItem);
      selectedSessionData = dataItem;
    }
  }

  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);
    if (mediaQueryData.accessibleNavigation) {
      bScreenReaderIsUsed = true;
    } else {
      bScreenReaderIsUsed = false;
    }

    String strPageTitle = 'Unfinished games';
    if (widget.bCalledFromFinishedGames)
      strPageTitle = 'Finished games';

    ScrollController scrollController = ScrollController();

    return SafeArea(
        minimum: const EdgeInsets.all(4.0),
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        primary: false,
        centerTitle: false,
        title: Text(strPageTitle, /* style: textStyle, */),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        /*   centerTitle: true, */
        actions: [
          if (widget.bCalledFromFinishedGames ||
              (widget.listDataSessions == null || widget.listDataSessions!.isEmpty))
            Padding(padding: const EdgeInsets.only(top: 5.0, right: 10.0),
                child: Semantics(
                    readOnly: true,
                    label: "Back",
                    hint: 'Back button',
                    child: ElevatedButton(
                  style: buttonStyle,
                  child: const Text(
                    'Back',
                  ),
                  onPressed: () async {
                    if (widget.bCalledFromFinishedGames) {
                      Navigator.pop(context);
                    } else {
                      selectedLGameSessionData = null;
                      di<LGameDataService>().selectedLGameSessionData = null;
                      // Navigator.pushNamedAndRemoveUntil(context, "/lgamefor2", ModalRoute.withName('/lgamefor2'));
                      Navigator.pop(context, selectedLGameSessionData);
                      //  Navigator.pushAndRemoveUntil(context,  MaterialPageRoute(builder: (context) => SecondPage(title : "Hello World")), (route) => false);
                    }
                  },
                )),
            )
          else Padding(padding: const EdgeInsets.only(top: 5.0, right: 10.0),
            child: Semantics(
    readOnly: true,
    label: "Select game",
    hint: 'Select game button',
    child: ElevatedButton(
              style: buttonStyle,
              child: const Text(
                'Select game',
              ),
              onPressed: () async {
                if (selectedSessionData != null) {
                  selectedLGameSessionData = SelectedLGameSessionData(selectedSessionData);
                } else {
                  selectedLGameSessionData = null;
                }
                di<LGameDataService>().selectedLGameSessionData = selectedSessionData;
                // Navigator.pushNamedAndRemoveUntil(context, "/lgamefor2", ModalRoute.withName('/lgamefor2'));
                Navigator.pop(context, selectedLGameSessionData);
                //  Navigator.pushAndRemoveUntil(context,  MaterialPageRoute(builder: (context) => SecondPage(title : "Hello World")), (route) => false);
              },
            ),
          ),
          ),
        ],
      ),
      body:   widget.listDataSessions == null || widget.listDataSessions!.isEmpty ?
      Card(child: Padding(padding: EdgeInsets.all(5),
        child: const Text("No unfinished games"),),)
          : SafeArea(
          minimum: const EdgeInsets.all(16.0),
          child: /* ListView( crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [ */
          ListView(
            /* crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min, */
            children: [
              /*
          required this.strDeleteTitle,
    required this.strDeleteAsk,
    required this.listDataSessions,
    required this.lGameSessionFunctionCallback,
    required this.bScreenReaderIsUsed
           */
              if (widget.listDataSessions != null
                  && widget.listDataSessions!.isNotEmpty)
              /* ConstrainedBox(
                          constraints: BoxConstraints(
                              maxHeight: 420),
                          child: IntrinsicHeight(child: */
                Container(
                  constraints: BoxConstraints(maxHeight:
                  MediaQuery.of(context).size.height / 2 - 20),
                  color: Colors.red,
                  child: Scrollbar(
                    controller: scrollController,
                    thickness: 20.0,
                    thumbVisibility: true,
                    trackVisibility: true,
                    // thumbColor: Colors.black,
                    child: ListGameSessions(strDeleteTitle: strDeleteTitle,
                        strDeleteAsk: strDeleteAsk,
                        listDataSessions: widget.listDataSessions!,
                        lGameSessionRemoveFunctionCallback:
                        widget.lGameSessionRemoveFunctionCallback,
                        lGameSessionSelectedFunctionCallback:
                        lGameSessionSelectedFunctionCallback,
                        bScreenReaderIsUsed: bScreenReaderIsUsed,
                        scrollController: scrollController,
                        indexBackgroundColor: indexBackgroundColor),
                  ),
                ),
              //  ),
              // ),
              const SizedBox(height: 10, width: 100,),
              if (selectedSessionData != null && widget.listDataSessions!.isNotEmpty)
              /* Expanded( // Expanded_A
      child: */ LGameBoard(bScreenReaderIsUsed: bScreenReaderIsUsed,
                lGameSession: lGameSession,
              ),
              // ),
            ],
          )
      ),

      /* ListView.builder(
        itemCount: listDataSessions!.length,
        itemBuilder: (context, index) {
          return Card(
            child: ExpansionTile(
              title: Text('${listDataSessions![index].startedAt!}'),
              children: [
            LGameBoard(lGameSession: LGameSession.fromLGamaSessionData(listDataSessions![index])),
              ],
            ),
          );
        },
      ) */
        ),
    );

  }
  /* SystemChrome.setSystemUIOverlayStyle(
  const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
  );
  */

  /*
    Widget _renderOldGames() {
      return ExpansionPanelList(
        expansionCallback: (int index, bool isExpanded) {
          setState(() {
            _steps![index].isExpanded = !isExpanded;
          });
        },
        children: _steps!.map<ExpansionPanel>((Step step) {
          return ExpansionPanel(
            headerBuilder: (BuildContext context, bool isExpanded) {
              return ListTile(
                title: Text(step.title),
              );
            },
            body: LGameBoard(lGameSession: LGameSession() /* LGameSession.fromLGamaSessionData(step.data) */),
            isExpanded: step.isExpanded,
          );
        }).toList(),
      );
    }
     */

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
    if (widget.listDataSessions != null) {
      widget.listDataSessions!.sort((b, a) => getModified(a, b));
      LGameSessionData data;
      for (int i = 0; i < widget.listDataSessions!.length; i++) {
        data = widget.listDataSessions![i];
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

  /*
    updateTileControllers()
    {
      if (_dataTitles != null && _dataTitles!.isNotEmpty) {
        expansionControllers = List.generate(
          _dataTitles!.length,
              (index) => ExpansionTileController(),
        );
      }
    }
    */

  setInitDataList() async
  {
    //   _dataTitles = null;
    setState(() {
      lGameSession.initState();
      /*
        if (listDataSessions != null) {
          _dataTitles = getSteps();
        }
        updateTileControllers();
         */
    });
    //
  }

  void initControls()
  {
    //  listDataSessions = di<LGameDataService>().getLGameSessionDataUnfinished();
    setInitDataList();
  }

  /*
    Widget renderOldGames() {
      return Flexible(child:
      listDataSessions == null ? Card(margin: EdgeInsets.all(5.0),
        child: Text("No old unfinished games"),) :
      ListView.builder(
          itemCount: listDataSessions!.length,
          itemBuilder: (context, index) {
            return Card(
              child: Row(children: [
                Flexible(
                flex: 1,
                child: ExpansionTile(
                  backgroundColor: (selectedIndex == -1 || selectedIndex != index)
                    ? Colors.white : Colors.lightGreenAccent,
                  key: Key(index.toString()), //attention
                  initiallyExpanded: selectedIndex == index,
                  controller: expansionControllers![index],
                  title: (selectedIndex == -1 || selectedIndex != index)
                    ?  Text(formatTitle(_dataTitles![index].title))
                    : Text(formatTitle(_dataTitles![index].title), style:
                       TextStyle(color: Colors.black, fontSize: ScreenUtil().setSp(20),
                      backgroundColor: Colors.lightGreenAccent ),
                        ),
                  children: [
                    Text(_dataTitles![index].data.name1 != null
                        ? "Player 1: ${_dataTitles![index].data.name1!}"
                        : '', style: TextStyle(fontSize: ScreenUtil().setSp(15))),
                    const SizedBox(
                      height: 5.0,
                    ),
                    Text(_dataTitles![index].data.name2 != null
                        ? "Player 2: ${_dataTitles![index].data.name2!}"
                        : '', style: TextStyle(fontSize: ScreenUtil().setSp(15))),
                  ],
                  onExpansionChanged: (newState) {
                    if (bUnderCollapse)
                    {
                         return;
                    }
                    setState(() {
                      if (newState) {
                        selectedSessionData = _dataTitles![index].data;
                        selectedIndex = index;
                        if (prevIndexExpanded != index && prevIndexExpanded != -1
                            && expansionControllers != null
                            && expansionControllers!.length > prevIndexExpanded
                            && expansionControllers![prevIndexExpanded] != null)
                        {
                            bUnderCollapse = true;
                            expansionControllers![prevIndexExpanded].collapse();
                            bUnderCollapse = false;
                        }
                        if (selectedSessionData != null) {
                          lGameSession.setStartGameAfterOldGame(selectedSessionData!);
                        }
                        prevIndexExpanded = index;
                      //  selectedExpansionTile = ExpansionTileController.of(context);
                      }
                      else {
                        selectedIndex = -1;
                        prevIndexExpanded = -1;
                      }
                    },);
                  }
              ),
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  tooltip: 'Delete an old game',
                  onPressed: () async {
                    bool bDeleteThisStep = await showDeleteOldGameDialog(
                                                 context);
                    if (bDeleteThisStep) {
                      di<LGameDataService>().deleteUnFinishedGameSessionData(
                        _dataTitles![index].data);
                      setState(() {
                        lGameSession = LGameSession();
                        selectedSessionData = null;
                        expansionControllers = null;
                        selectedExpansionTile = null;
                        selectedIndex = -1;
                        prevIndexExpanded = -1;
                        initControls();
                        // _dataTitles!.remove(_dataTitles![index]);
                       // updateTileControllers();
                      });
                    }
                  },
                ),
            ],
            ),
            );
          }
      ),
      );
    }
     */

  void lGameSessionSelectedFunctionCallback(LGameSessionData? selectedThis,
      int p_indexBackgroundColor)
  {
    if (selectedThis != null) {
      setState(() {
        selectedSessionData = selectedThis;
        indexBackgroundColor = p_indexBackgroundColor;
        lGameSession.setStartGameAfterOldGame(selectedSessionData!);
      });
    }
  }

  String strDeleteTitle = "Delete old game";
  String strDeleteAsk = "Would you like to delete an old L game?";

}

