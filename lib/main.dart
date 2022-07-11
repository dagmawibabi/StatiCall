// ignore_for_file: prefer_const_constructors

import 'package:callstats/routes/homepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent, //Colors.grey[200],
        statusBarIconBrightness: Brightness.dark,
      ),
    );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
      },
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xFFEEEEEE),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.grey[200],
          elevation: 0.0,
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontSize: 20.0,
          ),
          actionsIconTheme: IconThemeData(
            color: Colors.black,
          ),
          foregroundColor: Colors.black,
        ),
      ),
    );
  }
}
