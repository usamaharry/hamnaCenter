import 'package:flutter/material.dart';

import '../models/student.dart';
import '../widgets/studentInfo.dart';

class StudentsList extends StatelessWidget {
  final Function deleteHandler;

  final List<Student> students;

  StudentsList(this.students, this.deleteHandler);

  void _showStudentInformation(BuildContext ctx, Student s) {
    Navigator.of(ctx).push(MaterialPageRoute(builder: (_) {
      return StudentInfo(s);
    }));
  }

  void showAlertDialog(BuildContext ctx, Student s) {
    Widget okButton = TextButton(
        onPressed: () {
          deleteHandler(s.id);
          Navigator.pop(ctx);
        },
        child: Text('Ok'));
    Widget cancelButton =
        TextButton(onPressed: () => Navigator.pop(ctx), child: Text('Cancel'));

    AlertDialog alert = AlertDialog(
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      title: Text(
        'AlertDialog',
        style: ThemeData.light().textTheme.headline6,
      ),
      content: Text(
        'Are you sure to remove ${s.name}',
        style: ThemeData.light().textTheme.headline6,
      ),
      actions: [okButton, cancelButton],
    );

    showDialog(
        context: ctx,
        builder: (_) {
          return alert;
        });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (ctx, constraints) {
        return Container(
          height: constraints.maxHeight * 0.8,
          child: ListView.builder(
            itemCount: students.length,
            itemBuilder: (context, index) {
              return ListTile(
                onTap: () => _showStudentInformation(
                  ctx,
                  students[index],
                ),
                leading: CircleAvatar(
                  backgroundColor: Theme.of(context).primaryColorLight,
                  child: Text(
                    students[index].name.substring(0, 1),
                  ),
                ),
                title: Text(students[index].name),
                subtitle: Text(students[index].fatherName),
                trailing: IconButton(
                  color: Colors.orange,
                  icon: Icon(Icons.delete_forever),
                  onPressed: () => showAlertDialog(context, students[index]),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
