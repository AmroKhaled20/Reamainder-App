import 'package:hive/hive.dart';

part 'reminder_model.g.dart';

@HiveType(typeId: 0)
class ReminderModel extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String title;

  @HiveField(2)
  List<int> days;

  @HiveField(3)
  int hours;

  @HiveField(4)
  int minutes;

  @HiveField(5)
  bool isActive;

  @HiveField(6)
  String? note;

  ReminderModel({
    required this.id,
    required this.title,
    required this.days,
    required this.hours,
    required this.minutes,
    required this.isActive,
    this.note,
  });
}
