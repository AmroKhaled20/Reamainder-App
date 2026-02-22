import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remainder/constants.dart';
import 'package:remainder/cubits/reminder_form_cubit/reminder_form_cubit.dart';

class CustomDayIconWidget extends StatelessWidget {
  final Map<String, dynamic> day;
  final bool isClickable;

  const CustomDayIconWidget({required this.day, this.isClickable = false});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        BlocProvider.of<ReminderFormCubit>(context).toggleDay(day['value']);
      },
      child: CircleAvatar(
        radius: 27,
        backgroundColor: ktextColor,
        child: BlocBuilder<ReminderFormCubit, ReminderFormState>(
          builder: (context, state) {
            final List<int> selectedDays;
            bool isSelected;
            if (state is ReminderFormSelectDays) {
              selectedDays = state.selectedDays;
            } else {
              selectedDays = BlocProvider.of<ReminderFormCubit>(
                context,
              ).selectedDays;
            }
            print(selectedDays.toString());
            isSelected = selectedDays.contains(day['value']);
            return CircleAvatar(
              radius: 25,
              backgroundColor: isSelected ? kDayselected : kDayNotselected,
              child: Text(day['label']),
            );
          },
        ),
      ),
    );
  }
}
