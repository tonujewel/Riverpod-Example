import 'package:riverpod_example/core/model/home_model.dart';

class AppConstant {
  static List<HomeModel> homeList = [
    HomeModel(id: 1, title: "Counter", imgPath: 'assets/images/count.png'),
    HomeModel(id: 2, title: "Get Api call", imgPath: 'assets/images/count.png'),
  ];
}
