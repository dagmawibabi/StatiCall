import 'package:callstats/screens/full_screen_details_screen.dart';
import 'package:callstats/screens/home_screen.dart';
import 'package:callstats/screens/landing_screen.dart';
import 'package:callstats/screens/splash_screen.dart';
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
      initialRoute: SplashScreen.routeName,
      routes: {
        SplashScreen.routeName: (context) => const SplashScreen(),
        LandingScreen.routeName: (context) => const LandingScreen(),
        HomeScreen.routeName: (context) => const HomeScreen(),
        FullScreenDetailsScreen.routeName: (context) =>
            const FullScreenDetailsScreen(),
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
