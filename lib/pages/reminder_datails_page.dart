import 'package:flutter/material.dart';
import 'package:remainder/models/reminder_model.dart';
import 'package:remainder/widgets/custom_details_card_widget.dart';

class ReminderDatailsPage extends StatelessWidget {
  static String id = 'Details page';
  final ReminderModel? initialReminder;

  const ReminderDatailsPage({this.initialReminder, super.key});

  @override
  Widget build(BuildContext context) {
    final ReminderModel reminder =
        initialReminder ??
        ModalRoute.of(context)!.settings.arguments as ReminderModel;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: 260,
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 5, 102, 181),
            ),
            child: const Center(
              child: Padding(
                padding: EdgeInsets.only(bottom: 60),
                child: Text(
                  'Reminder Details',
                  style: TextStyle(
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
