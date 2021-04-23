import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutter/modules/archived_tasks/archived_tasks_screen.dart';
import 'package:udemy_flutter/modules/done_tasks/done_tasks_screen.dart';
import 'package:udemy_flutter/modules/new_tasks/new_task_screen.dart';
import 'package:udemy_flutter/shared/cubit/app_states.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(BuildContext context) =>
      BlocProvider.of<AppCubit>(context);

  int currentIndex = 0;
  List<Widget> screens = [
    NewTasksScreen(),
    DoneTasksScreen(),
    ArchivedTasksScreen(),
  ];

  List<String> titles = [
    'New Tasks',
    'Done Tasks',
    'Archived Tasks',
  ];

  void changeIndex(int index) {
    currentIndex = index;
    emit(AppChangeBottomNavBarState());
  }
}
