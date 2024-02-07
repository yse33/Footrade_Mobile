import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../view_models/login_view_model.dart';
import '../components/custom_button.dart';
import '../components/custom_textfield.dart';
import '../components/custom_logo.dart';
import '../constants/app_strings.dart';
import '../constants/app_colors.dart';
import '../constants/app_dimensions.dart';
import '../constants/app_icons.dart';

class LoginView extends StatelessWidget {
  LoginView({super.key});

  final _formKey = GlobalKey<FormState>();

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
                }
              ),
              child: Consumer<LoginViewModel>(
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
                          controller: viewModel.passwordController,
                          labelText: AppStrings.passwordLabel,
                          prefixIcon: AppIcons.password,
                          obscureText: viewModel.obscurePassword,
                          validator: viewModel.validatePassword,
                          onPressed: viewModel.togglePasswordVisibility,
                        ),

                        const SizedBox(height: AppDimensions.smallSizedBox),

                        InkWell(
                          onTap: () {
                            // TODO: Implement forgot password
                          },
                          child: const Text(
                            AppStrings.forgotPassword,
                            style: TextStyle(
                              color: AppColors.grey,
                            ),
                          ),
                        ),

                        const SizedBox(height: AppDimensions.mediumSizedBox),

                        CustomButton(
                          text: AppStrings.loginButton,
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

                              viewModel.loginUser(context);
                            }
                          },
                        ),

                        const SizedBox(height: AppDimensions.largeSizedBox),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              AppStrings.promptRegister,
                              style: TextStyle(color: AppColors.grey),
                            ),

                            const SizedBox(width: AppDimensions.smallSizedBox),

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