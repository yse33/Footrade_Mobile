import 'package:flutter/material.dart';

import '../models/user_model.dart';
import '../services/api_service.dart';
import '../services/storage_service.dart';
import '../constants/app_strings.dart';

class RegisterViewModel extends ChangeNotifier {
  final ApiService apiService = ApiService();

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  bool obscurePassword = true;
  bool obscureConfirmPassword = true;
  bool isLoading = false;

  final Function(String) navigateTo;

  RegisterViewModel({required this.navigateTo});

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> registerUser(BuildContext context) async {
    try {
      if (isLoading) return;

      isLoading = true;
      notifyListeners();

      final UserModel userModel = await apiService.registerUser(
        usernameController.text,
        emailController.text,
        passwordController.text,
      );

      await StorageService.storeToken(userModel.token);
      await StorageService.storeUsername(userModel.username);

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

  void loginNavigation() {
    navigateTo('login');
  }

  void togglePasswordVisibility() {
    obscurePassword = !obscurePassword;
    notifyListeners();
  }

  void toggleConfirmPasswordVisibility() {
    obscureConfirmPassword = !obscureConfirmPassword;
    notifyListeners();
  }

  String? validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return AppStrings.usernameEmpty;
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return AppStrings.emailEmpty;
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return AppStrings.passwordEmpty;
    }
    return null;
  }

  String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return AppStrings.passwordRepeatEmpty;
    }
    if (value != passwordController.text) {
      return AppStrings.passwordMismatch;
    }
    return null;
  }
}