// lib/app/modules/home/controllers/home_controller.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store/app/modules/home/model/product_model.dart' show ProductModel;
import 'package:store/app/modules/home/repository/home_repo.dart';
import 'package:store/app/modules/auth/controllers/auth_controller.dart'; 
class HomeController extends GetxController {
  final HomeRepository repository;
  final AuthController authController = Get.find<AuthController>();
  HomeController({required this.repository});

  var products = <ProductModel>[].obs;
  var filteredProducts = <ProductModel>[].obs; 
  var selectedProduct = Rxn<ProductModel>();
  var isLoading = false.obs;
  var searchQuery = "".obs; 


  @override
  void onInit() {
        

    super.onInit();
      WidgetsBinding.instance.addPostFrameCallback((_) {
    fetchProducts();
  });

   
  }

 

  Future<void> fetchProducts() async {
    try {
      isLoading.value = true;
      await authController.getUser();
      final fetchedProducts = await repository.getProducts();
      products.value = fetchedProducts;
      filteredProducts.value = fetchedProducts; 
    } catch (e) {
      
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  void searchProducts(String query) {
    searchQuery.value = query.trim().toLowerCase();

    if (searchQuery.value.isEmpty) {
      
      filteredProducts.value = products;
    } else {
      filteredProducts.value = products.where((product) {
        final titleMatch = product.title.toLowerCase().contains(searchQuery.value);
        final categoryMatch = product.category.toLowerCase().contains(searchQuery.value);
        return titleMatch || categoryMatch;
      }).toList();
    }
  }

  Future<void> fetchProductDetail(int id) async {
  
      isLoading.value = true;

      selectedProduct.value = await repository.getProductById(id);
    
  
      isLoading.value = false;
    
  }

  Future<void> logout() async {
    try {
      await authController.logOut();
      Get.offNamedUntil('/login',(route) => false,);
    } catch (e) {
      Get.snackbar("Logout Error", "Failed to log out: ${e.toString()}");
    }
  }

}
