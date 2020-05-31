import 'package:flutter/material.dart';
import 'package:yestolibre_admin/src/add_partner.dart';
import 'package:yestolibre_admin/src/home_view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'YesToLibre Admin',
      theme: ThemeData(
        primaryColor: Color(0xffFF5C27),
        accentColor: Color(0xffFF5C27),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: AddPartner(),
    );
  }
}
