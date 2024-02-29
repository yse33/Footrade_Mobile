import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../view_models/login_view_model.dart';
import '../components/custom_button.dart';
import '../components/custom_textfield.dart';
import '../components/custom_logo.dart';
import '../components/custom_error_snackbar.dart';
import '../constants/app_strings.dart';
import '../constants/app_colors.dart';
import '../constants/app_dimensions.dart';
import '../constants/app_icons.dart';

class LoginView extends StatelessWidget {
  LoginView({super.key});

  final _formKey = GlobalKey<FormState>();

  Future<void> _loginUser(BuildContext context, LoginViewModel viewModel) async {
    try {
      await viewModel.loginUser(context);
    } catch (e) {
      if (!context.mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        CustomErrorSnackbar(message: e.toString().replaceAll('Exception: ', '')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * AppDimensions.standardPaddingMultiplier
          ),
          child: Center(
            child: ChangeNotifierProvider(
              create: (context) => LoginViewModel(
                navigateTo: (routeName) {
                  Navigator.pushNamed(context, routeName);
                },
              ),
              child: Consumer<LoginViewModel>(
                builder: (context, viewModel, _) {
                  return Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const CustomLogo(),

                        AppDimensions.sizedBoxH25,

                        CustomTextField(
                          controller: viewModel.usernameController,
                          labelText: AppStrings.usernameLabel,
                          prefixIcon: AppIcons.user,
                          obscureText: false,
                          validator: viewModel.validateUsername,
                          onPressed: null,
                        ),

                        AppDimensions.sizedBoxH10,

                        CustomTextField(
                          controller: viewModel.passwordController,
                          labelText: AppStrings.passwordLabel,
                          prefixIcon: AppIcons.password,
                          obscureText: viewModel.obscurePassword,
                          validator: viewModel.validatePassword,
                          onPressed: viewModel.togglePasswordVisibility,
                        ),

                        AppDimensions.sizedBoxH25,

                        CustomButton(
                          text: AppStrings.loginText,
                          isLoading: viewModel.isLoading,
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              await _loginUser(context, viewModel);
                            }
                          },
                        ),

                        AppDimensions.sizedBoxH50,

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              AppStrings.promptRegister,
                              style: TextStyle(color: AppColors.grey),
                            ),

                            AppDimensions.sizedBoxH10,

                            TextButton(
                              onPressed: () {
                                viewModel.registerNavigation();
                              },
                              child: const Text(
                                AppStrings.registerText,
                                style: TextStyle(
                                  color: AppColors.blue,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }
              )
            )
          )
        )
      )
    );
  }
}