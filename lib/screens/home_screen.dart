import 'package:callstats/providers/call_stats_provider.dart';
import 'package:callstats/screens/wrapped_intro_screen.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:callstats/widgets/home_widgets/callstats.dart';
import 'package:callstats/widgets/home_widgets/search_bottom_sheet.dart';
import 'package:callstats/widgets/home_widgets/detailed_call_stat.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isInit = true;
  late final CallStatsProvider callStatsProvider;

  // Detailed Stat
  void showDetail(curCall) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      anchorPoint: const Offset(100, 100),
      // isScrollControlled: true,
      isDismissible: true,
      enableDrag: true,
      builder: (context) {
        return Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
          ),
          clipBehavior: Clip.hardEdge,
          child: DetailedCallStats(
            curCall: curCall,
            showNumber: context.read<CallStatsProvider>().showNumber,
          ),
        );
      },
    );
  }

  // Search
  List searchFunction(String searchTerm) {
    List result = [];
    final classifiedCallLogs = callStatsProvider.classifiedCallLogs;

    String normalizedSearchTerm = searchTerm;

    if (normalizedSearchTerm.startsWith('251') &&
        normalizedSearchTerm.length > 3) {
      normalizedSearchTerm = normalizedSearchTerm.replaceFirst('251', '');
    } else if (normalizedSearchTerm.startsWith('0') &&
        normalizedSearchTerm.length > 1) {
      normalizedSearchTerm = normalizedSearchTerm.replaceFirst('0', '');
    } else if (normalizedSearchTerm.startsWith('+251') &&
        normalizedSearchTerm.length > 4) {
      normalizedSearchTerm = normalizedSearchTerm.replaceFirst('+251', '');
    }

    for (dynamic i in classifiedCallLogs) {
      if (i['name']
              .toString()
              .toLowerCase()
              .contains(normalizedSearchTerm.toLowerCase()) ||
          i['number'].toString().contains(normalizedSearchTerm.toLowerCase())) {
        result.add(i);
      }
    }
    return result;
  }

  // Search Stat
  void showSearch() {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      anchorPoint: const Offset(0, 100),
      constraints:
          BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.8),
      isScrollControlled: true,
      isDismissible: true,
      enableDrag: true,
      builder: (context) {
        return Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
          ),
          clipBehavior: Clip.hardEdge,
          child: SearchBottomSheet(
            searchFunction: searchFunction,
            showDetail: showDetail,
          ),
        );
      },
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (isInit) {
      callStatsProvider = Provider.of<CallStatsProvider>(context);
      callStatsProvider.getCallHistory();
      isInit = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Row(
          children: [
            Icon(
              Icons.call,
            ),
            SizedBox(width: 10.0),
            Text(
              "StatiCall",
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 18.0,
              ),
            ),
          ],
        ),
        actions: callStatsProvider.gotCalls
            ? [
                IconButton(
                  onPressed: callStatsProvider.toggleNumberVisibility,
                  icon: Icon(
                    size: 22.0,
                    callStatsProvider.showNumber
                        ? Ionicons.eye_off_outline
                        : Ionicons.eye_outline,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    showSearch();
                    // setState(() {});
                  },
                  icon: const Icon(
                    Ionicons.search_outline,
                    size: 20.0,
                  ),
                ),
                IconButton(
                  icon: const Icon(
                    Ionicons.gift_outline,
                    size: 20.0,
                  ),
                  tooltip: '30 days Wrapped',
                  onPressed: () => Navigator.of(context).pushNamed(
                    WrappedIntroScreen.routeName,
                  ),
                ),
                const SizedBox(width: 10.0),
              ]
            : [],
      ),
      body: callStatsProvider.gotCalls
          ? (callStatsProvider.classifiedCallLogs.isEmpty &&
                  callStatsProvider.isSorting == false)
              ? Center(
                  // Error Page - No calls
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Spacer(),
                      Image.asset('assets/illustrations/4.png'),
                      const SizedBox(height: 20.0),
                      const Text(
                        "You have no call history",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      const Text(
                        "Make some calls and come back.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      ElevatedButton(
                        style: ButtonStyle(
                          fixedSize:
                              const WidgetStatePropertyAll(Size(230.0, 45.0)),
                          backgroundColor:
                              WidgetStatePropertyAll(Colors.grey[900]),
                        ),
                        onPressed: callStatsProvider.getCallHistory,
                        child: const Text(
                          "I've made some calls",
                          style: TextStyle(
                            fontSize: 18.0,
                          ),
                        ),
                      ),
                      const Spacer(),
                    ],
                  ),
                )
              : CallStats(showDetail: showDetail)
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
