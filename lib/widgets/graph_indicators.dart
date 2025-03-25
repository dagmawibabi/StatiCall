import 'package:flutter/material.dart';

class GraphIndicators extends StatelessWidget {
  const GraphIndicators({
    super.key,
    required this.color,
    required this.text,
  });

  final Color color;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 70,
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
        margin: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          boxShadow: [
            BoxShadow(
              color: Colors.grey[300]!,
              blurRadius: 10.0,
              spreadRadius: 4.0,
            )
          ],
          // border: Border.all(color: Colors.blueGrey),
          borderRadius: const BorderRadius.all(Radius.circular(10.0)),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 18.0,
                height: 18.0,
                decoration: BoxDecoration(
                  color: color,
                  border: Border.all(color: Colors.blueGrey),
                  borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                ),
              ),
              const SizedBox(height: 8.0),
              FittedBox(
                child: Text(
                  text,
                  style: const TextStyle(
                    fontSize: 13.0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
