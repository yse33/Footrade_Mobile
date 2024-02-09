import 'package:flutter/material.dart';
import '../constants/app_dimensions.dart';

class CustomLogo extends StatelessWidget {
  const CustomLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * AppDimensions.logoWidthMultiplier,
      height: MediaQuery.of(context).size.height * AppDimensions.logoHeightMultiplier,
      child: Image.asset(
        'assets/images/logo-transparent.png',
        fit: BoxFit.cover,
      ),
    );
  }
}