import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final bool? isLoading;
  final String label;
  final VoidCallback? onPressed;

  const CustomButton({
    super.key, 
    required this.label, 
    required this.onPressed,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
        textStyle: TextStyle(fontSize: 16),
        backgroundColor: Color.fromARGB(255, 219, 232, 255),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      onPressed: onPressed,
      child: isLoading!
        ? CircularProgressIndicator()
        : Text(
            label,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.blueAccent,
            ),
          ),
    );
  }
}