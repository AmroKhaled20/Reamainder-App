import 'package:flutter/material.dart';
import 'package:remainder/models/reminder_model.dart';
import 'package:remainder/widgets/custom_addedit_reminder_card_widget.dart';
import 'package:remainder/widgets/custom_details_card_widget.dart';

class ReminderDatailsPage extends StatelessWidget {
  static String id = 'Details page';

  const ReminderDatailsPage({super.key});
  @override
  Widget build(BuildContext context) {
    final ReminderModel reminder =
        ModalRoute.of(context)!.settings.arguments as ReminderModel;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: 260,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 5, 102, 181),
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 60),
                child: Text(
                  'Reminder Details',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),

          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 40),
              child: CustomDetailsCardWidget(reminder: reminder),
            ),
          ),
        ],
      ),
    );
  }
}
