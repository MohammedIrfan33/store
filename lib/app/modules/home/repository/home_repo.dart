// lib/app/modules/home/repository/home_repository.dart

import 'package:store/app/modules/home/model/product_model.dart';
import 'package:store/core/constants/api_constants.dart';
import 'package:store/core/services/api_services.dart';

class HomeRepository {
  final ApiService apiService;

  HomeRepository({required this.apiService});

  Future<List<ProductModel>> getProducts() async {
    final response = await apiService.get(ApiConstants.productList);
    final List data = response;
    return data.map((e) => ProductModel.fromJson(e)).toList();
  }

  Future<ProductModel> getProductById(int id) async {
    final response = await apiService.get("${ApiConstants.productDetails}$id");
    return ProductModel.fromJson(response);
  }
}
