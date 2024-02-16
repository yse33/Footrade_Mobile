import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:provider/provider.dart';

import '../view_models/shoe_listing_view_model.dart';
import '../models/shoe_listing_model.dart';
import '../constants/app_icons.dart';
import '../constants/app_colors.dart';
import '../constants/app_strings.dart';

class CustomShoeListingWidget extends StatelessWidget {
  final List<ShoeListingModel> shoes;
  final String sasToken;
  final void Function(String) onItemClick;

  const CustomShoeListingWidget({
    Key? key,
    required this.shoes,
    required this.sasToken,
    required this.onItemClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ShoeListingViewModel(),
      child: Consumer<ShoeListingViewModel>(
        builder: (context, viewModel, _) {
          return Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 1.0,
              mainAxisSpacing: 4.0,
              childAspectRatio: 0.6,
              children: List.generate(shoes.length, (index) {
                final ShoeListingModel shoe = shoes[index];
                return GestureDetector(
                  onTap: () {
                    onItemClick(shoe.id);
                  },
                  child: Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    child: Stack(
                      alignment: Alignment.topRight,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CachedNetworkImage(
                              imageUrl: '${shoe.image}?$sasToken',
                              width: double.infinity,
                              height: 180,
                              fit: BoxFit.cover,
                              alignment: Alignment.center,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    shoe.model,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'Brand: ${shoe.brand}',
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Visibility(
                                    visible: shoe.newPrice != 0.0,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          '${shoe.newPrice}лв.',
                                          style: const TextStyle(
                                            fontSize: 18,
                                            color: AppColors.red,
                                          ),
                                        ),
                                        Text(
                                          '${shoe.oldPrice}лв.',
                                          style: const TextStyle(
                                            fontSize: 14,
                                            color: AppColors.grey,
                                            decoration: TextDecoration.lineThrough,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Visibility(
                                    visible: shoe.newPrice == 0.0,
                                    child: const Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          AppStrings.shoeNotOnSale,
                                          style: TextStyle(
                                            fontSize: 18,
                                            color: AppColors.grey,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        IconButton(
                          icon: Icon(
                            shoe.isFavorite ? AppIcons.favorite : AppIcons.favoriteBorder,
                            color: shoe.isFavorite ? AppColors.yellow : AppColors.grey,
                          ),
                          onPressed: () {
                            viewModel.toggleFavorite(shoe);
                          },
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
          );
        },
      ),
    );
  }
}