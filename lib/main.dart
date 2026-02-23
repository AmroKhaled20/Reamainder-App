import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:remainder/constants.dart';
import 'package:remainder/cubits/read_reminder_cubit/read_reminder_cubit.dart';
import 'package:remainder/cubits/reminder_form_cubit/reminder_form_cubit.dart';
import 'package:remainder/models/reminder_model.dart';
import 'package:remainder/pages/edit_page.dart';
import 'package:remainder/pages/home_page.dart';
import 'package:remainder/simple_bloc_observer.dart';
import 'package:remainder/widgets/custom_reminder_card_widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = SimpleBlocObserver();

  await Hive.initFlutter();

  Hive.registerAdapter(ReminderModelAdapter());

  await Hive.openBox<ReminderModel>(kReminderBox);
  runApp(RemainderApp());
}

class RemainderApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ReminderFormCubit()),
        BlocProvider(create: (context) => ReadReminderCubit()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          HomePage.id: (context) => HomePage(),
          EditPage.id: (context) => EditPage(),
        },
        theme: ThemeData(brightness: Brightness.dark, fontFamily: 'Poppins'),
        home: const HomePage(),
      ),
    );
  }
}
