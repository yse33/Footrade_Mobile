import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:provider/provider.dart';

import '../view_models/shoe_detail_view_model.dart';
import '../models/shoe_detail_model.dart';
import '../constants/app_strings.dart';
import '../constants/app_colors.dart';
import '../constants/app_icons.dart';
import '../constants/app_dimensions.dart';

class ShoeDetailView extends StatelessWidget {
  final ShoeDetailModel shoe;

  const ShoeDetailView({
    Key? key, required this.shoe,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.shoeDetailTitle),
      ),
      body: SingleChildScrollView(
        child: ChangeNotifierProvider(
          create: (context) => ShoeDetailViewModel(shoe: shoe),
          child: Consumer<ShoeDetailViewModel>(
            builder: (context, viewModel, _) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    height: 350,
                    child: PageView.builder(
                      controller: viewModel.pageController,
                      itemCount: shoe.images.length,
                      itemBuilder: (context, index) {
                        return CachedNetworkImage(
                          imageUrl: '${shoe.images[index]}?${viewModel.sasToken}',
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        );
                      },
                    ),
                  ),

                  AppDimensions.sizedBoxH10,

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: const Icon(AppIcons.arrowBack),
                        onPressed: () {
                          viewModel.previousPage();
                        }
                      ),
                      IconButton(
                        icon: const Icon(Icons.arrow_forward),
                        onPressed: () {
                          viewModel.nextPage();
                        },
                      ),
                    ]
                  ),

                  AppDimensions.sizedBoxH10,

                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          shoe.brand,
                          style: const TextStyle(fontSize: 16, color: AppColors.grey),
                        ),

                        Text(
                          shoe.model,
                          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                        ),

                        AppDimensions.sizedBoxH25,

                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: '${shoe.newPrice.toString()} лв.',
                                style: const TextStyle(
                                  color: AppColors.red,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const TextSpan(text: '  '),
                              TextSpan(
                                text: '${shoe.oldPrice.toString()} лв.',
                                style: const TextStyle(
                                  decoration: TextDecoration.lineThrough,
                                  color: AppColors.grey,
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                        ),

                        AppDimensions.sizedBoxH25,

                        Wrap(
                          spacing: 8.0,
                          runSpacing: 8.0,
                          children: shoe.sizes.map((currentSize) {
                            final isAvailable = shoe.availableSizes.contains(currentSize);

                            return Container(
                              width: MediaQuery.of(context).size.width / 2 - 30.0,
                              height: 50.0,
                              decoration: BoxDecoration(
                                color: isAvailable ? AppColors.white : AppColors.greyLight,
                                borderRadius: BorderRadius.circular(8.0),
                                border: Border.all(
                                  color: AppColors.grey,
                                  width: 1.0,
                                ),
                              ),
                              margin: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
                              child: Center(
                                child: Text(
                                  currentSize,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: AppColors.black
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),

                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Center(
                            child: ElevatedButton(
                              onPressed: () {
                                viewModel.redirectToProvider();
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.purple,
                                padding: const EdgeInsets.all(10.0),
                                minimumSize: const Size(double.infinity, 50),
                              ),
                              child: Text(
                                AppStrings.shoeDetailProvider + shoe.provider,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        )
      ),
    );
  }
}
