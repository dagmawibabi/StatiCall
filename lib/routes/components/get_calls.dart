import 'package:flutter/material.dart';

class GetCalls extends StatefulWidget {
  const GetCalls({super.key, required this.getCallHistory});
  final Function getCallHistory;

  @override
  State<GetCalls> createState() => _GetCallsState();
}

class _GetCallsState extends State<GetCalls> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.9,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 30.0),
              const Text(
                "StatiCall", //"👋 Hello There!",
                style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              // Spacer(),
              // const SizedBox(height: 30.0),
              const Text(
                " ", //"👋 Hello There!",
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 20.0),
              Image.asset("assets/illustrations/2.png"),
              const SizedBox(height: 20.0),
              const Text(
                "Ready to analyze your calls?",
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 0.0),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 10.0),
                child: Text(
                  "Click the button below to import all your call history and start analyzing",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              const SizedBox(height: 10.0),
              ElevatedButton(
                style: ButtonStyle(
                  fixedSize: const WidgetStatePropertyAll(Size(230.0, 45.0)),
                  backgroundColor: WidgetStatePropertyAll(Colors.grey[900]),
                ),
                onPressed: () {
                  widget.getCallHistory();
                },
                child: const Text(
                  "Get Call History",
                  style: TextStyle(
                    fontSize: 18.0,
                  ),
                ),
              ),
              const Spacer(),
              Text(
                "Dream Intelligence",
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.grey[400],
                ),
              ),
              const SizedBox(height: 5.0),
              Text(
                "Version 1.0.0",
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.grey[350],
                ),
              ),
              const SizedBox(height: 0.0),
              const Spacer(),
            ],
          ),
        ),
      ],
    );
  }
}
