import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:worldclockproject/Activities/home.dart';
import 'package:worldclockproject/Activities/location.dart';
import 'package:worldclockproject/Activities/loading.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitDown,DeviceOrientation.portraitUp]);
runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        "/": (context) => Loading(),
        "/home": (context) => Home(),
        "/location": (context) => Location(),
      },
    );
  }
}