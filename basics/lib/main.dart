// ignore_for_file: prefer_const_constructors, deprecated_member_use, prefer_const_literals_to_create_immutables, sort_child_properties_last, unused_local_variable

import 'package:flutter/material.dart';

import './question.dart';
import './answers.dart';

void main (){
  runApp(MyApp());
}

//void main() => runApp(MyApp());

class MyApp extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  var _index = 0;
  
  void _answerQuestion() {
    setState(() {
      _index += 1;
    });
    print("Answer chosen!");
  }

  @override
  Widget build (BuildContext context){
    var questions = [
      {"question": "What is your favourite color?", 
      "answers" : ["Black", "Blue", "Red", "Green"],
      },
      {"question": "What is your age?", 
      "answers" : ["<18", "18-48", "49-69", ">69"],
      },
    ];
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("My First App"),
      ),
      body: Column(
        children: [
          Question(
            questions[_index]["question"] as String,
            ),
          ...(questions[_index]["answers"] as List<String>)
          .map((answer) {
            return Answer (_answerQuestion, answer);
          }).toList()
        ],
        ),
    ),
    );
  }
}