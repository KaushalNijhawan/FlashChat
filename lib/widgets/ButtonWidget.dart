import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ButtonWidget extends StatefulWidget {
  final String id;
  final String buttonString;
  final Color color;
  final Function onPressed;
  ButtonWidget({@required this.id, @required this.buttonString, this.color , this.onPressed});

  @override
  _ButtonWidgetState createState() => _ButtonWidgetState();
}

class _ButtonWidgetState extends State<ButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style:ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(widget.                       color),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24.0),
                  //side: BorderSide(color: Colors.blue)
                )
            )
        ),
        onPressed: widget.onPressed,
        child: Text(
            widget.buttonString,
            style:TextStyle(
                color: Colors.white
            )
        )
    );
  }
}
