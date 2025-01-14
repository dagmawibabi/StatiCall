import 'package:flutter/material.dart';
import 'package:callstats/widgets/call_date_range_viewer.dart';
import 'package:callstats/widgets/single_person_duration_view.dart';

class DetailedCallStats extends StatefulWidget {
  const DetailedCallStats({
    super.key,
    required this.curCall,
    required this.showNumber,
  });
  final Map curCall;
  final bool showNumber;

  @override
  State<DetailedCallStats> createState() => _DetailedCallStatsState();
}

class _DetailedCallStatsState extends State<DetailedCallStats> {
  @override
  Widget build(BuildContext context) {
    return ListView(
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
              const SizedBox(height: 6.0),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Text(
                  widget.curCall["name"],
                  maxLines: 1,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(height: 4.0),
              widget.showNumber
                  ? Text(
                      widget.curCall["number"],
                      style: const TextStyle(fontSize: 15.0),
                    )
                  : Container(),
              const SizedBox(height: 6.0),
              SinglePersonDurationView(
                title: "Total Duration",
                inSeconds: widget.curCall["totalDuration"].toString(),
                inMinutes: widget.curCall["totalDurationMinutes"].toString(),
                inHours: widget.curCall["totalDurationHours"].toString(),
                icon: Icons.upgrade_outlined,
              ),
              SinglePersonDurationView(
                title: "Maximum Duration",
                inSeconds: widget.curCall["maxDuration"].toString(),
                inMinutes: widget.curCall["maxDurationMinutes"].toString(),
                inHours: widget.curCall["maxDurationHours"].toString(),
                icon: Icons.unfold_more_sharp,
              ),
              SinglePersonDurationView(
                title: "Minimum Duration",
                inSeconds: widget.curCall["minDuration"].toString(),
                inMinutes: widget.curCall["minDurationMinutes"].toString(),
                inHours: widget.curCall["minDurationHours"].toString(),
                icon: Icons.unfold_less_rounded,
              ),
              CallDateRangeViewer(
                initialDate: DateTime.fromMicrosecondsSinceEpoch(
                  widget.curCall["oldestDate"] * 1000,
                ).toString().substring(0, 10),
                finalDate: DateTime.fromMicrosecondsSinceEpoch(
                        widget.curCall["newestDate"] * 1000)
                    .toString()
                    .substring(0, 10),
              ),
              const SizedBox(height: 0.0),
              // End
              Text(
                " ",
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.grey[400],
                ),
              ),
              const SizedBox(height: 20.0),
            ],
          ),
        ),
      ],
    );
  }
}
