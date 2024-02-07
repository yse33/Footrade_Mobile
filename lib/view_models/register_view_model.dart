import 'package:flutter/material.dart';

import '../components/custom_error_snackbar.dart';
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
      final UserModel userModel = await apiService.registerUser(
        usernameController.text,
        emailController.text,
        passwordController.text,
      );

      await StorageService.storeToken(userModel.token);
      await StorageService.storeUsername(userModel.username);

      if (!context.mounted) return;
      Navigator.popUntil(context, (route) => route.isFirst);

      if (userModel.hasPreference) {
        // Redirect to the home page
        // navigateTo('home');
        // For testing purposes, just print the user's hasPreference value
        print(userModel.hasPreference);
      } else {
        // Redirect to the preference page
        // navigateTo('preference');
        // For testing purposes, just print the user's hasPreference value
        print(userModel.hasPreference);
      }
    } catch (e) {
      Navigator.pop(context);

      ScaffoldMessenger.of(context).showSnackBar(
        CustomErrorSnackbar(
          message: e.toString().replaceAll('Exception: ', ''),
        ),
      );
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