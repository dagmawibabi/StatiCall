import 'package:call_log/call_log.dart';

class YearWrapped {
  final int totalCalls;
  final int totalCallDuration;
  final CallLogEntry longestCall;
  final CallLogEntry shortestCall;
  final Map<String, dynamic> mostFrequentCallDay;

  YearWrapped({
    required this.totalCalls,
    required this.totalCallDuration,
    required this.longestCall,
    required this.shortestCall,
    required this.mostFrequentCallDay,
  });
}
