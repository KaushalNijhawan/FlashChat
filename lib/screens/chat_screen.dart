import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flashchat/screens/home-Screen.dart';
import 'package:flashchat/screens/register_screen.dart';
import 'package:flashchat/widgets/ChatWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ChatScreen extends StatefulWidget {
  static const String id = 'ChatScreen';

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  FirebaseAuth _auth;
  FirebaseFirestore databse;
  String email = '';
  String message = '';
  final fieldText = TextEditingController();

  void clearText() {
    fieldText.clear();
  }

  void checkUser() async{
    _auth = FirebaseAuth.instance;
    try{
      final user = await _auth.currentUser;
      if(user!=null){
        email = user.email;
        print(user.email);
        print('its valid!');
      }else{
        Navigator.pushNamed(context, RegisterScreen.id);
      }
    }catch(e){
      print(e);
    }



  }

  @override
  void initState() {
    databse = FirebaseFirestore.instance;
    super.initState();
    checkUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions : [
            Container(
              margin: EdgeInsets.only(right:MediaQuery.of(context).size.width*0.18),
              child: Text(
                  '⚡ Chat',

                  style:TextStyle(
                      color: Colors.white,
                      fontSize: 37.0,

                  )
              ),
            ),
            TextButton(
              onPressed: (){
               _auth.signOut();
               Navigator.pushNamed(context, HomeScreen.id);
               // getDataFromDB();
              },
              child: Icon(
                Icons.close,
                color: Colors.white,
                size: 32.0,
              ),
            )
          ],
          backgroundColor: Colors.blue,

        ),
        body: Container(
          margin: EdgeInsets.only(top: 15.0, left: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child:StreamBuilder<QuerySnapshot>(
                  stream : databse.collection("messages").snapshots(),
                  builder: (context , snapshot){
                    if(!snapshot.hasData){
                      return SpinKitRotatingCircle(
                          color: Colors.blue[400],
                          size: 100.0,
                        );
                    }else{
                      var messages = snapshot.data.docs.reversed;
                      List<ChatWidget> chats = [];
                      for (var message in messages ){
                          chats.add(ChatWidget(sender: message.get('sender'), message:  message.get('senderMessage'), loggedEmail: email,));
                      }
                      return ListView(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        clipBehavior: Clip.hardEdge,
                        //itemBuilder:(BuildContext context , int index ) => ChatWidget(message : databaseDocuments.values.elementAt(index), sender : databaseDocuments.keys.elementAt(index)),
                        //itemCount: databaseDocuments.length,
                        children: chats,

                      );
                    }
                  },
                )

              ),
              Row(
                 crossAxisAlignment: CrossAxisAlignment.center,
                 children: [
                   Expanded(
                     child: TextField(
                       controller: fieldText,
                       onChanged: (String enteredval){
                            message = enteredval;
                       },
                       style: TextStyle(
                           color: Colors.black,
                           fontSize: 20.0
                       ),
                       decoration: InputDecoration(
                         border: InputBorder.none,
                         hintText: 'Enter your message...',
                         hintStyle: TextStyle(
                             color: Colors.grey
                         ),

                       ),
                       textCapitalization: TextCapitalization.words,
                       onSubmitted: (String finalString){
                         Navigator.pop(context,finalString);
                       },
                     ),
                   )
                   ,
                   TextButton(
                     onPressed: (){
                       FirebaseFirestore.instance.collection('messages').add({
                         'sender' : email,
                         'senderMessage' : message
                       });
                       clearText();
                     },
                     child: Icon(
                       Icons.send,
                       color: Colors.blue,
                       size: 45.0,
                     ),
                   )
                 ],
               )
            ],
          ),
        )
    );
  }
}
