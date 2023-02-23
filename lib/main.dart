import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/home-Screen.dart';

import 'package:hive_flutter/hive_flutter.dart';

import 'Data/task.dart';
import 'Data/task_type.dart';
import 'Data/type_enum.dart';

Future<void> main() async {
  // await Hive.initFlutter();

  // Hive.registerAdapter(TaskAdapter());
  // Hive.registerAdapter(TaskTypeAdapter());
  // Hive.registerAdapter(TaskTypeEnumAdapter());
  // await Hive.openBox<Task>('TaskBox');

  runApp(const Application());
}

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'SM',
      ),
      debugShowCheckedModeBanner: false,
      home: HomeScr(),
    );
  }
}
