import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed; // Nullable to allow disabling
  final bool isLoading;
  final Color color;
  final bool isRound;

  CustomButton({
    required this.label,
    this.onPressed,
    this.isLoading = false,
    this.color = Colors.blue,
    this.isRound = false,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isLoading ? null : onPressed, // Disable button if loading
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        shape: isRound
            ? RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))
            : RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      ),
      child: isLoading
          ? CircularProgressIndicator(color: Colors.white) // Loading state
          : Text(
              label,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
    );
  }
}
