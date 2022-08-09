// ignore_for_file: prefer_const_constructors, deprecated_member_use, prefer_const_literals_to_create_immutables, sort_child_properties_last, unused_local_variable
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import './courses_provider.dart';
import './edit_course_screen.dart';
import './user_course_item.dart';

class CourseScreen extends StatelessWidget {
  static const routeName = '/user-coursses';

  @override
  Widget build(BuildContext context) {
    final coursesData = Provider.of<Courses>(context);
    return Scaffold(
      appBar: AppBar(
          title: Text("Your Courses"),
          actions: <Widget>[
            IconButton(icon: Icon(Icons.add), onPressed: () {
              Navigator.of(context).pushNamed(EditCourseScreen.routeName);
            },),
          ],
        ),
      body : Padding (
        padding: EdgeInsets.all(8),
        child: ListView.builder(
          itemCount: coursesData.items.length, 
          itemBuilder: (_,i) => Column(
            children: [
              UserCourseItem(
                coursesData.items[i].course_code,
              ),
              Divider(),
            ],
        ),
      ),
      ),
      );
  }
}