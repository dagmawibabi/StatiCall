import 'dart:math';

import 'package:callstats/background_gradients.dart';
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
  late final int initialBackgroundIndex;
  late int currentBackgroundIndex;
  int selectedPageIndex = 0;

  @override
  void initState() {
    super.initState();

    final random = Random();
    initialBackgroundIndex = random.nextInt(BACKGROUND_GRADIENTS.length);
    currentBackgroundIndex = initialBackgroundIndex;
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
            colors: BACKGROUND_GRADIENTS[
                currentBackgroundIndex % BACKGROUND_GRADIENTS.length],
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
                      currentBackgroundIndex =
                          initialBackgroundIndex + pageIndex;
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
