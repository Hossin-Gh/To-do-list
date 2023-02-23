import 'package:flutter/material.dart';
import 'package:flutter_application_1/Data/task.dart';
import 'package:flutter_application_1/const/const.dart';

import 'package:flutter_application_1/utility/utility.dart';
import 'package:flutter_application_1/widget/task_type_item.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:time_pickerr/time_pickerr.dart';

class AddTaskScr extends StatefulWidget {
  const AddTaskScr({super.key});

  @override
  State<AddTaskScr> createState() => _AddTaskScrState();
}

class _AddTaskScrState extends State<AddTaskScr> {
  FocusNode focusNode1 = FocusNode();
  FocusNode focusNode2 = FocusNode();

  final TextEditingController controllerTaskTitle = TextEditingController();
  final TextEditingController controllerTaskSubTitle = TextEditingController();

  final box = Hive.box<Task>('TaskBox');

  DateTime? _time;

  int _selectedTaskItem = 0;

  @override
  void initState() {
    super.initState();
    focusNode1.addListener(() {
      setState(() {});
    });
    focusNode2.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                SizedBox(height: 50),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 44),
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: TextField(
                      controller: controllerTaskTitle,
                      focusNode: focusNode1,
                      decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                        labelText: 'عنوان تسک',
                        labelStyle: TextStyle(
                          fontFamily: 'GB',
                          fontSize: 16,
                          color: focusNode1.hasFocus
                              ? GreenColor
                              : Color(0xffC5C5C5),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          borderSide: BorderSide(
                            color: Color(0xffC5C5C5),
                            width: 3,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          borderSide: BorderSide(
                            color: GreenColor,
                            width: 3,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 100),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 44),
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: TextField(
                      controller: controllerTaskSubTitle,
                      maxLines: 2,
                      focusNode: focusNode2,
                      decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                        labelText: 'توضیحات تسک',
                        labelStyle: TextStyle(
                          fontFamily: 'GB',
                          fontSize: 16,
                          color: focusNode2.hasFocus
                              ? GreenColor
                              : Color(0xffC5C5C5),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          borderSide: BorderSide(
                            color: Color(0xffC5C5C5),
                            width: 3,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          borderSide: BorderSide(
                            color: GreenColor,
                            width: 3,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: CustomHourPicker(
                    title: 'زمان تسک',
                    titleStyle: TextStyle(
                      color: GreenColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    //
                    positiveButtonText: 'انتخاب زمان',
                    positiveButtonStyle: TextStyle(
                      color: GreenColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    onPositivePressed: (context, time) {
                      setState(() {
                        _time = time;
                      });
                    },
                    //
                    negativeButtonText: 'حذف کن',
                    negativeButtonStyle: TextStyle(
                      color: Colors.red,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    onNegativePressed: (context) {},
                    elevation: 2,
                  ),
                ),
                Container(
                  height: 200,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          setState(() {
                            _selectedTaskItem = index;
                          });
                        },
                        child: TaskTypeItemList(
                          index: index,
                          selectedItemList: _selectedTaskItem,
                          taskType: getTaskTypeList()[index],
                        ),
                      );
                    },
                    itemCount: getTaskTypeList().length,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    String taskTitle = controllerTaskTitle.text;
                    String taskSubTitle = controllerTaskSubTitle.text;
                    addTask(taskTitle, taskSubTitle);
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'اضافه کردن تسک',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: GreenColor,
                    minimumSize: Size(200, 40),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    focusNode1.dispose();
    focusNode2.dispose();
  }

  addTask(String title, String subTitle) {
    var task = Task(
        title: title,
        subTitle: subTitle,
        time: _time!,
        taskType: getTaskTypeList()[_selectedTaskItem]);
    box.add(task);
  }
}
