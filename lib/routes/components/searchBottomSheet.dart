import 'package:callstats/routes/components/eachCallStat.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class SearchBottomSheet extends StatefulWidget {
  const SearchBottomSheet({
    super.key,
    required this.searchFunction,
    required this.showDetail,
    required this.showNumber,
    required this.allCalls,
  });

  final Function searchFunction;
  final Function showDetail;
  final bool showNumber;
  final Map allCalls;

  @override
  State<SearchBottomSheet> createState() => _SearchBottomSheetState();
}

class _SearchBottomSheetState extends State<SearchBottomSheet> {
  TextEditingController searchController = TextEditingController();
  List results = [];
  void initSearch() {
    results = widget.searchFunction("9");
  }

  @override
  void initState() {
    super.initState();
    initSearch();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 15.0),
          color: Colors.grey[300],
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Search Label
              const Padding(
                padding: EdgeInsets.only(left: 20.0),
                child: Text(
                  "Search",
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.w500,
                  ), //3249ca
                ),
              ),
              const SizedBox(height: 5.0),
              // Search Input
              Container(
                padding: const EdgeInsets.only(left: 15.0),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                  color: Colors.grey[200],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: searchController,
                        decoration: const InputDecoration(
                          hintText: "Search names or phone number",
                          border: InputBorder.none,
                        ),
                        maxLines: 1,
                        onChanged: (value) {
                          results = widget.searchFunction(value);
                          setState(() {});
                        },
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Ionicons.search_outline,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15.0),
              // Search Label
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Text(
                      "Results - ${results.length}",
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: Colors.grey[700],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5.0),
              // Results
              results.isEmpty
                  ? SizedBox(
                      height: MediaQuery.of(context).size.height * 0.8,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 50.0),
                            child: Text(
                              "No results found",
                              style: TextStyle(
                                color: Colors.grey[500],
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  : SizedBox(
                      height: MediaQuery.of(context).size.height,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: results.length,
                        itemBuilder: (context, index) {
                          return EachCallStatCard(
                              curCall: results[index],
                              index: index + 1,
                              showNumber: widget.showNumber,
                              showDetail: widget.showDetail,
                              allCalls: widget.allCalls);
                        },
                      ),
                    )
            ],
          ),
        ),
      ],
    );
  }
}
