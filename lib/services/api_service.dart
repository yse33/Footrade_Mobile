import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';

import '../models/user_model.dart';
import '../models/shoe_search_model.dart';
import '../models/shoe_preference_model.dart';
import '../services/storage_service.dart';
import '../constants/app_strings.dart';

class ApiService {
  static final String _baseUrl = dotenv.env['API_BASE_URL']!;

  final StorageService _storageService = GetIt.instance<StorageService>();

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
    final token = await _storageService.getToken();

    if (token == null) {
      throw Exception(AppStrings.tokenNotFound);
    }

    final username = await _storageService.getUsername();

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

  Future<List<ShoeSearchModel>> searchShoes(String query, {
    int page = 0,
    int pageSize = 20,
  }) async {
    final token = await _storageService.getToken();

    if (token == null) {
      throw Exception(AppStrings.tokenNotFound);
    }

    final username = await _storageService.getUsername();

    if (username == null) {
      throw Exception(AppStrings.usernameNotFound);
    }

    final response = await http.get(
      Uri.parse('$_baseUrl/api/v1/shoes/search')
        .replace(queryParameters: {
          'query': query,
          'username': username,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization' : 'Bearer $token',
        },
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(utf8.decode(response.bodyBytes));
      return data.map((shoeData) => ShoeSearchModel.fromJson(shoeData)).toList();
    } else {
      throw Exception(AppStrings.failedSearch);
    }
  }

  Future<List<String>> getSuggestions(String query) async {
    final token = await _storageService.getToken();

    if (token == null) {
      throw Exception(AppStrings.tokenNotFound);
    }

    final response = await http.get(
      Uri.parse('$_baseUrl/api/v1/shoes/suggestions')
        .replace(queryParameters: {
          'query': query,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(utf8.decode(response.bodyBytes));
      return data.map((suggestion) => suggestion.toString()).toList();
    } else {
      throw Exception(AppStrings.failedSuggestions);
    }
  }

  Future<void> setUserFavorite(String shoeId) async {
    final token = await _storageService.getToken();

    if (token == null) {
      throw Exception(AppStrings.tokenNotFound);
    }

    final username = await _storageService.getUsername();

    if (username == null) {
      throw Exception(AppStrings.usernameNotFound);
    }

    final response = await http.put(
      Uri.parse('$_baseUrl/api/v1/auth/favorite')
        .replace(queryParameters: {
          'username': username,
          'id': shoeId,
        }),
        headers: <String, String>{
          'Authorization': 'Bearer $token',
        },
    );

    if (response.statusCode != 200) {
      throw Exception(AppStrings.failedSetFavorite);
    }
  }

  Future<List<ShoePreferenceModel>> getShoePreferences({int page = 0, int pageSize = 20}) async {
    final token = await _storageService.getToken();

    if (token == null) {
      throw Exception(AppStrings.tokenNotFound);
    }

    final username = await _storageService.getUsername();

    if (username == null) {
      throw Exception(AppStrings.usernameNotFound);
    }

    final response = await http.get(
      Uri.parse('$_baseUrl/api/v1/shoes/user/$username')
        .replace(queryParameters: {
          'page': page.toString(),
          'pageSize': pageSize.toString(),
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(utf8.decode(response.bodyBytes));
      return data.map((shoeData) => ShoePreferenceModel.fromJson(shoeData)).toList();
    } else {
      throw Exception(AppStrings.failedGetShoePreferences);
    }
  }
}