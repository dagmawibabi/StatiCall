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
    Map<int, int> weekdayCalls = {
      DateTime.monday: 0,
      DateTime.tuesday: 0,
      DateTime.wednesday: 0,
      DateTime.thursday: 0,
      DateTime.friday: 0,
      DateTime.saturday: 0,
      DateTime.sunday: 0,
    };
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

      // add 1 for the weekday of this call
      if (callLogEntry.timestamp != null) {
        final callDay = DateTime.fromMillisecondsSinceEpoch(
          callLogEntry.timestamp!,
        );
        weekdayCalls[callDay.weekday] = (weekdayCalls[callDay.weekday]!) + 1;
      }
    }

    // extract the busiest week day from the weekDayCalls map
    int busiestDayNumOfCalls = 0;
    String busiestWeekDay = '';

    weekdayCalls.forEach((key, value) {
      if (value > busiestDayNumOfCalls) {
        busiestDayNumOfCalls = value;
        busiestWeekDay = getWeekDay(key);
      }
    });

    final busiestWeekDayData = {
      'num_of_calls': busiestDayNumOfCalls,
      'weekday': busiestWeekDay,
    };

    _yearWrapped = YearWrapped(
      totalCalls: totalCalls,
      totalCallDuration: totalCallDuration,
      longestCall: longestCall,
      shortestCall: shortestCall,
      mostFrequentCallDay: busiestWeekDayData,
    );
    notifyListeners();
  }

  String getWeekDay(int weekDayValue) {
    const weekDays = [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday',
    ];

    // DateTime.weekday returns 1 for Monday and 7 for Sunday
    return weekDays[weekDayValue - 1];
  }
}
