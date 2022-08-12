// ignore_for_file: prefer_const_constructors, dead_code, unnecessary_this

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/services.dart';
import 'package:units/history.dart';
import 'package:vibration/vibration.dart';

void main() {
  runApp(Splash());
}

final propertiesPics = {
  "Temperature": "assets/Temperature.png",
  "Length": "assets/Length.png",
  "Weight": "assets/Weight.png",
  "Speed": "assets/Speed.png",
};

final unitsPics = {
  "Celcius": "assets/Celcius.png",
  "Fahrenheit": "assets/Fahrenheit.png",
  "Kelvin": "assets/Kelvin.png",
  "Metre": "assets/Metre.png",
  "Feet": "assets/Feet.png",
  "Yard": "assets/Yard.png",
  "Kilogram": "assets/Kilogram.png",
  "Pound": "assets/Pound.png",
  "Ounce": "assets/Ounce.png",
  "Kmph": "assets/Kmph.png",
  "Mph": "assets/Mph.png",
  "Knot": "assets/Knot.png",
};

class MyApp extends StatefulWidget {
  @override
  MyAppState createState() => MyAppState();
}

class Splash extends StatefulWidget {
  @override
  SplashState createState() => SplashState();
}

class SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AnimatedSplashScreen(
        splash: Scaffold(
          backgroundColor: Color.fromARGB(255, 80, 66, 209),
          body: Center(
            child: Image.asset(
              "assets/splash.png",
            ),
          ),
        ),
        duration: 200,
        nextScreen: MyApp(),
        splashTransition: SplashTransition.fadeTransition,
        backgroundColor: Color.fromARGB(255, 80, 66, 209),
      ),
    );
  }
}

DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
      value: item,
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 4,
            ),
            child: Text(
              item,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
          ),
          Image.asset(propertiesPics[item]!),
        ],
      ),
    );

DropdownMenuItem<String> buildMenuItemMini(String item) => DropdownMenuItem(
      value: item,
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 4,
            ),
            child: Text(
              item,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
          Image.asset(unitsPics[item]!),
        ],
      ),
    );

class MyAppState extends State<MyApp> {
  final properties = {
    "Temperature": ["Celcius", "Fahrenheit", "Kelvin"],
    "Length": ["Metre", "Feet", "Yard"],
    "Weight": ["Kilogram", "Pound", "Ounce"],
    "Speed": ["Kmph", "Mph", "Knot"],
  };

  final units = {
    "Celcius": "°C",
    "Fahrenheit": "°F",
    "Kelvin": "K",
    "Metre": "m",
    "Feet": "ft",
    "Yard": "yd",
    "Kilogram": "kg",
    "Pound": "lb",
    "Ounce": "oz.",
    "Kmph": "km/h",
    "Mph": "mi/h",
    "Knot": "kn",
  };

