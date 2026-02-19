import 'package:flutter/material.dart';
import 'package:remainder/widgets/custom_addedit_reminder_card_widget.dart';

class EditPage extends StatelessWidget {
  static String id = 'Edit page';

  const EditPage();
  @override
  Widget build(BuildContext context) {
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
                padding: const EdgeInsets.only(bottom: 80),
                child: Text(
                  'Reminder',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),

          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 100),
              child: CustomAddeditReminderCardWidget(),
            ),
          ),
        ],
      ),
    );
  }
}
