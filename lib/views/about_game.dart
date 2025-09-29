import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

final TextStyle textStyle = TextStyle(fontSize: ScreenUtil().setSp(20),
    color: Colors.orangeAccent, backgroundColor: Colors.black);

class AboutRoute extends StatelessWidget {
  const AboutRoute({super.key});

  @override
  Widget build(BuildContext context) {
    final ButtonStyle buttonStyle =
    ElevatedButton.styleFrom(textStyle: TextStyle(fontSize:
    ScreenUtil().setSp(15), fontWeight: FontWeight.bold),
        backgroundColor: Colors.amberAccent);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        // leadingWidth: MediaQuery.of(context).padding.top,
        primary: false,
        title: Text('About LGame', style: TextStyle(fontSize: 20,
            color: Colors.white) /* style: textStyle, */),
        centerTitle: false,
        actions: [
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
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(context, "/lgamefor2",
                    ModalRoute.withName('/lgamefor2'));
              },
            ),
          ),
          ),
        ],
      ),
      body: SafeArea(
        minimum: const EdgeInsets.all(4.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white70, /* Theme.of(context).colorScheme.primary, */// const Color(0xffe8e8e8),
            border: Border.all(
              color: Theme.of(context).colorScheme.inversePrimary,
              width: 10,
            ),
          ),
          child: Column(
            children: <Widget>[
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
                child: Text('version 1.1.1',
                    style: TextStyle(fontSize: 20, color: Colors.black)),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
