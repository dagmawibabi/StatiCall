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
          Text("Number Of Control Calls:"),
          ElevatedButton(
            onPressed: () {
              widget.getCallHistory();
            },
            child: Text(
              "Get Call History",
            ),
          ),
        ],
      ),
    );
  }
}
