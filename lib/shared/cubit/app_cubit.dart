import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:udemy_flutter/modules/archived_tasks/archived_tasks_screen.dart';
import 'package:udemy_flutter/modules/done_tasks/done_tasks_screen.dart';
import 'package:udemy_flutter/modules/new_tasks/new_task_screen.dart';
import 'package:udemy_flutter/shared/cubit/app_states.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  Database database;
  List<Map<String, dynamic>> tasks = [];

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
          getDataFromDatabase(database).then((value) {
            tasks = value;
            print(tasks);
            emit(AppGetDatabaseState());
          }).catchError((onError) {
            print('${onError.toString()}');
          });
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
      await getDataFromDatabase(database).then((value) {
        tasks = value;
        print(tasks);
        emit(AppGetDatabaseState());
      }).catchError((onError) {
        print('${onError.toString()}');
      });
    } catch (e) {
      print('${e.toString()}');
    }
  }

  Future<List<Map<String, dynamic>>> getDataFromDatabase(
      Database database) async {
    emit(AppGetDatabaseLoadingState());
    return await database.rawQuery('SELECT * FROM tasks');
  }

  void changeBottomSheetState(bool value) {
    isBottomSheetShown = value;
    emit(AppBottomSheetState());
  }
}
