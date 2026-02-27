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
  bool _initialized = false;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_initialized) return;
    _initialized = true;
    final editReminder =
        ModalRoute.of(context)!.settings.arguments as ReminderModel?;

    if (editReminder != null) {
      context.read<ReminderFormCubit>().setReminderForEdit(editReminder);

      titleController.text = editReminder.title;
      noteController.text = editReminder.note ?? '';
      selectedTime = TimeOfDay(
        hour: editReminder.hours,
        minute: editReminder.minutes,
      );
      timeController.text = selectedTime!.format(context);

      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
  }

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

      var cubit = BlocProvider.of<ReminderFormCubit>(context);
      var selectedDays = cubit.selectedDays;

      if (selectedDays.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please select at least one day')),
        );
        return;
      }

      if (selectedTime == null) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Please select time')));
        return;
      }

      if (cubit.editingReminder != null) {
        cubit.updateReminder(
          title: titleController.text.trim(),
          days: List.from(selectedDays),
          hours: selectedTime!.hour,
          minutes: selectedTime!.minute,
          note: noteController.text.trim().isEmpty
              ? null
              : noteController.text.trim(),
        );
      } else {
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

        cubit.saveReminder(reminder);
      }
    } else {
      setState(() {
        autovalidateMode = AutovalidateMode.always;
      });
    }
  }

  void _onClear() {
    if (!mounted) return;
    final cubit = context.read<ReminderFormCubit>();

    cubit.clearFormKeepEditing();

    titleController.clear();
    timeController.clear();
    noteController.clear();

    setState(() {
      selectedTime = null;
    });
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
          child: BlocConsumer<ReminderFormCubit, ReminderFormState>(
            listener: (context, state) {
              if (state is ReminderFormSaveFailure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Error: ${state.errorMessage}')),
                );
              }
              if (state is ReminderFormSaveSuccessful) {
                titleController.clear();
                timeController.clear();
                noteController.clear();
                BlocProvider.of<ReminderFormCubit>(context).clearForm();
                setState(() {
                  selectedTime = null;
                });
                BlocProvider.of<ReadReminderCubit>(context).fetchAllReminders();
                Navigator.pushReplacementNamed(context, HomePage.id);
              }
            },
            builder: (context, state) {
              return ModalProgressHUD(
                inAsyncCall: state is ReminderFormLoading,
                progressIndicator: const Center(
                  child: CircularProgressIndicator(),
                ),
                child: AbsorbPointer(
                  absorbing: state is ReminderFormLoading,
                  child: SingleChildScrollView(
                    // ← اتنقلت لهنا
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
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
