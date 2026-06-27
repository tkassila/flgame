import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flgame/ParameterValues.dart';
import '../l10n/app_localizations.dart';

final TextStyle textStyle = TextStyle(fontSize: ScreenUtil().setSp(!ScreenValues.isWeb ? 20 : 3),
    color: Colors.orangeAccent, backgroundColor: Colors.black);

class AboutRoute extends StatelessWidget {
  const AboutRoute({super.key});

  @override
  Widget build(BuildContext context) {
    final ButtonStyle buttonStyle =
    ElevatedButton.styleFrom(textStyle: TextStyle(fontSize:
    ScreenUtil().setSp(!ScreenValues.isWeb ? 15 : 3), fontWeight: FontWeight.bold),
        backgroundColor: Colors.amberAccent);

    return SafeArea(
      minimum: const EdgeInsets.all(4.0),
      child: Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        // leadingWidth: MediaQuery.of(context).padding.top,
        primary: false,
        title: Text(AppLocalizations.of(context)!.aboutLGame, style: TextStyle(fontSize: 20,
            color: Colors.white) /* style: textStyle, */),
        centerTitle: false,
        actions: [
          Padding(padding: const EdgeInsets.only(top: 5.0, right: 10.0),
            child: Semantics(
              readOnly: true,
              label: AppLocalizations.of(context)!.back,
              hint: AppLocalizations.of(context)!.backButtonHint,
              child: ElevatedButton(
              style: buttonStyle,
              child: Text(
                AppLocalizations.of(context)!.back,
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
              const SizedBox(height: 150, width: 100),
              Center(
                child: Text(AppLocalizations.of(context)!.lGameTitle,
                    style: TextStyle(fontSize: 37, color: Colors.black)),
              ),
              Image(width: 150,
                height: 150,
                image:
              AssetImage('assets/L_Game_start_position.svg.png', ),
              ),
              Center(
                child: Text(AppLocalizations.of(context)!.copyright,
                    style: TextStyle(fontSize: 20, color: Colors.black)),
              ),
              Center(
                child: Text(AppLocalizations.of(context)!.version('1.1.8'),
                    style: TextStyle(fontSize: 20, color: Colors.black)),
              ),

            ],
          ),
        ),
    ),
    );
  }
}
