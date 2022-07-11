// ignore_for_file: sized_box_for_whitespace, prefer_const_constructors

import 'package:flutter/material.dart';

class GetCalls extends StatefulWidget {
  const GetCalls({Key? key, required this.getCallHistory}) : super(key: key);
  final Function getCallHistory;

  @override
  State<GetCalls> createState() => _GetCallsState();
}

class _GetCallsState extends State<GetCalls> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Spacer(),
          Text(
            "Hello There!",
            style: TextStyle(
              fontSize: 25.0,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 20.0),
          Image.asset("assets/illustrations/2.png"),
          SizedBox(height: 20.0),
          Text(
            "Ready to analyze your calls?",
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 0.0),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 40.0, vertical: 10.0),
            child: Text(
              "Click the button below to import all your call history and start analyzing",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          SizedBox(height: 10.0),
          ElevatedButton(
            style: ButtonStyle(
              fixedSize: MaterialStateProperty.all(Size(320.0, 50.0)),
              backgroundColor: MaterialStateProperty.all(Colors.grey[900]),
            ),
            onPressed: () {
              widget.getCallHistory();
            },
            child: Text(
              "Get Call History",
              style: TextStyle(
                fontSize: 18.0,
              ),
            ),
          ),
          Spacer(),
          Text(
            "Dream Intelligence",
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.grey[400],
            ),
          ),
          SizedBox(height: 0.0),
          Spacer(),
        ],
      ),
    );
  }
}
