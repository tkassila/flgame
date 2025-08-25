import 'package:flutter/material.dart';
import '../../services/navigation_service.dart';

Future<bool> showYesNoDialogWithContext(String strTitle, String strCancel,
    String strContinue, String strQuestion,
    bool bCancelReturnValue, bool bContinueReturnValue) async {
      var thisContext = NavigationService.navigatorKey.currentContext;
      return showYesNoDialog(thisContext!, strTitle, strCancel,
          strContinue, strQuestion, bCancelReturnValue, bContinueReturnValue);
    }

Future<bool> showYesNoDialog(BuildContext thisContext,
    String strTitle, String strCancel,
    String strContinue, String strQuestion,
    bool bCancelReturnValue, bool bContinueReturnValue) async {
  Widget cancelButton = Semantics(
      readOnly: true,
      label: strCancel,
      hint: 'Cancel button',
      child: ElevatedButton(
    child: Text(strCancel),
    onPressed:  () {
      Navigator.of(thisContext).pop(bCancelReturnValue);
    },
      ),
  );
  Widget continueButton = Semantics(
      readOnly: true,
      label: strContinue,
      hint: 'Continue button',
      child: ElevatedButton(
    child: Text(strContinue),
    onPressed:  () {
      Navigator.of(thisContext).pop(bContinueReturnValue);
    },
      ),
  );
  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text(strTitle),
    content: Text(strQuestion),
    actions: [
      cancelButton,
      continueButton,
    ],
  );  // show the dialog
  final result = await showDialog<bool?>(
    context: thisContext,
    builder: (BuildContext context) {
      return alert;
    },
  );
  return result ?? false;
}
