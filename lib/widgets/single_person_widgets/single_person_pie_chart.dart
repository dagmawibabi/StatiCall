import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class SinglePersonPieChart extends StatelessWidget {
  final Map curCall;

  const SinglePersonPieChart({
    super.key,
    required this.curCall,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        Container(
          width: 250.0,
          height: 250.0,
          padding: const EdgeInsets.all(15.0),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            boxShadow: const [
              BoxShadow(
                color: Colors.white,
                blurRadius: 15.0,
                spreadRadius: 5.0,
              )
            ],
            // border: Border.all(color: Colors.blueGrey),
            borderRadius: const BorderRadius.all(Radius.circular(300.0)),
          ),
          child: PieChart(
            PieChartData(
              sections: [
                PieChartSectionData(
                  color: Colors.pinkAccent,
                  title: curCall["numOfMissedCalls"].toString(),
                  value: double.parse(curCall["numOfMissedCalls"].toString()),
                  titleStyle: const TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                PieChartSectionData(
                  color: Colors.greenAccent,
                  title: curCall["numOfIncomingCalls"].toString(),
                  value: double.parse(curCall["numOfIncomingCalls"].toString()),
                  titleStyle: const TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                PieChartSectionData(
                  color: Colors.blue,
                  title: curCall["numOfOutgoingCalls"].toString(),
                  value: double.parse(curCall["numOfOutgoingCalls"].toString()),
                  titleStyle: const TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                PieChartSectionData(
                  color: Colors.red.shade800,
                  title: curCall["numOfRejectedCalls"].toString(),
                  value: double.parse(curCall["numOfRejectedCalls"].toString()),
                  titleStyle: const TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                PieChartSectionData(
                  color: Colors.black,
                  title: curCall["numOfBlockedCalls"].toString(),
                  value: double.parse(curCall["numOfBlockedCalls"].toString()),
                  titleStyle: const TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                PieChartSectionData(
                  color: Colors.cyanAccent,
                  title: curCall["numOfUnknownCalls"].toString(),
                  value: double.parse(curCall["numOfUnknownCalls"].toString()),
                  titleStyle: const TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
        Text(
          curCall['numOfAllCalls'].toString(),
          style: const TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
