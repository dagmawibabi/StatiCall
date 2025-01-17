import 'package:flutter/material.dart';

class WrappedScreen extends StatelessWidget {
  static const routeName = '/wrapped';

  const WrappedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('2024 Wrapped'),
      ),
      body: const Placeholder(),
    );
  }
}
