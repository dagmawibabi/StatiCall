import 'package:flutter/material.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  void load() {
    Future.delayed(const Duration(milliseconds: 1000), () {
      setState(() {
        Navigator.pushReplacementNamed(context, 'homePage');
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 21, 20, 20),
      body: Column(
        children: [
          Spacer(),
          Spacer(),
          Spacer(),
          Center(
            child: Image.asset(
              'assets/icons/icon.png',
              width: 150.0,
            ),
          ),
          Spacer(),
          Spacer(),
          Column(
            children: [
              Text(
                "Dream Intelligence",
                style: TextStyle(
                  fontSize: 15.0,
                  color: Colors.grey[800],
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                "Version 1.0.0",
                style: TextStyle(
                  fontSize: 12.0,
                  color: Colors.grey[900],
                ),
              ),
            ],
          ),
          Spacer(),
        ],
      ),
    );
  }
}
