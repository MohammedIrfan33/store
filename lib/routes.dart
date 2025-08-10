// lib/routes.dart

import 'package:get/get.dart';
import 'package:store/app/modules/auth/views/login_screen.dart';

import 'app/modules/auth/bindings/auth_bindings.dart';


class AppPages {
  static const INITIAL = '/login';

  static final routes = [
    GetPage(
      name: '/login',
      page: () => LoginScreen(),
      binding: AuthBinding(),
    ),
  ];
}
