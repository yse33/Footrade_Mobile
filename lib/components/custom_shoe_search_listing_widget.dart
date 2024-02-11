import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:provider/provider.dart';

import '../view_models/shoe_listing_view_model.dart';
import '../models/shoe_search_model.dart';
import '../components/custom_error_snackbar.dart';
import '../constants/app_icons.dart';
import '../constants/app_colors.dart';
import '../constants/app_dimensions.dart';

class CustomShoeSearchListingWidget extends StatelessWidget {
  final List<ShoeSearchModel> shoes;
  final String sasToken;

  const CustomShoeSearchListingWidget({
    super.key,
    required this.shoes,
    required this.sasToken,
  });

  Future<void> _toggleFavorite(BuildContext context, ShoeListingViewModel viewModel, ShoeSearchModel shoe) async {
    try {
      await viewModel.toggleFavorite(shoe);
    } catch (e) {
      if (!context.mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        CustomErrorSnackbar(message: e.toString().replaceAll('Exception: ', '')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ChangeNotifierProvider(
        create: (context) => ShoeListingViewModel(),
        child: Consumer<ShoeListingViewModel>(
          builder: (context, viewModel, _) {
            return ListView.builder(
              itemCount: shoes.length,
              itemBuilder: (context, index) {
                final ShoeSearchModel shoe = shoes[index];
                return Card(
                  elevation: 4,
                  margin: AppDimensions.standardMargin,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: InkWell(
                    child: Stack(
                      alignment: Alignment.topRight,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            CachedNetworkImage(
                              imageUrl: '${shoe.image}?$sasToken',
                              width: double.infinity,
                              height: 300,
                              fit: BoxFit.cover,
                              alignment: Alignment.center,
                            ),
                            Padding(
                              padding: AppDimensions.standardPadding,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    shoe.model,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    shoe.brand,
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        IconButton(
                          icon: Icon(
                            shoe.isFavorite ? AppIcons.favorite : AppIcons.favoriteBorder,
                            color: AppColors.yellow,
                            size: 34,
                          ),
                          onPressed: () async {
                            await _toggleFavorite(context, viewModel, shoe);
                          },
                        )
                      ],
                    ),
                  ),
                );
              },
            );
          }
        ),
      ),
    );
  }
}