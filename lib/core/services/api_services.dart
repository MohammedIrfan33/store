// lib/core/services/api_service.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:store/core/constants/api_constants.dart';

import '../utils/api_response_handler.dart';

class ApiService {
  Future<dynamic> get(String endpoint) async {
    try {
      final response = await http.get(Uri.parse('${ApiConstants.baseUrl}$endpoint'));
      
     return ApiResponseHandler.handleResponse(response);

    } catch (e) {
      throw Exception('Error during GET request: $e');
    }
  }

  Future<Map<String, dynamic>> post(String endpoint, Map<String, dynamic> body) async {
      final response = await http.post(
        Uri.parse('${ApiConstants.baseUrl}$endpoint'
),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(body),
      );

           return ApiResponseHandler.handleResponse(response);

      
    
  }
}
