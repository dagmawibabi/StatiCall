import 'package:callstats/routes/homepage.dart';
import 'package:callstats/routes/landing_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const LandingPage(),
        'homePage': (context) => const HomePage(),
      },
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFEEEEEE),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.grey[200],
          elevation: 0.0,
          titleTextStyle: const TextStyle(
            color: Colors.black,
            fontSize: 20.0,
          ),
          actionsIconTheme: const IconThemeData(
            color: Colors.black,
          ),
          foregroundColor: Colors.black,
        ),
      ),
    );
  }
}
