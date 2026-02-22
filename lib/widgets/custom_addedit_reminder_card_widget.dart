import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remainder/constants.dart';
import 'package:remainder/cubits/reminder_form_cubit/reminder_form_cubit.dart';
import 'package:remainder/widgets/custom_daily_checkbox_widget.dart';
import 'package:remainder/widgets/custom_listofdays_widget.dart';
import 'package:remainder/widgets/custom_outline_button_widget.dart';
import 'package:remainder/widgets/custom_textfield_widget.dart';

class CustomAddeditReminderCardWidget extends StatefulWidget {
  @override
  State<CustomAddeditReminderCardWidget> createState() =>
      _CustomAddeditReminderCardWidgetState();
}

class _CustomAddeditReminderCardWidgetState
    extends State<CustomAddeditReminderCardWidget> {
  final GlobalKey<FormState> formKey = GlobalKey();
  final TextEditingController timeController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController noteController = TextEditingController();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  TimeOfDay? selectedTime;

  String? title, note;
  bool clear = false;
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
            child: BlocListener<ReminderFormCubit, ReminderFormState>(
              listener: (context, state) {
                if (state is ReminderFormClear) {
                  titleController.clear();
                  timeController.clear();
                  noteController.clear();
                }
              },
              child: Form(
                key: formKey,
                autovalidateMode: autovalidateMode,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Reminder Title*', style: TextStyle(color: kEditPage)),
                    //Title feild
                    CustomTextFieldWidget(
                      controller: titleController,
                      onSaved: (value) {
                        title = value;
                      },
                    ),
                    const SizedBox(height: 20),
                    Text('Reminder Time*', style: TextStyle(color: kEditPage)),
                    //Reminder Date
                    CustomTextFieldWidget(
                      controller: timeController,
                      readOnly: true,
                      onTap: () => _pickTime(context),
                    ),
                    const SizedBox(height: 20),
                    Text('Note (optional)', style: TextStyle(color: kEditPage)),
                    //Note (optional)
                    CustomTextFieldWidget(
                      minLines: 5,
                      maxLines: 5,
                      controller: noteController,
                      isRequired: false,
                      onSaved: (value) {
                        note = value;
                      },
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Reminder Frequency*',
                          style: TextStyle(color: kEditPage),
                        ),
                        CustomDailyCheckboxWidget(),
                      ],
                    ),
                    const SizedBox(height: 5),
                    CustomListofdaysWidget(isClikable: true),
                    const SizedBox(height: 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CustomOutlineButtonWidget(title: 'Save', onTap: () {}),
                        CustomOutlineButtonWidget(
                          title: 'Clear',
                          onTap: () {
                            BlocProvider.of<ReminderFormCubit>(
                              context,
                            ).clearForm();
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _pickTime(BuildContext context) async {
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
}