  final conversion = {
    "Metre": 1000, "Feet": 304.8, "Yard": 914.4, //to millimetre
    "Kilogram": 1000, "Pound": 453.592, "Ounce": 28.3495, //to grams
    "Kmph": 0.277778, "Mph": 0.44704, "Knot": 0.514444, //to m/s
  };
  int c1 = 0;
  int c2 = 0;
  TextEditingController textController1 = TextEditingController(text: "0.0");
  TextEditingController textController2 = TextEditingController(text: "0.0");
  String? value;
  String? unit1;
  String? unit2;
  String symbol1 = "";
  String symbol2 = "";
  String correctAnswer = "";
  Color bgcolor = Colors.white;

List<List<String>> data = [];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: bgcolor,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text(
            "Units Convertor",
          ),
          actions: <Widget>[
            IconButton(
              iconSize: 40,
              icon: Icon(
                Icons.history_rounded,
              ),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => history(data)));
              },
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(8),
                padding: EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Colors.blueAccent,
                    width: 3,
                  ),
                ),
                child: Theme(
                  data: Theme.of(context).copyWith(
                    canvasColor: Colors.blueAccent,
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      hint: Text(
                        "Choose Physical Property",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        ),
                      ),
                      value: value,
                      iconSize: 36,
                      icon: Icon(
                        Icons.arrow_drop_down,
                        color: Colors.black,
                      ),
                      isExpanded: true,
                      items: properties.keys.map(buildMenuItem).toList(),
                      onChanged: (value) => setState(() {
                        this.value = value;
                        unit1 = properties[value]![0];
                        unit2 = properties[value]![1];
                        symbol1 = units[unit1]!;
                        symbol2 = units[unit2]!;
                        textController1.text = "0.0";
                        textController2.text = "0.0";
                        correctAnswer = "";
                        bgcolor = Colors.white;
                      }),
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.all(8),
                    width: 85,
                    padding: EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 4,
                    ),
                    child: Text(
                      "From",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Color.fromARGB(255, 96, 75, 255),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(8),
                    width: 275,
                    padding: EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 158, 146, 248),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Color.fromARGB(255, 158, 146, 248),
                        width: 3,
                      ),
                    ),
                    child: Theme(
                      data: Theme.of(context).copyWith(
                        canvasColor: Color.fromARGB(255, 158, 146, 248),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          hint: Text(
                            "Choose First Unit",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          value: unit1,
                          iconSize: 36,
                          icon: Icon(
                            Icons.arrow_drop_down,
                            color: Colors.black,
                          ),
                          isExpanded: true,
                          items:
                              properties[value]?.map(buildMenuItemMini).toList(),
                          onChanged: (value) => setState(() {
                            unit1 = value;
                            symbol1 = units[value]!;
                            textController1.text = "0.0";
                            correctAnswer = "";
                            bgcolor = Colors.white;
                          }),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.all(8),
                    width: 275,
                    padding: EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 4,
                    ),
                    child: TextFormField(
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20),
                      controller: textController1,
                      keyboardType: TextInputType.number,
                      onTap: fun1,
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    margin: EdgeInsets.all(8),
                    width: 80,
                    padding: EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 4,
                    ),
                    child: Text(
                      symbol1,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.all(8),
                    width: 85,
                    padding: EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 4,
                    ),
                    child: Text(
                      "To",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Color.fromARGB(255, 96, 75, 255),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(8),
                    width: 275,
                    padding: EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 158, 146, 248),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Color.fromARGB(255, 158, 146, 248),
                        width: 3,
                      ),
                    ),
                    child: Theme(
                      data: Theme.of(context).copyWith(
                        canvasColor: Color.fromARGB(255, 158, 146, 248),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          hint: Text(
                            "Choose Second Unit",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          value: unit2,
                          iconSize: 36,
                          icon: Icon(
                            Icons.arrow_drop_down,
                            color: Colors.black,
                          ),
                          isExpanded: true,
                          items:
                              properties[value]?.map(buildMenuItemMini).toList(),
                          onChanged: (value) => setState(() {
                            unit2 = value;
                            symbol2 = units[value]!;
                            textController2.text = "0.0";
                            correctAnswer = "";
                            bgcolor = Colors.white;
                          }),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.all(8),
                    width: 275,
                    padding: EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 4,
                    ),
                    child: TextFormField(
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20),
                      controller: textController2,
                      keyboardType: TextInputType.number,
                      onTap: fun2,
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    margin: EdgeInsets.all(8),
                    width: 80,
                    padding: EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 4,
                    ),
                    child: Text(
                      symbol2,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.all(8),
                    height: 100,
                    padding: EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 4,
                    ),
                    child: SizedBox(
                      width: 125,
                      height: 50,
                      child: ElevatedButton(
                        child: Text(
                          "Convert",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            correctAnswer = "";
                            bgcolor = Colors.white;
                            String txt1 = textController1.text;
                            String txt2 = textController2.text;
                            if (value != null) {
                              if (double.tryParse(txt1) != null &&
                                  double.tryParse(txt2) != null) {
                                if (value == "Temperature") {
                                  if (unit1 == "Celcius" && unit2 == "Fahrenheit") {
                                    textController2.text =
                                        (32 + (9 / 5 * double.parse(txt1)))
                                            .toString();
                                  } else if (unit2 == "Celcius" &&
                                      unit1 == "Fahrenheit") {
                                    textController2.text =
                                        ((double.parse(txt1) - 32) * 5 / 9)
                                            .toString();
                                  } else if (unit1 == "Kelvin" &&
                                      unit2 == "Fahrenheit") {
                                    textController2.text =
                                        (((double.parse(txt1) - 273.15) * 9 / 5) + 32)
                                            .toString();
                                  } else if (unit2 == "Kelvin" &&
                                      unit1 == "Fahrenheit") {
                                    textController2.text =
                                        (((double.parse(txt1) - 32) * 5 / 9) + 273.15)
                                            .toString();
                                  } else if (unit1 == "Kelvin" &&
                                      unit2 == "Celcius") {
                                    textController2.text =
                                        (double.parse(txt1) - 273.15).toString();
                                  } else if (unit2 == "Kelvin" &&
                                      unit1 == "Celcius") {
                                    textController2.text =
                                        (double.parse(txt1) + 273.15).toString();
                                  } else {
                                    textController2.text = textController1.text;
                                    WidgetsBinding.instance.focusManager.primaryFocus
                                        ?.unfocus();
                                  }
                                } else {
                                  textController2.text = (double.parse(txt1) *
                                          (conversion[unit1]!) /
                                          conversion[unit2]!)
                                      .toString();
                                  if (txt1 != "0.0" && unit1 != unit2) {
                                    WidgetsBinding.instance.focusManager.primaryFocus
                                        ?.unfocus();
                                    Fluttertoast.showToast(
                                      msg: "Conversion Sucessful!",
                                      fontSize: 15,
                                    );
                                    data.add([value!,unit1!,unit2!,double.parse(textController1.text).toStringAsFixed(2),double.parse(textController2.text).toStringAsFixed(2)]);
                                  }
                                }
                                if (value == "Temperature" && unit1 != unit2) {
                                  WidgetsBinding.instance.focusManager.primaryFocus
                                      ?.unfocus();
                                  Fluttertoast.showToast(
                                    msg: "Conversion Sucessful!",
                                    fontSize: 15,
                                  );
                                  data.add([value!,unit1!,unit2!,double.parse(textController1.text).toStringAsFixed(2),double.parse(textController2.text).toStringAsFixed(2)]);
                                }
                                if ((txt1 == "0.0" &&
                                        txt2 == "0.0" &&
                                        value != "Temperature") ||
                                    (txt1 == "0.0" &&
                                        txt2 == "0.0" &&
                                        value == "Temperature" &&
                                        unit1 == unit2)) {
                                  Fluttertoast.showToast(
                                    msg: "Enter non-zero decimal input!",
                                    fontSize: 15,
                                  );
                                }
                              } else {
                                Fluttertoast.showToast(
                                  msg: "Enter valid decimal input!",
                                  fontSize: 15,
                                );
                              }
                            } else {
                              Fluttertoast.showToast(
                                msg: "Choose a Physical Property!",
                                fontSize: 15,
                              );
                            }
                          });
                        },
                      ),
                    ),
                  ),
                  Container(
                alignment: Alignment.center,
                margin: EdgeInsets.all(8),
                height: 100,
                padding: EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 4,
                ),
                child: SizedBox(
                  width: 125,
                  height: 50,
                  child: ElevatedButton(
                    child: Text(
                      "Check",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        String txt1 = textController1.text;
                        String txt2 = textController2.text;
                        double answer;
                        if (value != null) {
                          if (double.tryParse(txt1) != null &&
                              double.tryParse(txt2) != null) {
                            if (value == "Temperature") {
                              if (unit1 == "Celcius" && unit2 == "Fahrenheit") {
                                answer = (32 + (9 / 5 * double.parse(txt1)));
                              } else if (unit2 == "Celcius" &&
                                  unit1 == "Fahrenheit") {
                                answer = ((double.parse(txt1) - 32) * 5 / 9);
                              } else if (unit1 == "Kelvin" &&
                                  unit2 == "Fahrenheit") {
                                answer =
                                    (((double.parse(txt1) - 273.15) * 9 / 5) +
                                        32);
                              } else if (unit2 == "Kelvin" &&
                                  unit1 == "Fahrenheit") {
                                answer = (((double.parse(txt1) - 32) * 5 / 9) +
                                    273.15);
                              } else if (unit1 == "Kelvin" &&
                                  unit2 == "Celcius") {
                                answer = (double.parse(txt1) - 273.15);
                              } else if (unit2 == "Kelvin" &&
                                  unit1 == "Celcius") {
                                answer = (double.parse(txt1) + 273.15);
                              } else {
                                answer = double.parse(txt1);
                              }
                            } else {
                              answer = (double.parse(txt1) *
                                  (conversion[unit1]!) /
                                  conversion[unit2]!);
                            }
        
                            if (value != "Temperature" &&
                                unit1 != unit2 &&
                                double.parse(txt1) != 0.0) {
                              WidgetsBinding.instance.focusManager.primaryFocus
                                  ?.unfocus();
                              if (double.parse(answer.toStringAsFixed(2)) ==
                                  double.parse(
                                      double.parse(txt2).toStringAsFixed(2))) {
                                correctAnswer = "";
                                bgcolor = Colors.green.shade300;
                              } else {
                                bgcolor = Colors.red.shade300;
                                Vibration.vibrate();
                                correctAnswer =
                                    "Correct Answer = ${double.parse(answer.toStringAsFixed(2))}";
                              }
                            } else if (value != "Temperature" &&
                                unit1 != unit2 &&
                                double.parse(txt1) == 0.0) {
                              bgcolor = Colors.white;
                              correctAnswer = "";
                              Fluttertoast.showToast(
                                msg: "Enter non-zero decimal input!",
                                fontSize: 15,
                              );
                            } else if (value == "Temperature" && unit1 != unit2) {
                              WidgetsBinding.instance.focusManager.primaryFocus
                                  ?.unfocus();
                              if (double.parse(answer.toStringAsFixed(2)) ==
                                  double.parse(
                                      double.parse(txt2).toStringAsFixed(2))) {
                                correctAnswer = "";
                                bgcolor = Colors.green.shade300;
                              } else {
                                bgcolor = Colors.red.shade300;
                                Vibration.vibrate();
                                correctAnswer =
                                    "Correct Answer = ${double.parse(answer.toStringAsFixed(2))}";
                              }
                            } else if (value == "Temperature" &&
                                unit1 == unit2 &&
                                double.parse(txt1) == 0.0) {
                              bgcolor = Colors.white;
                              correctAnswer = "";
                              Fluttertoast.showToast(
                                msg: "Enter non-zero decimal input!",
                                fontSize: 15,
                              );
                            } else if (unit1 == unit2 &&
                                double.parse(txt1) != 0) {
                              WidgetsBinding.instance.focusManager.primaryFocus
                                  ?.unfocus();
                              if (double.parse(answer.toStringAsFixed(2)) ==
                                  double.parse(
                                      double.parse(txt2).toStringAsFixed(2))) {
                                correctAnswer = "";
                                bgcolor = Colors.green.shade300;
                              } else {
                                bgcolor = Colors.red.shade300;
                                Vibration.vibrate();
                                correctAnswer =
                                    "Correct Answer = ${double.parse(answer.toStringAsFixed(2))}";
                              }
                            }
                          } else {
                            bgcolor = Colors.white;
                            correctAnswer = "";
                            Fluttertoast.showToast(
                              msg: "Enter valid decimal input!",
                              fontSize: 15,
                            );
                          }
                        } else {
                          bgcolor = Colors.white;
                          correctAnswer = "";
                          Fluttertoast.showToast(
                            msg: "Choose a Physical Property!",
                            fontSize: 15,
                          );
                        }
                      });
                    },
                  ),
                ),
              ),
                ],
              ),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.all(8),
                height: 100,
                padding: EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 4,
                ),
                child: Text(
                  correctAnswer,
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void fun1() {
    if (c1 == 0) {
      final val = TextSelection.collapsed(offset: textController1.text.length);
      textController1.selection = val;
      c1 = 1;
    }
  }

  void fun2() {
    if (c2 == 0) {
      final val = TextSelection.collapsed(offset: textController2.text.length);
      textController2.selection = val;
      c2 = 1;
    }
  }
}
