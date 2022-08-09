// ignore_for_file: prefer_const_constructors, dead_code, unnecessary_this

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  MyAppState createState() => MyAppState();
}

DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
      value: item,
      child: Text(
        item,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 25,
        ),
      ),
    );

DropdownMenuItem<String> buildMenuItemMini(String item) => DropdownMenuItem(
      value: item,
      child: Text(
        item,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
    );

class MyAppState extends State<MyApp> {
  final items = ["Temperature", "Length", "Weight", "Speed"];
  final temp = ["Celcius", "Fahrenheit"];
  final length = ["Metre", "Feet"];
  final weight = ["Kilogram", "Pound"];
  final empty = [""];
  final speed = ["Kmph", "Mph"];
  int c1 = 0;
  int c2 = 0;
  TextEditingController textController1 = TextEditingController(text: "0.0");
  TextEditingController textController2 = TextEditingController(text: "0.0");

  String? value;
  String? unit1;
  String? unit2;
  final tempUnit = ["°C", "°F"];
  final lengthUnit = ["m", "ft"];
  final weightUnit = ["kg", "lb"];
  final speedUnit = ["km/h", "mi/h"];
  String symbol1 = "";
  String symbol2 = "";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text(
            "Units Convertor",
          ),
        ),
        body: Column(
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
                  items: items.map(buildMenuItem).toList(),
                  onChanged: (value) => setState(() {
                    this.value = value;
                    value == "Temperature"
                        ? unit1 = temp[0]
                        : value == "Length"
                            ? unit1 = length[0]
                            : value == "Weight"
                                ? unit1 = weight[0]
                                : value == "Speed"
                                    ? unit1 = speed[0]
                                    : unit1 = "";
                    value == "Temperature"
                        ? unit2 = temp[1]
                        : value == "Length"
                            ? unit2 = length[1]
                            : value == "Weight"
                                ? unit2 = weight[1]
                                : value == "Speed"
                                    ? unit2 = speed[1]
                                    : unit2 = "";

                    value == "Temperature"
                        ? symbol1 = tempUnit[temp.indexOf(unit1!)]
                        : value == "Length"
                            ? symbol1 = lengthUnit[length.indexOf(unit1!)]
                            : value == "Weight"
                                ? symbol1 = weightUnit[weight.indexOf(unit1!)]
                                : value == "Speed"
                                    ? symbol1 = speedUnit[speed.indexOf(unit1!)]
                                    : symbol1 = "";

                    value == "Temperature"
                        ? symbol2 = tempUnit[temp.indexOf(unit2!)]
                        : value == "Length"
                            ? symbol2 = lengthUnit[length.indexOf(unit2!)]
                            : value == "Weight"
                                ? symbol2 = weightUnit[weight.indexOf(unit2!)]
                                : value == "Speed"
                                    ? symbol2 = speedUnit[speed.indexOf(unit2!)]
                                    : symbol2 = "";
                    textController1.text = "0.0";
                    textController2.text = "0.0";
                  }),
                ),
              ),
            ),
            Row(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.all(8),
                  width: 100,
                  padding: EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 4,
                  ),
                  child: Text(
                    "From",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      color: Color.fromARGB(255, 96, 75, 255),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(8),
                  width: 250,
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
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      hint: Text(
                        "Choose first unit",
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
                      items: value == "Temperature"
                          ? temp.map(buildMenuItemMini).toList()
                          : value == "Length"
                              ? length.map(buildMenuItemMini).toList()
                              : value == "Weight"
                                  ? weight.map(buildMenuItemMini).toList()
                                  : value == "Speed"
                                      ? speed.map(buildMenuItemMini).toList()
                                      : empty.map(buildMenuItemMini).toList(),
                      onChanged: (value) => setState(() {
                        unit1 = value;
                        this.value == "Temperature"
                            ? symbol1 = tempUnit[temp.indexOf(unit1!)]
                            : this.value == "Length"
                                ? symbol1 = lengthUnit[length.indexOf(unit1!)]
                                : this.value == "Weight"
                                    ? symbol1 =
                                        weightUnit[weight.indexOf(unit1!)]
                                    : this.value == "Speed"
                                        ? symbol1 =
                                            speedUnit[speed.indexOf(unit1!)]
                                        : symbol1 = "";
                        textController1.text = "0.0";
                      }),
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
              children: <Widget>[
                Container(
                  margin: EdgeInsets.all(8),
                  width: 100,
                  padding: EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 4,
                  ),
                  child: Text(
                    "To",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      color: Color.fromARGB(255, 96, 75, 255),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(8),
                  width: 250,
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
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      hint: Text(
                        "Choose second unit",
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
                      items: value == "Temperature"
                          ? temp.map(buildMenuItemMini).toList()
                          : value == "Length"
                              ? length.map(buildMenuItemMini).toList()
                              : value == "Weight"
                                  ? weight.map(buildMenuItemMini).toList()
                                  : value == "Speed"
                                      ? speed.map(buildMenuItemMini).toList()
                                      : empty.map(buildMenuItemMini).toList(),
                      onChanged: (value) => setState(() {
                        unit2 = value;
                        this.value == "Temperature"
                            ? symbol2 = tempUnit[temp.indexOf(unit2!)]
                            : this.value == "Length"
                                ? symbol2 = lengthUnit[length.indexOf(unit2!)]
                                : this.value == "Weight"
                                    ? symbol2 =
                                        weightUnit[weight.indexOf(unit2!)]
                                    : this.value == "Speed"
                                        ? symbol2 =
                                            speedUnit[speed.indexOf(unit2!)]
                                        : symbol2 = "";
                        textController2.text = "0.0";
                      }),
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
                            } else {
                              textController2.text = textController1.text;
                              WidgetsBinding.instance.focusManager.primaryFocus
                                  ?.unfocus();
                            }
                          }
                          if (value == "Length") {
                            if (unit1 == "Metre" && unit2 == "Feet") {
                              textController2.text =
                                  ((double.parse(txt1) * 3.28084)).toString();
                            } else if (unit2 == "Metre" && unit1 == "Feet") {
                              textController2.text =
                                  ((double.parse(txt1) / 3.28084)).toString();
                            } else {
                              textController2.text = textController1.text;
                              WidgetsBinding.instance.focusManager.primaryFocus
                                  ?.unfocus();
                            }
                          }
                          if (value == "Weight") {
                            if (unit1 == "Kilogram" && unit2 == "Pound") {
                              textController2.text =
                                  ((double.parse(txt1) * 2.20462)).toString();
                            } else if (unit2 == "Kilogram" &&
                                unit1 == "Pound") {
                              textController2.text =
                                  ((double.parse(txt1) / 2.20462)).toString();
                            } else {
                              textController2.text = textController1.text;
                              WidgetsBinding.instance.focusManager.primaryFocus
                                  ?.unfocus();
                            }
                          }
                          if (value == "Speed") {
                            if (unit1 == "Kmph" && unit2 == "Mph") {
                              textController2.text =
                                  ((double.parse(txt1) / 1.60934)).toString();
                            } else if (unit2 == "Kmph" && unit1 == "Mph") {
                              textController2.text =
                                  ((double.parse(txt1) * 1.60934)).toString();
                            } else {
                              textController2.text = textController1.text;
                              WidgetsBinding.instance.focusManager.primaryFocus
                                  ?.unfocus();
                            }
                          }
                          if (unit1 != unit2 && txt1 != "0.0") {
                            WidgetsBinding.instance.focusManager.primaryFocus
                                ?.unfocus();
                            Fluttertoast.showToast(
                              msg: "Conversion Sucessful!",
                              fontSize: 15,
                            );
                          }
                          else if (txt1 == "0.0" && txt2 == "0.0"){
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
          ],
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
