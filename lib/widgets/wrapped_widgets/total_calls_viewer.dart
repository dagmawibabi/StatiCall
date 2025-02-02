import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class TotalCallsViewer extends StatelessWidget {
  final int totalCalls;

  const TotalCallsViewer({super.key, required this.totalCalls});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          '$totalCalls',
          style: const TextStyle(
            fontSize: 50.0,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 30.0),
        Text(
          'Total Calls Made',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.w500,
            letterSpacing: 1.0,
            color: Colors.white.withValues(alpha: 0.9),
          ),
        ),
        const SizedBox(height: 20.0),
        Icon(
          Ionicons.call_outline,
          size: 64.0,
          color: Colors.white.withValues(alpha: 0.8),
        ),
        const SizedBox(height: 8.0),
        Container(
          width: 100.0,
          height: 1.5,
          color: Colors.white.withValues(alpha: 0.5),
        ),
        const SizedBox(height: 30.0),
        Text(
          'You\'ve stayed connected through the year!',
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
