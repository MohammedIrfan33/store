// lib/app/modules/auth/bindings/auth_binding.dart

import 'package:get/get.dart';
import 'package:store/core/services/shared_prfs_services.dart';

import '../../../../core/services/api_services.dart';
import '../controllers/auth_controller.dart';
import '../repository/auth_repo.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    
    Get.lazyPut<AuthRepository>(() => AuthRepository(apiService: Get.find(),sharedPreferences: Get.find<SharedPreferenceService>()),);
    Get.lazyPut<AuthController>(() => AuthController(authRepository: Get.find()));
  }
}
