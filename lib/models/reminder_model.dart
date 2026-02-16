import 'package:hive/hive.dart';

part 'reminder_model.g.dart';

@HiveType(typeId: 0)
class ReminderModel {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final List<String> days;

  @HiveField(3)
  final int hours;

  @HiveField(4)
  final int minutes;

  @HiveField(5)
  final bool isActive;

  ReminderModel({
    required this.id,
    required this.title,
    required this.days,
    required this.hours,
    required this.minutes,
    required this.isActive,
  });
}
