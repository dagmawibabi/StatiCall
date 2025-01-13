import 'dart:math';

import 'package:callstats/routes/components/graohIndicators.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class FullScreenDetail extends StatefulWidget {
  const FullScreenDetail({
    super.key,
    required this.curCall,
    required this.showNumber,
    required this.allCalls,
  });

  final Map curCall;
  final bool showNumber;
  final Map allCalls;

  @override
  State<FullScreenDetail> createState() => _FullScreenDetailState();
}

class _FullScreenDetailState extends State<FullScreenDetail> {
  int curPage = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        centerTitle: true,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: widget.showNumber ? 5.0 : 15.0),
            Hero(
              key: UniqueKey(),
              tag: {"name": widget.curCall["name"]},
              child: Text(
                widget.curCall["name"],
                style: const TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(height: widget.showNumber ? 2.0 : 10.0),
            widget.showNumber
                ? Text(
                    widget.curCall["number"],
                    style: TextStyle(
                      fontSize: 12.0,
                      color: Colors.grey[800],
                    ),
                  )
                : Container(),
          ],
        ),
        actions: [
          SizedBox(width: widget.showNumber ? 0.0 : 50.0),
        ],
      ),
      body: ListView(
        shrinkWrap: true,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              // border: Border.all(color: Colors.black),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              ),
            ),
            child: Column(
              children: [
                const SizedBox(height: 0.0),
                SizedBox(
                  height: 470.0,
                  child: PageView(
                    scrollDirection: Axis.horizontal,
                    pageSnapping: true,
                    onPageChanged: (value) {
                      curPage = value;
                      setState(() {});
                    },
                    children: [
                      graph(),
                      barGraph(),
                    ],
                  ),
                ),
                const SizedBox(height: 0.0),
                // Page Indicator
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 5.0,
                      height: 5.0,
                      decoration: BoxDecoration(
                        color:
                            curPage == 0 ? Colors.blueAccent : Colors.grey[400],
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
                        color:
                            curPage == 1 ? Colors.blueAccent : Colors.grey[400],
                        borderRadius: const BorderRadius.all(
                          Radius.circular(20.0),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10.0),
                // Duration Stats
                Column(children: [
                  eachDetailDuration(
                    "Total Duration",
                    widget.curCall["totalDuration"].toString(),
                    widget.curCall["totalDurationMinutes"].toString(),
                    widget.curCall["totalDurationHours"].toString(),
                    Icons.upgrade_outlined,
                  ),
                  eachDetailDuration(
                    "Maximum Duration",
                    widget.curCall["maxDuration"].toString(),
                    widget.curCall["maxDurationMinutes"].toString(),
                    widget.curCall["maxDurationHours"].toString(),
                    Icons.unfold_more_sharp,
                  ),
                  eachDetailDuration(
                    "Minimum Duration",
                    widget.curCall["minDuration"].toString(),
                    widget.curCall["minDurationMinutes"].toString(),
                    widget.curCall["minDurationHours"].toString(),
                    Icons.unfold_less_rounded,
                  ),
                  dateDetail(
                    "Date Range",
                    DateTime.fromMicrosecondsSinceEpoch(
                      widget.curCall["oldestDate"] * 1000,
                    ).toString().substring(0, 10),
                    DateTime.fromMicrosecondsSinceEpoch(
                            widget.curCall["newestDate"] * 1000)
                        .toString()
                        .substring(0, 10),
                    Icons.calendar_month_outlined,
                  ),
                ]),
                const SizedBox(height: 50.0),
                // End
                Text(
                  "End of Analysis",
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.grey[400],
                  ),
                ),
                const SizedBox(height: 30.0),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // PieGraph
  Widget graph() {
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
                      title: widget.curCall["numOfMissedCalls"].toString(),
                      value: double.parse(
                          widget.curCall["numOfMissedCalls"].toString()),
                      titleStyle: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    PieChartSectionData(
                      color: Colors.greenAccent,
                      title: widget.curCall["numOfIncomingCalls"].toString(),
                      value: double.parse(
                          widget.curCall["numOfIncomingCalls"].toString()),
                      titleStyle: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    PieChartSectionData(
                      color: Colors.blue,
                      title: widget.curCall["numOfOutgoingCalls"].toString(),
                      value: double.parse(
                          widget.curCall["numOfOutgoingCalls"].toString()),
                      titleStyle: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    PieChartSectionData(
                      color: Colors.red,
                      title: widget.curCall["numOfRejectedCalls"].toString(),
                      value: double.parse(
                          widget.curCall["numOfRejectedCalls"].toString()),
                      titleStyle: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    PieChartSectionData(
                      color: Colors.black,
                      title: widget.curCall["numOfBlockedCalls"].toString(),
                      value: double.parse(
                          widget.curCall["numOfBlockedCalls"].toString()),
                      titleStyle: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    PieChartSectionData(
                      color: Colors.cyanAccent,
                      title: widget.curCall["numOfUnknownCalls"].toString(),
                      value: double.parse(
                          widget.curCall["numOfUnknownCalls"].toString()),
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
              widget.curCall['numOfAllCalls'].toString(),
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

  // Line Graph
  Widget lineGraph() {
    return const Text(
      "",
    );
  }

  // Duration Triplets
  Container eachDetailDuration(String title, String firstVal, String secondVal,
      String thirdVal, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
      margin: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        // border: Border.all(color: Colors.black),
        borderRadius: const BorderRadius.all(
          Radius.circular(10.0),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Title
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 0.0),
                child: Icon(
                  icon,
                  size: 21.0,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 2.0),
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6.0),
          // Values
          Container(
            padding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
            margin: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              // border: Border.all(color: Colors.black),
              borderRadius: const BorderRadius.all(
                Radius.circular(10.0),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Text(
                      firstVal,
                      style: const TextStyle(
                        fontSize: 17.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 2.0),
                    Text(
                      "sec",
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.grey[700],
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      '${(((double.parse(secondVal) * 60) / 60).floor().toInt()).toString().padLeft(2, "0")}:${(((double.parse(secondVal) * 60) % 60).floor().toInt()).toString().padLeft(2, "0")}',
                      style: const TextStyle(
                        fontSize: 17.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 2.0),
                    Text(
                      "min",
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.grey[700],
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      '${(((double.parse(thirdVal) * 60) / 60).floor().toInt()).toString().padLeft(2, "0")}:${(((double.parse(thirdVal) * 60) % 60).floor().toInt()).toString().padLeft(2, "0")}',
                      style: const TextStyle(
                        fontSize: 17.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 2.0),
                    Text(
                      "hour",
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.grey[700],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Date Detail
  Container dateDetail(
      String title, String firstVal, String secondVal, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
      margin: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        // border: Border.all(color: Colors.black),
        borderRadius: const BorderRadius.all(
          Radius.circular(10.0),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Title
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 4.0),
                child: Icon(
                  icon,
                  size: 17.0,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5.0),
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8.0),
          // Values
          Container(
            padding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
            margin: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              // border: Border.all(color: Colors.black),
              borderRadius: const BorderRadius.all(
                Radius.circular(10.0),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Text(
                      firstVal,
                      style: const TextStyle(
                        fontSize: 17.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 2.0),
                    Text(
                      "from",
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.grey[700],
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      secondVal,
                      style: const TextStyle(
                        fontSize: 17.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 2.0),
                    Text(
                      "to",
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.grey[700],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Bar Graph
  Widget barGraph() {
    return Column(children: [
      overViewGraph(widget.curCall, widget.allCalls),
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
  Widget overViewGraph(Map curCall, Map callHistoryOverview) {
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
          maxY: double.parse((([
                            int.parse(callHistoryOverview['totalNumOfCalls']
                                .toString()),
                            int.parse(
                                callHistoryOverview['totalNumOfMissedCalls']
                                    .toString()),
                            int.parse(
                                callHistoryOverview['totalNumOfIncomingCalls']
                                    .toString()),
                            int.parse(
                                callHistoryOverview['totalNumOfOutgoingCalls']
                                    .toString()),
                            int.parse(
                                callHistoryOverview['totalNumOfRejectedCalls']
                                    .toString()),
                            int.parse(
                                callHistoryOverview['totalNumOfBlockedCalls']
                                    .toString()),
                            int.parse(
                                callHistoryOverview['totalNumOfUnknownCalls']
                                    .toString()),
                          ].reduce(max)) +
                          0)
                      .toString())
                  .roundToDouble() +
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
                  toY: double.parse((curCall['numOfMissedCalls']).toString()),
                ),
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
                  toY: double.parse((curCall['numOfIncomingCalls']).toString()),
                ),
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
                  toY: double.parse((curCall['numOfOutgoingCalls']).toString()),
                ),
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
                  toY: double.parse((curCall['numOfRejectedCalls']).toString()),
                ),
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
                  toY: double.parse((curCall['numOfBlockedCalls']).toString()),
                ),
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
                  toY: double.parse((curCall['numOfUnknownCalls']).toString()),
                ),
                BarChartRodData(
                  width: 12.0,
                  color: Colors.cyanAccent,
                  toY: double.parse(
                    (callHistoryOverview['totalNumOfUnknownCalls']).toString(),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
