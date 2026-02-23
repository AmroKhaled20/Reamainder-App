import 'package:flutter/material.dart';
import 'package:remainder/constants.dart';

class CustomDayIconWidget extends StatelessWidget {
  final Map<String, dynamic> day;
  final bool isSelected;
  final VoidCallback? onTap;

  const CustomDayIconWidget({
    required this.day,
    required this.isSelected,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: CircleAvatar(
        radius: 27,
        backgroundColor: ktextColor,
        child: CircleAvatar(
          radius: 25,
          backgroundColor: isSelected ? kDayselected : kDayNotselected,
          child: Text(day['label']),
        ),
      ),
    );
  }
}
