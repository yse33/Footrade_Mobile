import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../view_models/register_view_model.dart';
import '../components/custom_button.dart';
import '../components/custom_textfield.dart';
import '../components/custom_logo.dart';
import '../components/custom_error_snackbar.dart';
import '../constants/app_strings.dart';
import '../constants/app_colors.dart';
import '../constants/app_dimensions.dart';
import '../constants/app_icons.dart';

class RegisterView extends StatelessWidget {
  RegisterView({super.key});

  final _formKey = GlobalKey<FormState>();

  Future<void> _registerUser(BuildContext context, RegisterViewModel viewModel) async {
    try {
      await viewModel.registerUser(context);
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
              create: (context) => RegisterViewModel(
                navigateTo: (routeName) {
                  Navigator.pushNamed(context, routeName);
                }
              ),
              child: Consumer<RegisterViewModel>(
                builder: (context, viewModel, _) {
                  return Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const CustomLogo(),

                        const SizedBox(height: AppDimensions.mediumSizedBox),

                        CustomTextField(
                          controller: viewModel.usernameController,
                          labelText: AppStrings.usernameLabel,
                          prefixIcon: AppIcons.username,
                          obscureText: false,
                          validator: viewModel.validateUsername,
                          onPressed: null,
                        ),

                        const SizedBox(height: AppDimensions.smallSizedBox),

                        CustomTextField(
                          controller: viewModel.emailController,
                          labelText: AppStrings.emailLabel,
                          prefixIcon: AppIcons.email,
                          obscureText: false,
                          validator: viewModel.validateEmail,
                          onPressed: null,
                        ),

                        const SizedBox(height: AppDimensions.smallSizedBox),

                        CustomTextField(
                          controller: viewModel.passwordController,
                          labelText: AppStrings.passwordLabel,
                          prefixIcon: AppIcons.password,
                          obscureText: viewModel.obscurePassword,
                          validator: viewModel.validatePassword,
                          onPressed: viewModel.togglePasswordVisibility,
                        ),

                        const SizedBox(height: AppDimensions.smallSizedBox),

                        CustomTextField(
                          controller: viewModel.confirmPasswordController,
                          labelText: AppStrings.passwordRepeatLabel,
                          prefixIcon: AppIcons.password,
                          obscureText: viewModel.obscureConfirmPassword,
                          validator: viewModel.validateConfirmPassword,
                          onPressed: viewModel.toggleConfirmPasswordVisibility,
                        ),

                        const SizedBox(height: AppDimensions.mediumSizedBox),

                        CustomButton(
                          text: AppStrings.registerButton,
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                },
                              );

                              _registerUser(context, viewModel);
                            }
                          },
                        ),

                        const SizedBox(height: AppDimensions.mediumSizedBox),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              AppStrings.promptLogin,
                              style: TextStyle(color: AppColors.grey),
                            ),

                            const SizedBox(width: AppDimensions.smallSizedBox),

                            TextButton(
                              onPressed: () {
                                viewModel.loginNavigation();
                              },
                              child: const Text(
                                AppStrings.loginText,
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