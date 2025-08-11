// lib/core/repositories/auth_repository.dart

import 'package:shared_preferences/shared_preferences.dart';
import 'package:store/app/modules/auth/model/user_model.dart';
import 'package:store/core/constants/api_constants.dart';
import 'package:store/core/services/api_services.dart';

import '../../../../core/services/shared_prfs_services.dart';

class AuthRepository {
  final ApiService apiService;
  final SharedPreferenceService sharedPreferences;

  AuthRepository({required this.apiService, required this.sharedPreferences});

  Future<UserModel> login(String username, String password) async {
    final body = {'username': username.trim(), 'password': password.trim()};

    final response = await apiService.post(ApiConstants.loginEndpoint, body);

    final user = UserModel(username: username, token: response['token']);

    await sharedPreferences.setUser(user);

    return user;
  }

  Future<UserModel?> getLoggedInUser() async {
    final user = sharedPreferences.getUser();

    return user;
  }

  Future<void> logout() async {
    await sharedPreferences.clear();
  }
}
