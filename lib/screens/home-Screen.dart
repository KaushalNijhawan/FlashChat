import 'package:flashchat/screens/login_screen.dart';
import 'package:flashchat/screens/register_screen.dart';
import 'package:flashchat/widgets/ButtonWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class HomeScreen extends StatefulWidget {
  static const String id = 'HomeScreen';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation colorAnimation ;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration:Duration(milliseconds: 1000),
      vsync: this,
    );
    colorAnimation = ColorTween(

      begin: Colors.blueGrey,
      end: Colors.white
    ).animate(controller);
    controller..forward();
    controller.addListener(() {
      setState(() {

      });

    });

  }
  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorAnimation.value,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
            Row(

              children: [
                Hero(
                  tag: 'logo',
                  child: Image(
                    height: MediaQuery.of(context).size.width*0.25*(controller.value),
                    image :  AssetImage('images/logo.png'),
                  ),
                ),

                Center(
                  child: AnimatedTextKit(
                    animatedTexts: [
                      TypewriterAnimatedText(
                          ' Flash Chat',
                          speed: Duration(milliseconds:70),
                          textStyle: TextStyle(
                              color : Colors.grey[700],
                              fontSize: 48.0,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.none
                          )
                      ,)
                    ],
                  ),
                ),

              ],

            ),
          SizedBox(height: MediaQuery.of(context).size.height*0.01),

          Padding(
            padding: const EdgeInsets.all(15.0),
            child: SizedBox(
              height: MediaQuery.of(context).size.height*0.06,
              child: ButtonWidget(id: LoginScreen.id, buttonString: 'Login', color: Colors.teal[400],
              onPressed: (){
                Navigator.pushNamed(context, LoginScreen.id);
              },)
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: SizedBox(
              height: MediaQuery.of(context).size.height*0.06,
              child: ButtonWidget(id:RegisterScreen.id , buttonString: 'Register' , color: Colors.purple[600],
              onPressed: (){
                Navigator.pushNamed(context, RegisterScreen.id);
              },)
            ),
          )
          ],
      ),
    );
  }
}
