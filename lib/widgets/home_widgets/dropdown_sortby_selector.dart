import 'package:flutter/material.dart';

class DropdownSortbySelector extends StatelessWidget {
  final dynamic sortIndex;
  final Function(dynamic v) onChanged;
  const DropdownSortbySelector({
    super.key,
    required this.onChanged,
    required this.sortIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
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
            onChanged: (value) => onChanged(value),
          ),
        ),
      ],
    );
  }
}
