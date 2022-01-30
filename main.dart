import 'package:flutter/material.dart';
import "package:math_expressions/math_expressions.dart";

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculator',
      home: Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  const Calculator({Key? key}) : super(key: key);

  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String equation = '0';
  String result = '0';
  String expression = '';

  double equationFontSize = 38.0;
  double resultFontSize = 48.0;

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Text(
              equation,
              style: TextStyle(
                color: Colors.white,
                fontSize: equationFontSize,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Text(
              result,
              style: TextStyle(
                fontSize: resultFontSize,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(
            height: h * 0.03,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CustomButton('AC', Colors.grey, Colors.black, w * 0.2),
              CustomButton('C', Colors.grey, Colors.black, w * 0.2),
              CustomButton('+/-', Colors.grey, Colors.black, w * 0.2),
              CustomButton('÷', Colors.amber.shade700, Colors.white, w * 0.2),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CustomButton('7', Colors.grey, Colors.black, w * 0.2),
              CustomButton('8', Colors.grey, Colors.black, w * 0.2),
              CustomButton('9', Colors.grey, Colors.black, w * 0.2),
              CustomButton('x', Colors.amber.shade700, Colors.white, w * 0.2),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CustomButton('4', Colors.grey, Colors.black, w * 0.2),
              CustomButton('5', Colors.grey, Colors.black, w * 0.2),
              CustomButton('6', Colors.grey, Colors.black, w * 0.2),
              CustomButton('-', Colors.amber.shade700, Colors.white, w * 0.2),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CustomButton('1', Colors.grey, Colors.black, w * 0.2),
              CustomButton('2', Colors.grey, Colors.black, w * 0.2),
              CustomButton('3', Colors.grey, Colors.black, w * 0.2),
              CustomButton('+', Colors.amber.shade700, Colors.white, w * 0.2),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CustomButton('0', Colors.grey, Colors.black, w * 0.45),
              CustomButton('.', Colors.grey, Colors.black, w * 0.2),
              CustomButton('=', Colors.amber.shade700, Colors.white, w * 0.2),
            ],
          ),
        ],
      ),
    );
  }

  Widget CustomButton(
      String text, Color BtnClr, Color txtClr, double BtnWidth) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          operation(text);
        },
        child: Container(
          height: h * 0.09,
          width: BtnWidth,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: BtnClr,
            borderRadius: BorderRadius.circular(200.0),
          ),
          child: Text(
            text,
            style: TextStyle(
              color: txtClr,
              fontSize: 38,
            ),
          ),
        ),
      ),
    );
  }

  void operation(String text) {
    setState(() {
      if (text == '=') {
        try {
          equationFontSize = 38.0;
          resultFontSize = 48.0;
          expression = equation;
          expression = expression.replaceAll('÷', '/');
          expression = expression.replaceAll('x', '*');

          Parser P = Parser();
          Expression Exp = P.parse(expression);

          ContextModel contxt = ContextModel();
          result = '${Exp.evaluate(EvaluationType.REAL, contxt)}';
        } catch (e) {
          equationFontSize = 35;
          resultFontSize = 45;
          result = 'ERROR';
          setState(() {});
        }
      } else if (text == 'C') {
        equationFontSize = 48.0;
        resultFontSize = 38.0;
        equation = equation.substring(0, equation.length - 1);
        if (equation == '') {
          equation = '0';
          result = '0';
        }
      } else if (text == 'AC') {
        equation = '0';
        result = '0';
      } else if (text == '+/-') {
        equation.toString().startsWith('-')
            ? equation = equation.toString().substring(1)
            : equation = '-' + equation.toString();
      } else {
        if (equation == '0') {
          equation = text;
        } else {
          equationFontSize = 48.0;
          resultFontSize = 38.0;
          equation = equation + text;
        }
      }
    });
  }
}
