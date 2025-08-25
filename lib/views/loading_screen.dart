
//import 'package:flgame/main.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';

class LoadingScreen extends StatefulWidget {
  // final NavigatorState parentNavigator;
  const LoadingScreen({super.key /*, required this.parentNavigator */});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen>
    with SingleTickerProviderStateMixin
{
  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    super.initState();
    Timer(const Duration(seconds: 2), handleTimeout);
  }

  bool _visible = true;

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);
    super.dispose();
  }

    handleTimeout2()
  {
    Navigator.pushNamedAndRemoveUntil(context, "/lgamefor2",
            (Route<dynamic> route) => false);
  }

  handleTimeout()
  {
    setState(() {
      _visible = !_visible;
    });

    Timer(const Duration(milliseconds: 100), handleTimeout2);
    // Navigator.pushNamed(context, "/lgamefor2");
  }

  @override
  Widget build(BuildContext context)
  {
    //  rootBundle = context;
    return MaterialApp(
      title: 'L Game is loading...',
      home: SafeArea(
        minimum: const EdgeInsets.all(16.0),
        child: Center( child:  Scaffold(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
       /* appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          automaticallyImplyLeading: false,
          title: const Text('LGame is loading...',
            style: TextStyle(fontSize: ScreenUtil().setSp(30)),),
        ),
        */
        body: Container(
          decoration: BoxDecoration(
            color: Colors.white70, /* Theme.of(context).colorScheme.primary, */// const Color(0xffe8e8e8),
            border: Border.all(
              color: Theme.of(context).colorScheme.inversePrimary,
              width: 10,
            ),
          ),
    child: Column(
          children: [
            const SizedBox(height: 150, width: 100),
            const Center(
              child: Text('L Game',
                  style: TextStyle(fontSize: 37, color: Colors.black)),
            ),
            AnimatedOpacity(
                opacity: _visible ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 500),
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