// lib/core/services/api_service.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:store/core/constants/api_constants.dart';

class ApiService {
  Future<Map<String, dynamic>> get(String endpoint) async {
    try {
      final response = await http.get(Uri.parse('${ApiConstants.baseUrl}$endpoint'));
      print(response.body);
      print(response.statusCode);

      if (response.statusCode == 200) {
    
        return json.decode(response.body);
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      throw Exception('Error during GET request: $e');
    }
  }

  Future<Map<String, dynamic>> post(String endpoint, Map<String, dynamic> body) async {
    try {
      final response = await http.post(
        Uri.parse('https://fakestoreapi.com/auth/login'
),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(body),
      );

      print(response.statusCode);
      print(response.body);

      if (response.statusCode == 201) {
        // Return decoded response
        return json.decode(response.body);
      } else {
        throw Exception('Failed to post data');
      }
    } catch (e) {
      throw Exception('Error during POST request: $e');
    }
  }
}
