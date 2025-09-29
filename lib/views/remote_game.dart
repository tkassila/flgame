
//import 'package:flgame/main.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RemoteGamesRoute extends StatefulWidget {
  // final NavigatorState parentNavigator;
  const RemoteGamesRoute({super.key /*, required this.parentNavigator */});

  @override
  State<RemoteGamesRoute> createState() => _RemoteGamesRouteState();
}

class _RemoteGamesRouteState extends State<RemoteGamesRoute>
{
  @override
  void initState() {
    super.initState();
  }

  bool _visible = true;

  @override
  void dispose() {
    super.dispose();
  }

  callMainPage()
  {
    Navigator.pop(context, );
  }

  final ButtonStyle buttonStyle =
  ElevatedButton.styleFrom(textStyle:
  TextStyle(fontSize: ScreenUtil().setSp(13),
      fontWeight: FontWeight.bold),
      backgroundColor: Colors.amberAccent);

  @override
  Widget build(BuildContext context)
  {
    //  rootBundle = context;
    return SafeArea(
        minimum: const EdgeInsets.all(4.0),
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        // leadingWidth: MediaQuery.of(context).padding.top,
        primary: false,
        title: Text('About LGame', style: TextStyle(fontSize: 20,
            color: Colors.white) /* style: textStyle, */),
        centerTitle: false,
        actions: [
          Padding(padding: const EdgeInsets.only(top: 5.0, right: 10.0),
            child: ElevatedButton(
              style: buttonStyle,
              child: const Text(
                'Back',
              ),
              onPressed: () {
                callMainPage();
              },
            ),
          ),
        ],
      ),
      body: Container(
          decoration: BoxDecoration(
            color: Colors.white70, /* Theme.of(context).colorScheme.primary, */// const Color(0xffe8e8e8),
            border: Border.all(
              color: Theme.of(context).colorScheme.inversePrimary,
              width: 10,
            ),
          ),
          child: Column(
            children: <Widget>[
              Container(
                width: double.infinity,
                height: 200.0,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Colors.blue, Colors.green],
                  ),
                ),
              ),
              const SizedBox(height: 150, width: 100),
              const Center(
                child: Text('L Game',
                    style: TextStyle(fontSize: 37, color: Colors.black)),
              ),
              Image( image:
              AssetImage('assets/L_Game_start_position.svg.png', ),
              ),
              Center(
                child: Text('copyright Tuomas Kassila',
                    style: TextStyle(fontSize: 20, color: Colors.black)),
              ),
              Center(
                child: Text('version 1.1',
                    style: TextStyle(fontSize: 20, color: Colors.black)),
              ),

            ],
          ),
        ),
      ),
    );
  }
}

/*

class HelpRoute extends StatefulWidget {
  const HelpRoute({super.key});

  @override
  State<HelpRoute> createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpRoute> {
 // late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController();
    _controller.loadFlutterAsset('assets/help.html');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WebViewWidget(controller: _controller),
    );
  }
}
 */