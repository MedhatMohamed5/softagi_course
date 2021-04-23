import 'package:flutter/material.dart';
import 'package:udemy_flutter/shared/cubit/app_cubit.dart';

Widget defaultButton({
  double width = double.infinity,
  Color background = Colors.blue,
  bool isUpperCase = true,
  double radius = 3.0,
  @required VoidCallback onPressed,
  @required String text,
}) =>
    Container(
      width: width,
      height: 50.0,
      child: MaterialButton(
        onPressed: onPressed,
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          radius,
        ),
        color: background,
      ),
    );

Widget defaultFormField({
  @required TextEditingController controller,
  @required TextInputType type,
  ValueChanged<String> onSubmit,
  ValueChanged<String> onChange,
  bool isPassword = false,
  @required String Function(String) validate,
  @required String label,
  @required IconData prefix,
  IconData suffix,
  VoidCallback suffixPressed,
  VoidCallback onTap,
  bool readOnly = false,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      onFieldSubmitted: onSubmit,
      onChanged: onChange,
      validator: validate,
      onTap: onTap,
      readOnly: readOnly,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(
          prefix,
        ),
        suffixIcon: suffix != null
            ? IconButton(
                onPressed: suffixPressed,
                icon: Icon(
                  suffix,
                ),
              )
            : null,
        border: OutlineInputBorder(),
      ),
    );

Widget buildTaskItem({Map<String, dynamic> model, BuildContext context}) =>
    Dismissible(
      key: ValueKey(model['id']),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 30,
              child: Text(
                '${model['id']}',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
            SizedBox(
              width: 12,
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${model['title']}',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '${model['date']}',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 5,
            ),
            IconButton(
              icon: Icon(
                Icons.check_box_outlined,
                color: Colors.green,
              ),
              onPressed: () {
                AppCubit.get(context)
                    .updateRecord(status: 'Done', id: model['id']);
              },
            ),
            SizedBox(
              width: 5,
            ),
            IconButton(
              icon: Icon(
                Icons.archive_outlined,
                color: Colors.black45,
              ),
              onPressed: () {
                AppCubit.get(context)
                    .updateRecord(status: 'Archive', id: model['id']);
              },
            ),
          ],
        ),
      ),
      onDismissed: (direction) {
        AppCubit.get(context).deleteRecord(id: model['id']);
      },
      background: Container(
        color: Colors.red,
      ),
    );

Widget buildEmptyList() => Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.menu),
          Text('No Tasks Yet, Please Add Some!'),
        ],
      ),
    );

Widget buildTasksList(List<Map<String, dynamic>> tasks) => tasks.length == 0
    ? buildEmptyList()
    : ListView.separated(
        itemBuilder: (context, index) => buildTaskItem(
          model: tasks[index],
          context: context,
        ),
        separatorBuilder: (context, index) => Divider(
          thickness: 1,
          height: .5,
        ),
        itemCount: tasks.length,
      );
