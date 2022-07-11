// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class FullScreenDetail extends StatefulWidget {
  const FullScreenDetail(
      {Key? key, required this.curCall, required this.showNumber})
      : super(key: key);
  final Map curCall;
  final bool showNumber;

  @override
  State<FullScreenDetail> createState() => _FullScreenDetailState();
}

class _FullScreenDetailState extends State<FullScreenDetail> {
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
                style: TextStyle(
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
        actions: [SizedBox(width: widget.showNumber ? 0.0 : 50.0)],
      ),
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              // border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              ),
            ),
            child: Column(
              children: [
                SizedBox(height: 5.0),
                graph(),
                SizedBox(height: 0.0),

                // Duration Stats
                Container(
                  child: Column(children: [
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
                ),
                SizedBox(height: 150.0),
                // End
                Text(
                  "End of Analysis",
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.grey[400],
                  ),
                ),
                SizedBox(height: 50.0),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // PieGraph
  Container graph() {
    return Container(
        child: Column(
      children: [
        Container(
          width: 250.0,
          height: 250.0,
          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            boxShadow: [
              BoxShadow(
                color: Colors.white,
                blurRadius: 15.0,
                spreadRadius: 5.0,
              )
            ],
            // border: Border.all(color: Colors.blueGrey),
            borderRadius: BorderRadius.all(Radius.circular(300.0)),
          ),
          child: PieChart(
            PieChartData(
              sections: [
                PieChartSectionData(
                  color: Colors.pinkAccent,
                  title: widget.curCall["numOfMissedCalls"].toString(),
                  value: double.parse(
                      widget.curCall["numOfMissedCalls"].toString()),
                  titleStyle: TextStyle(
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
                  titleStyle: TextStyle(
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
                  titleStyle: TextStyle(
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
                  titleStyle: TextStyle(
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
                  titleStyle: TextStyle(
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
                  titleStyle: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 20.0),
        // Indicators
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              graphIndicator(Colors.pinkAccent, "Missed"),
              graphIndicator(Colors.greenAccent, "Incoming"),
              graphIndicator(Colors.blue, "Outgoing"),
            ],
          ),
        ),
        SizedBox(height: 20.0),
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              graphIndicator(Colors.red, "Rejected"),
              graphIndicator(Colors.black, "Blocked"),
              graphIndicator(Colors.cyanAccent, "Unknown"),
            ],
          ),
        ),
        SizedBox(height: 30.0),
      ],
    ));
  }

  // Duration Triplets
  Container eachDetailDuration(String title, String firstVal, String secondVal,
      String thirdVal, IconData icon) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
      margin: EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        // border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.all(
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
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 6.0),
          // Values
          Container(
            padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
            margin: EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              // border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.all(
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
                      style: TextStyle(
                        fontSize: 17.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 2.0),
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
                      secondVal,
                      style: TextStyle(
                        fontSize: 17.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 2.0),
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
                      thirdVal,
                      style: TextStyle(
                        fontSize: 17.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 2.0),
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
      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
      margin: EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        // border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.all(
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
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 8.0),
          // Values
          Container(
            padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
            margin: EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              // border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.all(
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
                      style: TextStyle(
                        fontSize: 17.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 2.0),
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
                      style: TextStyle(
                        fontSize: 17.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 2.0),
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

  // Graph Indicators
  Container graphIndicator(Color color, String text) {
    return Container(
      width: 80.0,
      height: 60.0,
      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        boxShadow: [
          BoxShadow(
            color: Colors.grey[300]!,
            blurRadius: 10.0,
            spreadRadius: 4.0,
          )
        ],
        // border: Border.all(color: Colors.blueGrey),
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      child: Column(
        children: [
          Container(
            width: 18.0,
            height: 18.0,
            decoration: BoxDecoration(
              color: color,
              border: Border.all(color: Colors.blueGrey),
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            text,
            style: TextStyle(
              fontSize: 13.0,
            ),
          ),
        ],
      ),
    );
  }
}
