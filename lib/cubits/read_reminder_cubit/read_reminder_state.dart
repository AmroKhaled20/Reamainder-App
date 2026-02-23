part of 'read_reminder_cubit.dart';

@immutable
sealed class ReadReminderState {}

final class ReadReminderInitial extends ReadReminderState {}

final class ReadRemindersSuccess extends ReadReminderState {
  final List<ReminderModel> reminders;

  ReadRemindersSuccess({required this.reminders});
}
