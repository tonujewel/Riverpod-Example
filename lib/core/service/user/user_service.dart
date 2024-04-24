import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_example/core/network/dio_client.dart';
import 'package:riverpod_example/feature/user_list/model/user_response.dart';

class UserService {
  String url = "https://reqres.in/api/users?page=1&per_page=10";

  Future<List<UserData>> getUser() async {
    try {
      final response = await DioClient().get(url: url);

      if (response != null) {
        final result = UserResponse.fromJson(response);
        return result.data ?? [];
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }
}

final userProvide = Provider<UserService>((ref) => UserService());
