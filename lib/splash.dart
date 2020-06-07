import 'dart:async';
import 'package:flutter/material.dart';
import 'dart:math';

import 'package:yestolbre/src/home_view.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  AnimationController rotationController;
  @override
  void initState() {
    rotationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    //rotationController = AnimationController(duration: Duration(seconds: 5), upperBound: pi * 2, vsync: this);
    rotationController.forward(from: 0.0); // it starts the animation
    super.initState();
    Timer(
        Duration(seconds: 3),
        () => Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (BuildContext context) => HomeView())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.orange,
        body: Center(
            child: Image.asset(
          'assets/icon.png',
          fit: BoxFit.cover,
          height: 250,
          width: 250,
        )));
  }
}