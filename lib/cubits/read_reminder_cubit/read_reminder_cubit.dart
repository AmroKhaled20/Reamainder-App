import 'package:bloc/bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:meta/meta.dart';
import 'package:remainder/constants.dart';
import 'package:remainder/core/services/notification_service.dart';
import 'package:remainder/models/reminder_model.dart';

part 'read_reminder_state.dart';

class ReadReminderCubit extends Cubit<ReadReminderState> {
  ReadReminderCubit() : super(ReadReminderInitial());

  void fetchAllReminders() {
    var reminderBox = Hive.box<ReminderModel>(kReminderBox);
    final List<ReminderModel> reminders = reminderBox.values.toList();
    emit(ReadRemindersSuccess(reminders: reminders));
  }

  void deleteReminder(ReminderModel reminder) async {
    await NotificationService.instance.cancelReminderNotifications(reminder);
    await reminder.delete();
    fetchAllReminders();
  }
}
