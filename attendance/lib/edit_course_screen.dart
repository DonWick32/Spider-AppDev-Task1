// ignore_for_file: prefer_final_fields
import 'package:provider/provider.dart';
import 'package:attendance/courses.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'dart:io';

// ignore_for_file: prefer_const_constructors, deprecated_member_use, prefer_const_literals_to_create_immutables, sort_child_properties_last, unused_local_variable

import 'package:flutter/material.dart';
import './courses.dart';
import './courses_provider.dart';

class EditCourseScreen extends StatefulWidget {
  static const routeName = '/edit-course';

  @override
  _EditCourseScreenState createState() => _EditCourseScreenState();
}

class _EditCourseScreenState extends State<EditCourseScreen> {
  final _codeFoucsNode = FocusNode();
  final _attendedFocusNode = FocusNode();
  final _missedFocusNode = FocusNode();
  final _form = GlobalKey <FormState>();
  var _editedCourse = Course(course_code: "", course_name: "", classes_attended: 0, classes_missed: 0);
  var _initValues = {
    "course_name" : "",
    "course_code" : "",
    "classes_attended" : 0,
    "classes_missed" : 0,
  };
  var _isInit = true;

  @override
  void didChangeDependencies(){
    if (_isInit){
      final course_code = ModalRoute.of(context)!.settings.arguments as String;
      if (course_code != null){
        _editedCourse = Provider.of<Courses>(context, listen: false).findByCourseCode(course_code);
      _initValues = {
        "course_name" : _editedCourse.course_name,
        "course_code" : _editedCourse.course_code,
        "classes_attended" : _editedCourse.classes_attended.toString(),
        "classes_missed" : _editedCourse.classes_missed.toString(),
      };
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  void dispose (){
    _codeFoucsNode.dispose();
    _attendedFocusNode.dispose();
    _missedFocusNode.dispose();
    super.dispose();
  }

  void _saveForm(){
    final isValid = _form.currentState?.validate();
    if (!isValid!){
      return;
    }
    _form.currentState?.save();
    /*if (_editedCourse.course_code != "") {
      Provider.of<Courses>(context, listen: false).updateCourse(_editedCourse.course_code,_editedCourse);
    }
    else {
      Provider.of<Courses>(context, listen: false).addCourse(_editedCourse);
    }*/
    print(_initValues["course_name"].toString());
    Provider.of<Courses>(context, listen: false).updateCourse(_initValues["course_code"].toString(),_editedCourse.course_code,_editedCourse);
    Navigator.of(context).pop();
  }
  //static const routeName = '/edit-course';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Edit Course"),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.save),
              onPressed: () {
                _saveForm();
              },
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _form,
            child: ListView(
              children: <Widget>[
                TextFormField(
                  initialValue: _initValues["course_name"].toString(),
                  decoration: InputDecoration(labelText: "Course Name"),
                  textInputAction: TextInputAction.next,
                  maxLength: 15,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_codeFoucsNode);
                  },
                  validator: (value) {
                    if (value!.isEmpty){
                      return "Please enter Course Name.";
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _editedCourse = Course(
                      course_name: value.toString(), 
                      course_code: _editedCourse.course_code, 
                      classes_attended: _editedCourse.classes_attended, 
                      classes_missed: _editedCourse.classes_missed);
                  },
                  ),
                SizedBox(height: 5),
                TextFormField(
                  initialValue: _initValues["course_code"].toString(),
                  decoration: InputDecoration(labelText: "Course Code"),
                  textInputAction: TextInputAction.next,
                  focusNode: _codeFoucsNode,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_attendedFocusNode);
                  },
                  validator: (value) {
                    if (value!.isEmpty){
                      return "Please enter Course Code.";
                    }
                    if (!(value.substring(0,4).toUpperCase().contains(new RegExp(r'[A-Z]')) && value.substring(4).contains(new RegExp(r'^-?[0-9]+$')))){
                      return "Please enter a valid Course Code.";
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _editedCourse = Course(
                      course_name: _editedCourse.course_name, 
                      course_code: value.toString(), 
                      classes_attended: _editedCourse.classes_attended, 
                      classes_missed: _editedCourse.classes_missed);
                  },
                  ),
                SizedBox(height: 5),
                TextFormField(
                  initialValue: _initValues["classes_attended"].toString(),
                  decoration: InputDecoration(labelText: "Classes Attended"),
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  focusNode: _attendedFocusNode,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_missedFocusNode);
                  },
                  validator: (value) {
                    if (value!.isEmpty){
                      return "Please enter number of Classes Attended.";
                    }
                    if (int.tryParse(value.toString()) == null){
                      return "Please enter a valid number.";
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _editedCourse = Course(
                      course_name: _editedCourse.course_name, 
                      course_code: _editedCourse.course_code, 
                      classes_attended: int.parse(value.toString()),
                      classes_missed: _editedCourse.classes_missed);
                  },
                  ),
                SizedBox(height: 5),
                TextFormField(
                  initialValue: _initValues["classes_missed"].toString(),
                  decoration: InputDecoration(labelText: "Classes Missed"),
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  focusNode: _missedFocusNode,
                  onFieldSubmitted: (_) {
                    _saveForm();
                  },
                  validator: (value) {
                    if (value!.isEmpty){
                      return "Please enter number of Classes missed.";
                    }
                    if (int.tryParse(value.toString()) == null){
                      return "Please enter a valid number.";
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _editedCourse = Course(
                      course_name: _editedCourse.course_name, 
                      course_code: _editedCourse.course_code, 
                      classes_attended: _editedCourse.classes_attended, 
                      classes_missed: int.parse(value.toString()));
                  },
                  ),
              ],
            ),
          ),
        ),
    );
  }
}