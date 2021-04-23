import 'package:flutter/material.dart';
import 'package:udemy_flutter/shared/components/components.dart';
import 'package:udemy_flutter/shared/components/constants.dart';

class NewTasksScreen extends StatelessWidget {
  const NewTasksScreen({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) => buildTaskItem(model: tasks[index]),
      separatorBuilder: (context, index) => Divider(
        thickness: 1,
        height: .5,
      ),
      itemCount: tasks.length,
    );
  }
}
