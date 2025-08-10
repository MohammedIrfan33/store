import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store/app/modules/auth/model/user_model.dart';
import 'package:store/app/modules/auth/services/auth_service.dart' show AuthRepository;

class AuthController extends GetxController {
  var isLoggedIn = false.obs;
  var username = ''.obs;


  UserModel ? user;

  final AuthRepository authRepository;

  // Form key for Flutter form validation
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  var isPasswordHidden = true.obs;
  var isLoading = false.obs;

  TextEditingController usernameTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();

  AuthController({required this.authRepository});

  void togglePasswordVisibility() {
    isPasswordHidden.value = !isPasswordHidden.value;
  }

  Future<void> login() async {
    if (!(formKey.currentState?.validate() ?? false)) return;

    try {
      isLoading.value = true;

      final response = await authRepository.login(
        usernameTextController.text.trim(),
        passwordTextController.text,
      );

      user = response;

      Get.snackbar('Suceess', 'Login successfull!!');

     
    } catch (e) {
     
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  void getUser() async{



    try{

      isLoading.value = true;


       user = await  authRepository.getLoggedInUser();

    }catch (e){

      Get.snackbar('Error', e.toString());

    } finally {

       isLoading.value = false;
    }
  }

  @override
  void onClose() {
    usernameTextController.dispose();
    passwordTextController.dispose();
    super.onClose();
  }
}
