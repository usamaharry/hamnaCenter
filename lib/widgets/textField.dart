import 'package:flutter/material.dart';

class MyTextField extends StatefulWidget {
  final TextEditingController ctrl;
  final String hint;
  MyTextField(this.ctrl, this.hint);

  @override
  _MyTextFieldState createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 5, left: 3, right: 3),
      height: 50,
      child: TextField(
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
          ),
          filled: true,
          hintText: widget.hint,
        ),
        controller: widget.ctrl,
      ),
    );
  }
}
