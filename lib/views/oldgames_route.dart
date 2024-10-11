/*
import 'dart:convert';
import 'dart:html';

import 'package:flutter/material.dart';
// import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter/services.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
*/
import 'dart:async';
// import 'dart:nativewrappers/_internal/vm/lib/internal_patch.dart';
// import 'dart:js_interop_unsafe';
import '../models/LGameDataService.dart';

// import 'package:flutter/cupertino.dart';
import 'package:flgame/models/lgame_data.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
// import 'package:flutter_html/flutter_html.dart';
import '../di.dart';

import 'game_board.dart';
import './utils/util_dialog.dart';

class LGameSessionTitle {
  String title;
  LGameSessionData data;
  bool isExpanded;

  LGameSessionTitle(
      this.title,
      this.data,
      [this.isExpanded = false]
      );
}

class OldGamesPage extends StatelessWidget {
  final Widget child;
  final Color? color;

  const OldGamesPage({super.key,
    required this.child,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 20),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Theme.of(context).dividerColor)),
        color: color,
      ),
      child: child,
    );
  }
}

const TextStyle textStyle = TextStyle(fontSize: 20,
    color: Colors.orangeAccent, backgroundColor: Colors.black);

class OldGamesRoute extends StatefulWidget {
  const OldGamesRoute({super.key});

  @override
  State<OldGamesRoute> createState() => _OldGamesState();
}

class _OldGamesState extends State<OldGamesRoute> {

