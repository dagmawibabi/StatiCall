// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors

import 'package:callstats/routes/components/eachCallStat.dart';
import 'package:flutter/material.dart';

class CallStats extends StatefulWidget {
  const CallStats({
    Key? key,
    required this.rawCallLog,
    required this.classifiedCallLogs,
    required this.showNumber,
    required this.showDetail,
  }) : super(key: key);
  final List classifiedCallLogs;
  final List rawCallLog;
  final bool showNumber;
  final Function showDetail;

  @override
  State<CallStats> createState() => _CallStatsState();
}

class _CallStatsState extends State<CallStats> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: widget.classifiedCallLogs.length,
        itemBuilder: (context, index) {
          return EachCallStatCard(
            curCall: widget.classifiedCallLogs[index],
            index: index + 1,
            showNumber: widget.showNumber,
            showDetail: widget.showDetail,
          );
        },
      ),
    );
  }
}
