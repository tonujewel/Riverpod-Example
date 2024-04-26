import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_example/feature/login/model/login_request.dart';
import 'package:riverpod_example/feature/login/provider/login_provider.dart';

class LoginScreen extends ConsumerWidget {
  LoginScreen({super.key});

  final usernameController = TextEditingController(text: "kminchelle");
  final passwordController = TextEditingController(text: "0lelplR");

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 100),
            const Text("Demo user name : kminchelle"),
            const Text("Demo password : 0lelplR"),
            const SizedBox(height: 10),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                controller: usernameController,
                decoration: const InputDecoration(
                  labelText: 'Username',
                ),
              ),
            ),
            // Password TextField
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Password',
                ),
              ),
            ),
            // Login Button
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final isValid =
                    ref.read(loginProvider).loginValidation(usernameController.text, passwordController.text);
                if (isValid) {
                  LoginRequest body =
                      LoginRequest(username: usernameController.text, password: passwordController.text);
                  ref.read(loginProvider).doLoginApiCall(body, context);
                }
              },
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
