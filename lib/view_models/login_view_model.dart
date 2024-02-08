import 'package:flutter/material.dart';

import '../components/custom_error_snackbar.dart';
import '../models/user_model.dart';
import '../services/api_service.dart';
import '../services/storage_service.dart';
import '../constants/app_strings.dart';

class LoginViewModel extends ChangeNotifier {
  final ApiService apiService = ApiService();

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool obscurePassword = true;

  final Function(String) navigateTo;

  LoginViewModel({required this.navigateTo});

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> loginUser(BuildContext context) async {
    try {
      final UserModel userModel = await apiService.loginUser(
        usernameController.text,
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
        navigateTo('preference');
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