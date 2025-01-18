import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ionicons/ionicons.dart';

import 'package:callstats/providers/year_wrapped_provider.dart';

class WrappedScreen extends StatelessWidget {
  static const routeName = '/wrapped';

  const WrappedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final yearWrappedProvider = Provider.of<YearWrappedProvider>(context);

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFFF5F6D), // Soft red-pink
              Color(0xFFFFC371), // Light golden-yellow
            ],
          ),
        ),
        child: Builder(
          builder: (ctx) {
            if (yearWrappedProvider.yearWrapped == null) {
              yearWrappedProvider.initialize();
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            final yearWrapped = yearWrappedProvider.yearWrapped;

            return PageView.builder(
              itemCount: 1,
              itemBuilder: (ctx, index) => Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Total Calls Number (Bold and Highlighted)
                    Text(
                      '${yearWrapped!.totalCalls}',
                      style: const TextStyle(
                        fontSize: 50.0,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 30.0),
                    // Total Calls Label
                    Text(
                      'Total Calls Made',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 1.0,
                        color: Colors.white.withValues(alpha: 0.9),
                      ),
                    ),
                    const SizedBox(height: 20.0),

                    // Call Icon with a softer color
                    Icon(
                      Ionicons.call_outline,
                      size: 64.0, // Smaller for minimalism
                      color: Colors.white.withValues(alpha: 0.8),
                    ),

                    const SizedBox(height: 8.0),

                    // Divider Line
                    Container(
                      width: 100.0,
                      height: 1.5,
                      color: Colors.white.withValues(alpha: 0.5),
                    ),
                    const SizedBox(height: 30.0),

                    // Motivational or Contextual Text
                    Text(
                      'You\'ve stayed connected through the year!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.white.withValues(alpha: 0.7),
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
