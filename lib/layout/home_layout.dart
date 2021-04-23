import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
// import 'package:sqflite/sqflite.dart';
// import 'package:udemy_flutter/modules/archived_tasks/archived_tasks_screen.dart';
// import 'package:udemy_flutter/modules/done_tasks/done_tasks_screen.dart';
// import 'package:udemy_flutter/modules/new_tasks/new_task_screen.dart';
import 'package:udemy_flutter/shared/components/components.dart';
// import 'package:udemy_flutter/shared/components/constants.dart';
import 'package:udemy_flutter/shared/cubit/app_cubit.dart';
import 'package:udemy_flutter/shared/cubit/app_states.dart';

class HomeLayout extends StatelessWidget {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  final titleController = TextEditingController();
  final timeController = TextEditingController();
  final dateController = TextEditingController();

  /*@override
  void initState() {
    super.initState();
    createDataBase();
  }*/

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit()..createDataBase(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {
          if (state is AppInsertDatabaseState) {
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          var blocCubit = AppCubit.get(context);
          return Scaffold(
            key: scaffoldKey,
            appBar: AppBar(
              title: Text(
                blocCubit.titles[blocCubit.currentIndex],
              ),
            ),
            body: state is AppGetDatabaseLoadingState //tasks.length == 0
                ? Center(child: CircularProgressIndicator())
                : blocCubit.screens[blocCubit.currentIndex],
            floatingActionButton: FloatingActionButton(
              child: blocCubit.isBottomSheetShown
                  ? Icon(Icons.done)
                  : Icon(Icons.add),
              onPressed: () async {
                if (blocCubit.isBottomSheetShown) {
                  if (formKey.currentState.validate()) {
                    await blocCubit.insertToDatabase(
                        title: titleController.text,
                        time: timeController.text,
                        date: dateController.text);

                    timeController.clear();
                    titleController.clear();
                    dateController.clear();
                    // insertToDatabase(
                    //         title: titleController.text,
                    //         time: timeController.text,
                    //         date: dateController.text)
                    //     .then((value) {
                    //   getDataFromDatabase(database).then((value) {
                    //     Navigator.pop(context);
                    //     timeController.clear();
                    //     titleController.clear();
                    //     dateController.clear();
                    //     //setState(() {
                    //     tasks = value;
                    //     // });
                    //   }).catchError((onError) {
                    //     print('${onError.toString()}');
                    //   });
                    // }).catchError((onError) {
                    //   print('${onError.toString()}');
                    // });
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
                                          lastDate: DateTime.now()
                                              .add(Duration(days: 365)),
                                          context: context,
                                          initialDate: DateTime.now(),
                                        ).then((value) {
                                          if (value != null) {
                                            // dateController.text = DateFormat.
                                            dateController.text =
                                                DateFormat.yMMMEd()
                                                    .format(value);
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
                      blocCubit.changeBottomSheetState(false);
                      // setState(() {});
                    });
                    blocCubit.changeBottomSheetState(true);

                    // setState(() {});
                  }
                }
                //await insertToDatabase();
              },
            ),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: blocCubit.currentIndex,
              type: BottomNavigationBarType.fixed,
              onTap: (index) {
                // setState(() {
                //currentIndex = index;
                // });
                blocCubit.changeIndex(index);
              },
              items: [
                BottomNavigationBarItem(icon: Icon(Icons.menu), label: 'Tasks'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.check_circle_outlined), label: 'Done'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.archive), label: 'Archived'),
              ],
            ),
          );
        },
      ),
    );
  }
}
