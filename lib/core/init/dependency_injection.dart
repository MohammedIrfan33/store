import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/api_services.dart';
import '../services/shared_prfs_services.dart';

Future<void> initServices() async {
  // SharedPreferences
  final prefs = await SharedPreferences.getInstance();
  Get.put<SharedPreferenceService>(
    SharedPreferenceService(prefs),
    permanent: true,
  );

  // API Service
  Get.put<ApiService>(
    ApiService(),
    permanent: true,
  );

  
}
