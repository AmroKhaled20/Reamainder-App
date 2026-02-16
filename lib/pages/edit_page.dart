import 'package:flutter/material.dart';
import 'package:remainder/widgets/custom_bar_widget.dart';

class EditPage extends StatelessWidget {
  static String id = 'Edit page';

  const EditPage();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              CustomBarWidget(icon: Icons.check),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
