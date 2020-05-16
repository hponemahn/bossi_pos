import 'package:flutter/material.dart';
import 'package:bossi_pos/page/login.dart';
import 'package:bossi_pos/page/register.dart';
import 'package:bossi_pos/page/home.dart';

final routes = {
  "/"    : (BuildContext context) => new LoginPage(),
  "/register"    : (BuildContext context) => new RegisterPage(),
  "/home"    : (BuildContext context) => new HomePage(),
};

class Routes {
  static const String login = LoginPage.routeName;
  static const String register = LoginPage.routeName;
  static const String home = LoginPage.routeName;
}