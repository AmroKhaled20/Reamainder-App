import 'package:flutter/material.dart';

class CustomDailyCheckboxWidget extends StatefulWidget {
  const CustomDailyCheckboxWidget({super.key});

  @override
  State<CustomDailyCheckboxWidget> createState() => _DailyCheckboxState();
}

class _DailyCheckboxState extends State<CustomDailyCheckboxWidget> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isChecked = !isChecked;
        });
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
  }
}
