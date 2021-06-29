import 'package:firebase_auth/firebase_auth.dart';
import 'package:flashchat/screens/chat_screen.dart';
import 'package:flashchat/widgets/ButtonWidget.dart';
import 'package:flashchat/widgets/TextField.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class RegisterScreen extends StatefulWidget {
  static const String id = 'RegisterScreen';

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  FirebaseAuth _auth;
   String email= '';
   String password = '';
   bool loading = false;

  @override
  void initState() {
    super.initState();
    _auth = FirebaseAuth.instance;
  }

  Widget showSpinner(){
    return SafeArea(
      child: Center(
        child: SpinKitFadingCube(
          color: Colors.blue[400],
          size: 100.0,
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
          scrollDirection: Axis.vertical,
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
                    child:TextFieldWidget(helpTextString: 'abc@gmail.com', borderColor: Colors.teal[400], passwordField: false,
                    onSubmit: (String getString){
                      setState(() {
                        this.email = getString;
                      });

                    },)
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Container(
                    height: MediaQuery.of(context).size.height*0.07,
                    width: MediaQuery.of(context).size.width*0.9,
                    child:TextFieldWidget(helpTextString: 'password', borderColor: Colors.blue,passwordField: true,
                        onSubmit: (String getString){
                          setState(() {
                            this.password = getString;
                            });

                        }),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(14.0),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height*0.06,
                  child: ButtonWidget(id:RegisterScreen.id , buttonString: 'Register' , color: Colors.purple[600],
                  onPressed:  () async{
                        print('its final ');
                        print(email);
                        print(password);
                        try{
                          setState(() {
                            loading = true;
                          });
                          final newUser = await _auth.createUserWithEmailAndPassword(email: email, password: password);
                          if(newUser!= null){
                            setState(() {
                              loading = false;
                            });

                            Navigator.pushNamed(context, ChatScreen.id);
                          }

                        }catch(e){
                          print(e);
                    }

                  },)
                ),
              )
            ],
          ),
        )
    );
  }
}
