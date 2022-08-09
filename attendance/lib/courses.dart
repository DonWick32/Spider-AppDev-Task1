// ignore_for_file: prefer_const_constructors, deprecated_member_use, prefer_const_literals_to_create_immutables, sort_child_properties_last, unused_local_variable, non_constant_identifier_names, prefer_typing_uninitialized_variables


import 'package:flutter/foundation.dart';

class Course with ChangeNotifier {
  final String course_code;
  final String course_name;
  var classes_attended;
  var classes_missed;
  var percentage;

  Course ({
    required this.course_code, 
    required this.course_name, 
    this.classes_attended = 0, 
    this.classes_missed = 0,
    this.percentage = 0,
    });
}