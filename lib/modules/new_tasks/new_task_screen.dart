import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutter/shared/components/components.dart';
// import 'package:udemy_flutter/shared/components/constants.dart';
import 'package:udemy_flutter/shared/cubit/app_cubit.dart';
import 'package:udemy_flutter/shared/cubit/app_states.dart';

class NewTasksScreen extends StatelessWidget {
  const NewTasksScreen({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var tasks = AppCubit.get(context).tasks.reversed.toList();
        return ListView.separated(
          itemBuilder: (context, index) => buildTaskItem(model: tasks[index]),
          separatorBuilder: (context, index) => Divider(
            thickness: 1,
            height: .5,
          ),
          itemCount: tasks.length,
        );
      },
    );
  }
}
