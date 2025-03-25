import 'package:callstats/providers/call_stats_provider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AllCallsPieChart extends StatelessWidget {
  const AllCallsPieChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CallStatsProvider>(
        builder: (context, callStatsProvider, _) {
      final callHistoryOverview = callStatsProvider.callHistoryOverview;

      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            Container(
              width: 250.0,
              height: 250.0,
              padding:
                  const EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                boxShadow: const [
                  BoxShadow(
                    color: Colors.white,
                    blurRadius: 15.0,
                    spreadRadius: 5.0,
                  )
                ],
                // border: Border.all(color: Colors.blueGrey),
                borderRadius: const BorderRadius.all(Radius.circular(300.0)),
              ),
              child: PieChart(
                PieChartData(
                  sections: [
                    PieChartSectionData(
                      color: Colors.pinkAccent,
                      title: callHistoryOverview["totalNumOfMissedCalls"]
                          .toString(),
                      value: double.parse(
                          callHistoryOverview["totalNumOfMissedCalls"]
                              .toString()),
                      titleStyle: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    PieChartSectionData(
                      color: Colors.greenAccent,
                      title: callHistoryOverview["totalNumOfIncomingCalls"]
                          .toString(),
                      value: double.parse(
                          callHistoryOverview["totalNumOfIncomingCalls"]
                              .toString()),
                      titleStyle: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    PieChartSectionData(
                      color: Colors.blue,
                      title: callHistoryOverview["totalNumOfOutgoingCalls"]
                          .toString(),
                      value: double.parse(
                          callHistoryOverview["totalNumOfOutgoingCalls"]
                              .toString()),
                      titleStyle: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    PieChartSectionData(
                      color: Colors.red.shade800,
                      title: callHistoryOverview["totalNumOfRejectedCalls"]
                          .toString(),
                      value: double.parse(
                          callHistoryOverview["totalNumOfRejectedCalls"]
                              .toString()),
                      titleStyle: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    PieChartSectionData(
                      color: Colors.black,
                      title: callHistoryOverview["totalNumOfBlockedCalls"]
                          .toString(),
                      value: double.parse(
                          callHistoryOverview["totalNumOfBlockedCalls"]
                              .toString()),
                      titleStyle: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    PieChartSectionData(
                      color: Colors.cyanAccent,
                      title: callHistoryOverview["totalNumOfUnknownCalls"]
                          .toString(),
                      value: double.parse(
                          callHistoryOverview["totalNumOfUnknownCalls"]
                              .toString()),
                      titleStyle: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Text(
              callHistoryOverview['totalNumOfCalls'].toString(),
              style: const TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      );
    });
  }
}
