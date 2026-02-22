import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'reminder_form_state.dart';

class ReminderFormCubit extends Cubit<ReminderFormState> {
  ReminderFormCubit() : super(ReminderFormInitial());
  List<int> selectedDays = [];

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

  void clearForm() {
    selectedDays.clear();
    emit(ReminderFormClear());
    emit(ReminderFormSelectDays(selectedDays: List.from(selectedDays)));
  }
}
