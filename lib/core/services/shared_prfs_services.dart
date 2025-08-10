// lib/core/services/shared_preference_service.dart

import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:store/app/modules/auth/model/user_model.dart';

class SharedPreferenceService {
  final SharedPreferences _prefs;

  SharedPreferenceService(this._prefs);

  static const String _userKey = 'user_model';

  Future<void> setUser(UserModel user) async {
    final userJson = jsonEncode(user.toJson());
    await _prefs.setString(_userKey, userJson);
  }

  UserModel? getUser() {
    final userJson = _prefs.getString(_userKey);
    if (userJson == null) return null;

    final Map<String, dynamic> userMap = jsonDecode(userJson);
   
   
    return UserModel.fromJson(userMap);
  }


  bool isLoggind() {
    final userJson = _prefs.getString(_userKey);
    if (userJson == null) return false;

    final Map<String, dynamic> userMap = jsonDecode(userJson);




    if(userMap['token'] != '' || userMap['token'] != null){

      return true;
    }
   
   
    return  false;
  }


  Future<bool> clear() async {
    return await _prefs.clear();
  }
}
