import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:udemy_flutter/modules/archived_tasks/archived_tasks_screen.dart';
import 'package:udemy_flutter/modules/done_tasks/done_tasks_screen.dart';
import 'package:udemy_flutter/modules/new_tasks/new_task_screen.dart';
import 'package:udemy_flutter/shared/components/components.dart';
import 'package:udemy_flutter/shared/components/constants.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({Key key}) : super(key: key);

  @override
  _HomeLayoutState createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  int currentIndex = 0;
  Database database;

  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();
  bool isBottomSheetShown = false;

  var titleController = TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();

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

  @override
  void initState() {
    super.initState();
    createDataBase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text(
          titles[currentIndex],
        ),
      ),
      body: tasks.length == 0
          ? Center(child: CircularProgressIndicator())
          : screens[currentIndex],
      floatingActionButton: FloatingActionButton(
        child: isBottomSheetShown ? Icon(Icons.done) : Icon(Icons.add),
        onPressed: () async {
          if (isBottomSheetShown) {
            if (formKey.currentState.validate()) {
              insertToDatabase(
                      title: titleController.text,
                      time: timeController.text,
                      date: dateController.text)
                  .then((value) {
                getDataFromDatabase(database).then((value) {
                  Navigator.pop(context);
                  timeController.clear();
                  titleController.clear();
                  dateController.clear();
                  setState(() {
                    tasks = value;
                  });
                }).catchError((onError) {
                  print('${onError.toString()}');
                });
              }).catchError((onError) {
                print('${onError.toString()}');
              });
            }
          } else {
            {
              scaffoldKey.currentState
                  .showBottomSheet(
                    (context) => Container(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Form(
                          key: formKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              defaultFormField(
                                controller: titleController,
                                type: TextInputType.text,
                                validate: (value) {
                                  if (value.isEmpty)
                                    return 'title must not be empty';
                                  return null;
                                },
                                label: 'Task title',
                                prefix: Icons.title,
                              ),
                              SizedBox(
                                height: 12,
                              ),
                              defaultFormField(
                                readOnly: true,
                                controller: timeController,
                                type: TextInputType.datetime,
                                onTap: () {
                                  showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.now(),
                                  ).then((value) {
                                    if (value != null) {
                                      timeController.text =
                                          value?.format(context);
                                    }
                                  });
                                },
                                validate: (value) {
                                  if (value.isEmpty)
                                    return 'time must not be empty';
                                  return null;
                                },
                                label: 'Task time',
                                prefix: Icons.watch_later_outlined,
                              ),
                              SizedBox(
                                height: 12,
                              ),
                              defaultFormField(
                                readOnly: true,
                                controller: dateController,
                                type: TextInputType.datetime,
                                onTap: () {
                                  showDatePicker(
                                    firstDate: DateTime.now(),
                                    lastDate:
                                        DateTime.now().add(Duration(days: 365)),
                                    context: context,
                                    initialDate: DateTime.now(),
                                  ).then((value) {
                                    if (value != null) {
                                      // dateController.text = DateFormat.
                                      dateController.text =
                                          DateFormat.yMMMEd().format(value);
                                    }
                                  });
                                },
                                validate: (value) {
                                  if (value.isEmpty)
                                    return 'date must not be empty';
                                  return null;
                                },
                                label: 'Task date',
                                prefix: Icons.calendar_today_outlined,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    elevation: 15,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                      ),
                    ),
                  )
                  .closed
                  .then((value) {
                isBottomSheetShown = !isBottomSheetShown;
                setState(() {});
              });
              isBottomSheetShown = !isBottomSheetShown;
              setState(() {});
            }
          }
          //await insertToDatabase();
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.menu), label: 'Tasks'),
          BottomNavigationBarItem(
              icon: Icon(Icons.check_circle_outlined), label: 'Done'),
          BottomNavigationBarItem(icon: Icon(Icons.archive), label: 'Archived'),
        ],
      ),
    );
  }

  Future<void> createDataBase() async {
    try {
      database =
          await openDatabase('todo.db', onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE tasks (id INTEGER PRIMARY KEY,title TEXT, date TEXT, time TEXT,status TEXT)');
        print("Datbase created");
      }, onOpen: (database) {
        print("Datbase opened");
        getDataFromDatabase(database).then((value) {
          tasks = value;
          setState(() {});
        }).catchError((onError) {
          print('${onError.toString()}');
        });
      }, version: 1);
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
          return val;
        },
      );
    } catch (e) {
      print('${e.toString()}');
    }
  }

  Future<List<Map<String, dynamic>>> getDataFromDatabase(
      Database database) async {
    return await database.rawQuery('SELECT * FROM tasks');
  }
}
