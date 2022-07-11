// ignore_for_file: prefer_const_constructors

import 'package:callstats/routes/components/detailedCallStat.dart';
import 'package:callstats/routes/fullScreenDetails.dart';
import 'package:flutter/material.dart';

class EachCallStatCard extends StatefulWidget {
  const EachCallStatCard({
    Key? key,
    required this.curCall,
    required this.index,
    required this.showNumber,
    required this.showDetail,
  }) : super(key: key);
  final Map curCall;
  final int index;
  final bool showNumber;
  final Function showDetail;

  @override
  State<EachCallStatCard> createState() => _EachCallStatCardState();
}

class _EachCallStatCardState extends State<EachCallStatCard> {
  String overallDuration = "";
  // Pick the right duration metric
  void calculateOverallDuration() {
    print(widget.curCall['totalDurationHours'] == "0.28");
    if (double.parse(widget.curCall['totalDurationHours']) >= 1.0) {
      overallDuration = "${widget.curCall['totalDurationHours']} hr";
    } else if (double.parse(widget.curCall['totalDurationMinutes']) >= 1.0) {
      overallDuration = "${widget.curCall['totalDurationMinutes']} min";
    } else {
      overallDuration = "${widget.curCall['totalDuration']} sec";
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    calculateOverallDuration();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // showDetail();
        widget.showDetail(widget.curCall);
      },
      onLongPress: () {
        FullScreenDetail(
          curCall: widget.curCall,
        );
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FullScreenDetail(curCall: widget.curCall),
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.only(top: 8.0, bottom: 8.0, left: 8.0, right: 8.0),
        margin: EdgeInsets.only(top: 2.0, bottom: 2.0, left: 5.0, right: 5.0),
        decoration: BoxDecoration(
          color: Colors.white,
          // border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        child: Column(
          children: [
            // Name and index
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${widget.index.toString()}.${(widget.curCall['name'] == "" || widget.curCall['name'] == " " || widget.curCall['name'] == "null") ? "Unknown" : widget.curCall['name']}",
                ),
                widget.showNumber
                    ? Text(
                        widget.curCall['number'].toString(),
                      )
                    : Container(),
              ],
            ),
            SizedBox(height: 10.0),
            // Number of calls
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Total Calls",
                ),
                Text(
                  widget.curCall['numOfAllCalls'].toString(),
                ),
              ],
            ),
            // Number of calls
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Overall Duration",
                ),
                Text(
                  overallDuration.toString(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
