import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

// ignore_for_file: prefer_const_constructors, deprecated_member_use, prefer_const_literals_to_create_immutables, sort_child_properties_last, unused_local_variable


import 'package:flutter/material.dart';

class Answer extends StatelessWidget {
  final VoidCallback select;
  final String answerText;

  Answer(this.select, this.answerText);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: RaisedButton(
        color: Colors.blue,
        textColor: Colors.white,
        
        child: Text(answerText), 
        onPressed: select,
        ),
    );
  }
}