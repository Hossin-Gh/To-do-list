import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_application_1/Data/task.dart';
import 'package:flutter_application_1/const/const.dart';

import 'package:flutter_application_1/widget/task_widget.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'add_task_screen.dart';

class HomeScr extends StatefulWidget {
  const HomeScr({super.key});

  @override
  State<HomeScr> createState() => _HomeScrState();
}

class _HomeScrState extends State<HomeScr> {
  var controller = TextEditingController();

  var taskbox = Hive.box<Task>('TaskBox');

  bool isFabVisible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BackGroundColor,
      body: Center(
        child: ValueListenableBuilder(
            valueListenable: taskbox.listenable(),
            builder: (context, value, child) {
              return NotificationListener<UserScrollNotification>(
                onNotification: (notif) {
                  if (notif.direction == ScrollDirection.forward) {
                    setState(() {
                      isFabVisible = true;
                    });
                  }
                  ;
                  if (notif.direction == ScrollDirection.reverse) {
                    setState(() {
                      isFabVisible = false;
                    });
                  }
                  ;
                  return true;
                },
                child: ListView.builder(
                  itemBuilder: ((context, index) {
                    var task = taskbox.values.toList()[index];
                    return getTaskList(task);
                  }),
                  itemCount: taskbox.length,
                ),
              );
            }),
      ),
      floatingActionButton: Visibility(
        visible: isFabVisible,
        child: FloatingActionButton(
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => AddTaskScr()));
          },
          backgroundColor: GreenColor,
          child: Image.asset('images/icon_add.png'),
        ),
      ),
    );
  }

  Widget getTaskList(Task task) {
    return Dismissible(
      key: UniqueKey(),
      onDismissed: (direction) {
        task.delete();
      },
      child: TaskWidget(task: task),
    );
  }
}
