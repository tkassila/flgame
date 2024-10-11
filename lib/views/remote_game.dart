
//import 'package:flgame/main.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';

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
    Navigator.pushNamedAndRemoveUntil(context, "/lgamefor2",
            (Route<dynamic> route) => false);
  }

  @override
  Widget build(BuildContext context)
  {
    //  rootBundle = context;
    return MaterialApp(
      title: 'LGame is loading...',
      home: Center( child:  Scaffold(
        /* appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          automaticallyImplyLeading: false,
          title: const Text('LGame is loading...',
            style: TextStyle(fontSize: 30),),
        ),
        */
        body: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.inversePrimary, // const Color(0xffe8e8e8),
            border: Border.all(
              color: Theme.of(context).colorScheme.inversePrimary,
              width: 10,
            ),
          ),
          child: Column(
            children: [
              const SizedBox(height: 150, width: 100),
              const Center(
                child: Text('LGame',
                    style: TextStyle(fontSize: 37, color: Colors.black)),
              ),
              AnimatedOpacity(
                opacity: _visible ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 600),
                child: const Image(
                  height: 300,
                  width: 300,
                  image: AssetImage(
                    'assets/L_Game_start_position.svg.png',
                  ),
                ),
              ),
            ],
          ),
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