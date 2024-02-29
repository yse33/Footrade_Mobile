import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../models/user_model.dart';
import '../services/api_service.dart';
import '../services/storage_service.dart';
import '../constants/app_strings.dart';

class RegisterViewModel extends ChangeNotifier {
  final Function(String) navigateTo;

  RegisterViewModel({required this.navigateTo});

  final ApiService _apiService = GetIt.I.get<ApiService>();
  final StorageService _storageService = GetIt.I.get<StorageService>();

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  bool obscurePassword = true;
  bool obscureConfirmPassword = true;
  bool isLoading = false;

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

      final UserModel userModel = await _apiService.registerUser(
        usernameController.text,
        emailController.text,
        passwordController.text,
      );

      await _storageService.storeToken(userModel.token);

      await _apiService.saveUserDeviceToken();

      if (userModel.hasPreference) {
        navigateTo('home');
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