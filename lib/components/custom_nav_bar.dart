import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../constants/app_colors.dart';
import '../constants/app_strings.dart';
import '../constants/app_icons.dart';

class CustomNavBar extends StatelessWidget {
  final void Function(int)? onTabChange;
  const CustomNavBar({super.key, required this.onTabChange});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: GNav(
        color: AppColors.navBar,
        activeColor: AppColors.navBarActive,
        tabActiveBorder: Border.all(color: AppColors.white),
        tabBackgroundColor: AppColors.tabBackground,
        mainAxisAlignment: MainAxisAlignment.center,
        tabBorderRadius: 16,
        onTabChange: (index) => onTabChange!(index),
        tabs: const [
          GButton(
            icon: AppIcons.home,
            text: AppStrings.salesTitle,
          ),
          GButton(
            icon: AppIcons.favorite,
            text: AppStrings.favoritesTitle,
          ),
        ]
      )
    );
  }
}