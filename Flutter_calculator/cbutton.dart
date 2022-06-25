import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class cbutton extends StatelessWidget {
  final String text;
  final int fillcolor;
  final int textcolor;
  final Function callback;
  const cbutton({
    Key key,
    this.text,
    this.fillcolor,
    this.textcolor=0xffffffff,
    this.callback,
  }): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(12.0),
      child: SizedBox(
          width:65,
          height: 65,
          child:FlatButton(onPressed: (){
            callback(text);
          },
          splashColor: Colors.lightBlueAccent,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0)),
          child: Text(text,
          style: TextStyle(fontSize: 24.0),),
          color: fillcolor != null ? Color(fillcolor): null,
            textColor: Color(textcolor),
      )),
    );
  }
}
