import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remainder/core/services/notification_service.dart';
import 'package:remainder/cubits/read_reminder_cubit/read_reminder_cubit.dart';
import 'package:remainder/cubits/reminder_form_cubit/reminder_form_cubit.dart';
import 'package:remainder/pages/edit_page.dart';
import 'package:remainder/widgets/custom_bar_widget.dart';
import 'package:remainder/widgets/custom_listOfCards_widget.dart';

class HomePage extends StatefulWidget {
  static String id = 'Home page';
  const HomePage();

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<ReadReminderCubit>(context).fetchAllReminders();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              CustomBarWidget(icon: Icons.search),
              const SizedBox(height: 10),
              Expanded(child: CustomListofcardsWidget()),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            //await NotificationService.instance.showTestNotification();

            // await NotificationService.instance.scheduleNotification();

            final cubit = context.read<ReminderFormCubit>();
            cubit.clearForm();
            Navigator.pushNamed(context, EditPage.id);
          },

          backgroundColor: const Color.fromARGB(255, 11, 130, 3),
          child: Icon(Icons.add, size: 35),
        ),
      ),
    );
  }
}
