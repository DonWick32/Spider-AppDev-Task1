// ignore_for_file: prefer_final_fields

import 'package:flutter/cupertino.dart';

import './courses.dart';

class Courses with ChangeNotifier {
  List <Course> _items = [
    Course(
      course_code: "MAIR22",
      course_name: "Mathematics",
      classes_attended: 5,
      classes_missed: 1,
    ),
    Course(
      course_code: "CSIR21",
      course_name: "Computer",
      classes_attended: 5,
      classes_missed: 0,
    ),
    Course(
      course_code: "CHIR11",
      course_name: "Chemistry",
      classes_attended: 4,
      classes_missed: 2,
    ),
  ];

  List <Course> get items {
    return [..._items];
  }

  Course findByCourseCode (String courseCode) {
    return _items.firstWhere((cour) => cour.course_code == courseCode);
  }

  void updateCourse(String initial, String course_code, Course course){
    final courseIndex = _items.indexWhere((cour) => cour.course_code == initial);
    if (courseIndex >= 0) {
      _items[courseIndex] = course;
      notifyListeners();
    }
    else {
      final newCourse = Course(
      course_code: course.course_code, 
      course_name: course.course_name,
      classes_attended: course.classes_attended,
      classes_missed: course.classes_missed, 
    );
    _items.add(newCourse);
    notifyListeners();
    }
  }

  void deleteProduct(String course_code){
    _items.removeWhere((cour) => cour.course_code == course_code);
    notifyListeners();
  }
}