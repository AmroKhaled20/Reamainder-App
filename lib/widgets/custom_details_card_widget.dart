import 'package:flutter/material.dart';
import 'package:remainder/constants.dart';
import 'package:remainder/models/reminder_model.dart';
import 'package:remainder/widgets/custom_listofdays_widget.dart';
import 'package:remainder/widgets/custom_textfield_widget.dart';

class CustomDetailsCardWidget extends StatelessWidget {
  final ReminderModel reminder;
  const CustomDetailsCardWidget({required this.reminder, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 507,
      width: 300,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 11,
            spreadRadius: 3,
            offset: const Offset(4, 6),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Reminder Title*', style: TextStyle(color: kEditPage)),
            CustomTextFieldWidget(
              readOnly: true,
              controller: TextEditingController(text: reminder.title),
            ),
            const SizedBox(height: 20),
            Text('Reminder Time*', style: TextStyle(color: kEditPage)),
            CustomTextFieldWidget(
              readOnly: true,
              controller: TextEditingController(
                text:
                    '${reminder.hours.toString()}:${reminder.minutes.toString().padLeft(2, '0')}',
              ),
            ),
            const SizedBox(height: 20),
            Text('Note*', style: TextStyle(color: kEditPage)),
            CustomTextFieldWidget(
              minLines: 5,
              maxLines: 5,
              readOnly: true,
              controller: TextEditingController(text: reminder.note ?? ''),
            ),
            const SizedBox(height: 20),
            Text('Reminder Frequency*', style: TextStyle(color: kEditPage)),
            const SizedBox(height: 5),
            CustomListofdaysWidget(reminder: reminder, isClickable: false),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
