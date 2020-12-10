import 'package:flutter/material.dart';
import 'package:worldclockproject/Activities/home.dart';
import 'package:worldclockproject/Activities/location.dart';
import 'package:worldclockproject/Activities/loading.dart';

void main() => runApp(MaterialApp(
  routes: {
    "/": (context) => Loading(),
    "/home": (context) => Home(),
    "/location": (context) => Location(),
  },
));