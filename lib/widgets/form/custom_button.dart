// widgets/custom_button.dart
import 'package:flutter/material.dart';

class CustomOutlinedButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final double width; 
  final double height; 
  final Color backgroundColor;
  final Color borderColor;
  final double borderWidth;
  final double borderRadius;
  final TextStyle textStyle;

  const CustomOutlinedButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.width = 270, 
    this.height = 50, 
    this.backgroundColor = Colors.black,
    this.borderColor = Colors.black,
    this.borderWidth = 2,
    this.borderRadius = 8,
    this.textStyle = const TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 18,
    ),
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width, 
      height: height, 
      child: OutlinedButton(
        
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          backgroundColor: backgroundColor,
          side: BorderSide(color: borderColor, width: borderWidth),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
        child: FittedBox(
          fit: BoxFit.scaleDown, 
          child: Text(
            label,
            style: textStyle,
            textAlign: TextAlign.center, 
          ),
        ),
      ),
    );
  }
}