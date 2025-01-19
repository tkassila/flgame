/*
import 'dart:convert';
import 'dart:html';

import 'package:flutter/material.dart';
// import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter/services.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
*/
import 'dart:async';
import 'dart:ffi';
// import 'dart:nativewrappers/_internal/vm/lib/internal_patch.dart';
// import 'dart:js_interop_unsafe';
import 'package:flutter_html/flutter_html.dart';

import '../models/LGameDataService.dart';
import 'package:intl/intl.dart';

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
    listDataSessions = di<LGameDataService>().getLGameSessionDataUnfinished();
    _dataTitles = null;
    setState(() {
      if (listDataSessions != null) {
        _dataTitles = getSteps();
      }
      updateTileControllers();
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
    listDataSessions = di<LGameDataService>().getLGameSessionDataUnfinished();
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
          "Would you like to delete an old L game?", bCancelReturnValue,
          bContinueReturnValue);
    }

    String _formatTitle(String title)
    {
      if (title == "") {
        return "";
      }
      // .format()
      var dt = DateTime.parse(title);
      String tmp = DateFormat('yyyy-MM-dd hh:mm:ss').format(dt).toString();
      return tmp;
    }

    Widget _renderOldGames() {
      return Flexible(child:
      _dataTitles == null ? Card(margin: EdgeInsets.all(5.0),
        child: Text("No old unfinished games"),) :
      ListView.builder(
          itemCount: _dataTitles!.length,
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
                    ?  Text(_formatTitle(_dataTitles![index].title))
                    : Text(_formatTitle(_dataTitles![index].title), style:
                       const TextStyle(color: Colors.black, fontSize: 20,
                      backgroundColor: Colors.lightGreenAccent ),
                        ),
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
                      if (newState) {
                        selectedSessionData = _dataTitles![index].data;
                        selectedIndex = index;
                        if (prevIndexExpanded != index && prevIndexExpanded != -1)
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
                        initControls();
                        // _dataTitles!.remove(_dataTitles![index]);
                        updateTileControllers();
                        selectedSessionData = null;
                        selectedIndex = -1;
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
          if (listDataSessions == null || listDataSessions!.isEmpty) ElevatedButton(
            style: buttonStyle,
            child: const Text(
              'Back to the game',
            ),
            onPressed: () async {
              selectedLGameSessionData = null;
              di<LGameDataService>().selectedLGameSessionData = null;
              // Navigator.pushNamedAndRemoveUntil(context, "/lgamefor2", ModalRoute.withName('/lgamefor2'));
              Navigator.pop(context, selectedLGameSessionData);
              //  Navigator.pushAndRemoveUntil(context,  MaterialPageRoute(builder: (context) => SecondPage(title : "Hello World")), (route) => false);
            },
          ) else ElevatedButton(
            style: buttonStyle,
            child: const Text(
              'Select game',
            ),
            onPressed: () async {
              if (selectedSessionData != null)
                selectedLGameSessionData = SelectedLGameSessionData(selectedSessionData);
              else
                selectedLGameSessionData = null;
              di<LGameDataService>().selectedLGameSessionData = selectedSessionData;
             // Navigator.pushNamedAndRemoveUntil(context, "/lgamefor2", ModalRoute.withName('/lgamefor2'));
              Navigator.pop(context, selectedLGameSessionData);
            //  Navigator.pushAndRemoveUntil(context,  MaterialPageRoute(builder: (context) => SecondPage(title : "Hello World")), (route) => false);
            },
          ),
        ],
      ),
      body:   listDataSessions == null || listDataSessions!.length == 0 ?
        Card(child: Padding(padding: EdgeInsets.all(5),
        child: const Text("No unfinished games"),),)
          : Column( crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
          Container(
                  child: _renderOldGames(),
                ),
            selectedSessionData != null ?
            Column(children: [
                LGameBoard(lGameSession: lGameSession,
                bScreenReaderIsUsed: bScreenReaderIsUsed),
                SizedBox(height: 20,)
                ],
            )
                : Card(child: null,),
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
      ) */
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
    // a.modifiedAt ??= DateTime.parse(a.startedAt!);
    // b.modifiedAt ??= DateTime.parse(b.startedAt!);
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
    setState(() {
      listDataSessions = di<LGameDataService>().getLGameSessionDataFinished();
      _dataTitles = null;
      if (listDataSessions != null) {
        _dataTitles = getSteps();
      }
      updateTileControllers();
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

    String _formatTime(DateTime dateTime) {
      return DateFormat('hh:mm:ss').format(dateTime);
    }


    String _formatTitle(String title)
    {
      if (title == "") {
        return "";
      }
      // .format()
      var dt = DateTime.parse(title);
      String tmp = DateFormat('yyyy-MM-dd hh:mm:ss').format(dt).toString();
      return tmp;
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
                      backgroundColor: (selected_index == -1 || selected_index != index)
                          ? Colors.white : Colors.lightGreenAccent,
                      key: Key(index.toString()), //attention
                      initiallyExpanded: selected_index == index,
                      controller: expansionControllers![index],
                      title: Text(_formatTitle(_dataTitles![index].title)),
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
                          if (newState) {
                            selectedSessionData = _dataTitles![index].data;
                            selected_index = index;
                            if (prevIndexExpanded != index && prevIndexExpanded != -1)
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
                            selected_index = -1;
                            prevIndexExpanded = -1;
                          }
                          lGameSession.setStartGameAfterOldGame(
                              selectedSessionData!);
                        },);
                      }
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  tooltip: 'Delete a finished game',
                  onPressed: () async {
                    bool bDeleteThisStep = await showDeleteOldGameDialog(
                        context);
                    if (bDeleteThisStep) {
                      di<LGameDataService>().deleteFinishedLGameSessionData(
                          _dataTitles![index].data);
                      setState(() {
                        initControls();
                        // _dataTitles!.remove(_dataTitles![index]);
                        updateTileControllers();
                        selectedSessionData = null;
                        selected_index = -1;
                        prevIndexExpanded = -1;
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
          Container(
          decoration: BoxDecoration(
          color: Colors.white70,
          border: Border.all(
          color: Theme.of(context).colorScheme.inversePrimary,
          width: 20,
          ),
          ),
          child: Column(children: [
            LGameBoard(lGameSession: lGameSession,
              bScreenReaderIsUsed: bScreenReaderIsUsed),
              SizedBox(height: 20),
            ],
          ),
          )
              : Text("No selected session"),
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
      ) */ : const Center(child:  Text('No finished l games.',
        style: TextStyle(fontSize: 30),),),
    );
  }
}

