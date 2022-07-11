// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:call_log/call_log.dart';
import 'package:callstats/routes/components/callstats.dart';
import 'package:callstats/routes/components/getcalls.dart';
import 'package:flutter/material.dart';

import 'components/detailedCallStat.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Globals
  List classifiedCallLogs = [];
  List rawCallLog = [];
  bool gotCalls = false;
  bool showNumber = false;
  int sortIndex = 0;
  List sortTypes = [
    'numOfAllCalls',
    'totalDuration',
    'maxDuration',
    'minDuration',
    'oldestDate',
    'newestDate'
  ];

  // Reset
  void reset() {
    classifiedCallLogs = [];
    rawCallLog = [];
  }

  // Fetch call history from device
  void getCallHistory() async {
    // Reset
    reset();
    // Get contact history
    dynamic callHistory = await CallLog.query();
    // Convert to working list
    callHistory = callHistory.toList();
    for (int i = 0; i < callHistory.length; i++) {
      dynamic callLog = {
        "type": callHistory[i].callType,
        "name": callHistory[i].name.toString(),
        "number": callHistory[i].number.toString(),
        "minDuration": callHistory[i].duration,
        "minDurationMinutes": (callHistory[i].duration / 60).toStringAsFixed(2),
        "minDurationHours":
            ((callHistory[i].duration / 60) / 60).toStringAsFixed(2),
        "maxDuration": callHistory[i].duration,
        "maxDurationMinutes": (callHistory[i].duration / 60).toStringAsFixed(2),
        "maxDurationHours":
            ((callHistory[i].duration / 60) / 60).toStringAsFixed(2),
        "totalDuration": callHistory[i].duration,
        "totalDurationMinutes":
            (callHistory[i].duration / 60).toStringAsFixed(2),
        "totalDurationHours":
            ((callHistory[i].duration / 60) / 60).toStringAsFixed(2),
        "numOfMissedCalls": callHistory[i].callType == CallType.missed ? 1 : 0,
        "numOfIncomingCalls":
            callHistory[i].callType == CallType.incoming ? 1 : 0,
        "numOfOutgoingCalls":
            callHistory[i].callType == CallType.outgoing ? 1 : 0,
        "numOfRejectedCalls":
            callHistory[i].callType == CallType.rejected ? 1 : 0,
        "numOfBlockedCalls":
            callHistory[i].callType == CallType.blocked ? 1 : 0,
        "numOfUnknownCalls":
            callHistory[i].callType == CallType.unknown ? 1 : 0,
        "numOfAllCalls": 1,
        "oldestDate": callHistory[i].timestamp,
        "newestDate": callHistory[i].timestamp,
      };
      rawCallLog.add(callLog);
    }
    // Classify
    classify();

    // Sort
    sort(sortTypes[sortIndex]);

    // Start
    setState(() {
      gotCalls = true;
    });
  }

  // Classify call history
  void classify() {
    for (int i = 0; i < rawCallLog.length; i++) {
      bool exists = false;
      for (int j = 0; j < classifiedCallLogs.length; j++) {
        String a = rawCallLog[i]['name'].toString();
        String b = classifiedCallLogs[j]['name'].toString();
        String c = rawCallLog[i]['number'].toString();
        String d = classifiedCallLogs[j]['number'].toString();

        try {
          c = c.substring(c.length - 9);
          d = d.substring(d.length - 9);
        } catch (e) {}

        if (a == b && c == d) {
          exists = true;
          // Find Minimum Call Duration
          if (rawCallLog[i]['minDuration'] <
                  classifiedCallLogs[j]['minDuration'] &&
              rawCallLog[i]['minDuration'] > 0) {
            classifiedCallLogs[j]['minDuration'] = rawCallLog[i]['minDuration'];
          }
          // Set min minutes
          classifiedCallLogs[j]['minDurationMinutes'] =
              (classifiedCallLogs[j]['minDuration'] / 60).toStringAsFixed(2);
          // Set min hours
          classifiedCallLogs[j]['minDurationHours'] =
              ((classifiedCallLogs[j]['minDuration'] / 60) / 60)
                  .toStringAsFixed(2);

          // Find Maximum Call Duration
          if (rawCallLog[i]['maxDuration'] >
              classifiedCallLogs[j]['maxDuration']) {
            classifiedCallLogs[j]['maxDuration'] = rawCallLog[i]['maxDuration'];
          }
          // Set max minutes
          classifiedCallLogs[j]['maxDurationMinutes'] =
              (classifiedCallLogs[j]['maxDuration'] / 60).toStringAsFixed(2);
          // Set max hours
          classifiedCallLogs[j]['maxDurationHours'] =
              ((classifiedCallLogs[j]['maxDuration'] / 60) / 60)
                  .toStringAsFixed(2);

          // Count total duration
          classifiedCallLogs[j]['totalDuration'] +=
              rawCallLog[i]['maxDuration'];
          // Set total minutes
          classifiedCallLogs[j]['totalDurationMinutes'] =
              (classifiedCallLogs[j]['totalDuration'] / 60).toStringAsFixed(2);
          // Set total hours
          classifiedCallLogs[j]['totalDurationHours'] =
              ((classifiedCallLogs[j]['totalDuration'] / 60) / 60)
                  .toStringAsFixed(2);

          // Count number of calls
          classifiedCallLogs[j]['numOfAllCalls'] += 1;

          // Count call type
          if (rawCallLog[i]['type'] == CallType.missed) {
            classifiedCallLogs[j]['numOfMissedCalls'] += 1;
          } else if (rawCallLog[i]['type'] == CallType.incoming) {
            classifiedCallLogs[j]['numOfIncomingCalls'] += 1;
          } else if (rawCallLog[i]['type'] == CallType.outgoing) {
            classifiedCallLogs[j]['numOfOutgoingCalls'] += 1;
          } else if (rawCallLog[i]['type'] == CallType.rejected) {
            classifiedCallLogs[j]['numOfRejectedCalls'] += 1;
          } else if (rawCallLog[i]['type'] == CallType.blocked) {
            classifiedCallLogs[j]['numOfBlockedCalls'] += 1;
          } else if (rawCallLog[i]['type'] == CallType.unknown) {
            classifiedCallLogs[j]['numOfUnknownCalls'] += 1;
          }

          // Oldest Date
          if (rawCallLog[i]['oldestDate'] <
              classifiedCallLogs[j]['oldestDate']) {
            classifiedCallLogs[j]['oldestDate'] = rawCallLog[i]['oldestDate'];
          }
          // Newest Date
          if (rawCallLog[i]['newestDate'] >
              classifiedCallLogs[j]['newestDate']) {
            classifiedCallLogs[j]['newestDate'] = rawCallLog[i]['newestDate'];
          }
        }
      }
      if (exists == false) {
        classifiedCallLogs.add(rawCallLog[i]);
      }
    }
  }

  // Sort
  void sort(String sortMethod) {
    classifiedCallLogs.sort((a, b) => b[sortMethod].compareTo(a[sortMethod]));
    // classifiedCallLogs.reversed;
  }

  // Sort Button
  void swapSort() {
    getCallHistory();
    sortIndex++;
    if (sortIndex > sortTypes.length - 1) {
      sortIndex = 0;
    }
    setState(() {});
  }

// Detailed Stat
  void showDetail(curCall) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      anchorPoint: Offset(100, 100),
      // isScrollControlled: true,
      isDismissible: true,
      enableDrag: true,
      builder: (context) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
          ),
          clipBehavior: Clip.hardEdge,
          child: DetailedCallStats(
            curCall: curCall,
            showNumber: showNumber,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Icon(
              Icons.call,
            ),
            SizedBox(width: 10.0),
            Text(
              gotCalls ? "Call History Analyzer" : " ",
              style: TextStyle(
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
        actions: gotCalls
            ? [
                IconButton(
                  onPressed: () {
                    showNumber = !showNumber;
                    setState(() {});
                  },
                  icon: Icon(
                    showNumber ? Icons.block : Icons.remove_red_eye_outlined,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 0.0),
                  child: IconButton(
                    icon: Icon(
                      Icons.sort,
                    ),
                    onPressed: swapSort,
                  ),
                ),
              ]
            : [],
      ),
      body: gotCalls
          ? CallStats(
              rawCallLog: rawCallLog,
              classifiedCallLogs: classifiedCallLogs,
              showNumber: showNumber,
              showDetail: showDetail,
            )
          : GetCalls(
              getCallHistory: getCallHistory,
            ),
    );
  }
}
