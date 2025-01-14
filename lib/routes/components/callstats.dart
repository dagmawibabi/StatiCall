import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import 'package:callstats/routes/components/each_call_stat.dart';
import 'package:callstats/widgets/graph_indicators.dart';

class CallStats extends StatefulWidget {
  const CallStats({
    super.key,
    required this.rawCallLog,
    required this.classifiedCallLogs,
    required this.showNumber,
    required this.showDetail,
    required this.callHistoryOverview,
    required this.swapSort,
  });

  final List classifiedCallLogs;
  final List rawCallLog;
  final bool showNumber;
  final Function showDetail;
  final Map callHistoryOverview;
  final Function swapSort;

  @override
  State<CallStats> createState() => _CallStatsState();
}

class _CallStatsState extends State<CallStats> {
  int curPage = 0;
  int sortIndex = 0;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: widget.classifiedCallLogs.length,
      itemBuilder: (context, index) {
        return Column(
          children: [
            // Graph Title
            index == 0
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 10.0, top: 5.0, bottom: 5.0),
                            child: Icon(
                              Icons.bar_chart,
                              color: Colors.grey[600],
                            ),
                          ),
                          const SizedBox(width: 5.0),
                          Text(
                            "Graphs",
                            style: TextStyle(
                              fontSize: 14.0,
                              color: Colors.grey[700],
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 12.0),
                        child: Text(
                          "${curPage + 1}/2",
                          style: TextStyle(
                            fontSize: 12.0,
                            color: Colors.grey[700],
                          ),
                        ),
                      ),
                    ],
                  )
                : Container(),
            // Pages
            index == 0
                ? Container(
                    height: 470.0,
                    padding: const EdgeInsets.only(top: 8.0),
                    child: PageView(
                      onPageChanged: (value) {
                        curPage = value;
                        setState(() {});
                      },
                      children: [
                        pieChart(),
                        barGraph(),
                      ],
                    ),
                  )
                : Container(),
            // Page Indicator
            index == 0
                ? Container(
                    padding: const EdgeInsets.only(bottom: 30.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 5.0,
                          height: 5.0,
                          decoration: BoxDecoration(
                            color: curPage == 0
                                ? Colors.blueAccent
                                : Colors.grey[400],
                            borderRadius: const BorderRadius.all(
                              Radius.circular(20.0),
                            ),
                          ),
                        ),
                        const SizedBox(width: 5.0),
                        Container(
                          width: 5.0,
                          height: 5.0,
                          decoration: BoxDecoration(
                            color: curPage == 1
                                ? Colors.blueAccent
                                : Colors.grey[400],
                            borderRadius: const BorderRadius.all(
                              Radius.circular(20.0),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : Container(),
            // All Calls
            index == 0
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 10.0, bottom: 5.0),
                            child: Icon(
                              Icons.person_outline,
                              color: Colors.grey[600],
                            ),
                          ),
                          const SizedBox(width: 5.0),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 0.0, bottom: 5.0),
                            child: Text(
                              "All Calls",
                              style: TextStyle(
                                fontSize: 15.0,
                                color: Colors.grey[700],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(right: 10.0, bottom: 5.0),
                        child: DropdownButton(
                          value: sortIndex,
                          elevation: 0,
                          icon: Padding(
                            padding: const EdgeInsets.only(left: 5.0),
                            child: Icon(
                              Icons.sort,
                              color: Colors.grey[700],
                            ),
                          ),
                          isDense: true,
                          style: TextStyle(
                            fontSize: 14.0,
                            color: Colors.grey[800],
                          ),
                          iconSize: 20.0,
                          // itemHeight: 40.0,
                          items: const [
                            DropdownMenuItem(
                              value: 0,
                              child: Text(
                                "All Calls",
                              ),
                            ),
                            DropdownMenuItem(
                              value: 6,
                              child: Text(
                                "Missed Calls",
                              ),
                            ),
                            DropdownMenuItem(
                              value: 7,
                              child: Text(
                                "Incoming Calls",
                              ),
                            ),
                            DropdownMenuItem(
                              value: 8,
                              child: Text(
                                "Outgoing Calls",
                              ),
                            ),
                            DropdownMenuItem(
                              value: 9,
                              child: Text(
                                "Rejected Calls",
                              ),
                            ),
                            DropdownMenuItem(
                              value: 10,
                              child: Text(
                                "Blocked Calls",
                              ),
                            ),
                            DropdownMenuItem(
                              value: 11,
                              child: Text(
                                "Unknown Calls",
                              ),
                            ),
                            DropdownMenuItem(
                              value: 1,
                              child: Text(
                                "Total Duration",
                              ),
                            ),
                            DropdownMenuItem(
                              value: 2,
                              child: Text(
                                "Max Duration",
                              ),
                            ),
                            DropdownMenuItem(
                              value: 3,
                              child: Text(
                                "Min Duration",
                              ),
                            ),
                            DropdownMenuItem(
                              value: 4,
                              child: Text(
                                "Oldest Date",
                              ),
                            ),
                            DropdownMenuItem(
                              value: 5,
                              child: Text(
                                "Newest Date",
                              ),
                            )
                          ],
                          onChanged: (dynamic value) {
                            sortIndex = value;
                            widget.swapSort(value);
                          },
                        ),
                      ),
                    ],
                  )
                : Container(),
            EachCallStatCard(
              curCall: widget.classifiedCallLogs[index],
              index: index + 1,
              showNumber: widget.showNumber,
              showDetail: widget.showDetail,
              allCalls: widget.callHistoryOverview,
            ),
            index == widget.classifiedCallLogs.length - 1
                ? Column(children: [
                    const SizedBox(height: 150.0),
                    // End
                    Text(
                      "End of Contacts",
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.grey[400],
                      ),
                    ),
                    const SizedBox(height: 50.0),
                  ])
                : const SizedBox.shrink(),
          ],
        );
      },
    );
  }

  // Bar Graph
  Widget barGraph() {
    return Column(children: [
      overViewGraph(widget.callHistoryOverview),
      const SizedBox(height: 20.0),
      // Indicators
      const Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GraphIndicators(color: Colors.pinkAccent, text: "Missed"),
          GraphIndicators(color: Colors.greenAccent, text: "Incoming"),
          GraphIndicators(color: Colors.blue, text: "Outgoing"),
        ],
      ),
      const SizedBox(height: 20.0),
      const Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GraphIndicators(color: Colors.red, text: "Rejected"),
          GraphIndicators(color: Colors.black, text: "Blocked"),
          GraphIndicators(color: Colors.cyanAccent, text: "Unknown"),
        ],
      ),
      const SizedBox(height: 30.0),
    ]);
  }

  // Overview Graph
  Widget overViewGraph(Map callHistoryOverview) {
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

  // PieGraph
  Widget pieChart() {
    return Column(
      children: [
        const SizedBox(height: 18.0),
        Stack(
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
                      title: widget.callHistoryOverview["totalNumOfMissedCalls"]
                          .toString(),
                      value: double.parse(widget
                          .callHistoryOverview["totalNumOfMissedCalls"]
                          .toString()),
                      titleStyle: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    PieChartSectionData(
                      color: Colors.greenAccent,
                      title: widget
                          .callHistoryOverview["totalNumOfIncomingCalls"]
                          .toString(),
                      value: double.parse(widget
                          .callHistoryOverview["totalNumOfIncomingCalls"]
                          .toString()),
                      titleStyle: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    PieChartSectionData(
                      color: Colors.blue,
                      title: widget
                          .callHistoryOverview["totalNumOfOutgoingCalls"]
                          .toString(),
                      value: double.parse(widget
                          .callHistoryOverview["totalNumOfOutgoingCalls"]
                          .toString()),
                      titleStyle: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    PieChartSectionData(
                      color: Colors.red,
                      title: widget
                          .callHistoryOverview["totalNumOfRejectedCalls"]
                          .toString(),
                      value: double.parse(widget
                          .callHistoryOverview["totalNumOfRejectedCalls"]
                          .toString()),
                      titleStyle: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    PieChartSectionData(
                      color: Colors.black,
                      title: widget
                          .callHistoryOverview["totalNumOfBlockedCalls"]
                          .toString(),
                      value: double.parse(widget
                          .callHistoryOverview["totalNumOfBlockedCalls"]
                          .toString()),
                      titleStyle: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    PieChartSectionData(
                      color: Colors.cyanAccent,
                      title: widget
                          .callHistoryOverview["totalNumOfUnknownCalls"]
                          .toString(),
                      value: double.parse(widget
                          .callHistoryOverview["totalNumOfUnknownCalls"]
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
              widget.callHistoryOverview['totalNumOfCalls'].toString(),
              style: const TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        const SizedBox(height: 20.0),
        // Indicators
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GraphIndicators(color: Colors.pinkAccent, text: "Missed"),
            GraphIndicators(color: Colors.greenAccent, text: "Incoming"),
            GraphIndicators(color: Colors.blue, text: "Outgoing"),
          ],
        ),
        const SizedBox(height: 20.0),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GraphIndicators(color: Colors.red, text: "Rejected"),
            GraphIndicators(color: Colors.black, text: "Blocked"),
            GraphIndicators(color: Colors.cyanAccent, text: "Unknown"),
          ],
        ),
        const SizedBox(height: 30.0),
      ],
    );
  }
}
