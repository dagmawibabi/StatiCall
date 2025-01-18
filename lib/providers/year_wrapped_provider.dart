import 'package:call_log/call_log.dart';
import 'package:callstats/models/year_wrapped.dart';
import 'package:flutter/material.dart';

class YearWrappedProvider with ChangeNotifier {
  YearWrapped? _yearWrapped;

  YearWrapped? get yearWrapped => _yearWrapped;

  void initialize() async {
    List<CallLogEntry>? callLog;

    callLog = (await CallLog.query(
      dateTimeFrom: DateTime(2024),
      dateTimeTo: DateTime(
        2024,
        DateTime.december,
        31,
      ),
    ))
        .toList();

    final totalCalls = callLog.length;

    _yearWrapped = YearWrapped(totalCalls: totalCalls);

    notifyListeners();
  }
}
