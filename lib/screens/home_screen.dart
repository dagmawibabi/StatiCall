import 'package:callstats/providers/call_stats_provider.dart';
import 'package:callstats/screens/wrapped_screen.dart';
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

    for (dynamic i in classifiedCallLogs) {
      if (i['name']
              .toString()
              .toLowerCase()
              .contains(searchTerm.toLowerCase()) ||
          i['number'].toString().contains(searchTerm.toLowerCase())) {
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
                  tooltip: '',
                  onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) {
                        return const IntroScreen();
                      },
                    ),
                  ),
                  icon: const Icon(Ionicons.contract),
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

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blueAccent, Colors.purpleAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'Welcome to your 2024 Wrapped!',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                const Text(
                  'Discover new insights and enjoy your experience.',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pushNamed(
                      WrappedScreen.routeName,
                    );
                  },
                  child: const Text('Get Started'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
