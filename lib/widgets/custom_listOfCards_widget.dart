import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:remainder/widgets/custom_reminder_card_widget.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class CustomListofcardsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 5,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Slidable(
            // المفروض الليست دي بتستقبل اوبجيكت وكل ما تبني اوبجيكت الكي بتاعه
            // يبقى ال الي دي بتاع الاوبجيكت اللي من نوع  ReminderModel
            // key: ValueKey(reminder.id),
            startActionPane: ActionPane(
              motion: const DrawerMotion(),
              children: [
                CustomSlidableAction(
                  onPressed: (context) {
                    // deleteReminder(reminder.id);
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 20),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    width: 60,

                    alignment: Alignment.center,
                    child: const Icon(
                      Icons.delete,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ),
                CustomSlidableAction(
                  onPressed: (context) {
                    // editReminder(reminder.id);
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 20),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    width: 60,

                    alignment: Alignment.center,
                    child: const Icon(
                      Icons.edit,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ),
              ],
            ),
            child: CustomReminderCardWidget(),
          ),
        );
      },
    );
  }
}
