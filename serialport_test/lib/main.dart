import 'package:flutter/material.dart';
import 'package:serialport_test/console_app.dart';

import 'dart:ffi';
import 'package:serialport_test/serialport_screen.dart';
import 'package:serialport_test/serialport_screen2.dart';
import 'package:serialport_test/win32.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: ExampleApp(),
    );
  }
}