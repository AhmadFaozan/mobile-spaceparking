import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loginlagi/pages/backuphome.dart';
import 'package:loginlagi/pages/camera.dart';
import 'package:loginlagi/pages/login.dart';
import 'package:loginlagi/pages/splashscreen.dart';
// import 'package:camera/camera.dart';

// late List<CameraDescription> cameras;

Future<void> main() async {
  // cameras = await availableCameras();
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: SplashScreen(),
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
