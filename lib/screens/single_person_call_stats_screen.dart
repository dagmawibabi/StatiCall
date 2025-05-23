import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:callstats/providers/call_stats_provider.dart';
import 'package:callstats/widgets/call_date_range_viewer.dart';
import 'package:callstats/widgets/graph_indicators.dart';
import 'package:callstats/widgets/single_person_widgets/single_person_bar_graph_overview.dart';
import 'package:callstats/widgets/single_person_duration_view.dart';
import 'package:callstats/widgets/single_person_widgets/single_person_pie_chart.dart';

class SinglePersonCallStatsScreen extends StatefulWidget {
  static const routeName = '/single-person-call-stats';

  const SinglePersonCallStatsScreen({
    super.key,
  });

  @override
  State<SinglePersonCallStatsScreen> createState() => _FullScreenDetailState();
}

class _FullScreenDetailState extends State<SinglePersonCallStatsScreen> {
  bool isInit = true;

  late final Map curCall;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (isInit) {
      final arguments = ModalRoute.of(context)!.settings.arguments as List;
      curCall = arguments[0];
      isInit = false;
    }
  }

  int curPage = 0;

  @override
  Widget build(BuildContext context) {
    final callStatsProvider = Provider.of<CallStatsProvider>(context);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        centerTitle: true,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: callStatsProvider.showNumber ? 5.0 : 15.0,
            ),
            Hero(
              key: UniqueKey(),
              tag: {"name": curCall["name"]},
              child: Text(
                "${(curCall['name'] == "" || curCall['name'] == " " || curCall['name'] == "null") ? "Unknown" : curCall['name']}",
                maxLines: 1,
                style: const TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(height: callStatsProvider.showNumber ? 2.0 : 10.0),
            callStatsProvider.showNumber
                ? Text(
                    curCall["number"],
                    style: TextStyle(
                      fontSize: 12.0,
                      color: Colors.grey[800],
                    ),
                  )
                : Container(),
          ],
        ),
        actions: [
          SizedBox(width: callStatsProvider.showNumber ? 0.0 : 50.0),
        ],
      ),
      body: ListView(
        shrinkWrap: true,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              // border: Border.all(color: Colors.black),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              ),
            ),
            child: Column(
              children: [
                const SizedBox(height: 0.0),
                SizedBox(
                  height: 280,
                  child: PageView(
                    scrollDirection: Axis.horizontal,
                    pageSnapping: true,
                    onPageChanged: (value) {
                      setState(() => curPage = value);
                    },
                    children: [
                      SinglePersonPieChart(
                        curCall: curCall,
                      ),
                      SinglePersonBarGraphOverview(
                        curCall: curCall,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 0.0),
                // Page Indicator
                Row(
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
                const SizedBox(height: 20.0),
                // Indicators
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GraphIndicators(color: Colors.pinkAccent, text: "Missed"),
                    GraphIndicators(
                        color: Colors.greenAccent, text: "Incoming"),
                    GraphIndicators(color: Colors.blue, text: "Outgoing"),
                  ],
                ),
                const SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GraphIndicators(
                      color: Colors.red.shade800,
                      text: "Rejected",
                    ),
                    const GraphIndicators(
                      color: Colors.black,
                      text: "Blocked",
                    ),
                    const GraphIndicators(
                      color: Colors.cyanAccent,
                      text: "Unknown",
                    ),
                  ],
                ),
                const SizedBox(height: 30.0),
                // Duration Stats
                Column(children: [
                  SinglePersonDurationView(
                    title: "Total Duration",
                    inSeconds: curCall["totalDuration"].toString(),
                    inMinutes: curCall["totalDurationMinutes"].toString(),
                    inHours: curCall["totalDurationHours"].toString(),
                    icon: Icons.upgrade_outlined,
                  ),
                  SinglePersonDurationView(
                    title: "Maximum Duration",
                    inSeconds: curCall["maxDuration"].toString(),
                    inMinutes: curCall["maxDurationMinutes"].toString(),
                    inHours: curCall["maxDurationHours"].toString(),
                    icon: Icons.unfold_more_sharp,
                  ),
                  SinglePersonDurationView(
                    title: "Minimum Duration",
                    inSeconds: curCall["minDuration"].toString(),
                    inMinutes: curCall["minDurationMinutes"].toString(),
                    inHours: curCall["minDurationHours"].toString(),
                    icon: Icons.unfold_less_rounded,
                  ),
                  CallDateRangeViewer(
                    initialDate: DateTime.fromMicrosecondsSinceEpoch(
                      curCall["oldestDate"] * 1000,
                    ).toString().substring(0, 10),
                    finalDate: DateTime.fromMicrosecondsSinceEpoch(
                            curCall["newestDate"] * 1000)
                        .toString()
                        .substring(0, 10),
                  ),
                ]),
                const SizedBox(height: 50.0),
                // End
                Text(
                  "End of Analysis",
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.grey[400],
                  ),
                ),
                const SizedBox(height: 30.0),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
