import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'dart:math';
// ignore_for_file: prefer_const_constructors, deprecated_member_use, prefer_const_literals_to_create_immutables, sort_child_properties_last, unused_local_variable

import './courses_provider.dart';

double roundDouble(double value, int places){ 
   num mod = pow(10.0, places); 
   return ((value * mod).round().toDouble() / mod); 
}

class CourseDetailScreen extends StatelessWidget {
  //final String title;
  //CourseDetailScreen(this.title);

  static const routeName = '/course-detail';

  @override
  Widget build(BuildContext context) {
    final courseCode = ModalRoute.of(context)?.settings.arguments as String;
    final loadedCourse = Provider.of<Courses>(context, listen: false).findByCourseCode(courseCode);
    if (loadedCourse.classes_attended == 0){
              loadedCourse.percentage = 0;
            }
    else {
      loadedCourse.percentage = roundDouble(loadedCourse.classes_attended / (loadedCourse.classes_attended + loadedCourse.classes_missed) * 100,2);
    }
  
    return Scaffold(
      appBar: AppBar(
        title: Text(loadedCourse.course_code),
        ),
      body: SingleChildScrollView (
        child: Column(
          children: <Widget>[
            SizedBox(height: 10),
            Container(
              height: 50,
              width: double.infinity,
              child: Text(loadedCourse.course_name, textAlign: TextAlign.center, style: TextStyle(fontSize: 30), overflow: TextOverflow.ellipsis)
            ),
            SizedBox(height: 5),
            Text("Course code : ${loadedCourse.course_code}", textAlign: TextAlign.center, style: TextStyle(fontSize: 20),),
            SizedBox(height: 5),
            Text("Classes Attended : ${loadedCourse.classes_attended}", textAlign: TextAlign.center, style: TextStyle(fontSize: 20),),
            SizedBox(height: 5),
            Text("Classes Missed : ${loadedCourse.classes_missed}", textAlign: TextAlign.center, style: TextStyle(fontSize: 20),),
            SizedBox(height: 5),
            SizedBox(height: 20),
            loadedCourse.percentage > 75 ? Text("Attendance Percentage : ${loadedCourse.percentage}", textAlign: TextAlign.center, style: TextStyle(fontSize: 20),) : Text("Attendance Percentage : ${loadedCourse.percentage}", textAlign: TextAlign.center, style: TextStyle(fontSize: 20, color: Colors.red),)
          ],
        ),
      ),
    );
  }
}