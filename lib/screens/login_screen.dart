import 'package:firebase_auth/firebase_auth.dart';
import 'package:flashchat/screens/chat_screen.dart';
import 'package:flashchat/screens/home-Screen.dart';
import 'package:flashchat/widgets/ButtonWidget.dart';
import 'package:flashchat/widgets/TextField.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'LoginScreen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  FirebaseAuth _auth;
  String email = '';
  String password = '';
  bool loading = false;
  @override
  void initState() {
    super.initState();
    _auth = FirebaseAuth.instance;

  }
  Widget showSpinner(){
     return SafeArea(
       child: Container(
         child: Center(
           child: SpinKitFadingCube(
            color: Colors.blue[400],
            size: 100.0,
        ),
         ),
       ),
     );
  }

  @override
  Widget build(BuildContext context) {
    return loading ? showSpinner() :
      Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height:MediaQuery.of(context).size.height*0.2),
              Hero(
                tag: 'logo',
                child: Image(
                  height: MediaQuery.of(context).size.height*0.2,
                   image: AssetImage('images/logo.png')
                ),
              ),
              SizedBox(height:MediaQuery.of(context).size.height*0.08),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Container(
                    height: MediaQuery.of(context).size.height*0.07,
                    width: MediaQuery.of(context).size.width*0.9,
                    child: TextFieldWidget(helpTextString: 'abc@gmail.com', borderColor: Colors.teal,passwordField: false,
                    onSubmit: (String valChanged){
                            email = valChanged;
                    },)
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Container(
                    height: MediaQuery.of(context).size.height*0.07,
                    width: MediaQuery.of(context).size.width*0.9,
                    child: TextFieldWidget(helpTextString: 'password', borderColor: Colors.blue,passwordField: true,
                    onSubmit:(String valChanged){
                    password = valChanged;
                    },)
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(14.0),
                child: SizedBox(
                    height: MediaQuery.of(context).size.height*0.06,
                  child: ButtonWidget(id: LoginScreen.id, buttonString: 'Login', color: Colors.teal[400],
                  onPressed: () async{
                    setState(() {
                      loading = true;
                    });
                    try{
                     final user = await _auth.signInWithEmailAndPassword(email: email, password: password);


                     if(user!=null){
                       Navigator.pushNamed(context, ChatScreen.id);
                       setState(() {
                         loading = false;
                       });

                     }else{
                       Navigator.pushNamed(context, HomeScreen.id);
                     }
                   }catch(e){
                     print(e);
                   }

                    print(email);
                    print(password);
                  },),
                ),
              )
            ],
          ),
        )
    );
  }
}
