import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/shoe_detail_model.dart';

class ShoeDetailViewModel extends ChangeNotifier {
  final String sasToken = dotenv.env['AZURE_SAS_TOKEN']!;
  final PageController pageController = PageController(initialPage: 0);
  final ShoeDetailModel shoe;

  ShoeDetailViewModel({required this.shoe});

  void previousPage() {
    pageController.previousPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void nextPage() {
    if (pageController.page! < shoe.images.length - 1) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      pageController.animateToPage(
        0,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  Future<void> redirectToProvider() async {
    final Uri uri = Uri.parse(shoe.url);
    await launchUrl(uri);
  }
}