import 'package:flutter/material.dart';
import 'package:flutter_application_1/const/const.dart';

import '../Data/task.dart';
import '../screens/edit_task_screen.dart';


class TaskWidget extends StatefulWidget {
  TaskWidget({super.key, required this.task});

  Task task;

  @override
  State<TaskWidget> createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  bool isBoxChecked = false;

  @override
  void initState() {
    super.initState();
    isBoxChecked = widget.task.isDon;
  }

  @override
  Widget build(BuildContext context) {
    return getTaskItem();
  }

  Widget getTaskItem() {
    return GestureDetector(
      onTap: () {
        setState(() {
          isBoxChecked = !isBoxChecked;
          widget.task.isDon = isBoxChecked;
          widget.task.save();
        });
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        height: 132,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: Padding(
          padding: EdgeInsets.all(12),
          child: _getContent(),
        ),
      ),
    );
  }

  Row _getContent() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Transform.scale(
                    scale: 1.4,
                    child: Checkbox(
                        checkColor: Colors.white,
                        activeColor: GreenColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(5),
                          ),
                        ),
                        value: isBoxChecked,
                        onChanged: (isChecked) {
                          //
                        }),
                  ),
                  Text('${widget.task.title}')
                ],
              ),
              Text(
                '${widget.task.subTitle}',
                overflow: TextOverflow.ellipsis,
              ),
              Spacer(),
              getTimeAndEditBadgs(),
            ],
          ),
        ),
        SizedBox(width: 10),
        Image.asset('${widget.task.taskType.image}'),
      ],
    );
  }

  Row getTimeAndEditBadgs() {
    return Row(
      children: [
        Container(
          height: 32,
          width: 83,
          decoration: BoxDecoration(
            color: GreenColor,
            borderRadius: BorderRadius.circular(18),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 6,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${widget.task.time.hour}:${getMinUnderTen(widget.task.time)}',
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
                Image.asset('images/icon_time.png'),
              ],
            ),
          ),
        ),
        SizedBox(width: 15),
        Container(
          height: 32,
          width: 83,
          decoration: BoxDecoration(
            color: LightGreen,
            borderRadius: BorderRadius.circular(18),
          ),
          child: InkWell(
            onTap: (() {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => EditTaskScr(
                  task: widget.task,
                ),
              ));
            }),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 6,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'ویرایش',
                    style: TextStyle(color: GreenColor),
                  ),
                  Image.asset('images/icon_edit.png'),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  String getMinUnderTen(DateTime time) {
    if (time.minute < 10) {
      var min = widget.task.time.minute.toString();
      return '0$min';
    } else {
      return '${time.minute}';
    }
  }
}
