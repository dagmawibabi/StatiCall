// Globals
import 'package:call_log/call_log.dart';

Map callStats = {};
List allCalls = [];
List allActualCalls = [];
List allMissedCalls = [];
List allIncomingCalls = [];
List allOutgoingCalls = [];
List allRejectedCalls = [];
List allUnknownCalls = [];
List allBlockedCalls = [];
List allCallStats = [];
List actualCallStats = [];
List missedCallStats = [];
List incomingCallStats = [];
List outgoingCallStats = [];
List rejectedCallStats = [];
List unknownCallStats = [];
List blockedCallStats = [];

int misseds = 0;

// Find max in a list
dynamic findMax(List curList) {
  List givenList = curList;
  int max = 0;
  dynamic maxObj = {};
  for (dynamic i in givenList) {
    if (i['duration'] > max) {
      max = i['duration'];
      maxObj = i;
    }
  }
  return maxObj;
}

// find rand of max
List findNMax(int howMany, List curList) {
  List workingList = curList;
  List result = [];
  for (int i = 0; i < howMany; i++) {
    dynamic maxObj = findMax(workingList);
    result.add(maxObj);
    for (int j = 0; j < workingList.length; j++) {
      workingList[j]['duration'] = 0;
    }
  }
  return result;
}

// Find the max
List findTopX(int numOfResults, List curList, String sortField) {
  List result = [];
  List allMax = curList;
  for (int k = 0; k < numOfResults; k++) {
    dynamic max = 0;
    dynamic maxObj = {};
    for (dynamic i in allMax) {
      if (i[sortField] > max) {
        max = i[sortField];
        maxObj = i;
      }
    }
    result.add(maxObj);
    for (int z = 0; z < allMax.length; z++) {
      if (allMax[z]['name'] == maxObj['name'] &&
          allMax[z]['number'] == maxObj['number'] &&
          allMax[z][sortField] == maxObj[sortField]) {
        allMax.removeAt(z);
        break;
      }
    }
  }
  return result;
}

// Filter all calls to unique sets
List filterCalls(List workingList) {
  List result = [];
  List curList = workingList;
  for (dynamic eachCall in curList) {
    bool exists = false;
    for (dynamic uniqueCall in result) {
      String a = eachCall['number'].toString();
      String b = uniqueCall['number'].toString();
      String c = eachCall['name'].toString();
      String d = uniqueCall['name'].toString();
      try {
        a = eachCall['number'].substring(eachCall['number'].length - 9);
        b = uniqueCall['number'].substring(uniqueCall['number'].length - 9);
      } catch (e) {}
      if (a == b) {
        uniqueCall['duration'] += eachCall['duration'];
        uniqueCall['count'] += 1;
        uniqueCall['totalDuration'] += eachCall['duration'];
        exists = true;
      }
    }
    if (exists == false) {
      eachCall['count'] = 1;
      eachCall['totalDuration'] = eachCall['duration'];
      result.add(eachCall);
    }
  }
  return result;
}

