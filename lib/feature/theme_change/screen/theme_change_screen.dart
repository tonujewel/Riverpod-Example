import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/theme_provider.dart';

class ThemeChangeScreen extends ConsumerWidget {
  const ThemeChangeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final theme = ref.read(themeProvider.notifier).themeData;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Change Theme"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                ref.read(themeProvider).toggleLight();
              },
              child: const Text('Light Theme'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                ref.read(themeProvider).toggleDark();
              },
              child: const Text('Dark Theme'),
            ),
          ],
        ),
      ),
    );
  }
}
