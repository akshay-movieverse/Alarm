import 'package:flutter/material.dart';
import 'package:new_app/pages/startScreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => StartScreen(),
      },
    );
  }
}
