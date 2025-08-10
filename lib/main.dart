// lib/main.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:store/core/constants/app_colors.dart';
import 'package:store/core/services/shared_prfs_services.dart';
import 'routes.dart';

void main()async {

  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();
  Get.put<SharedPreferenceService>(SharedPreferenceService(prefs), permanent: true);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
   

    return ScreenUtilInit(
      designSize: const Size(360.0,712.0),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, state) {
        return GetMaterialApp(
          theme: ThemeData(
            fontFamily: 'Montserrat',
            scaffoldBackgroundColor: AppColors.kWhite,
          ),
          title: 'Store',
          initialRoute: AppPages.INITIAL,
          getPages: AppPages.routes,
        );
      },
    );
  }
}
