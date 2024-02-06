import 'package:flutter/material.dart';

import '../models/user_model.dart';
import '../services/api_service.dart';
import '../services/storage_service.dart';

class LoginViewModel extends ChangeNotifier {
  final ApiService apiService = ApiService();

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
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
        // Redirect to the preference page
        // navigateTo('preference');
        // For testing purposes, just print the user's hasPreference value
        print(userModel.hasPreference);
      }


    } catch (e) {
      Navigator.pop(context);
      // Show an error popup
      // For testing purposes, just print the error message
      print(e.toString().replaceAll('Exception: ', ''));
    }
  }

  void registerNavigation() {
    // Redirect to the register page
    // navigateTo('register');
    // For testing purposes, just print the message
    print('Redirecting to the register page');
  }

  void togglePasswordVisibility() {
    obscurePassword = !obscurePassword;
    notifyListeners();
  }

  String? validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your username';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    return null;
  }
}