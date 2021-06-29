import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatWidget extends StatefulWidget {
  final String message ;
  final String sender;
  final String loggedEmail;


  ChatWidget({this.message, this.sender, this.loggedEmail});

  @override
  _ChatWidgetState createState() => _ChatWidgetState();
}

class _ChatWidgetState extends State<ChatWidget> {
  bool changeAlign = false;
  @override
  Widget build(BuildContext context) {
    if(widget.loggedEmail != widget.sender){
       changeAlign = true;
    }else{
      changeAlign = false;
    }
    return   Container(
      margin: changeAlign ? EdgeInsets.only(left:8.0,bottom:18.0): EdgeInsets.only(right:8.0,bottom: 18.0),
      child: Column(
        crossAxisAlignment: changeAlign ? CrossAxisAlignment.start  : CrossAxisAlignment.end,
        children: [
          Text(
            widget.sender,
            style:TextStyle(
                color: Colors.grey[700],
                fontSize: 14.0
            ),
          ),
          Material(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(26.0),
                  bottomRight: Radius.circular(26.0)
              ),
              elevation: 7.0,
              color: changeAlign ? Colors.blueGrey :  Colors.teal,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical:12.0 , horizontal: 12.0),
                child: Text(
                    widget.message,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 17.0
                    )
                ),
              )
          ),
        ],
      ),
    );
  }
}