// Get Call History
void getCallHistory() async {
  // Reset
  allCalls = [];
  allActualCalls = [];
  allMissedCalls = [];
  allIncomingCalls = [];
  allOutgoingCalls = [];
  allRejectedCalls = [];
  allUnknownCalls = [];
  allBlockedCalls = [];

  allCallStats = [];
  actualCallStats = [];
  missedCallStats = [];
  incomingCallStats = [];
  outgoingCallStats = [];
  rejectedCallStats = [];
  unknownCallStats = [];
  blockedCallStats = [];

  // Get all calls
  dynamic result = await CallLog.query();

  // Classify Calls
  for (CallLogEntry eachCall in result) {
    Map curCall = {
      "name": eachCall.name,
      "number": eachCall.number,
      "callType": eachCall.callType,
      "duration": eachCall.duration,
      "timeStamp": eachCall.timestamp,
      "count": 0,
      "totalDuration": 0
    };
    if (curCall['callType'] == CallType.missed) {
      allMissedCalls.add(curCall);
    } else if (curCall['callType'] == CallType.incoming) {
      allIncomingCalls.add(curCall);
    } else if (curCall['callType'] == CallType.outgoing) {
      allOutgoingCalls.add(curCall);
    } else if (curCall['callType'] == CallType.rejected) {
      allRejectedCalls.add(curCall);
    } else if (curCall['callType'] == CallType.unknown) {
      allUnknownCalls.add(curCall);
    } else if (curCall['callType'] == CallType.blocked) {
      allBlockedCalls.add(curCall);
    }
    if (curCall['callType'] == CallType.incoming ||
        curCall['callType'] == CallType.outgoing) {
      allActualCalls.add(curCall);
    }
    misseds++;
    allCalls.add(curCall);
  }
  print(allActualCalls.length);
  print(allCalls.length);

  // Filter Calls
  allCallStats = filterCalls(allCalls);
  actualCallStats = allActualCalls;
  missedCallStats = filterCalls(allMissedCalls);
  incomingCallStats = filterCalls(allIncomingCalls);
  outgoingCallStats = filterCalls(allOutgoingCalls);
  rejectedCallStats = filterCalls(allRejectedCalls);
  unknownCallStats = filterCalls(allUnknownCalls);
  blockedCallStats = filterCalls(allBlockedCalls);

  print(actualCallStats.length);
  print(allCallStats.length);

  // Sort Calls
  List a = [];
  print(
      '-----------------------------------------------------------------------------Outgoing Calls ${outgoingCallStats.length}');
  a = findTopX(20, outgoingCallStats, "duration");
  for (dynamic x in a) {
    print(
        '${x['name']} = ${x['number']} = ${x['totalDuration']} = ${x['count']}');
  }
  print(
      '-----------------------------------------------------------------------------Incoming Calls ${incomingCallStats.length}');
  a = findTopX(20, incomingCallStats, "duration");
  for (dynamic x in a) {
    print(
        '${x['name']} = ${x['number']} = ${x['totalDuration']} = ${x['count']}');
  }
  // print(
  //     '-----------------------------------------------------------------------------Missed Calls ${missedCallStats.length}');
  // a = findTopX(20, missedCallStats, "duration");
  // for (dynamic x in a) {
  //   print(
  //       '${x['name']} = ${x['number']} = ${x['totalDuration']} = ${x['count']}');
  // }
  print(
      '-----------------------------------------------------------------------------Actual Calls ${actualCallStats.length}');
  actualCallStats = [];
  actualCallStats.addAll(incomingCallStats);
  actualCallStats.addAll(outgoingCallStats);
  a = filterCalls(actualCallStats);
  a = findTopX(20, a, "duration");
  for (dynamic x in a) {
    print(
        '${x['name']} = ${x['number']} = ${x['totalDuration']} = ${x['count']}');
  }
  print(
      '-----------------------------------------------------------------------------All Calls ${allCallStats.length}');
  a = findTopX(20, allCallStats, "duration");
  // a = findTopX(20, allCallStats, "duration");
  for (dynamic x in a) {
    print(
        '${x['name']} = ${x['number']} = ${x['totalDuration']} = ${x['count']}');
  }

  // print(
  //     '-----------------------------------------------------------------------------All Rejected ${rejectedCallStats.length}');
  // a = findTopX(20, rejectedCallStats, "duration");
  // for (dynamic x in a) {
  //   print(
  //       '${x['name']} = ${x['number']} = ${x['totalDuration']} = ${x['count']}');
  // }
  // print(
  //     '-----------------------------------------------------------------------------All Unknown ${unknownCallStats.length}');
  // a = findTopX(20, unknownCallStats, "duration");
  // for (dynamic x in a) {
  //   print(
  //       '${x['name']} = ${x['number']} = ${x['totalDuration']} = ${x['count']}');
  // }
  // print(
  //     '-----------------------------------------------------------------------------All Blocked ${blockedCallStats.length}');
  // a = findTopX(20, blockedCallStats, "duration");
  // for (dynamic x in a) {
  //   print(
  //       '${x['name']} = ${x['number']} = ${x['totalDuration']} = ${x['count']}');
  // }

  // Update
  // setState(() {});
}
