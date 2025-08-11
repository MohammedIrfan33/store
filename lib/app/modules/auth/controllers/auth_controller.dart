import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store/app/modules/auth/model/user_model.dart';
import 'package:store/app/modules/auth/repository/auth_repo.dart' show AuthRepository;

class AuthController extends GetxController {
  var isLoggedIn = false.obs;
  var username = ''.obs;


  UserModel ? user;

  final AuthRepository authRepository;

  // Form key for Flutter form validation
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  var isPasswordHidden = true.obs;
  var isLoading = false.obs;

  
  AuthController({required this.authRepository});

  void togglePasswordVisibility() {
    isPasswordHidden.value = !isPasswordHidden.value;
  }

  Future<void> login(String username,String password) async {
    if (!(formKey.currentState?.validate() ?? false)) return;

    try {
      isLoading.value = true;

      final response = await authRepository.login(
        username,
        password
       
      );

      user = response;

      Get.snackbar('Suceess', 'Login successfull!!');

      Get.offAndToNamed('/home');

     
    } catch (e) {
     
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getUser() async{



    try{

      isLoading.value = true;


       user = await  authRepository.getLoggedInUser();

    }catch (e){

      Get.snackbar('Error', e.toString());

    } finally {

       isLoading.value = false;
    }
  }


  Future<void> logOut() async{

    try{

       isLoading.value = true;


       await  authRepository.logout();

    }catch (e){

      Get.snackbar('Error', e.toString());



    }finally{

      isLoading.value = false;

    }



  }

  

  @override
  void onClose() {
   
    super.onClose();
  }
}
