import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:remainder/cubits/read_reminder_cubit/read_reminder_cubit.dart';
import 'package:remainder/cubits/reminder_form_cubit/reminder_form_cubit.dart';
import 'package:remainder/models/reminder_model.dart';
import 'package:remainder/pages/home_page.dart';
import 'package:remainder/widgets/custom_form_card_widget.dart';

import 'package:uuid/uuid.dart';

class CustomAddeditReminderCardWidget extends StatefulWidget {
  const CustomAddeditReminderCardWidget({super.key});

  @override
  State<CustomAddeditReminderCardWidget> createState() =>
      _CustomAddeditReminderCardWidgetState();
}

class _CustomAddeditReminderCardWidgetState
    extends State<CustomAddeditReminderCardWidget> {
  final uuid = Uuid();
  final GlobalKey<FormState> formKey = GlobalKey();
  final TextEditingController timeController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController noteController = TextEditingController();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  TimeOfDay? selectedTime;
  String? title, note;

  @override
  void dispose() {
    timeController.dispose();
    titleController.dispose();
    noteController.dispose();
    super.dispose();
  }

  void _onSave() {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      var selectedDays = BlocProvider.of<ReminderFormCubit>(
        context,
      ).selectedDays;
      if (selectedDays.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Please select at least one day')),
        );
        return;
      }
      ReminderModel reminder = ReminderModel(
        id: uuid.v4(),
        title: titleController.text.trim(),
        days: List.from(selectedDays),
        hours: selectedTime!.hour,
        minutes: selectedTime!.minute,
        isActive: true,
        note: noteController.text.trim().isEmpty
            ? null
            : noteController.text.trim(),
      );

      BlocProvider.of<ReminderFormCubit>(context).saveReminder(reminder);
      print('saved');
    } else {
      setState(() {
        autovalidateMode = AutovalidateMode.always;
      });
    }
  }

  void _onClear() {
    BlocProvider.of<ReminderFormCubit>(context).clearForm();
  }

  void _pickTime() {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return SizedBox(
          height: 250,
          child: CupertinoDatePicker(
            mode: CupertinoDatePickerMode.time,
            use24hFormat: false,
            onDateTimeChanged: (DateTime value) {
              final time = TimeOfDay.fromDateTime(value);
              setState(() {
                selectedTime = time;
                timeController.text = time.format(context);
              });
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        height: 600,
        width: 300,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 11,
              spreadRadius: 3,
              offset: const Offset(4, 6),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: SingleChildScrollView(
            child: BlocConsumer<ReminderFormCubit, ReminderFormState>(
              listener: (context, state) {
                if (state is ReminderFormClear) {
                  titleController.clear();
                  timeController.clear();
                  noteController.clear();
                  setState(() {
                    selectedTime = null;
                  });
                }
                if (state is ReminderFormSaveFailure) {
                  print('Failed ${state.errorMessage}');
                }
                if (state is ReminderFormSaveSuccessful) {
                  titleController.clear();
                  timeController.clear();
                  noteController.clear();
                  BlocProvider.of<ReminderFormCubit>(context).clearForm();
                  setState(() {
                    selectedTime = null;
                  });
                  BlocProvider.of<ReadReminderCubit>(
                    context,
                  ).fetchAllReminders();
                  Navigator.pushReplacementNamed(context, HomePage.id);
                }
              },
              builder: (context, state) {
                return ModalProgressHUD(
                  inAsyncCall: state is ReminderFormLoading ? true : false,
                  progressIndicator: Center(
                    child: const CircularProgressIndicator(),
                  ),
                  child: AbsorbPointer(
                    absorbing: state is ReminderFormLoading ? true : false,
                    child: CustomFormCardWidget(
                      formKey: formKey,
                      titleController: titleController,
                      timeController: timeController,
                      noteController: noteController,
                      autovalidateMode: autovalidateMode,
                      selectedTime: selectedTime,
                      onPickTime: _pickTime,
                      onSave: _onSave,
                      onClear: _onClear,
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
