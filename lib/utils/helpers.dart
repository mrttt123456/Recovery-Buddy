import 'package:flutter/material.dart';

class Helpers {
  // Helper function to show a Snackbar
  static void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  // Other helper functions can be added here as needed
}