  final ButtonStyle buttonStyle =
  ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20),
      backgroundColor: Colors.amberAccent);

  Future<Null> _fetchPartner() async {
    print('Please Wait');
  }

  List<LGameSessionData>? listDataSessions;
  List<LGameSessionTitle>? _dataTitles;
  LGameSessionData? selectedSessionData;
  LGameSession lGameSession = LGameSession();
  int selectedIndex = -1, prevIndexExpanded = -1;
  ExpansionTileController? selectedExpansionTile;
  List<ExpansionTileController>? expansionControllers;
  bool bUnderCollapse = false;
  SelectedLGameSessionData? selectedLGameSessionData;
  bool bScreenReaderIsUsed = false;

  int getModified(LGameSessionData a, LGameSessionData b)
  {
    a.modifiedAt ??= DateTime.parse(a.startedAt!);
    b.modifiedAt ??= DateTime.parse(b.startedAt!);
    return a.modifiedAt!.compareTo(b.modifiedAt!);
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
        ret.add(LGameSessionTitle(data.modifiedAt != null ?
            data.modifiedAt!.toString()
            : data.startedAt!, data));
      }
    }
    return ret;
  }

  updateTileControllers()
  {
    if (_dataTitles != null && _dataTitles!.isNotEmpty) {
      expansionControllers = List.generate(
        _dataTitles!.length,
            (index) => ExpansionTileController(),
      );
    }
  }

  setInitDataList() async
  {
    listDataSessions = di<LGameDateService>().getLGameSessionDatasUnfinished();
    setState(() {
      if (listDataSessions != null) {
        _dataTitles = getSteps();
      }
    });
    //

    updateTileControllers();
  }

  @override
  void initState() {
    super.initState();
    setInitDataList();
    lGameSession.initState();
  }

  @override
  Widget build(BuildContext context) {


    final mediaQueryData = MediaQuery.of(context);
    if (mediaQueryData.accessibleNavigation) {
      bScreenReaderIsUsed = true;
    } else {
      bScreenReaderIsUsed = false;
    }
 /* SystemChrome.setSystemUIOverlayStyle(
  const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
  );
  */
    final ButtonStyle buttonStyle =
    ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 15),
        backgroundColor: Colors.amberAccent);

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
      return showYesNoDialog(thisContext, "Delete old game", "Cancel", "Continue",
          "Would you like to delete a old L game?", bCancelReturnValue,
          bContinueReturnValue);
    }


    Widget _renderOldGames() {
      return Flexible(child:
      ListView.builder(
          itemCount: _dataTitles!.length,
          itemBuilder: (context, index) {
            return Card(
              child: Row(children: [
                Flexible(
                flex: 1,
                child: ExpansionTile(
                  key: Key(index.toString()), //attention
                  initiallyExpanded: selectedIndex == index,
                  controller: expansionControllers![index],
                  title: Text(_dataTitles![index].title),
                  children: [
                    Text(_dataTitles![index].data.name1 != null
                        ? "Player 1: ${_dataTitles![index].data.name1!}"
                        : '', style: const TextStyle(fontSize: 15)),
                    const SizedBox(
                      height: 5.0,
                    ),
                    Text(_dataTitles![index].data.name2 != null
                        ? "Player 2: ${_dataTitles![index].data.name2!}"
                        : '', style: TextStyle(fontSize: 15)),
                  ],
                  onExpansionChanged: (newState) {
                    if (bUnderCollapse)
                    {
                         return;
                    }
                    setState(() {
                      selectedSessionData = _dataTitles![index].data;
                      if (newState) {
                        selectedIndex = index;
                        if (prevIndexExpanded != index && prevIndexExpanded != -1)
                        {
                            bUnderCollapse = true;
                            expansionControllers![prevIndexExpanded].collapse();
                            bUnderCollapse = false;
                      }
                        prevIndexExpanded = index;
                      //  selectedExpansionTile = ExpansionTileController.of(context);
                      }
                      else {
                        selectedIndex = -1;
                      }
                      lGameSession.setStartGameAfterOldGame(
                          selectedSessionData!);
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
                      await di<LGameDateService>().deleteLGameSessionData(
                        _dataTitles![index].data);
                      setState(() {
                        _dataTitles!.remove(_dataTitles![index]);
                        updateTileControllers();
                        selectedSessionData = null;
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

  return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Unfinished games', /* style: textStyle, */),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
     /*   centerTitle: true, */
        actions: [
          ElevatedButton(
            style: buttonStyle,
            child: const Text(
              'Select game',
            ),
            onPressed: () async {
              selectedLGameSessionData = SelectedLGameSessionData(selectedSessionData);
              di<LGameDateService>().selectedLGameSessionData = selectedLGameSessionData;
             // Navigator.pushNamedAndRemoveUntil(context, "/lgamefor2", ModalRoute.withName('/lgamefor2'));
              Navigator.pop(context, selectedLGameSessionData);
            //  Navigator.pushAndRemoveUntil(context,  MaterialPageRoute(builder: (context) => SecondPage(title : "Hello World")), (route) => false);
            },
          ),
        ],
      ),
      body:   listDataSessions != null ?
          Column( crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
          Container(
                  child: _renderOldGames(),
                ),
            selectedSessionData != null ?
            LGameBoard(lGameSession: lGameSession,
                bScreenReaderIsUsed: bScreenReaderIsUsed)
        : Container(child: Text("No selected session")),
              const SizedBox(height: 10, width: 100,),
        ],
           )

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
      ) */ : Container(child: const Center(child:  Text('No old unfinished l games.',
         style: TextStyle(fontSize: 30),),),),
      );
  }
  }


class FinishedGamesRoute extends StatefulWidget {
  const FinishedGamesRoute({super.key});

  @override
  State<FinishedGamesRoute> createState() => _FinishedGamesState();
}

class _FinishedGamesState extends State<FinishedGamesRoute> {

  final ButtonStyle buttonStyle =
  ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20),
      backgroundColor: Colors.amberAccent);

  Future<Null> _fetchPartner() async {
    print('Please Wait');
  }

  List<LGameSessionData>? listDataSessions;
  List<LGameSessionTitle>? _dataTitles;
  LGameSessionData? selectedSessionData;
  LGameSession lGameSession = LGameSession();
  int selected_index = -1, prevIndexExpanded = -1;
  ExpansionTileController? selectedExpansionTile;
  List<ExpansionTileController>? expansionControllers;
  bool bUnderCollapse = false;
  SelectedLGameSessionData? selectedLGameSessionData;
  bool bScreenReaderIsUsed = false;

  int getModified(LGameSessionData a, LGameSessionData b)
  {
    a.modifiedAt ??= DateTime.parse(a.startedAt!);
    b.modifiedAt ??= DateTime.parse(b.startedAt!);
    return a.modifiedAt!.compareTo(b.modifiedAt!);
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
        ret.add(LGameSessionTitle(data.startedAt!, data));
      }
    }
    return ret;
  }

  updateTileControllers()
  {
    if (_dataTitles != null && _dataTitles!.length > 0) {
      expansionControllers = List.generate(
        _dataTitles!.length,
            (index) => ExpansionTileController(),
      );
    }
  }

  setInitDataList() async
  {
    listDataSessions = di<LGameDateService>().getLGameSessionDataFinished();
    setState(() {
      if (listDataSessions != null) {
        _dataTitles = getSteps();
      }
    });
    //

    updateTileControllers();
  }

  @override
  void initState() {
    super.initState();
    setInitDataList();
    lGameSession.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);
    if (mediaQueryData.accessibleNavigation) {
      bScreenReaderIsUsed = true;
    } else {
      bScreenReaderIsUsed = false;
    }

    /* SystemChrome.setSystemUIOverlayStyle(
  const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
  );
  */
    final ButtonStyle buttonStyle =
    ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 15),
        backgroundColor: Colors.amberAccent);

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
      return showYesNoDialog(thisContext, "Delete a game", "Cancel", "Continue",
          "Would you like to delete a finished L game?", bCancelReturnValue,
          bContinueReturnValue);
    }


    Widget _renderFinishedGames() {
      return Flexible(child:
      ListView.builder(
          itemCount: _dataTitles!.length,
          itemBuilder: (context, index) {
            return Card(
              child: Row(children: [
                Flexible(
                  flex: 1,
                  child: ExpansionTile(
                      key: Key(index.toString()), //attention
                      initiallyExpanded: selected_index == index,
                      controller: expansionControllers![index],
                      title: Text(_dataTitles![index].title),
                      children: [
                        Text(_dataTitles![index].data.name1 != null
                            ? "Player 1: ${_dataTitles![index].data.name1!}"
                            : '', style: const TextStyle(fontSize: 15)),
                        const SizedBox(
                          height: 5.0,
                        ),
                        Text(_dataTitles![index].data.name2 != null
                            ? "Player 2: ${_dataTitles![index].data.name2!}"
                            : '', style: TextStyle(fontSize: 15)),
                      ],
                      onExpansionChanged: (newState) {
                        if (bUnderCollapse)
                        {
                          return;
                        }
                        setState(() {
                          selectedSessionData = _dataTitles![index].data;
                          if (newState) {
                            selected_index = index;
                            if (prevIndexExpanded != index && prevIndexExpanded != -1)
                            {
                              bUnderCollapse = true;
                              expansionControllers![prevIndexExpanded].collapse();
                              bUnderCollapse = false;
                            }
                            prevIndexExpanded = index;
                            //  selectedExpansionTile = ExpansionTileController.of(context);
                          }
                          else {
                            selected_index = -1;
                          }
                          lGameSession.setStartGameAfterOldGame(
                              selectedSessionData!);
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
                      await di<LGameDateService>().deleteLGameSessionData(
                          _dataTitles![index].data);
                      setState(() {
                        _dataTitles!.remove(_dataTitles![index]);
                        updateTileControllers();
                        selectedSessionData = null;
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

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Finished games', /* style: textStyle, */),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        /*   centerTitle: true, */
        actions: const [
        ],
      ),
      body:   listDataSessions != null ?
      Column( crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            child: _renderFinishedGames(),
          ),
          selectedSessionData != null ?
          LGameBoard(lGameSession: lGameSession,
              bScreenReaderIsUsed: bScreenReaderIsUsed)
              : Container(child: Text("No selected session")),
          const SizedBox(height: 10, width: 100,),
        ],
      )

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
      ) */ : Container(child: const Center(child:  Text('No finished l games.',
        style: TextStyle(fontSize: 30),),),),
    );
  }
}

