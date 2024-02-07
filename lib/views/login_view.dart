import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../view_models/login_view_model.dart';
import '../components/custom_button.dart';
import '../components/custom_textfield.dart';
import '../constants/app_strings.dart';
import '../constants/app_colors.dart';

class LoginView extends StatelessWidget {
  LoginView({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1),
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
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.9,
                            height: MediaQuery.of(context).size.height * 0.1,
                            child: Image.asset(
                              'assets/logo-transparent.png',
                              fit: BoxFit.cover,
                            ),
                          ),

                          const SizedBox(height: 25),

                          CustomTextField(
                            controller: viewModel.usernameController,
                            labelText: AppStrings.usernameLabel,
                            prefixIcon: const Icon(Icons.person),
                            obscureText: false,
                            validator: viewModel.validateUsername,
                            onPressed: null,
                          ),

                          const SizedBox(height: 10),

                          CustomTextField(
                            controller: viewModel.passwordController,
                            labelText: AppStrings.passwordLabel,
                            prefixIcon: const Icon(Icons.lock),
                            obscureText: viewModel.obscurePassword,
                            validator: viewModel.validatePassword,
                            onPressed: viewModel.togglePasswordVisibility,
                          ),

                          const SizedBox(height: 15),

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

                          const SizedBox(height: 25),

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

                          const SizedBox(height: 50),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                AppStrings.promptRegister,
                                style: TextStyle(color: AppColors.grey),
                              ),

                              const SizedBox(width: 4),

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