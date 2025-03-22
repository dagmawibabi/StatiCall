import 'package:callstats/providers/call_stats_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DurationSelector extends StatefulWidget {
  const DurationSelector({super.key});

  @override
  State<DurationSelector> createState() => _DurationSelectorState();
}

class _DurationSelectorState extends State<DurationSelector> {
  late int _durationIndex;
  late final CallStatsProvider callStatsProvider;

  @override
  void initState() {
    super.initState();
    _durationIndex = 0;

    callStatsProvider = Provider.of<CallStatsProvider>(context, listen: false);
  }

  void _swapDuration(int index) {
    switch (index) {
      case 1:
        callStatsProvider.setStartAndEndDate(
          DateTime.now().subtract(const Duration(days: 7)),
          DateTime.now(),
        );
        break;
      case 2:
        callStatsProvider.setStartAndEndDate(null, null);
        break;
      default:
        callStatsProvider.setStartAndEndDate(
          DateTime.now().subtract(const Duration(days: 1)),
          DateTime.now(),
        );
    }
    setState(() {
      _durationIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildDurationButton('Today', 0),
          const SizedBox(width: 12),
          _buildDurationButton('This Week', 1),
          const SizedBox(width: 12),
          _buildDurationButton('All Time', 2),
        ],
      ),
    );
  }

  Widget _buildDurationButton(String label, int index) {
    final isSelected = _durationIndex == index;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: isSelected
              ? Theme.of(context).primaryColor.withValues(alpha: 0.1)
              : Colors.white,
          foregroundColor:
              isSelected ? Theme.of(context).primaryColor : Colors.black,
          elevation: isSelected ? 2 : 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(
              color: isSelected
                  ? Theme.of(context).primaryColor
                  : Colors.grey[300]!,
              width: 1.5,
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          shadowColor: isSelected
              ? Colors.black.withValues(alpha: 0.1)
              : Colors.transparent,
        ),
        onPressed: () => _swapDuration(index),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
