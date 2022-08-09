// @dart=2.9
// ignore_for_file: prefer_const_constructors, deprecated_member_use, prefer_const_literals_to_create_immutables, sort_child_properties_last, unused_local_variable
import 'package:attendance/courses_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import './courses_overview.dart';
import './courses_detail_screen.dart';
import './courses_provider.dart';
import './user_course_item.dart';
import './edit_course_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build (BuildContext context){
    return ChangeNotifierProvider(
      create: (ctx) => Courses(),
      child: MaterialApp(
        title: "MyAttendance",
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
          accentColor: Colors.deepPurpleAccent,
        ),
        home: CoursesOverview(),
        routes: {
          CourseDetailScreen.routeName: (ctx) => CourseDetailScreen(),
          CourseScreen.routeName: (ctx) => CourseScreen(),
          EditCourseScreen.routeName: (ctx) => EditCourseScreen(),
        },
      ),
    );
  }
}

