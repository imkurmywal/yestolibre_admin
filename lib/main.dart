import 'package:flutter/material.dart';
import 'package:yestolibre_admin/splash.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'YesToLibre Admin',
      theme: ThemeData(
        primaryColor: Color(0xffFF5C27),
        accentColor: Color(0xffFF5C27),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SplashScreen(),
    );
  }
}
