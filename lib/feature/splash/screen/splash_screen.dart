import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_example/feature/splash/provider/splash_provider.dart';

class SplashScreen extends ConsumerWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(splashProvider(context));

    return Scaffold(
      body: Center(
        child: Image.asset(
          "assets/images/logo_transparent.png",
          height: 200,
        ),
      ),
    );
  }
}
