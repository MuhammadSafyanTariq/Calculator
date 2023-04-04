import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  Widget calcBtn(String btnText, Color btnColor, Color txtColor) {
    return InkWell(
      onTap: () {
        calculation(btnText);
      },
      child: Material(
        borderRadius: BorderRadius.circular(100),
        clipBehavior: Clip.antiAlias,
        child: Container(
          height: 70,
          width: 70,
          color: btnColor,
          child: Center(
            child: Text(
              btnText,
              style: TextStyle(
                color: txtColor,
                fontSize: 35,
                //fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget calcBtn1(String btnText, Color btnColor, Color txtColor) {
    return InkWell(
      onTap: () {},
      child: ElevatedButton(
        style: ButtonStyle(),
        onPressed: () {
          calculation(btnText);
        },
        child: Text(
          btnText,
          style: TextStyle(
            color: txtColor,
          ),
        ),
      ),
    );
  }

  Widget longBtn(String btnText, Color btnColor, Color txtColor) {
    return InkWell(
      onTap: () {},
      child: Material(
        borderRadius: BorderRadius.circular(100),
        clipBehavior: Clip.antiAlias,
        child: Container(
          height: 70,
          width: 157,
          color: btnColor,
          child: Center(
            child: Text(
              btnText,
              style: TextStyle(
                color: txtColor,
                fontSize: 35,
                //fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("Calculator"),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5),
        child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
          SingleChildScrollView(
            reverse: true,
            scrollDirection: Axis.horizontal,
            child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  text,
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    fontSize: 100,
                    color: Colors.white,
                  ),
                ),
              ),
            ]),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              calcBtn("AC", (Colors.grey), (Colors.white)),
              calcBtn("+/-", (Colors.grey), (Colors.white)),
              calcBtn("%", (Colors.grey), (Colors.white)),
              calcBtn("/", (Colors.amber), (Colors.white)),
              //calcBtn1("+/-", (Colors.grey), (Colors.white)),
            ],
          ),
          SizedBox(
            height: 10.00,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              calcBtn("1", (Color.fromARGB(250, 29, 27, 27)), (Colors.white)),
              calcBtn("2", (Color.fromARGB(250, 29, 27, 27)), (Colors.white)),
              calcBtn("3", (Color.fromARGB(250, 29, 27, 27)), (Colors.white)),
              calcBtn("x", (Colors.amber), (Colors.white)),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              calcBtn("4", (Color.fromARGB(250, 29, 27, 27)), (Colors.white)),
              calcBtn("5", (Color.fromARGB(250, 29, 27, 27)), (Colors.white)),
              calcBtn("6", (Color.fromARGB(250, 29, 27, 27)), (Colors.white)),
              calcBtn('-', (Colors.amber), (Colors.white)),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              calcBtn("7", (Color.fromARGB(250, 29, 27, 27)), (Colors.white)),
              calcBtn("8", (Color.fromARGB(250, 29, 27, 27)), (Colors.white)),
              calcBtn("9", (Color.fromARGB(250, 29, 27, 27)), (Colors.white)),
              calcBtn("+", (Colors.amber), (Colors.white)),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              longBtn("0", (Color.fromARGB(250, 29, 27, 27)), (Colors.white)),
              calcBtn(".", (Color.fromARGB(250, 29, 27, 27)), (Colors.white)),
              calcBtn("=", (Colors.white), (Colors.black)),
            ],
          ),
          SizedBox(
            height: 30,
          ),
        ]),
      ),
    );
  }

  dynamic text = '0';
  double numOne = 0;
  double numTwo = 0;

  dynamic result = '';
  dynamic finalResult = '';
  dynamic opr = '';
  dynamic preOpr = '';
  void calculation(btnText) {
    if (btnText == 'AC') {
      text = '0';
      numOne = 0;
      numTwo = 0;
      result = '';
      finalResult = '0';
      opr = '';
      preOpr = '';
    } else if (opr == '=' && btnText == '=') {
      if (preOpr == '+') {
        finalResult = add();
      } else if (preOpr == '-') {
        finalResult = sub();
      } else if (preOpr == 'x') {
        finalResult = mul();
      } else if (preOpr == '/') {
        finalResult = div();
      }
    } else if (btnText == '+' ||
        btnText == '-' ||
        btnText == 'x' ||
        btnText == '/' ||
        btnText == '=') {
      if (numOne == 0) {
        numOne = double.parse(result);
      } else {
        numTwo = double.parse(result);
      }

      if (opr == '+') {
        finalResult = add();
      } else if (opr == '-') {
        finalResult = sub();
      } else if (opr == 'x') {
        finalResult = mul();
      } else if (opr == '/') {
        finalResult = div();
      }
      preOpr = opr;
      opr = btnText;
      result = '';
    } else if (btnText == '%') {
      result = numOne / 100;
      finalResult = doesContainDecimal(result);
    } else if (btnText == '.') {
      if (!result.toString().contains('.')) {
        result = result.toString() + '.';
      }
      finalResult = result;
    } else if (btnText == '+/-') {
      result.toString().startsWith('-')
          ? result = result.toString().substring(1)
          : result = '-' + result.toString();
      finalResult = result;
    } else {
      result = result + btnText;
      finalResult = result;
    }

    setState(() {
      text = finalResult;
    });
  }

  String add() {
    result = (numOne + numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }

  String sub() {
    result = (numOne - numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }

  String mul() {
    result = (numOne * numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }

  String div() {
    result = (numOne / numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }

  String doesContainDecimal(dynamic result) {
    if (result.toString().contains('.')) {
      List<String> splitDecimal = result.toString().split('.');
      if (!(int.parse(splitDecimal[1]) > 0))
        return result = splitDecimal[0].toString();
    }
    return result;
  }
}
