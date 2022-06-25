import 'package:flutter/material.dart';
import 'package:flutter_calcy/cbutton.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(MaterialApp(
    home: calcy(),
  ));
}

class calcy extends StatefulWidget {
  @override
  _calcyState createState() => _calcyState();
}

class _calcyState extends State<calcy> {
  String _expe='';
  String _his='';

  void clickb(String text)
  {
    setState(() {
      _expe+=text;
    });
  }
  void allclear(String text)
  {
    setState(() {
      _expe ='';
      _his ='';
    });
  }
  void clear(String text)
  {
    setState(() {
      _expe ='';
    });
  }
  void eval(String text)
  {
    Parser p = Parser();
    Expression exp = p.parse(_expe);
    ContextModel cm = ContextModel();
    double ans = exp.evaluate(EvaluationType.REAL, cm);
    setState(() {
      _his=_expe;
      _expe= ans.toString();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black26,
      appBar: AppBar(
        title: Text('Calculator in Flutter'),
        centerTitle: true,
        backgroundColor: Color(0xff283030),
      ),
      body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(17),
                  child: Text(_his,
                    style: TextStyle(
                      fontSize: 25.0,
                      color: Colors.white24,
                    ),
                  ),
                  alignment: Alignment(1,1),
                ),
                Container(
                  padding: EdgeInsets.all(17),
                  child: Text(_expe,
                  style: TextStyle(
                    fontSize: 50.0,
                    color: Colors.white,
                  ),
                  ),
                  alignment: Alignment(1,1),
                ),
            SizedBox(height: 50,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                cbutton(
                  text: 'AC',
                  fillcolor: 0xFFB388FF,
                  callback: allclear,
                ),
                cbutton(
                  text: 'C',
                  fillcolor: 0xFFB388FF,
                  callback: clear,
                ),
                cbutton(
                  text: '%',
                  fillcolor: 0xffffffff,
                  textcolor: 0xFFB388FF,
                  callback: clickb,
                ),
                cbutton(
                  text: '/',
                  fillcolor: 0xffffffff,
                  textcolor: 0xFFB388FF,
                  callback: clickb,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                cbutton(
                  text: '7',
                  callback: clickb,
                ),
                cbutton(
                  text: '8',
                  callback: clickb,
                ),
                cbutton(
                  text: '9',
                  callback: clickb,
                ),
                cbutton(
                  text: '*',
                  fillcolor: 0xffffffff,
                  textcolor: 0xFFB388FF,
                  callback: clickb,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                cbutton(
                  text: '4',
                  callback: clickb,
                ),
                cbutton(
                  text: '5',
                  callback: clickb,
                ),
                cbutton(
                  text: '6',
                  callback: clickb,
                ),
                cbutton(
                  text: '-',
                  fillcolor: 0xffffffff,
                  textcolor: 0xFFB388FF,
                  callback: clickb,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                cbutton(
                  text: '1',
                  callback: clickb,
                ),
                cbutton(
                  text: '2',
                  callback: clickb,
                ),
                cbutton(
                  text: '3',
                  callback: clickb,
                ),
                cbutton(
                  text: '+',
                  fillcolor: 0xffffffff,
                  textcolor: 0xFFB388FF,
                  callback: clickb,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                cbutton(
                  text: '.',
                  callback: clickb,
                ),
                cbutton(
                  text: '0',
                  callback: clickb,
                ),
                cbutton(
                  text: '00',
                  callback: clickb,
                ),
                cbutton(
                  text: '=',
                  fillcolor: 0xffffffff,
                  textcolor: 0xFFB388FF,
                  callback: eval,
                ),
              ],
            ),
          ])),
    );
  }
}
