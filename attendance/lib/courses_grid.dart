// ignore_for_file: prefer_const_constructors, deprecated_member_use, prefer_const_literals_to_create_immutables, sort_child_properties_last, unused_local_variable
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import './courses_item.dart';
import './courses_provider.dart';

class CoursesGrid extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    final coursesData = Provider.of<Courses>(context);
    final courses = coursesData.items;
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: courses.length,
      itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
        //create: (c) => courses[i],
        value : courses[i],
        child: CourseItem (
          //courses[i].course_code, 
          //courses[i].course_name,
          ),
          ) ,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 3 / 2, crossAxisSpacing: 10, mainAxisSpacing: 10,),
    );
  }
}