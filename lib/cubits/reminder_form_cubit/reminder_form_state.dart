part of 'reminder_form_cubit.dart';

@immutable
abstract class ReminderFormState {}

final class ReminderFormInitial extends ReminderFormState {}

// final class ReminderFormClear extends ReminderFormState {}

final class ReminderFormSave extends ReminderFormState {}

final class ReminderFormLoading extends ReminderFormState {}

final class ReminderFormSaveSuccessful extends ReminderFormState {}

final class ReminderFormSaveFailure extends ReminderFormState {
  final String errorMessage;

  ReminderFormSaveFailure(this.errorMessage);
}

final class ReminderFormSelectDays extends ReminderFormState {
  final List<int> selectedDays;
  ReminderFormSelectDays({required this.selectedDays});
}
