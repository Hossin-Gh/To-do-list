import 'package:flutter/material.dart';
import 'package:flutter_application_1/Data/task.dart';
import 'package:flutter_application_1/const/const.dart';

import 'package:flutter_application_1/utility/utility.dart';
import 'package:flutter_application_1/widget/task_type_item.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:time_pickerr/time_pickerr.dart';

class EditTaskScr extends StatefulWidget {
  EditTaskScr({super.key, required this.task});

  Task task;

  @override
  State<EditTaskScr> createState() => _EditTaskScrState();
}

class _EditTaskScrState extends State<EditTaskScr> {
  FocusNode focusNode1 = FocusNode();
  FocusNode focusNode2 = FocusNode();

  TextEditingController? controllerTaskTitle;
  TextEditingController? controllerTaskSubTitle;

  final box = Hive.box<Task>('TaskBox');

  DateTime? _time;

  int _selectedTaskItem = 0;

  @override
  void initState() {
    super.initState();

    var index = getTaskTypeList().indexWhere((element) {
      return element.taskTypeEnum == widget.task.taskType.taskTypeEnum;
    });
    setState(() {
      _selectedTaskItem = index;
    });

    controllerTaskTitle = TextEditingController(text: widget.task.title);
    controllerTaskSubTitle = TextEditingController(text: widget.task.subTitle);
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
        child: Center(
          child: SingleChildScrollView(
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
                SizedBox(height: 50),
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
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    String taskTitle = controllerTaskTitle!.text;
                    String taskSubTitle = controllerTaskSubTitle!.text;
                    editTask(taskTitle, taskSubTitle);
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'ویرایش کردن تسک',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: GreenColor,
                    minimumSize: Size(200, 40),
                  ),
                ),
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

  editTask(
    String title,
    String subTitle,
  ) {
    widget.task.title = title;
    widget.task.subTitle = subTitle;
    widget.task.time = _time!;
    widget.task.taskType = getTaskTypeList()[_selectedTaskItem];
    widget.task.save();
  }
}


