// lib/routes.dart

import 'package:get/get.dart';
import 'package:store/app/modules/auth/views/login_view.dart';
import 'package:store/app/modules/home/bindings/home_bings.dart' show HomeBinding;
import 'package:store/app/modules/home/views/home_view.dart' show HomeView;
import 'package:store/app/modules/home/views/product_details_view.dart' show ProductDetailView;

import 'app/modules/auth/bindings/auth_bindings.dart';


class AppPages {

  static final routes = [
    GetPage(
      name: '/login',
      page: () => LoginScreen(),
      binding: AuthBinding(),
    ),

    GetPage(
  name: '/home',
  page: () => const HomeView(),
  bindings:[ HomeBinding(),AuthBinding()],
),
GetPage(
  name: '/product-detail',
  page: () => const ProductDetailView(),
  binding: HomeBinding(), // Reuse home binding
),

  ];
}
