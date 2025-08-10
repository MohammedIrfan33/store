import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiResponseHandler {
  static dynamic handleResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        return json.decode(response.body);
      case 201:
        return json.decode(response.body);
      case 400:
        throw Exception('Please check your input');
      case 401:
        throw Exception('Invalid username or password');
      case 403:
        throw Exception('You don\'t have access');
      case 404:
        throw Exception('The requested resource was not found');
      case 500:
        throw Exception('Please try again later');
      default:
        throw Exception('Server error: ${response.statusCode}');
    }
  }
}
