import 'package:flutter/material.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';

class CustomErrorSnackbar extends SnackBar {
  CustomErrorSnackbar({Key? key, required String message})
    : super(
        key: key,
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        duration: const Duration(seconds: 3),
        content: AwesomeSnackbarContent(
          title: 'Oh Snap!',
          message: message,
          contentType: ContentType.failure,
        ),
      );
}