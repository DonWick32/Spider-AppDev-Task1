// ignore_for_file: prefer_const_constructors, deprecated_member_use, prefer_const_literals_to_create_immutables, sort_child_properties_last, unused_local_variable
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import './edit_course_screen.dart';
import './courses_provider.dart';

class UserCourseItem extends StatelessWidget {
  final String course_code;

  UserCourseItem(this.course_code);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(course_code),
      trailing: Container(
        width: 100,
        child: Row(children: <Widget>[
          IconButton(icon: Icon(Icons.edit), onPressed: () {
            Navigator.of(context).pushNamed(EditCourseScreen.routeName, arguments: course_code);
          },color: Theme.of(context).primaryColor,),
          IconButton(icon: Icon(Icons.delete), onPressed: () {
            Provider.of<Courses>(context, listen: false).deleteProduct(course_code);
          }, color: Theme.of(context).errorColor,),
        ]),
      ),
      );
  }
}