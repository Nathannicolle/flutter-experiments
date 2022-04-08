import 'package:firebasetest/main.dart';
import 'package:firebasetest/routes/UserPage.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static Map<String, WidgetBuilder> _routes = <String, WidgetBuilder>{
    '/': (BuildContext context)=>MyHomePage(title: 'Home'),
    UserPage.routeName: (BuildContext context) => UserPage(title: "UserPage"),
  };

  static getRoutes() => _routes;
}