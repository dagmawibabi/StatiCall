import 'package:callstats/providers/call_stats_provider.dart';
import 'package:callstats/providers/year_wrapped_provider.dart';
import 'package:callstats/screens/single_person_call_stats_screen.dart';
import 'package:callstats/screens/home_screen.dart';
import 'package:callstats/screens/landing_screen.dart';
import 'package:callstats/screens/splash_screen.dart';
import 'package:callstats/screens/wrapped_intro_screen.dart';
import 'package:callstats/screens/wrapped_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => CallStatsProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => YearWrappedProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: SplashScreen.routeName,
        routes: {
          SplashScreen.routeName: (_) => const SplashScreen(),
          LandingScreen.routeName: (_) => const LandingScreen(),
          HomeScreen.routeName: (_) => const HomeScreen(),
          SinglePersonCallStatsScreen.routeName: (_) =>
              const SinglePersonCallStatsScreen(),
          WrappedIntroScreen.routeName: (_) => const WrappedIntroScreen(),
          WrappedScreen.routeName: (_) => const WrappedScreen(),
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
      ),
    );
  }
}
