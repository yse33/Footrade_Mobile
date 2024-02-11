import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../view_models/preference_view_model.dart';
import '../components/custom_warning_snackbar.dart';
import '../constants/app_strings.dart';
import '../constants/app_colors.dart';
import '../constants/app_dimensions.dart';

class PreferenceView extends StatelessWidget {
  const PreferenceView({super.key});

  Widget _buildBrandList(BuildContext context, PreferenceViewModel viewModel) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
      ),
      itemCount: viewModel.brands.length,
      itemBuilder: (context, index) {
        final brand = viewModel.brands[index];
        return GestureDetector(
          onTap: () {
            viewModel.toggleBrand(brand);
          },
          child: Container(
            margin: AppDimensions.standardMargin,
            padding: AppDimensions.standardPadding,
            decoration: BoxDecoration(
              color: brand.isSelected ? AppColors.grey : null,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Image.asset(
              brand.image,
              width: 50,
              height: 50,
            ),
          ),
        );
      },
    );
  }

  Future<void> _showSizeDialog(BuildContext context, PreferenceViewModel viewModel) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: const Text(
                AppStrings.sizeDialogTitle,
                textAlign: TextAlign.center,
              ),
              content: SingleChildScrollView(
                child: Column(
                  children: viewModel.sizes.map((size) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          viewModel.toggleSize(size);
                        });
                      },
                      child: Card(
                        elevation: 4.0,
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          side: const BorderSide(color: AppColors.grey, width: 2),
                        ),
                        child: Padding(
                          padding: AppDimensions.standardPadding,
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  size.size,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Checkbox(
                                value: size.isSelected,
                                onChanged: (bool? value) {
                                  setState(() {
                                    viewModel.toggleSize(size);
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text(AppStrings.sizeDialogConfirm),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Future<void> _savePreferences(BuildContext context, PreferenceViewModel viewModel) async {
    try {
      await viewModel.savePreferences();
    } catch (e) {
      if (!context.mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        CustomWarningSnackbar(message: e.toString().replaceAll('Exception: ', '')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.brandDialogTitle),
      ),
      body: Center(
        child: ChangeNotifierProvider(
          create: (context) => PreferenceViewModel(),
          child: Consumer<PreferenceViewModel>(
            builder: (context, viewModel, _) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: _buildBrandList(context, viewModel),
                  ),
                  GestureDetector(
                    onTap: () {
                      _showSizeDialog(context, viewModel);
                    },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 20),
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(32),
                        border: Border.all(color: AppColors.grey, width: 1.5),
                      ),
                      child: const Text(
                        AppStrings.sizeButtonText,
                        style: TextStyle(
                          color: AppColors.black,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    child: ElevatedButton(
                      onPressed: () async {
                        await _savePreferences(context, viewModel);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.black,
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32),
                        ),
                      ),
                      child: const Text(
                        AppStrings.setPreference,
                        style: TextStyle(
                          color: AppColors.white,
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}