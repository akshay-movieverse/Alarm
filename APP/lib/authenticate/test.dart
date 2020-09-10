import "package:flutter/material.dart";
import 'package:new_app/models/user.dart';
import 'package:new_app/pages/wrapper.dart';
import 'package:new_app/services/auth.dart';
import 'package:provider/provider.dart';

class Test extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<Users>.value(
      value: AuthService().user,
      child: MaterialApp(
        initialRoute: '/',
        routes: {
          '/': (context) => Wrapper(), //startScreen(),
        },
      ),
    );
  }
}
