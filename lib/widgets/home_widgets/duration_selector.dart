import 'package:callstats/providers/call_stats_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DurationSelector extends StatelessWidget {
  const DurationSelector({super.key});

  void _swapDuration(int index, {required BuildContext context}) {
    final callStatsProvider = Provider.of<CallStatsProvider>(
      context,
      listen: false,
    );
    final durationType = callStatsProvider.durationType;

    if (durationType == DurationType.values[index]) return;

    switch (index) {
      case 1:
        callStatsProvider.setDurationType(DurationType.week);
        break;
      case 2:
        callStatsProvider.setDurationType(DurationType.allTime);
        break;
      default:
        callStatsProvider.setDurationType(DurationType.today);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildDurationButton('Today', 0, context: context),
          const SizedBox(width: 12),
          _buildDurationButton('This Week', 1, context: context),
          const SizedBox(width: 12),
          _buildDurationButton('All Time', 2, context: context),
        ],
      ),
    );
  }

  Widget _buildDurationButton(
    String label,
    int index, {
    required BuildContext context,
  }) {
    final callStatsProvider = Provider.of<CallStatsProvider>(
      context,
    );
    final isSelected =
        callStatsProvider.durationType == DurationType.values[index];

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
        onPressed: () => _swapDuration(index, context: context),
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
