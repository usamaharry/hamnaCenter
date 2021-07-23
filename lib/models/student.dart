import 'package:flutter/material.dart';

class Student {
  String id;
  String program;
  String name;
  String fatherName;
  String qualification;
  String address;
  String phone;
  String neeyat;
  String previousInstitute;
  String refernce;
  String dateOfJoining;

  Student(
      {@required this.id,
      @required this.program,
      @required this.name,
      @required this.fatherName,
      @required this.phone,
      @required this.address,
      @required this.qualification,
      @required this.neeyat,
      @required this.previousInstitute,
      @required this.refernce,
      @required this.dateOfJoining});
}
