import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class BusiestDayViewer extends StatelessWidget {
  final Map<String, dynamic> mostFrequentCallDay;

  const BusiestDayViewer({super.key, required this.mostFrequentCallDay});

  @override
  Widget build(BuildContext context) {
    final int numOfCalls = mostFrequentCallDay['num_of_calls'];
    final String weekDayName = mostFrequentCallDay['weekday'];

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          'Busiest Day',
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            shadows: [
              Shadow(
                blurRadius: 10.0,
                color: Colors.black45,
                offset: Offset(2.0, 2.0),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20.0),
        Icon(
          Ionicons.calendar_outline,
          size: 64.0,
          color: Colors.white.withValues(alpha: 0.8),
        ),
        const SizedBox(height: 20.0),
        Text(
          weekDayName,
          style: const TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 10.0),
        Text(
          '$numOfCalls Calls',
          style: TextStyle(
            fontSize: 16.0,
            color: Colors.white.withValues(alpha: 0.7),
          ),
        ),
        const SizedBox(height: 20.0),
        Text(
          'You love making calls on ${weekDayName}s.',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16.0,
            color: Colors.white.withValues(alpha: 0.7),
            height: 1.4,
            shadows: const [
              Shadow(
                blurRadius: 5.0,
                color: Colors.black26,
                offset: Offset(1.0, 1.0),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
