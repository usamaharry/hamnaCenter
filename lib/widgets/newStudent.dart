import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'textField.dart';

class AddNewStudent extends StatefulWidget {
  final Function addStudent;

  AddNewStudent(this.addStudent);

  @override
  _AddNewStudentState createState() => _AddNewStudentState();
}

class _AddNewStudentState extends State<AddNewStudent> {
  var nameController = TextEditingController();
  var fatherNameController = TextEditingController();
  var phoneController = TextEditingController();
  var addressController = TextEditingController();
  var qualificatonController = TextEditingController();
  var niyatController = TextEditingController();
  var lastInstiController = TextEditingController();
  var referenceController = TextEditingController();

  void _addnewSt() {
    if (nameController.text.isEmpty ||
        fatherNameController.text.isEmpty ||
        phoneController.text.isEmpty ||
        addressController.text.isEmpty ||
        qualificatonController.text.isEmpty ||
        niyatController.text.isEmpty ||
        lastInstiController.text.isEmpty ||
        referenceController.text.isEmpty ||
        dateChosen == null ||
        (valueChosen != 'One-Year' && valueChosen != 'Two-Year')) return;

    widget.addStudent(
      valueChosen,
      nameController.text,
      fatherNameController.text,
      phoneController.text,
      addressController.text,
      qualificatonController.text,
      niyatController.text,
      lastInstiController.text,
      referenceController.text,
      DateFormat.yMMMd().format(dateChosen).toString(),
    );

    Navigator.of(context).pop();
  }

  String valueChosen;
  List<String> programs = ['One-Year', 'Two-Year'];

  DateTime dateChosen;
  @override
  Widget build(BuildContext context) {
    var appBar = AppBar(
      backgroundColor: Theme.of(context).primaryColor,
      title: Text('Add new Student'),
    );

    var mediaQuery = MediaQuery.of(context);

    void _showDatePicker(BuildContext ctx) {
      showDatePicker(
        context: ctx,
        initialDate: DateTime.now(),
        firstDate: DateTime(2021),
        lastDate: DateTime.now(),
      ).then((value) {
        setState(() {
          dateChosen = value;
        });
      });
    }

    return Scaffold(
      appBar: appBar,
      body: Container(
        height: mediaQuery.size.height -
            appBar.preferredSize.height -
            mediaQuery.padding.bottom,
        child: ListView(
          children: [
            MyTextField(nameController, 'Name'),
            MyTextField(fatherNameController, 'Father Name'),
            MyTextField(phoneController, 'Phone'),
            MyTextField(addressController, 'Address'),
            MyTextField(qualificatonController, 'Qualification'),
            MyTextField(niyatController, 'Niyat'),
            MyTextField(lastInstiController, 'Previous institute'),
            MyTextField(referenceController, 'Reference'),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  dateChosen == null
                      ? ' No Date Chosen'
                      : DateFormat.yMMMd().format(dateChosen),
                  style: ThemeData.light().textTheme.title,
                ),
                Container(
                  width: 2,
                  height: 22,
                  color: Colors.black,
                ),
                DropdownButton(
                    onChanged: (newValue) {
                      setState(() {
                        valueChosen = newValue;
                      });
                    },
                    value: valueChosen,
                    hint: Text('Select program'),
                    icon: Icon(Icons.arrow_downward_sharp),
                    iconSize: 20,
                    items: programs.map((program) {
                      return DropdownMenuItem(
                        child: Text(program),
                        value: program,
                      );
                    }).toList()),
                Container(
                  width: 2,
                  height: 22,
                  color: Colors.black,
                ),
                TextButton.icon(
                  onPressed: () => _showDatePicker(context),
                  icon: Icon(Icons.date_range),
                  label: Text(
                    'Choose Date',
                    style: ThemeData.light().textTheme.title,
                  ),
                )
              ],
            ),
            SizedBox(
              width: 20,
              child: ElevatedButton(
                onPressed: _addnewSt,
                child: Text(
                  'Add',
                  style: ThemeData.light().textTheme.title,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
