import 'package:flutter/material.dart';
import 'package:jpy_minimize_your_change/result.dart';
import 'package:jpy_minimize_your_change/input.dart';
import 'package:jpy_minimize_your_change/home.dart';

void main() {
  runApp(new MaterialApp(
    initialRoute: '/',
    title: 'Navigation with Routes',
    theme: ThemeData(
      visualDensity: VisualDensity.adaptivePlatformDensity,
      primarySwatch: Colors.blue,
    ),
    routes: <String, WidgetBuilder>{
      '/': (_) => new Home(),
      '/input': (_) => new Input(),
      '/result': (_) => new Result(),
    },
  ));
}