import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/user_response.dart';
import '../provider/user_data_provider.dart';

class UsersScreen extends ConsumerWidget {
  const UsersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(userDataProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("Users")),
      body: data.when(
        data: (users) {
          List<UserData> userList = users;
          return Expanded(
            child: ListView.builder(
                itemCount: userList.length,
                itemBuilder: (_, index) {
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              userList[index].avatar ?? "",
                              height: 60,
                              width: 60,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(width: 20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("${userList[index].firstName ?? ""} ${userList[index].lastName ?? ""}"),
                              Text("${userList[index].email ?? ""}}"),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                }),
          );
        },
        error: (error, s) => Text(error.toString()),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
