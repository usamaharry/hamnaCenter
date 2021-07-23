import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/student.dart';

class StudentInfo extends StatelessWidget {
  final Student student;

  StudentInfo(this.student);
  final heightMultiplier = 0.10;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(student.name),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Card(
        color: Colors.grey[200],
        elevation: 20,
        child: Container(
          height: MediaQuery.of(context).size.height * 0.35,
          child: LayoutBuilder(
            builder: (ctx, constraints) {
              return Column(
                children: [
                  Container(
                    height: constraints.maxHeight * heightMultiplier,
                    child: Row(
                      children: [
                        Icon(Icons.admin_panel_settings_outlined),
                        SizedBox(
                          width: constraints.maxWidth / 14,
                        ),
                        Text(
                          student.name,
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: constraints.maxHeight * heightMultiplier,
                    child: Row(
                      children: [
                        Icon(Icons.admin_panel_settings_rounded),
                        SizedBox(
                          width: constraints.maxWidth / 14,
                        ),
                        Text(student.fatherName)
                      ],
                    ),
                  ),
                  Container(
                    height: constraints.maxHeight * heightMultiplier,
                    child: Row(
                      children: [
                        Icon(Icons.school),
                        SizedBox(
                          width: constraints.maxWidth / 14,
                        ),
                        Text(student.qualification)
                      ],
                    ),
                  ),
                  Container(
                    height: constraints.maxHeight * heightMultiplier,
                    child: Row(
                      children: [
                        Icon(Icons.timer),
                        SizedBox(
                          width: constraints.maxWidth / 14,
                        ),
                        Text(student.program)
                      ],
                    ),
                  ),
                  Container(
                    child: Row(
                      children: [
                        Icon(Icons.location_on),
                        SizedBox(
                          width: constraints.maxWidth / 14,
                        ),
                        Flexible(
                          fit: FlexFit.tight,
                          child: Text(
                            student.address,
                            maxLines: 3,
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: constraints.maxHeight * heightMultiplier,
                    child: Row(
                      children: [
                        Icon(Icons.phone),
                        SizedBox(
                          width: constraints.maxWidth / 14,
                        ),
                        Text(student.phone),
                      ],
                    ),
                  ),
                  Container(
                    height: constraints.maxHeight * heightMultiplier,
                    child: Row(
                      children: [
                        Icon(Icons.chat),
                        SizedBox(
                          width: constraints.maxWidth / 14,
                        ),
                        Text(student.neeyat),
                      ],
                    ),
                  ),
                  Container(
                    height: constraints.maxHeight * heightMultiplier,
                    child: Row(
                      children: [
                        Icon(Icons.cast_for_education),
                        SizedBox(
                          width: constraints.maxWidth / 14,
                        ),
                        Text(student.previousInstitute),
                      ],
                    ),
                  ),
                  Container(
                    height: constraints.maxHeight * heightMultiplier,
                    child: Row(
                      children: [
                        Icon(Icons.add),
                        SizedBox(
                          width: constraints.maxWidth / 14,
                        ),
                        Text(student.refernce),
                      ],
                    ),
                  ),
                  Container(
                    height: constraints.maxHeight * heightMultiplier,
                    child: Row(
                      children: [
                        Icon(Icons.date_range),
                        SizedBox(
                          width: constraints.maxWidth / 14,
                        ),
                        Text(
                          student.dateOfJoining,
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
