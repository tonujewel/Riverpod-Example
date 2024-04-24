import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_example/core/service/user/user_service.dart';
import 'package:riverpod_example/feature/user_list/model/user_response.dart';

final userDataProvider = FutureProvider<List<UserData>>((ref) async {
  return await ref.watch(userProvide).getUser();
});
