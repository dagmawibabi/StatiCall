import 'dart:math';

import 'package:call_log/call_log.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ionicons/ionicons.dart';

import 'package:callstats/providers/year_wrapped_provider.dart';

class WrappedScreen extends StatefulWidget {
  static const routeName = '/wrapped';

  const WrappedScreen({super.key});

  @override
  State<WrappedScreen> createState() => _WrappedScreenState();
}

class _WrappedScreenState extends State<WrappedScreen> {
  late List<Color> gradient;

  final backgroundGradients = const [
    [
      Color(0xFF7FFFD4),
      Color(0xFF00CED1),
    ],
    [
      Color(0xFF373737),
      Color(0xFF191919),
    ],
    [
      Color(0xFF4169E1),
      Color(0xFF1E90FF),
    ],
    [
      Color(0xFF7CFC00),
      Color(0xFF7CFC00),
      Color(0xFF00FA9A),
    ],
    [
      Color(0xFFF06292),
      Color(0xFFFF80CB),
    ],
    [
      Color(0xFFFF5F6D),
      Color(0xFFFFC371),
    ],
  ];

  List<Color> get randomGradient {
    final random = Random();
    return backgroundGradients[random.nextInt(backgroundGradients.length)];
  }

  @override
  void initState() {
    super.initState();
    gradient = backgroundGradients[0];
  }

  @override
  Widget build(BuildContext context) {
    final yearWrappedProvider = Provider.of<YearWrappedProvider>(context);

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: gradient,
          ),
        ),
        child: Builder(
          builder: (ctx) {
            if (yearWrappedProvider.yearWrapped == null) {
              yearWrappedProvider.initialize();
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            final yearWrapped = yearWrappedProvider.yearWrapped;

            final pages = <Widget>[
              totalCallsViewer(yearWrapped!.totalCalls),
              totalDurationViewer(yearWrapped.totalCallDuration),
              callViewer(callLog: yearWrapped.longestCall, isLongestCall: true),
              callViewer(
                callLog: yearWrapped.shortestCall,
                isLongestCall: false,
              ),
              busiestDayViewer(yearWrapped.mostFrequentCallDay),
            ];

            return PageView.builder(
              itemCount: pages.length,
              onPageChanged: (_) {
                setState(() {
                  gradient = randomGradient;
                });
              },
              itemBuilder: (ctx, index) => Center(
                child: SingleChildScrollView(
                  child: pages[index],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget totalCallsViewer(int totalCalls) {
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

  Widget totalDurationViewer(int totalCallDuration) {
    final duration = Duration(seconds: totalCallDuration);
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}',
          style: const TextStyle(
            fontSize: 50.0,
            fontWeight: FontWeight.w700,
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
        const SizedBox(height: 30.0),
        Text(
          'Total Call Duration',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.w500,
            letterSpacing: 1.0,
            color: Colors.white.withValues(alpha: 0.9),
            shadows: const [
              Shadow(
                blurRadius: 5.0,
                color: Colors.black26,
                offset: Offset(1.0, 1.0),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20.0),
        Icon(
          Ionicons.time_outline,
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
          'You\'ve spent quality time on calls!',
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

  Widget callViewer({
    required CallLogEntry callLog,
    required bool isLongestCall,
  }) {
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
        const SizedBox(height: 10.0),
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

  Widget busiestDayViewer(Map<String, dynamic> mostFrequentCallDay) {
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
