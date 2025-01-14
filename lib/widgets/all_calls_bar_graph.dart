import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class AllCallsBarGraph extends StatelessWidget {
  final Map callHistoryOverview;

  const AllCallsBarGraph({super.key, required this.callHistoryOverview});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 270.0,
      width: 390.0,
      child: BarChart(
        BarChartData(
          gridData: const FlGridData(
            drawVerticalLine: false,
            horizontalInterval: 100.0,
          ),
          backgroundColor: Colors.grey[100],
          titlesData: const FlTitlesData(
            topTitles: AxisTitles(
              axisNameWidget: Text(
                "",
              ),
            ),
            bottomTitles: AxisTitles(
              axisNameWidget: Text(
                "",
              ),
            ),
          ),
          minY: 0,
          maxY: [
                int.parse(callHistoryOverview['totalNumOfCalls'].toString()),
                int.parse(
                    callHistoryOverview['totalNumOfMissedCalls'].toString()),
                int.parse(
                    callHistoryOverview['totalNumOfIncomingCalls'].toString()),
                int.parse(
                    callHistoryOverview['totalNumOfOutgoingCalls'].toString()),
                int.parse(
                    callHistoryOverview['totalNumOfRejectedCalls'].toString()),
                int.parse(
                    callHistoryOverview['totalNumOfBlockedCalls'].toString()),
                int.parse(
                    callHistoryOverview['totalNumOfUnknownCalls'].toString()),
              ].reduce(max) +
              10,
          barGroups: [
            BarChartGroupData(
              x: 2,
              barRods: [
                BarChartRodData(
                  // color: Colors.pinkAccent,
                  gradient: const LinearGradient(
                    colors: [
                      Colors.pinkAccent,
                      Colors.pink,
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  width: 12.0,
                  toY: double.parse(
                      (callHistoryOverview['totalNumOfMissedCalls'])
                          .toString()),
                ),
              ],
            ),
            BarChartGroupData(
              x: 2,
              barRods: [
                BarChartRodData(
                  width: 12.0,
                  // color: Colors.greenAccent,
                  gradient: LinearGradient(
                    colors: [
                      Colors.greenAccent,
                      Colors.greenAccent[400]!,
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  toY: double.parse(
                      (callHistoryOverview['totalNumOfIncomingCalls'])
                          .toString()),
                ),
              ],
            ),
            BarChartGroupData(
              x: 2,
              barRods: [
                BarChartRodData(
                  width: 12.0,
                  // color: Colors.blueAccent,
                  gradient: const LinearGradient(
                    colors: [
                      Colors.lightBlueAccent,
                      Colors.blueAccent,
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  toY: double.parse(
                      (callHistoryOverview['totalNumOfOutgoingCalls'])
                          .toString()),
                ),
              ],
            ),
            BarChartGroupData(
              x: 2,
              barRods: [
                BarChartRodData(
                  width: 12.0,
                  color: Colors.red,
                  toY: double.parse(
                      (callHistoryOverview['totalNumOfRejectedCalls'])
                          .toString()),
                ),
              ],
            ),
            BarChartGroupData(
              x: 2,
              barRods: [
                BarChartRodData(
                  width: 12.0,
                  color: Colors.black,
                  toY: double.parse(
                      (callHistoryOverview['totalNumOfBlockedCalls'])
                          .toString()),
                ),
              ],
            ),
            BarChartGroupData(
              x: 2,
              barRods: [
                BarChartRodData(
                  width: 12.0,
                  color: Colors.cyanAccent,
                  toY: double.parse(
                      (callHistoryOverview['totalNumOfUnknownCalls'])
                          .toString()),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
