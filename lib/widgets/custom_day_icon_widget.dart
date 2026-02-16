import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:remainder/constants.dart';

class CustomDayIconWidget extends StatelessWidget {
  const CustomDayIconWidget({required this.day});
  final Map<String, dynamic> day;
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 27,
      backgroundColor: ktextColor,
      child: CircleAvatar(
        radius: 25,
        backgroundColor: kDayNotselected,
        child: Center(child: Text(day['label'])),
      ),
    );
  }
}
