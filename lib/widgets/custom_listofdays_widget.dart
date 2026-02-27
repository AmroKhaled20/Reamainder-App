import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remainder/cubits/reminder_form_cubit/reminder_form_cubit.dart';
import 'package:remainder/models/reminder_model.dart';
import 'package:remainder/widgets/custom_day_icon_widget.dart';

class CustomListofdaysWidget extends StatelessWidget {
  final ReminderModel? reminder;
  final List<int>? selectedDays;
  final bool isClickable;

  const CustomListofdaysWidget({
    this.reminder,
    this.selectedDays,
    this.isClickable = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: weekDays.map((day) {
          bool isSelected;

          if (reminder != null) {
            isSelected = reminder!.days.contains(day['value']);
          } else {
            isSelected = selectedDays?.contains(day['value']) ?? false;
          }

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 3),
            child: CustomDayIconWidget(
              day: day,
              isSelected: isSelected,
              onTap: isClickable
                  ? () {
                      BlocProvider.of<ReminderFormCubit>(
                        context,
                      ).toggleDay(day['value']);
                    }
                  : null,
            ),
          );
        }).toList(),
      ),
    );
  }
}

final List<Map<String, dynamic>> weekDays = [
  {"label": "Mon", "value": DateTime.monday},
  {"label": "Tue", "value": DateTime.tuesday},
  {"label": "Wed", "value": DateTime.wednesday},
  {"label": "Thu", "value": DateTime.thursday},
  {"label": "Fri", "value": DateTime.friday},
  {"label": "Sat", "value": DateTime.saturday},
  {"label": "Sun", "value": DateTime.sunday},
];
