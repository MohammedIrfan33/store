import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:remixicon/remixicon.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/widgets/button_widget.dart';
import '../../../../core/widgets/custom_text_filed.dart' show CustomTextField;
import '../controllers/auth_controller.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final AuthController authController = Get.put(
    AuthController(authRepository: Get.find()),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
        
          child: Form(
            key: authController
                .formKey, // Wrap inputs with Form and assign formKey
            child: Obx(() {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 55.h),
        
                  Text(
                    "Login Account",
                    style: TextStyle(
                      fontSize: 25.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5),
        
                  Text(
                    "Please login to your account. with\nuser name and password",
                    style: TextStyle(
                      color: AppColors.kTextGrey,
                      fontWeight: FontWeight.w500,
                      fontSize: 15.sp,
                    ),
                  ),
                  SizedBox(height: 40.h),
        
                  CustomTextField(
                    controller: authController.usernameTextController,
                    icon: RemixIcons.user_line,
                    hintText: "Enter your username",
                    labelText: "Username",
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Username cannot be empty';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20.h),
        
                  CustomTextField(
                    controller: authController.passwordTextController,
                    icon: RemixIcons.lock_line,
                    hintText: "Enter your password",
                    labelText: "Password",
        
                    obscureText: authController.isPasswordHidden.value,
        
                    sufficIcon: GestureDetector(
                      onTap: () {
                        authController.togglePasswordVisibility();
                      },
                      child: Icon(
                        authController.isPasswordHidden.value? RemixIcons.eye_off_line : RemixIcons.eye_line,
                        color: AppColors.kprimaryColor,
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Password cannot be empty';
                      } else if (value.length < 6) {
                        return 'Password must be at least 6 characters';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20.h),
        
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        // TODO: implement forgot password functionality if needed
                      },
                      child: Text(
                        "Forgot Password?",
                        style: TextStyle(color: AppColors.kprimaryColor),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
        
                  authController.isLoading.value
                      ? Center(child: CircularProgressIndicator(color: AppColors.kprimaryColor,))
                      : SizedBox(
                          width: double.maxFinite,
                          height: 50.h,
                          child: ButtonWidget(
                            onPressed: () async {
                              await authController.login();
                            },
                            text: 'Login',
                          ),
                        ),
                  SizedBox(height: 20.h),
        
        Center(
          child: RichText(
            text: TextSpan(
        text: "Don't have an account? ",
        style: TextStyle(color: Colors.black87, fontSize: 14.sp),
        children: [
          TextSpan(
            text: "Sign up",
            style: TextStyle(
              color: AppColors.kprimaryColor,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.underline,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
              },
          ),
        ],
            ),
          ),
        ),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}
