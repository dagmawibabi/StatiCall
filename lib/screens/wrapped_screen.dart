import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ionicons/ionicons.dart';

import 'package:callstats/providers/year_wrapped_provider.dart';

class WrappedScreen extends StatelessWidget {
  static const routeName = '/wrapped';

  const WrappedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final yearWrappedProvider = Provider.of<YearWrappedProvider>(context);

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFFF5F6D),
              Color(0xFFFFC371),
            ],
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
            ];

            return PageView.builder(
              itemCount: pages.length,
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
}
