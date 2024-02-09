import 'package:flutter/material.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import '../constants/app_strings.dart';

class CustomWarningSnackbar extends SnackBar {
  CustomWarningSnackbar({Key? key, required String message})
      : super(
    key: key,
    elevation: 0,
    width: double.infinity,
    behavior: SnackBarBehavior.floating,
    backgroundColor: Colors.transparent,
    duration: const Duration(seconds: 3),
    content: AwesomeSnackbarContent(
      title: AppStrings.snackbarErrorTitle,
      message: message,
      contentType: ContentType.warning,
    ),
  );
}