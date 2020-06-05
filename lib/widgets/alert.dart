import 'package:flutter/material.dart';

class Alert {
  static Alert shared = Alert();

  showError({BuildContext context, String message, String title}) {
    // set up the button
    Widget cancelButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [cancelButton],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  askYesNo(
      {BuildContext context,
      String message,
      String title,
      String btnTitle,
      Function done}) {
    // set up the button
    Widget cancelButton = FlatButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.pop(context);
        done(false);
      },
    );
    Widget okButton = FlatButton(
      child: Text(btnTitle),
      onPressed: () {
        done(true);
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [okButton, cancelButton],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
