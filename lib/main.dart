import 'dart:io';
import 'package:flutter/material.dart';
import 'package:project271/screens/ClientPage.dart';
import 'package:project271/screens/chooseavailabledates.dart';
import 'package:project271/screens/loadingscreen.dart';
import 'package:project271/screens/nurseadvancedinfo.dart';

void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    routes: {
      '/': (context) => const Loading(),
    },
  ));
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
