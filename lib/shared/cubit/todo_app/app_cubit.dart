import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:udemy_flutter/modules/archived_tasks/archived_tasks_screen.dart';
import 'package:udemy_flutter/modules/done_tasks/done_tasks_screen.dart';
import 'package:udemy_flutter/modules/new_tasks/new_task_screen.dart';
import 'package:udemy_flutter/shared/cubit/todo_app/app_states.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  Database database;
  List<Map<String, dynamic>> newTasks = [];
  List<Map<String, dynamic>> doneTasks = [];
  List<Map<String, dynamic>> archivedTasks = [];

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
  bool isBottomSheetShown = false;

  void changeIndex(int index) {
    currentIndex = index;
    emit(AppChangeBottomNavBarState());
  }

  Future<void> createDataBase() async {
    try {
      database = await openDatabase(
        'todo.db',
        onCreate: (database, version) async {
          await database.execute(
              'CREATE TABLE tasks (id INTEGER PRIMARY KEY,title TEXT, date TEXT, time TEXT,status TEXT)');
          print("Datbase created");
        },
        onOpen: (database) {
          print("Datbase opened");
          getDataFromDatabase(database);
        },
        version: 1,
      );
      emit(AppCreateDatabaseState());
    } catch (e) {
      print('Error while creating or openenig DB');
    }
  }

  Future insertToDatabase({
    @required String title,
    @required String time,
    @required String date,
  }) async {
    try {
      await database.transaction(
        (txn) async {
          var val = await txn.rawInsert(
              'INSERT INTO tasks(title,date,time,status) VALUES("$title","$date","$time","New")');
          print("$val inserted sussfully");
          emit(AppInsertDatabaseState());
          return val;
        },
      );
      getDataFromDatabase(database);
    } catch (e) {
      print('${e.toString()}');
    }
  }

  void getDataFromDatabase(Database database) {
    newTasks = [];
    doneTasks = [];
    archivedTasks = [];

    emit(AppGetDatabaseLoadingState());
    database.rawQuery('SELECT * FROM tasks').then((value) {
      value.forEach((task) {
        if (task['status'] == 'New')
          newTasks.add(task);
        else if (task['status'] == 'Done')
          doneTasks.add(task);
        else if (task['status'] == 'Archive') archivedTasks.add(task);
      });
      emit(AppGetDatabaseState());
    }).catchError((onError) {
      print('${onError.toString()}');
    });
  }

  void changeBottomSheetState(bool value) {
    isBottomSheetShown = value;
    emit(AppBottomSheetState());
  }

  void updateRecord({
    @required String status,
    @required int id,
  }) {
    database.rawUpdate('UPDATE tasks SET status = ? WHERE id = ?',
        ['$status', id]).then((value) {
      getDataFromDatabase(database);
      emit(AppUpdateDatabaseState());
    });
  }

  void deleteRecord({
    @required int id,
  }) {
    database.rawDelete('Delete FROM tasks WHERE id = ?', [id]).then((value) {
      getDataFromDatabase(database);
      emit(AppDeleteDatabaseState());
    });
  }

  bool isDark = false;
  void changeAppMode() {
    isDark = !isDark;
    emit(AppChangeModeState());
  }
}
