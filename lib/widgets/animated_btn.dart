import 'package:flutter/material.dart';

class AnimateBtn extends StatelessWidget {
  final int state;
  final String title;
  AnimateBtn({@required this.state, @required this.title});

  @override
  Widget build(BuildContext context) {
    return setUpButtonChild();
  }

  Widget setUpButtonChild() {
    if (state == 0) {
      return new Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 17.0,
        ),
      );
    } else if (state == 1) {
      return CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
      );
    } else {
      return Icon(Icons.check, color: Colors.white);
    }
  }
}
