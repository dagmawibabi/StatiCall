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

    for (var callLogEntry in callLog) {
      totalCallDuration += callLogEntry.duration ?? 0;
    }

    _yearWrapped = YearWrapped(
      totalCalls: totalCalls,
      totalCallDuration: totalCallDuration,
    );
    notifyListeners();
  }
}
