import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remainder/constants.dart';
import 'package:remainder/cubits/reminder_form_cubit/reminder_form_cubit.dart';
import 'package:remainder/widgets/custom_daily_checkbox_widget.dart';
import 'package:remainder/widgets/custom_listofdays_widget.dart';
import 'package:remainder/widgets/custom_outline_button_widget.dart';
import 'package:remainder/widgets/custom_textfield_widget.dart';

class CustomFormCardWidget extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController titleController;
  final TextEditingController timeController;
  final TextEditingController noteController;
  final AutovalidateMode autovalidateMode;
  final TimeOfDay? selectedTime;
  final VoidCallback onPickTime;
  final VoidCallback onSave;
  final VoidCallback onClear;

  const CustomFormCardWidget({
    required this.formKey,
    required this.titleController,
    required this.timeController,
    required this.noteController,
    required this.autovalidateMode,
    required this.selectedTime,
    required this.onPickTime,
    required this.onSave,
    required this.onClear,
  });

  @override
  State<CustomFormCardWidget> createState() => _CustomFormCardWidgetState();
}

class _CustomFormCardWidgetState extends State<CustomFormCardWidget> {
  String? title, note;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      autovalidateMode: widget.autovalidateMode,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Reminder Title*', style: TextStyle(color: kEditPage)),
          CustomTextFieldWidget(
            controller: widget.titleController,
            onSaved: (value) {
              title = value;
            },
          ),
          const SizedBox(height: 20),
          Text('Reminder Time*', style: TextStyle(color: kEditPage)),
          CustomTextFieldWidget(
            controller: widget.timeController,
            readOnly: true,
            onTap: widget.onPickTime,
          ),
          const SizedBox(height: 20),
          Text('Note (optional)', style: TextStyle(color: kEditPage)),
          CustomTextFieldWidget(
            minLines: 5,
            maxLines: 5,
            controller: widget.noteController,
            isRequired: false,
            onSaved: (value) {
              note = value;
            },
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Reminder Frequency*', style: TextStyle(color: kEditPage)),
              CustomDailyCheckboxWidget(),
            ],
          ),
          const SizedBox(height: 5),

          BlocBuilder<ReminderFormCubit, ReminderFormState>(
            builder: (context, state) {
              final selectedDays = BlocProvider.of<ReminderFormCubit>(
                context,
              ).selectedDays;

              return CustomListofdaysWidget(
                selectedDays: selectedDays,
                isClickable: true,
              );
            },
          ),
          const SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CustomOutlineButtonWidget(title: 'Save', onTap: widget.onSave),
              CustomOutlineButtonWidget(title: 'Clear', onTap: widget.onClear),
            ],
          ),
        ],
      ),
    );
  }
}
