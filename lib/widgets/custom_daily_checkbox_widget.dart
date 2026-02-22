import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remainder/cubits/reminder_form_cubit/reminder_form_cubit.dart';

class CustomDailyCheckboxWidget extends StatelessWidget {
  const CustomDailyCheckboxWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReminderFormCubit, ReminderFormState>(
      builder: (context, state) {
        final List<int> selectedDays = BlocProvider.of<ReminderFormCubit>(
          context,
        ).selectedDays;
        bool isChecked = selectedDays.length == 7;
        return GestureDetector(
          onTap: () {
            BlocProvider.of<ReminderFormCubit>(context).toggleAllDays();
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: 18,
                height: 18,
                decoration: BoxDecoration(
                  color: isChecked ? Colors.green : Colors.transparent,
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                    color: isChecked ? Colors.green : Colors.grey,
                    width: 2,
                  ),
                ),
                child: isChecked
                    ? const Icon(Icons.check, size: 14, color: Colors.white)
                    : null,
              ),
              const SizedBox(width: 5),
              const Text(
                "Daily",
                style: TextStyle(
                  fontSize: 15,
                  color: Color.fromARGB(255, 5, 102, 181),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
