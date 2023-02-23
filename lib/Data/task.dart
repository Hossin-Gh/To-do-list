import 'package:flutter_application_1/Data/task_type.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'task.g.dart';

@HiveType(typeId: 3)
class Task extends HiveObject {
  Task({
    required this.title,
    required this.subTitle,
    this.isDon = false,
    required this.time,
    required this.taskType,
  });

  @HiveField(0)
  String? subTitle;

  @HiveField(1)
  String? title;

  @HiveField(2)
  bool isDon;

  @HiveField(3)
  DateTime time;

  @HiveField(4)
  TaskType taskType;
}
