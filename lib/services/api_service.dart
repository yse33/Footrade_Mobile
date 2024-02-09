import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import '../models/user_model.dart';
import '../services/storage_service.dart';
import '../constants/app_strings.dart';

class ApiService {
  static final String _baseUrl = dotenv.env['API_BASE_URL']!;

  Future<UserModel> registerUser(String username, String email, String password) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/api/v1/auth/register'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        <String, String>{
          'username': username,
          'email': email,
          'password': password,
        },
      ),
    );

    if (response.statusCode == 200) {
      return UserModel.fromJson(jsonDecode(response.body));
    } else if (response.statusCode == 409) {
      throw Exception(jsonDecode(response.body)['message']);
    } else {
      throw Exception(AppStrings.failedRegister);
    }
  }

  Future<UserModel> loginUser(String username, String password) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/api/v1/auth/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        <String, String>{
          'username': username,
          'password': password,
        },
      ),
    );

    if (response.statusCode == 200) {
      return UserModel.fromJson(jsonDecode(response.body));
    } else if (response.statusCode == 401) {
      throw Exception(jsonDecode(response.body)['message']);
    } else {
      throw Exception(AppStrings.failedLogin);
    }
  }

  Future<void> saveUserPreference(List<String> brands, List<String> sizes) async {
    final token = await StorageService.getToken();

    if (token == null) {
      throw Exception(AppStrings.tokenNotFound);
    }

    final username = await StorageService.getUsername();

    if (username == null) {
      throw Exception(AppStrings.usernameNotFound);
    }

    final response = await http.put(
      Uri.parse('$_baseUrl/api/v1/auth/preference')
        .replace(queryParameters: {
          'username': username,
          'brands': brands.join(','),
          'sizes': sizes.join(','),
        }),
        headers: <String, String>{
          'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode != 200) {
      throw Exception(AppStrings.failedSavePreference);
    }
  }
}