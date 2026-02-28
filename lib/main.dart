import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:remainder/constants.dart';
import 'package:remainder/core/services/notification_service.dart';
import 'package:remainder/cubits/read_reminder_cubit/read_reminder_cubit.dart';
import 'package:remainder/cubits/reminder_form_cubit/reminder_form_cubit.dart';
import 'package:remainder/models/reminder_model.dart';
import 'package:remainder/pages/edit_page.dart';
import 'package:remainder/pages/home_page.dart';
import 'package:remainder/pages/reminder_datails_page.dart';
import 'package:remainder/simple_bloc_observer.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = SimpleBlocObserver();

  await Hive.initFlutter();
  Hive.registerAdapter(ReminderModelAdapter());
  await Hive.openBox<ReminderModel>(kReminderBox);

  await NotificationService.instance.initialize(navigatorKey: navigatorKey);

  final reminderId = await NotificationService.instance
      .getInitialNotificationPayload();

  runApp(const RemainderApp());

  if (reminderId != null) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final box = Hive.box<ReminderModel>(kReminderBox);
      final reminders = box.values.where((r) => r.id == reminderId).toList();
      if (reminders.isNotEmpty) {
        navigatorKey.currentState?.pushNamed(
          ReminderDatailsPage.id,
          arguments: reminders.first,
        );
      }
    });
  }
}

class RemainderApp extends StatelessWidget {
  const RemainderApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ReminderFormCubit()),
        BlocProvider(create: (context) => ReadReminderCubit()),
      ],
      child: MaterialApp(
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        routes: {
          HomePage.id: (context) => HomePage(),
          EditPage.id: (context) => EditPage(),
          ReminderDatailsPage.id: (context) => ReminderDatailsPage(),
        },
        theme: ThemeData(brightness: Brightness.dark, fontFamily: 'Poppins'),
        home: const HomePage(),
      ),
    );
  }
}
