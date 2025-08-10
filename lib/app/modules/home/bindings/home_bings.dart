// lib/app/modules/home/bindings/home_binding.dart

import 'package:get/get.dart';

import '../../../../core/services/api_services.dart';
import '../controllers/home_controllers.dart';
import '../repository/home_repo.dart';


class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeRepository>(() => HomeRepository(apiService: Get.find<ApiService>()));
    Get.lazyPut<HomeController>(() => HomeController(repository: Get.find<HomeRepository>()));
  }
}
