import 'package:callstats/providers/call_stats_provider.dart';
import 'package:flutter/material.dart';
import 'package:callstats/screens/single_person_call_stats_screen.dart';
import 'package:provider/provider.dart';

class EachCallStatCard extends StatefulWidget {
  const EachCallStatCard({
    super.key,
    required this.curCall,
    required this.index,
    required this.showDetail,
  });

  final Map curCall;
  final int index;
  final Function showDetail;

  @override
  State<EachCallStatCard> createState() => _EachCallStatCardState();
}

class _EachCallStatCardState extends State<EachCallStatCard> {
  String overallDuration = "";
  String timePhrase = "";
  // Pick the right duration metric
  void calculateOverallDuration() {
    if (double.parse(widget.curCall['totalDurationHours']) >= 1.0) {
      overallDuration = "${widget.curCall['totalDurationHours']}";
      timePhrase = 'hr';
    } else if (double.parse(widget.curCall['totalDurationMinutes']) >= 1.0) {
      overallDuration = "${widget.curCall['totalDurationMinutes']}";
      timePhrase = 'min';
    } else {
      overallDuration = "${widget.curCall['totalDuration']}";
      timePhrase = 'sec';
    }
  }

  @override
  void initState() {
    super.initState();
    calculateOverallDuration();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CallStatsProvider>(
        builder: (context, callStatsProvider, _) {
      return InkWell(
        onLongPress: () {
          widget.showDetail(widget.curCall);
        },
        onTap: () => Navigator.of(context).pushNamed(
          SinglePersonCallStatsScreen.routeName,
          arguments: [
            widget.curCall,
            callStatsProvider.showNumber,
            callStatsProvider.callHistoryOverview,
          ],
        ),
        child: Container(
          padding: const EdgeInsets.all(8),
          margin: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 5),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            // border: Border.all(color: Colors.black),
            borderRadius: const BorderRadius.all(Radius.circular(10.0)),
          ),
          child: Column(
            children: [
              // Name and index
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 220.0,
                    child: Hero(
                      key: UniqueKey(),
                      tag: {"name": widget.curCall["name"]},
                      child: Text(
                        "${widget.index.toString()}. ${(widget.curCall['name'] == "" || widget.curCall['name'] == " " || widget.curCall['name'] == "null") ? "Unknown" : widget.curCall['name']}",
                        maxLines: 1,
                        style: const TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  callStatsProvider.showNumber
                      ? Text(
                          widget.curCall['number'].toString(),
                        )
                      : Container(),
                ],
              ),
              const SizedBox(height: 5.0),
              // Number of calls
              Container(
                padding: const EdgeInsets.all(8),
                margin: const EdgeInsets.symmetric(vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  // border: Border.all(color: Colors.black),
                  borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Total Calls",
                        ),
                        Text(
                          widget.curCall['numOfAllCalls'].toString(),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4.0),
                    // Number of calls
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Overall Duration",
                        ),
                        Text(
                          '${(((double.parse(overallDuration) * 60) / 60).floor().toInt()).toString().padLeft(2, "0")}:${(((double.parse(overallDuration) * 60) % 60).floor().toInt()).toString().padLeft(2, "0")} $timePhrase',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
