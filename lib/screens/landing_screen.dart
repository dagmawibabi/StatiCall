import 'package:callstats/screens/home_screen.dart';
import 'package:flutter/material.dart';

class LandingScreen extends StatefulWidget {
  static const routeName = '/landing';

  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingScreen> {
  void load() {
    Future.delayed(const Duration(milliseconds: 1000), () {
      setState(() {
        Navigator.pushReplacementNamed(context, HomeScreen.routeName);
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
                "Version 1.0.0",
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
