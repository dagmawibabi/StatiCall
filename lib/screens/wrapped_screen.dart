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
  int selectedPageIndex = 0;

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

            return Stack(
              children: [
                PageView.builder(
                  itemCount: pages.length,
                  onPageChanged: (pageIndex) {
                    setState(() {
                      selectedPageIndex = pageIndex;
                      gradient = randomGradient;
                    });
                  },
                  itemBuilder: (ctx, index) => Center(
                    child: SingleChildScrollView(
                      child: pages[index],
                    ),
                  ),
                ),
                // indicate the index of the current page
                Positioned(
                  bottom: 16,
                  left: 0,
                  right: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(pages.length, (index) {
                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        height: 8,
                        width: selectedPageIndex == index ? 24 : 8,
                        decoration: BoxDecoration(
                          color: selectedPageIndex == index
                              ? Colors.white
                              : Colors.white38,
                          borderRadius: BorderRadius.circular(8),
                        ),
                      );
                    }),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
