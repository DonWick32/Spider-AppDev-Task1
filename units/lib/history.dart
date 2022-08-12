import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'main.dart';

class history extends StatelessWidget {
  late List<List<String>> data;

  history(this.data);

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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            "History",
          ),
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.home,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: SizedBox(
            child: Container(
              height: MediaQuery.of(context).size.height,
              child: ListView.builder(
                itemBuilder: (ctx, index) {
                  return Card(
                    color: Color.fromARGB(255, 158, 146, 248),
                    child: ListTile(
                      leading: Image.asset(propertiesPics[data[index][0]]!),
                      title: Container(
                        margin: const EdgeInsets.only(left: 3.0),
                        child: Text(
                          data[index][0],
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      subtitle: Container(
                        child: Row(
                          children: [
                            Image.asset(
                              unitsPics[data[index][1]]!,
                              width: 35,
                              height: 35,
                            ),
                            Text(
                              " to ",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Image.asset(
                              unitsPics[data[index][2]]!,
                              width: 35,
                              height: 35,
                            ),
                          ],
                        ),
                      ),
                      trailing: Container(
                        width: 160,
                        child: Column(
                          children: [
                            Text(
                              "${data[index][3]} ${data[index][1]}",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "to",
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                            Text(
                              "${data[index][4]} ${data[index][2]}",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                itemCount: data.length,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
