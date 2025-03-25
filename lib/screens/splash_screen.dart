import 'package:flutter/material.dart';
import 'package:callstats/screens/landing_screen.dart';

class SplashScreen extends StatefulWidget {
  static const routeName = '/splash';

  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _LandingPageState();
}

class _LandingPageState extends State<SplashScreen> {
  void load() {
    Future.delayed(const Duration(milliseconds: 1000), () {
      setState(() {
        Navigator.pushReplacementNamed(context, LandingScreen.routeName);
      });
    });
  }

  @override
  void initState() {
    super.initState();
    load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 21, 20, 20),
      body: Column(
        children: [
          const Spacer(),
          const Spacer(),
          const Spacer(),
          Center(
            child: Image.asset(
              'assets/icons/icon.png',
              width: 150.0,
            ),
          ),
          const Spacer(),
          const Spacer(),
          Column(
            children: [
              Text(
                "Dream Intelligence",
                style: TextStyle(
                  fontSize: 15.0,
                  color: Colors.grey[800],
                ),
              ),
              const SizedBox(height: 10.0),
              Text(
                "Version 2.0.0",
                style: TextStyle(
                  fontSize: 12.0,
                  color: Colors.grey[900],
                ),
              ),
            ],
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
