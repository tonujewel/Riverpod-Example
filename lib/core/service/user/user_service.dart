import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../feature/user_list/model/user_response.dart';
import '../../network/dio_client.dart';
import '../../network/url_manager.dart';

class UserService {
  Future<List<UserData>> getUser() async {
    try {
      final response = await DioClient().get(url: UrlManager.getUserUrl);

      final result = UserResponse.fromJson(response.data);
      return result.data ?? [];
    } catch (e) {
      return [];
    }
  }
}

final userProvide = Provider<UserService>((ref) => UserService());
