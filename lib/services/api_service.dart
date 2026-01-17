import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "https://sungod.demospro2023.in.net/api";


  Future<Map<String, dynamic>> login(
    String emailOrPhone,
    String password,
  ) async {
    final uri = Uri.parse('$baseUrl/login');

   
    final response = await http.post(
      uri,
      body: {
        'email_phone': emailOrPhone,
        'password': password,
      },
    );

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

    final response = await http.post(uri);

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
    String? value,
    String? filters,
    String? sortBy,
    String? sortOrder,
    int? page,
  }) async {
    final queryParams = {
      'id': id,
      'token': token,
      'by': by,
    };

    if (value != null) queryParams['value'] = value;
    if (filters != null) queryParams['filters'] = filters;
    if (sortBy != null) queryParams['sort_by'] = sortBy;
    if (sortOrder != null) queryParams['sort_order'] = sortOrder;
    if (page != null) queryParams['page'] = page.toString();

    final uri = Uri.parse('$baseUrl/products/en').replace(
      queryParameters: queryParams,
    );

    final response = await http.post(uri);

    if (response.statusCode == 200) {
      return jsonDecode(response.body) as Map<String, dynamic>;
    } else {
      throw Exception(
        'Failed to fetch products (${response.statusCode}): ${response.body}',
      );
    }
  }
}