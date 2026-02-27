import 'package:bloc/bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:meta/meta.dart';
import 'package:remainder/constants.dart';
import 'package:remainder/models/reminder_model.dart';

part 'reminder_form_state.dart';

class ReminderFormCubit extends Cubit<ReminderFormState> {
  ReminderFormCubit() : super(ReminderFormInitial());
  List<int> selectedDays = [];
  ReminderModel? editingReminder;

  void toggleDay(int dayValue) {
    if (selectedDays.contains(dayValue)) {
      selectedDays.remove(dayValue);
    } else {
      selectedDays.add(dayValue);
    }

    emit(ReminderFormSelectDays(selectedDays: List.from(selectedDays)));
  }

  void toggleAllDays() {
    if (selectedDays.length == 7) {
      selectedDays.clear();
    } else {
      selectedDays = [1, 2, 3, 4, 5, 6, 7];
    }
    emit(ReminderFormSelectDays(selectedDays: List.from(selectedDays)));
  }

  void setReminderForEdit(ReminderModel reminder) {
    editingReminder = reminder;
    selectedDays = List.from(reminder.days); // نشيل الأيام القديمة
    emit(ReminderFormSelectDays(selectedDays: List.from(selectedDays)));
  }

  void clearForm() {
    editingReminder = null;
    selectedDays.clear();
  }

  Future<void> updateReminder({
    required String title,
    required List<int> days,
    required int hours,
    required int minutes,
    required String? note,
  }) async {
    emit(ReminderFormLoading());

    try {
      editingReminder!
        ..title = title
        ..days = days
        ..hours = hours
        ..minutes = minutes
        ..note = note;

      await editingReminder!.save();

      clearForm();

      emit(ReminderFormSaveSuccessful());
    } catch (e) {
      emit(ReminderFormSaveFailure(e.toString()));
    }
  }

  void clearFormKeepEditing() {
    selectedDays.clear();
    emit(ReminderFormSelectDays(selectedDays: []));
  }

  void saveReminder(ReminderModel reminder) async {
    emit(ReminderFormLoading());
    print('Saving reminder: ${reminder.title}');
    try {
      var reminderBox = Hive.box<ReminderModel>(kReminderBox);
      await reminderBox.add(reminder);

      emit(ReminderFormSaveSuccessful());
      print('Saved successfully');
    } catch (e) {
      print('Error: $e');
      emit(ReminderFormSaveFailure(e.toString()));
    }
  }
}
