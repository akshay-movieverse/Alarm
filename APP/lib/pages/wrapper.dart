import 'package:flutter/material.dart';
import 'package:new_app/authenticate/authenticate.dart';
import 'package:new_app/home/home.dart';
import 'package:new_app/models/user.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Users>(context);
    print(user);
    if (user == null) {
      return Authenticate();
    } else {
      return Home();
    }
  }
}
