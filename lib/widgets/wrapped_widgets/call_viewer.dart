import 'package:call_log/call_log.dart';
import 'package:callstats/providers/call_stats_provider.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';

class CallViewer extends StatelessWidget {
  final CallLogEntry callLog;
  final bool isLongestCall;

  const CallViewer({
    super.key,
    required this.callLog,
    required this.isLongestCall,
  });

  @override
  Widget build(BuildContext context) {
    final title = isLongestCall ? 'Longest Call' : 'Shortest Call';
    final description = isLongestCall
        ? 'Your longest conversation this year!'
        : 'Your shortest call this year!';

    String name = callLog.name ?? 'Unknown';
    String phoneNumber = callLog.number ?? 'Unknown';
    Duration duration = Duration(
      seconds: callLog.duration ?? 0,
    );
    DateTime? date = callLog.timestamp == null
        ? null
        : DateTime.fromMillisecondsSinceEpoch(
            callLog.timestamp!,
          );

    final showNumber = Provider.of<CallStatsProvider>(context).showNumber;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 20.0),
        Icon(
          Ionicons.call_outline,
          size: 64.0,
          color: Colors.white.withValues(alpha: 0.8),
        ),
        const SizedBox(height: 20.0),
        Text(
          name,
          style: const TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        if (showNumber) const SizedBox(height: 10.0),
        if (showNumber)
          Text(
            phoneNumber,
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.white.withValues(alpha: 0.7),
            ),
          ),
        const SizedBox(height: 10.0),
        Text(
          '${duration.inHours.toString().padLeft(2, '0')}:${duration.inMinutes.remainder(60).toString().padLeft(2, '0')}:${duration.inSeconds.remainder(60).toString().padLeft(2, '0')}',
          style: const TextStyle(
            fontSize: 50.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        if (date != null) const SizedBox(height: 10.0),
        if (date != null)
          Text(
            'Date: ${date.toLocal().toString().split(' ')[0]}',
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.white.withValues(alpha: 0.7),
            ),
          ),
        const SizedBox(height: 20.0),
        Text(
          description,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16.0,
            color: Colors.white.withValues(alpha: 0.7),
            height: 1.4,
          ),
        ),
      ],
    );
  }
}
