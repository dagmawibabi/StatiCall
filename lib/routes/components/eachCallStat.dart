import 'package:callstats/routes/fullScreenDetails.dart';
import 'package:flutter/material.dart';

class EachCallStatCard extends StatefulWidget {
  const EachCallStatCard({
    super.key,
    required this.curCall,
    required this.index,
    required this.showNumber,
    required this.showDetail,
    required this.allCalls,
  });
  final Map curCall;
  final int index;
  final bool showNumber;
  final Function showDetail;
  final Map allCalls;

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
    return GestureDetector(
      onLongPress: () {
        // showDetail();
        widget.showDetail(widget.curCall);
      },
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FullScreenDetail(
              curCall: widget.curCall,
              showNumber: widget.showNumber,
              allCalls: widget.allCalls,
            ),
          ),
        );
      },
      child: Container(
        padding:
            const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 8.0, right: 8.0),
        margin:
            const EdgeInsets.only(top: 2.0, bottom: 2.0, left: 5.0, right: 5.0),
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
                widget.showNumber
                    ? Text(
                        widget.curCall['number'].toString(),
                      )
                    : Container(),
              ],
            ),
            const SizedBox(height: 5.0),
            // Number of calls
            Container(
              padding: const EdgeInsets.only(
                top: 8.0,
                bottom: 8.0,
                left: 8.0,
                right: 8.0,
              ),
              margin: const EdgeInsets.only(
                top: 2.0,
                bottom: 2.0,
                left: 0.0,
                right: 0.0,
              ),
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
  }
}
