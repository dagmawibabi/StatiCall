import 'package:callstats/widgets/all_calls_bar_graph.dart';
import 'package:callstats/widgets/all_calls_pie_chart.dart';
import 'package:flutter/material.dart';

import 'package:callstats/routes/components/each_call_stat.dart';
import 'package:callstats/widgets/graph_indicators.dart';

class CallStats extends StatefulWidget {
  const CallStats({
    super.key,
    required this.rawCallLog,
    required this.classifiedCallLogs,
    required this.showNumber,
    required this.showDetail,
    required this.callHistoryOverview,
    required this.swapSort,
  });

  final List classifiedCallLogs;
  final List rawCallLog;
  final bool showNumber;
  final Function showDetail;
  final Map callHistoryOverview;
  final Function swapSort;

  @override
  State<CallStats> createState() => _CallStatsState();
}

class _CallStatsState extends State<CallStats> {
  int curPage = 0;
  int sortIndex = 0;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: widget.classifiedCallLogs.length,
      itemBuilder: (context, index) {
        return Column(
          children: [
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
                  children: [
                    AllCallsPieChart(
                      callHistoryOverview: widget.callHistoryOverview,
                    ),
                    AllCallsBarGraph(
                      callHistoryOverview: widget.callHistoryOverview,
                    ),
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
                        color:
                            curPage == 0 ? Colors.blueAccent : Colors.grey[400],
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
                        color:
                            curPage == 1 ? Colors.blueAccent : Colors.grey[400],
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
                      GraphIndicators(color: Colors.pinkAccent, text: "Missed"),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0, bottom: 5.0),
                        child: Icon(
                          Icons.person_outline,
                          color: Colors.grey[600],
                        ),
                      ),
                      const SizedBox(width: 5.0),
                      Padding(
                        padding: const EdgeInsets.only(left: 0.0, bottom: 5.0),
                        child: Text(
                          "All Calls",
                          style: TextStyle(
                            fontSize: 15.0,
                            color: Colors.grey[700],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      right: 10.0,
                      bottom: 5.0,
                    ),
                    child: DropdownButton(
                      value: sortIndex,
                      elevation: 0,
                      icon: Padding(
                        padding: const EdgeInsets.only(left: 5.0),
                        child: Icon(
                          Icons.sort,
                          color: Colors.grey[700],
                        ),
                      ),
                      isDense: true,
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.grey[800],
                      ),
                      iconSize: 20.0,
                      // itemHeight: 40.0,
                      items: const [
                        DropdownMenuItem(
                          value: 0,
                          child: Text(
                            "All Calls",
                          ),
                        ),
                        DropdownMenuItem(
                          value: 6,
                          child: Text(
                            "Missed Calls",
                          ),
                        ),
                        DropdownMenuItem(
                          value: 7,
                          child: Text(
                            "Incoming Calls",
                          ),
                        ),
                        DropdownMenuItem(
                          value: 8,
                          child: Text(
                            "Outgoing Calls",
                          ),
                        ),
                        DropdownMenuItem(
                          value: 9,
                          child: Text(
                            "Rejected Calls",
                          ),
                        ),
                        DropdownMenuItem(
                          value: 10,
                          child: Text(
                            "Blocked Calls",
                          ),
                        ),
                        DropdownMenuItem(
                          value: 11,
                          child: Text(
                            "Unknown Calls",
                          ),
                        ),
                        DropdownMenuItem(
                          value: 1,
                          child: Text(
                            "Total Duration",
                          ),
                        ),
                        DropdownMenuItem(
                          value: 2,
                          child: Text(
                            "Max Duration",
                          ),
                        ),
                        DropdownMenuItem(
                          value: 3,
                          child: Text(
                            "Min Duration",
                          ),
                        ),
                        DropdownMenuItem(
                          value: 4,
                          child: Text(
                            "Oldest Date",
                          ),
                        ),
                        DropdownMenuItem(
                          value: 5,
                          child: Text(
                            "Newest Date",
                          ),
                        )
                      ],
                      onChanged: (dynamic value) {
                        sortIndex = value;
                        widget.swapSort(value);
                      },
                    ),
                  ),
                ],
              ),
            EachCallStatCard(
              curCall: widget.classifiedCallLogs[index],
              index: index + 1,
              showNumber: widget.showNumber,
              showDetail: widget.showDetail,
              allCalls: widget.callHistoryOverview,
            ),
            index == widget.classifiedCallLogs.length - 1
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
  }
}
