import 'dart:math';

import 'package:callstats/widgets/wrapped_widgets/busiest_day_viewer.dart';
import 'package:callstats/widgets/wrapped_widgets/call_viewer.dart';
import 'package:callstats/widgets/wrapped_widgets/total_calls_viewer.dart';
import 'package:callstats/widgets/wrapped_widgets/total_duration_viewer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
              TotalCallsViewer(totalCalls: yearWrapped!.totalCalls),
              TotalDurationViewer(
                totalCallDuration: yearWrapped.totalCallDuration,
              ),
              CallViewer(callLog: yearWrapped.longestCall, isLongestCall: true),
              CallViewer(
                callLog: yearWrapped.shortestCall,
                isLongestCall: false,
              ),
              BusiestDayViewer(
                mostFrequentCallDay: yearWrapped.mostFrequentCallDay,
              ),
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
}
