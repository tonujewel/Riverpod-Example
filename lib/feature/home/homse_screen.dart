import 'package:flutter/material.dart';
import 'package:riverpod_example/core/constant/app_constant.dart';
import 'package:riverpod_example/core/model/home_model.dart';
import 'package:riverpod_example/core/widgets/primary_container.dart';
import 'package:riverpod_example/feature/counter/screen/counter_screen.dart';
import 'package:riverpod_example/feature/user_list/screen/users_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: AppConstant.homeList.length,
        itemBuilder: (_, index) {
          return HomeItemWidget(
            data: AppConstant.homeList[index],
            onTap: () {
              if (AppConstant.homeList[index].id == 1) {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const CounterScreen()));
              }
              if (AppConstant.homeList[index].id == 2) {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const UsersScreen()));
              }
            },
          );
        },
      ),
    );
  }
}

class HomeItemWidget extends StatelessWidget {
  const HomeItemWidget({
    super.key,
    required this.data,
    required this.onTap,
  });

  final HomeModel data;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: PrimaryContainer(
        child: Row(
          children: [
            CircleAvatar(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Image.asset(data.imgPath, height: 30),
              ),
            ),
            const SizedBox(width: 20),
            Text(
              data.title,
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
