import 'package:flutter/material.dart';

class CustomIconhWidget extends StatelessWidget {
  const CustomIconhWidget({
    required this.icon,
    this.iconColor = Colors.white,
    this.onPressed,
  });
  final IconData icon;
  final Color? iconColor;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white.withValues(alpha: 0.3),
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(icon, size: 28, color: iconColor),
      ),
    );
  }
}
