import 'package:flutter/material.dart';

import '../view_models/shoe_preference_view_model.dart';
import '../constants/app_icons.dart';

class CustomPaginationWidget extends StatelessWidget {
  final ShoePreferenceViewModel viewModel;

  const CustomPaginationWidget({
    Key? key,
    required this.viewModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Visibility(
            visible: viewModel.currentPage > 1,
            child: IconButton(
              icon: const Icon(AppIcons.arrowBack),
              onPressed: () {
                viewModel.changePage(viewModel.currentPage - 1);
              },
            ),
          ),

          const SizedBox(width: 10),

          Text(
            'Page ${viewModel.currentPage}',
            style: const TextStyle(fontSize: 16),
          ),

          const SizedBox(width: 10),

          Visibility(
            visible: !viewModel.isLastPage,
            child: IconButton(
              icon: const Icon(AppIcons.arrowForward),
              onPressed: () {
                viewModel.changePage(viewModel.currentPage + 1);
              },
            ),
          )
        ],
      ),
    );
  }
}