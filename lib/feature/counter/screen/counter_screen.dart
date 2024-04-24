import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_example/feature/counter/provider/counter_provider.dart';

class CounterScreen extends ConsumerWidget {
  const CounterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Counter App"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(width: double.infinity),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Count: ",
                style: TextStyle(fontSize: 18),
              ),
              Text(
                "${ref.watch(counterProvider)}",
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () => ref.read(counterProvider.notifier).state++,
                child: const Text("Increment"),
              ),
              const SizedBox(width: 20),
              ElevatedButton(
                onPressed: () => ref.read(counterProvider.notifier).state--,
                child: const Text("Decrement"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
