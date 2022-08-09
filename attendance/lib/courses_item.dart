import 'package:attendance/courses.dart';
import 'package:attendance/courses_overview.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// ignore_for_file: prefer_const_constructors, deprecated_member_use, prefer_const_literals_to_create_immutables, sort_child_properties_last, unused_local_variable

import './courses_detail_screen.dart';
import './courses_provider.dart';

class CourseItem extends StatelessWidget {
  //final String course_code;
  //final String course_name;

  //CourseItem(this.course_code, this.course_name);

  @override
  Widget build(BuildContext context) {
    //final course = Provider.of<Course>(context);
    return Consumer<Course>(
      builder: (ctx, course, _) => GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(CourseDetailScreen.routeName, arguments: course.course_code);
      },
      child : Container(
        color: Colors.lightBlue,
        child: GridTile(
            child: Center(child: Text(course.course_name, textAlign: TextAlign.center, style: TextStyle(fontSize: 20,),)),
          footer: GridTileBar(
            backgroundColor: Colors.black54,
            title: Text(course.course_code, textAlign: TextAlign.center,),
          ),
        ),
      ),
      ),

    );
  }
}