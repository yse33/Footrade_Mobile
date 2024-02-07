import 'package:flutter/material.dart';
import 'package:footrade_mvvm/components/custom_logo.dart';
import 'package:provider/provider.dart';

import '../view_models/register_view_model.dart';
import '../components/custom_button.dart';
import '../components/custom_textfield.dart';
import '../constants/app_strings.dart';
import '../constants/app_colors.dart';
import '../constants/app_dimensions.dart';

class RegisterView extends StatelessWidget {
  RegisterView({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1),
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
                          prefixIcon: const Icon(Icons.person),
                          obscureText: false,
                          validator: viewModel.validateUsername,
                          onPressed: null,
                        ),

                        const SizedBox(height: AppDimensions.smallSizedBox),

                        CustomTextField(
                          controller: viewModel.emailController,
                          labelText: AppStrings.emailLabel,
                          prefixIcon: const Icon(Icons.email),
                          obscureText: false,
                          validator: viewModel.validateEmail,
                          onPressed: null,
                        ),

                        const SizedBox(height: AppDimensions.smallSizedBox),

                        CustomTextField(
                          controller: viewModel.passwordController,
                          labelText: AppStrings.passwordLabel,
                          prefixIcon: const Icon(Icons.lock),
                          obscureText: viewModel.obscurePassword,
                          validator: viewModel.validatePassword,
                          onPressed: viewModel.togglePasswordVisibility,
                        ),

                        const SizedBox(height: AppDimensions.smallSizedBox),

                        CustomTextField(
                          controller: viewModel.confirmPasswordController,
                          labelText: AppStrings.passwordRepeatLabel,
                          prefixIcon: const Icon(Icons.lock),
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

                              viewModel.registerUser(context);
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
                    )
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