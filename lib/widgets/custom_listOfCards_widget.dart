import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:remainder/cubits/read_reminder_cubit/read_reminder_cubit.dart';
import 'package:remainder/cubits/reminder_form_cubit/reminder_form_cubit.dart';
import 'package:remainder/models/reminder_model.dart';
import 'package:remainder/pages/edit_page.dart';
import 'package:remainder/widgets/custom_reminder_card_widget.dart';

class CustomListofcardsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReadReminderCubit, ReadReminderState>(
      builder: (context, state) {
        if (state is ReadRemindersSuccess) {
          final List<ReminderModel> reminders = state.reminders;

          if (reminders.isEmpty) {
            return Center(
              child: Text(
                'No reminders yet',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            );
          }

          return ListView.builder(
            itemCount: reminders.length,
            itemBuilder: (context, index) {
              final reminder = reminders[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: ColoredBox(
                    color: Colors.white,
                    child: Slidable(
                      key: ValueKey(reminder.id),
                      startActionPane: ActionPane(
                        motion: const DrawerMotion(),
                        children: [
                          CustomSlidableAction(
                            onPressed: (context) {
                              BlocProvider.of<ReadReminderCubit>(
                                context,
                              ).deleteReminder(reminder);
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
                              final reminder = reminders[index];
                              Navigator.pushNamed(
                                context,
                                EditPage.id,
                                arguments: reminder,
                              );
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
                      child: CustomReminderCardWidget(reminder: reminder),
                    ),
                  ),
                ),
              );
            },
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
