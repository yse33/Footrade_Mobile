import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/shoe_detail_model.dart';
import '../view_models/shoe_preference_view_model.dart';
import '../views/shoe_detail_view.dart';
import '../components/custom_shoe_listing_widget.dart';
import '../components/custom_error_snackbar.dart';
import '../components/custom_pagination_widget.dart';
import '../constants/app_strings.dart';

class ShoePreferenceView extends StatefulWidget {
  const ShoePreferenceView({Key? key}) : super(key: key);

  @override
  State<ShoePreferenceView> createState() => _ShoePreferenceViewState();
}

class _ShoePreferenceViewState extends State<ShoePreferenceView> {
  late final ShoePreferenceViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = Provider.of<ShoePreferenceViewModel>(context, listen: false);
    Future.delayed(Duration.zero, () {
      viewModel.fetchShoes();
    });
  }

  void _onItemClick(String id) async {
    try {
      ShoeDetailModel shoe = await viewModel.onItemClick(id);

      if(!context.mounted) return;

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ShoeDetailView(shoe: shoe),
        ),
      );
    } on Exception catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: CustomErrorSnackbar(
            message: e.toString(),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ShoePreferenceViewModel>(
      builder: (context, viewModel, child) {
        return Column(
          children: [
            if (viewModel.isLoading)
              const Center(
                child: CircularProgressIndicator(),
              )
            else if (viewModel.hasError)
              SnackBar(
                content: CustomErrorSnackbar(
                  message: AppStrings.failedGetShoePreferences,
                ),
              )
            else if (viewModel.shoes.isEmpty)
                const Center(
                  child: Text(AppStrings.shoePreferencesEmpty),
                )
              else
                CustomShoeListingWidget(
                  shoes: viewModel.shoes,
                  sasToken: viewModel.sasToken,
                  onItemClick: (String id) => _onItemClick(id),
                ),
            CustomPaginationWidget(
              viewModel: viewModel,
            ),
          ],
        );
      },
    );
  }
}