import 'package:flashchat/Service/TextFieldValues.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextFieldWidget extends StatefulWidget {
  final String helpTextString;
  final Color borderColor;
  final bool passwordField;
  final Function onSubmit;
  TextFieldWidget({@required this.helpTextString, this.borderColor, this.passwordField ,  this.onSubmit(String val)});

  @override
  _TextFieldWidgetState createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  TextFieldValues textFieldValue = new TextFieldValues();

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: widget.passwordField,

    onChanged: (String changedVal){
        widget.onSubmit(changedVal);

    },
      style: TextStyle(
          color: Colors.black,
          fontSize: 20.0
      ),
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
            borderSide:BorderSide(
                color: widget.borderColor
            ) ,
            borderRadius:BorderRadius.all(
                Radius.circular(28.0)

            )
        ),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: widget.borderColor
            ) ,
            borderRadius:BorderRadius.all(
                Radius.circular(28.0)
            )
        ),
        filled: true,
        hintText: widget.helpTextString,
        hintStyle: TextStyle(
          color: Colors.grey,

        ),
        fillColor: Colors.white,

      ),
      textCapitalization: TextCapitalization.words,
      textAlign: TextAlign.center,
      onSubmitted: (String finalString){
           widget.onSubmit(finalString);
      },

    );
  }
}
