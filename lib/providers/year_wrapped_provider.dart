import 'package:call_log/call_log.dart';
import 'package:callstats/models/year_wrapped.dart';
import 'package:flutter/material.dart';

class YearWrappedProvider with ChangeNotifier {
  YearWrapped? _yearWrapped;

  YearWrapped? get yearWrapped => _yearWrapped;

  void initialize() async {
    final callLog = (
      await CallLog.query(
        dateTimeFrom: DateTime(2024),
        dateTimeTo: DateTime(2024, DateTime.december, 31),
      ),
    ).$1.toList();

    final totalCalls = callLog.length;
    int totalCallDuration = 0;
    CallLogEntry longestCall = callLog[0], shortestCall = callLog[0];

    for (var callLogEntry in callLog) {
      // add the call duration of the current call to the total duration
      totalCallDuration += callLogEntry.duration ?? 0;

      // update the longest and shortest call variables if the call duration is not zero
      if ((callLogEntry.duration ?? 0) != 0) {
        if ((longestCall.duration ?? 0) < (callLogEntry.duration ?? 0)) {
          longestCall = callLogEntry;
        }
        if ((shortestCall.duration ?? 0) > (callLogEntry.duration ?? 0)) {
          shortestCall = callLogEntry;
        }
      }
    }

    _yearWrapped = YearWrapped(
      totalCalls: totalCalls,
      totalCallDuration: totalCallDuration,
      longestCall: longestCall,
      shortestCall: shortestCall,
    );
    notifyListeners();
  }
}
