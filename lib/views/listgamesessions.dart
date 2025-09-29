import 'dart:ffi';

import 'package:flgame/models/lgame_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../di.dart';
import './utils/util_dialog.dart';
import 'package:intl/intl.dart';

import '../models/LGameDataService.dart';
import 'package:flgame/models/lgame_data.dart';
import 'game_board.dart';

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

class LGameSessionTitle2 {
  LGameSessionTitle2({
    required this.id, required this.title, required this.data,
  });

  final int id;
  final String title;
  final LGameSessionData data;
}

typedef LGameSessionFunctionCallback = void Function(
    LGameSessionData deleteGameSesion);
typedef LGameSessionSelectedFunctionCallback = void Function(
    LGameSessionData deleteGameSesion, int selectedIndex);

// stores ExpansionPanel state information
class Item {
  Item({
    required this.id,
    required this.expandedValue,
    required this.headerValue,
  });

  int id;
  String expandedValue;
  String headerValue;
}

class ListGameSessions extends StatefulWidget {
  final String strDeleteTitle;
  final String strDeleteAsk;
  final List<LGameSessionData> listDataSessions;
  /* final */ LGameSessionFunctionCallback lGameSessionRemoveFunctionCallback;
  /* final */ LGameSessionSelectedFunctionCallback lGameSessionSelectedFunctionCallback;
  final ScrollController scrollController;
  final bool bScreenReaderIsUsed;
  final int indexBackgroundColor;
  ListGameSessions({super.key, required this.strDeleteTitle,
    required this.strDeleteAsk,
    required this.listDataSessions,
    required this.lGameSessionRemoveFunctionCallback,
    required this.lGameSessionSelectedFunctionCallback,
    required this.bScreenReaderIsUsed,
    required this.scrollController,
    required this.indexBackgroundColor});

  @override
  State<ListGameSessions> createState() =>
      _ListGameSessionsState();
}

class _ListGameSessionsState
    extends State<ListGameSessions>
{
  List<LGameSessionTitle2> _data = List.empty(growable: true);
  List<ExpansionPanelRadio> _expansionPanelList = List.empty(growable: true);
  LGameSessionData? selectedSessionData;
  LGameSession lGameSession = LGameSession();

  List<LGameSessionTitle2> generateItems() {
    List<LGameSessionTitle2> ret = List.empty(growable: true);
    if (widget.listDataSessions != null && widget.listDataSessions.isNotEmpty)
    {
      int max = widget.listDataSessions.length;
      LGameSessionData? data;
      String title;
      for(int i = 0; i < max; i++)
      {
        data = widget.listDataSessions[i];
        if (data == null) {
          continue;
        }
        title = data.modifiedAt != null ? data.modifiedAt.toString() :
        data.startedAt.toString();
        ret.add(LGameSessionTitle2(id: i, title: title, data: data));
      }
    }

    return ret;
  }

  @override
  void initState() {
    super.initState();
    lGameSession.initState();
    _data = generateItems();
  }

  @override
  void dispose() {
    widget.scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return /* Expanded(child: Column(children: [
       */ RawScrollbar(
        thumbColor: Colors.greenAccent,
        radius: Radius.circular(16),
    thickness: 7,
    child: SingleChildScrollView(
           controller: widget.scrollController,
          child: _buildPanel(),
    /* LGameBoard(lGameSession: lGameSession,
                          bScreenReaderIsUsed: widget.bScreenReaderIsUsed)

    ),
     */
    /*
    if (selectedSessionData != null && widget.listDataSessions.isNotEmpty)
    Expanded( // Expanded_A
    child: LGameBoard(bScreenReaderIsUsed: widget.bScreenReaderIsUsed,
    lGameSession: lGameSession,
    ),

    ),
     */
      /*
    ],
    ),
       */
    ),
    );
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

  Widget _buildPanel() {
    return ExpansionPanelList.radio(
      initialOpenPanelValue: 0,
        dividerColor: Colors.black,
        expandIconColor: Colors.blue,
        expansionCallback: (int index, bool isExpanded) {
     //   if (isExpanded) {
        //  setState(() {
            selectedSessionData = widget.listDataSessions[index];
            if (selectedSessionData != null) {
              lGameSession.setStartGameAfterOldGame(selectedSessionData!);
              widget.lGameSessionSelectedFunctionCallback(selectedSessionData!, index);
            }
          //     });
        },
        children: _buildExpansionPanelList(),
    );
  }

  List<ExpansionPanelRadio> _buildExpansionPanelList()
  {
     int index = 0;
     _expansionPanelList = _data.map<ExpansionPanelRadio>((LGameSessionTitle2 item) {
       ExpansionPanelRadio ret = ExpansionPanelRadio(
         splashColor: Colors.greenAccent,
         canTapOnHeader: true,
         backgroundColor: widget.indexBackgroundColor == -1 ? Colors.white
          : (index == widget.indexBackgroundColor ? Colors.lightGreen : Colors.white),
         highlightColor: Colors.greenAccent,
         value: item.id,
         headerBuilder: (BuildContext context, bool isExpanded) {
           return ListTile(
             title: Text(formatTitle(item.title), style: TextStyle(backgroundColor:
             isExpanded ? Colors.lightGreen :
             Colors.white, fontWeight: FontWeight.bold,
                 fontSize: ScreenUtil().setSp(16) ),
             ),
             //   },),
             onTap: () {
               // setState(() {
               //           setState(() {
               selectedSessionData = item.data;
               if (selectedSessionData != null) {
                 lGameSession.setStartGameAfterOldGame(selectedSessionData!);
                 widget.lGameSessionSelectedFunctionCallback(
                     selectedSessionData!, _data.indexOf(item));
               }
               //         });
               // });
             },
           );
         },
         body: /* InkWell(  onTap: () {
            // setState(() {
            setState(() {
              selectedSessionData = item.data;
              if (selectedSessionData != null) {
              lGameSession.setStartGameAfterOldGame(selectedSessionData!);
              widget.lGameSessionSelectedFunctionCallback(selectedSessionData!);
            }
            });
            //  });
            },
            child: */ Column(
           spacing: 0.1,
           children: [
             Text(item.data.name1 != null
                 ? "Player 1: ${item.data.name1}"
                 : '', style: TextStyle(backgroundColor:  Colors.lightGreen ,
                 fontWeight: FontWeight.bold,
                 fontSize: ScreenUtil().setSp(16) )),
             const SizedBox(
               height: 5.0,
             ),
             Text(item.data.name2 != null
                 ? "Player 2: ${item.data.name2}"
                 : '', style: TextStyle(backgroundColor: Colors.lightGreen ,
                 fontWeight: FontWeight.bold,
                 fontSize: ScreenUtil().setSp(16) )),
             const Text('To delete this game session, tap the trash can icon'),
             InkWell(child: const Icon(Icons.delete, size: 34,),
                 onTap: () async {
                   bool bCancelReturnValue = false;
                   bool bContinueReturnValue = true;
                   bool boolResult = await showYesNoDialogWithContext(widget.strDeleteTitle,
                       "Cancel", "Continue", widget.strDeleteAsk, bCancelReturnValue,
                       bContinueReturnValue);
                   if (boolResult) {
                     setState(() {
                       _data.removeWhere((LGameSessionTitle2 currentItem) =>
                       item == currentItem);
                       widget.lGameSessionRemoveFunctionCallback(item.data);
                     });
                   }
                 }
             ),
           ],
         ),
         // ),
       );
       index++;
       return ret;
     }  ).toList();
     return _expansionPanelList;
  }
}