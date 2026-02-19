import 'package:flutter/material.dart';
import 'package:remainder/constants.dart';

class CustomOutlineButtonWidget extends StatelessWidget {
  const CustomOutlineButtonWidget({
    super.key,
    required this.title,
    required this.onTap,
    this.color = kEditPage,
  });

  final String title;
  final VoidCallback onTap;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: color, width: 2),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: color,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
