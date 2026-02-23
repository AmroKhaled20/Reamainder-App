import 'package:flutter/material.dart';
import 'package:remainder/constants.dart';
import 'package:remainder/models/reminder_model.dart';
import 'package:remainder/widgets/custom_listofdays_widget.dart';
import 'package:remainder/widgets/custom_switch_widget.dart';

class CustomReminderCardWidget extends StatelessWidget {
  final ReminderModel reminder;

  const CustomReminderCardWidget({required this.reminder});

  String _getAmPm(int hour) {
    return hour >= 12 ? 'PM' : 'AM';
  }

  int _getDisplayHour(int hour) {
    if (hour == 0 || hour == 12) return 12;
    return hour > 12 ? hour - 12 : hour;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color.fromARGB(255, 120, 120, 120),
          width: 3,
        ),
        color: kCardColor,
      ),
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  reminder.title,
                  style: TextStyle(
                    color: ktextColor,
                    fontSize: 23,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                CustomSwitchWidget(),
              ],
            ),
            const SizedBox(height: 1),
            Align(
              alignment: Alignment.centerLeft,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "${_getDisplayHour(reminder.hours).toString().padLeft(2, '0')} : ${reminder.minutes.toString().padLeft(2, '0')}",
                    style: TextStyle(
                      color: kTimeColor,
                      fontSize: 50,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Text(
                      _getAmPm(reminder.hours),
                      style: TextStyle(
                        color: kTimeColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 1),
            Align(
              alignment: Alignment.centerLeft,
              child: const Text(
                'Days :',
                style: TextStyle(
                  color: ktextColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(height: 5),
            CustomListofdaysWidget(reminder: reminder, isClickable: false),
          ],
        ),
      ),
    );
  }
}
