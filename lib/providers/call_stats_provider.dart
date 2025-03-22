import 'package:call_log/call_log.dart';
import 'package:flutter/foundation.dart';

class CallStatsProvider with ChangeNotifier {
  // Globals
  List _classifiedCallLogs = [];
  List _rawCallLog = [];
  bool _gotCalls = false;
  bool _showNumber = false;
  bool _isSorting = false;
  int _sortIndex = 0;
  final _sortTypes = [
    'numOfAllCalls',
    'totalDuration',
    'maxDuration',
    'minDuration',
    'oldestDate',
    'newestDate',
    'numOfMissedCalls',
    'numOfIncomingCalls',
    'numOfOutgoingCalls',
    'numOfRejectedCalls',
    'numOfBlockedCalls',
    'numOfUnknownCalls',
  ];
  Map _callHistoryOverview = {
    "totalMinDuration": 0.0,
    "totalMinDurationMin": 0.0,
    "totalMinDurationHour": 0.0,
    "totalMaxDuration": 0.0,
    "totalMaxDurationMin": 0.0,
    "totalMaxDurationHour": 0.0,
    "totalDuration": 0.0,
    "totalDurationMin": 0.0,
    "totalDurationHour": 0.0,
    "totalNumOfCalls": 0,
    "totalNumOfMissedCalls": 0,
    "totalNumOfIncomingCalls": 0,
    "totalNumOfOutgoingCalls": 0,
    "totalNumOfRejectedCalls": 0,
    "totalNumOfBlockedCalls": 0,
    "totalNumOfUnknownCalls": 0,
    "oldestDate": 0,
    "newestDate": 0,
  };

  Map get callHistoryOverview => _callHistoryOverview;
  List get classifiedCallLogs => _classifiedCallLogs;
  List get rawCallLog => _rawCallLog;
  bool get gotCalls => _gotCalls;
  bool get showNumber => _showNumber;
  bool get isSorting => _isSorting;
  int get sortIndex => _sortIndex;
  List get sortTypes => _sortTypes;
  DateTime? _startDate = DateTime.now().subtract(const Duration(days: 1));
  DateTime? _endDate = DateTime.now();

  void setStartAndEndDate(DateTime? startDate, DateTime? endDate) {
    _startDate = startDate;
    _endDate = endDate;

    getCallHistory();
  }

  void toggleNumberVisibility() {
    _showNumber = !_showNumber;
    notifyListeners();
  }

  // Reset
  void reset() {
    _classifiedCallLogs = [];
    _rawCallLog = [];
    _callHistoryOverview = {
      "totalMinDuration": 0.0,
      "totalMinDurationMin": 0.0,
      "totalMinDurationHour": 0.0,
      "totalMaxDuration": 0.0,
      "totalMaxDurationMin": 0.0,
      "totalMaxDurationHour": 0.0,
      "totalDuration": 0.0,
      "totalDurationMin": 0.0,
      "totalDurationHour": 0.0,
      "totalNumOfCalls": 0,
      "totalNumOfMissedCalls": 0,
      "totalNumOfIncomingCalls": 0,
      "totalNumOfOutgoingCalls": 0,
      "totalNumOfRejectedCalls": 0,
      "totalNumOfBlockedCalls": 0,
      "totalNumOfUnknownCalls": 0,
      "oldestDate": 0,
      "newestDate": 0,
    };
  }

  // Fetch call history from device
  void getCallHistory() async {
    // Reset
    reset();
    // Get contact history
    dynamic callHistory = await CallLog.query(
      dateTimeFrom: _startDate,
      dateTimeTo: _endDate,
    );

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

    // Overview
    getOverview();

    // Sort
    sort(sortTypes[sortIndex]);

    _gotCalls = true;
    notifyListeners();
  }

  // Get Call History Overview
  void getOverview() {
    callHistoryOverview['oldestDate'] = classifiedCallLogs[0]['oldestDate'];
    for (dynamic i in classifiedCallLogs) {
      callHistoryOverview['totalMinDuration'] += i['minDuration'];
      callHistoryOverview['totalMinDurationMin'] +=
          double.parse(i['minDurationMinutes'].toString());
      callHistoryOverview['totalMinDurationHour'] +=
          double.parse(i['minDurationHours'].toString());
      callHistoryOverview['totalMaxDuration'] +=
          double.parse(i['maxDuration'].toString());
      callHistoryOverview['totalMaxDurationMin'] +=
          double.parse(i['maxDurationMinutes'].toString());
      callHistoryOverview['totalMaxDurationHour'] +=
          double.parse(i['maxDurationHours'].toString());
      callHistoryOverview['totalDuration'] +=
          double.parse(i['totalDuration'].toString());
      callHistoryOverview['totalDurationMin'] +=
          double.parse(i['totalDurationMinutes'].toString());
      callHistoryOverview['totalDurationHour'] +=
          double.parse(i['totalDurationHours'].toString());
      callHistoryOverview['totalNumOfCalls'] += i['numOfAllCalls'];
      callHistoryOverview['totalNumOfMissedCalls'] += i['numOfMissedCalls'];
      callHistoryOverview['totalNumOfIncomingCalls'] += i['numOfIncomingCalls'];
      callHistoryOverview['totalNumOfOutgoingCalls'] += i['numOfOutgoingCalls'];
      callHistoryOverview['totalNumOfRejectedCalls'] += i['numOfRejectedCalls'];
      callHistoryOverview['totalNumOfBlockedCalls'] += i['numOfBlockedCalls'];
      callHistoryOverview['totalNumOfUnknownCalls'] += i['numOfUnknownCalls'];
      callHistoryOverview['oldestDate'] =
          i['oldestDate'] < callHistoryOverview['oldestDate']
              ? i['oldestDate']
              : callHistoryOverview['oldestDate'];
      callHistoryOverview['newestDate'] =
          i['newestDate'] > callHistoryOverview['newestDate']
              ? i['newestDate']
              : callHistoryOverview['newestDate'];
    }
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
        } catch (e) {
          //
        }

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
  void swapSort(int sortInd) {
    getCallHistory();
    _sortIndex = sortInd;
    _isSorting = true;
    notifyListeners();
  }
}
