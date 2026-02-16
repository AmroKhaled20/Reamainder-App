import 'package:flutter/material.dart';
import 'package:remainder/widgets/custom_day_icon_widget.dart';

class CustomListofdaysWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: weekDays.map((day) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 3),
            child: CustomDayIconWidget(day: day),
          );
        }).toList(),
      ),
    );
  }
}

final List<Map<String, dynamic>> weekDays = [
  {"label": "Mon", "value": DateTime.monday},
  {"label": "Tue", "value": DateTime.tuesday},
  {"label": "Wed", "value": DateTime.wednesday},
  {"label": "Thu", "value": DateTime.thursday},
  {"label": "Fri", "value": DateTime.friday},
  {"label": "Sat", "value": DateTime.saturday},
  {"label": "Sun", "value": DateTime.sunday},
];
