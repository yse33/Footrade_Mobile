import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../models/user_model.dart';
import '../services/api_service.dart';
import '../services/storage_service.dart';
import '../constants/app_strings.dart';

class LoginViewModel extends ChangeNotifier {
  final Function(String) navigateTo;

  LoginViewModel({required this.navigateTo});

  final ApiService _apiService = GetIt.I.get<ApiService>();
  final StorageService _storageService = GetIt.I.get<StorageService>();

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool obscurePassword = true;
  bool isLoading = false;

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> loginUser(BuildContext context) async {
    try {
      if (isLoading) return;

      isLoading = true;
      notifyListeners();

      final UserModel userModel = await _apiService.loginUser(
        usernameController.text,
        passwordController.text,
      );

      await _storageService.storeToken(userModel.token);
      await _storageService.storeUsername(userModel.username);

      if (userModel.hasPreference) {
        // Redirect to the home page
        // navigateTo('home');
        // For testing purposes, just print the user's hasPreference value
        print(userModel.hasPreference);
      } else {
        navigateTo('preference');
      }
    } catch (e) {
      throw Exception(e.toString().replaceAll('Exception: ', ''));
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void registerNavigation() {
    navigateTo('register');
  }

  void togglePasswordVisibility() {
    obscurePassword = !obscurePassword;
    notifyListeners();
  }

  String? validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return AppStrings.usernameEmpty;
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return AppStrings.passwordEmpty;
    }
    return null;
  }
}