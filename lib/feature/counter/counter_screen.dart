import 'package:flutter/material.dart';

class CounterScreen extends StatelessWidget {
  const CounterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Counter App"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(width: double.infinity),
          const Text("Count"),
          ElevatedButton(onPressed: () {}, child: const Text("Increment")),
          ElevatedButton(onPressed: () {}, child: const Text("Decrement")),
        ],
      ),
    );
  }
}
