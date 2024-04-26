import 'package:riverpod_example/core/model/home_model.dart';

class AppConstant {
  static List<HomeModel> homeList = [
    HomeModel(id: 1, title: "Counter", imgPath: 'assets/images/count.png'),
    HomeModel(id: 2, title: "Get api call", imgPath: 'assets/images/users.png'),
    HomeModel(id: 3, title: "Theme Change", imgPath: 'assets/images/theme.png'),
    HomeModel(id: 4, title: "Login api call", imgPath: 'assets/images/login.png'),
  ];
}
