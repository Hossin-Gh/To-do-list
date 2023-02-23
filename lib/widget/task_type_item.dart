import 'package:flutter/material.dart';

import '../Data/task_type.dart';
import '../const/const.dart';

class TaskTypeItemList extends StatelessWidget {
  TaskTypeItemList(
      {Key? key,
      required this.taskType,
      required this.index,
      required this.selectedItemList})
      : super(key: key);

  TaskType taskType;
  int index, selectedItemList;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: (selectedItemList == index) ? GreenColor : Colors.white,
        border: Border.all(
          color: (selectedItemList == index) ? GreenColor : Colors.grey,
          width: (selectedItemList == index) ? 3 : 2,
        ),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      width: 150,
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          Image.asset('${taskType.image}'),
          Text(
            '${taskType.title}',
            style: TextStyle(
              fontSize: (selectedItemList == index) ? 20 : 18,
              color: (selectedItemList == index) ? Colors.white : Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
