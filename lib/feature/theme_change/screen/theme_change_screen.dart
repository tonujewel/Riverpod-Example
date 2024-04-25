import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/theme_provider.dart';

class ThemeChangeScreen extends ConsumerWidget {
  const ThemeChangeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<String> tempData = ref.watch(themeProvider).tempData;
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
            ElevatedButton(
              onPressed: () {
                ref.read(themeProvider).updateCount();
              },
              child: const Text('Update count'),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: tempData.length,
                itemBuilder: (c, i) {
                  return Text(tempData[i]);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
