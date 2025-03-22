import 'package:callstats/providers/call_stats_provider.dart';
import 'package:callstats/widgets/home_widgets/all_calls_bar_graph.dart';
import 'package:callstats/widgets/home_widgets/all_calls_pie_chart.dart';
import 'package:callstats/widgets/home_widgets/dropdown_sortby_selector.dart';
import 'package:callstats/widgets/home_widgets/duration_selector.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:callstats/widgets/each_call_stat.dart';
import 'package:callstats/widgets/graph_indicators.dart';

class CallStats extends StatefulWidget {
  final Function showDetail;

  const CallStats({
    super.key,
    required this.showDetail,
  });

  @override
  State<CallStats> createState() => _CallStatsState();
}

class _CallStatsState extends State<CallStats> {
  int curPage = 0;
  int sortIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Consumer<CallStatsProvider>(
      builder: (ctx, callStatsProvider, _) {
        return ListView.builder(
          shrinkWrap: true,
          itemCount: callStatsProvider.classifiedCallLogs.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                if (index == 0) const DurationSelector(),
                // Graph Title
                if (index == 0)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 10.0, top: 5.0, bottom: 5.0),
                            child: Icon(
                              Icons.bar_chart,
                              color: Colors.grey[600],
                            ),
                          ),
                          const SizedBox(width: 5.0),
                          Text(
                            "Graphs",
                            style: TextStyle(
                              fontSize: 14.0,
                              color: Colors.grey[700],
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 12.0),
                        child: Text(
                          "${curPage + 1}/2",
                          style: TextStyle(
                            fontSize: 12.0,
                            color: Colors.grey[700],
                          ),
                        ),
                      ),
                    ],
                  ),
                // Pages
                if (index == 0)
                  Container(
                    height: 300,
                    padding: const EdgeInsets.only(top: 8.0),
                    child: PageView(
                      onPageChanged: (value) {
                        curPage = value;
                        setState(() {});
                      },
                      children: const [
                        AllCallsPieChart(),
                        AllCallsBarGraph(),
                      ],
                    ),
                  ),
                // Page Indicator
                if (index == 0)
                  Container(
                    padding: const EdgeInsets.only(bottom: 30.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 5.0,
                          height: 5.0,
                          decoration: BoxDecoration(
                            color: curPage == 0
                                ? Colors.blueAccent
                                : Colors.grey[400],
                            borderRadius: const BorderRadius.all(
                              Radius.circular(20.0),
                            ),
                          ),
                        ),
                        const SizedBox(width: 5.0),
                        Container(
                          width: 5.0,
                          height: 5.0,
                          decoration: BoxDecoration(
                            color: curPage == 1
                                ? Colors.blueAccent
                                : Colors.grey[400],
                            borderRadius: const BorderRadius.all(
                              Radius.circular(20.0),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                if (index == 0)
                  const Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GraphIndicators(
                            color: Colors.pinkAccent,
                            text: "Missed",
                          ),
                          GraphIndicators(
                            color: Colors.greenAccent,
                            text: "Incoming",
                          ),
                          GraphIndicators(color: Colors.blue, text: "Outgoing"),
                        ],
                      ),
                      SizedBox(height: 20.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GraphIndicators(color: Colors.red, text: "Rejected"),
                          GraphIndicators(color: Colors.black, text: "Blocked"),
                          GraphIndicators(
                            color: Colors.cyanAccent,
                            text: "Unknown",
                          ),
                        ],
                      ),
                      SizedBox(height: 30.0),
                    ],
                  ),
                // All Calls
                if (index == 0)
                  DropdownSortbySelector(
                    onChanged: (value) {
                      sortIndex = value;
                      callStatsProvider.swapSort(value);
                    },
                    sortIndex: sortIndex,
                  ),
                EachCallStatCard(
                  curCall: callStatsProvider.classifiedCallLogs[index],
                  index: index + 1,
                  showDetail: widget.showDetail,
                ),
                index == callStatsProvider.classifiedCallLogs.length - 1
                    ? Column(children: [
                        const SizedBox(height: 150.0),
                        // End
                        Text(
                          "End of Contacts",
                          style: TextStyle(
                            fontSize: 14.0,
                            color: Colors.grey[400],
                          ),
                        ),
                        const SizedBox(height: 50.0),
                      ])
                    : const SizedBox.shrink(),
              ],
            );
          },
        );
      },
    );
  }
}
