// lib/core/repositories/auth_repository.dart

import 'package:shared_preferences/shared_preferences.dart';
import 'package:store/app/modules/auth/model/user_model.dart';
import 'package:store/core/constants/api_constants.dart';
import 'package:store/core/services/api_services.dart';

import '../../../../core/services/shared_prfs_services.dart';

class AuthRepository {
  final ApiService apiService;
  final SharedPreferenceService sharedPreferences;

  static const _keyUsername = 'username';
  static const _keyIsLoggedIn = 'isLoggedIn';
  static const _keyToken = 'token';

  AuthRepository({
    required this.apiService,
    required this.sharedPreferences,
  });

  Future<UserModel> login(String username, String password) async {
    try {
      final body = {
        'username': username.trim(),
        'password': password.trim(),
      };

      final response = await apiService.post(ApiConstants.loginEndpoint, body);

        

        final user = UserModel(username: username, token: response['token'] );


 
        await sharedPreferences.setUser(user);

        return user;
       
        
    } catch (e) {
      throw Exception(e.toString);
    }
  }

  Future<UserModel?> getLoggedInUser() async {
    try {
       final  user =  await sharedPreferences.getUser();

      return user;
    } catch (e) {
      throw Exception('Error retrieving logged in user: ${e.toString()}');
    }
  }

  Future<void> logout() async {
    try {
      await sharedPreferences.clear();
     
    } catch (e) {
      throw Exception('Error during logout: ${e.toString()}');
    }
  }
}
