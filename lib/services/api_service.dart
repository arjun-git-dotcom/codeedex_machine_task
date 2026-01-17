import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {

  static const String baseUrl = "https://sungod.demospro2023.in.net/api";

 
  Future<Map<String, dynamic>> login(
    String emailOrPhone,
    String password,
  ) async {
    final uri = Uri.parse('$baseUrl/login').replace(
      queryParameters: {
        'email_phone': emailOrPhone,
        'password': password,
      },
    );

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      return jsonDecode(response.body) as Map<String, dynamic>;
    } else {
      throw Exception(
        'Login failed (${response.statusCode}): ${response.body}',
      );
    }
  }

  Future<Map<String, dynamic>> getHome(
    String id,
    String token,
  ) async {
    final uri = Uri.parse('$baseUrl/home/en').replace(
      queryParameters: {
        'id': id,
        'token': token,
      },
    );

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      return jsonDecode(response.body) as Map<String, dynamic>;
    } else {
      throw Exception(
        'Failed to fetch home (${response.statusCode}): ${response.body}',
      );
    }
  }

  Future<Map<String, dynamic>> getProducts(
    String id,
    String token, {
    String by = "category",
  }) async {
    final uri = Uri.parse('$baseUrl/products/en').replace(
      queryParameters: {
        'id': id,
        'token': token,
        'by': by,
      },
    );

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      return jsonDecode(response.body) as Map<String, dynamic>;
    } else {
      throw Exception(
        'Failed to fetch products (${response.statusCode}): ${response.body}',
      );
    }
  }
}
