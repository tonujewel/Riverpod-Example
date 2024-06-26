import 'package:flutter/material.dart';

import '../../core/constant/app_constant.dart';
import '../../core/model/home_model.dart';
import '../../core/widgets/primary_container.dart';
import '../counter/screen/counter_screen.dart';
import '../login/screen/login_screen.dart';
import '../theme_change/screen/theme_change_screen.dart';
import '../user_list/screen/users_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Riverpod Example"),
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 5.0,
          crossAxisSpacing: 10.0,
          childAspectRatio: 1 / .7,
        ),
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
              if (AppConstant.homeList[index].id == 3) {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const ThemeChangeScreen()));
              }
              if (AppConstant.homeList[index].id == 4) {
                Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
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
        allPadding: 0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(data.imgPath, height: 30),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              data.title,
            ),
          ],
        ),
      ),
    );
  }
}
