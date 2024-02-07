import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../view_models/register_view_model.dart';
import '../components/custom_button.dart';
import '../constants/app_strings.dart';

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
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.9,
                          height: MediaQuery.of(context).size.height * 0.1,
                          child: Image.asset(
                            'assets/logo-transparent.png',
                            fit: BoxFit.cover,
                          ),
                        ),

                        const SizedBox(height: 25),

                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: TextFormField(
                            controller: viewModel.usernameController,
                            decoration: InputDecoration(
                              labelText: AppStrings.usernameLabel,
                              prefixIcon: const Icon(Icons.person),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            validator: viewModel.validateUsername,
                          ),
                        ),

                        const SizedBox(height: 10),

                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: TextFormField(
                            controller: viewModel.emailController,
                            decoration: InputDecoration(
                              labelText: AppStrings.emailLabel,
                              prefixIcon: const Icon(Icons.email),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            validator: viewModel.validateEmail,
                          ),
                        ),

                        const SizedBox(height: 10),

                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: TextFormField(
                            controller: viewModel.passwordController,
                            decoration: InputDecoration(
                              labelText: AppStrings.passwordLabel,
                              prefixIcon: const Icon(Icons.lock),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  viewModel.obscurePassword
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                                onPressed: () {
                                  viewModel.togglePasswordVisibility();
                                },
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            validator: viewModel.validatePassword,
                            obscureText: viewModel.obscurePassword,
                          ),
                        ),

                        const SizedBox(height: 10),

                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: TextFormField(
                            controller: viewModel.confirmPasswordController,
                            decoration: InputDecoration(
                              labelText: AppStrings.passwordRepeatLabel,
                              prefixIcon: const Icon(Icons.key),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  viewModel.obscureConfirmPassword
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                                onPressed: () {
                                  viewModel.toggleConfirmPasswordVisibility();
                                },
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            validator: viewModel.validateConfirmPassword,
                            obscureText: viewModel.obscureConfirmPassword,
                          ),
                        ),

                        const SizedBox(height: 25),

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

                        const SizedBox(height: 25),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              AppStrings.promptLogin,
                              style: TextStyle(color: Colors.grey[700]),
                            ),

                            const SizedBox(width: 4),

                            TextButton(
                              onPressed: () {
                                viewModel.loginNavigation();
                              },
                              child: const Text(
                                AppStrings.loginText,
                                style: TextStyle(
                                  color: Colors.blue,
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