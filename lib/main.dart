import 'package:firebase_core/firebase_core.dart';
import 'package:flashchat/screens/chat_screen.dart';
import 'package:flashchat/screens/home-Screen.dart';
import 'package:flashchat/screens/login_screen.dart';
import 'package:flashchat/screens/register_screen.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: HomeScreen.id,
    routes: {
      HomeScreen.id : (context) => HomeScreen(),
      LoginScreen.id: (context) => LoginScreen(),
      RegisterScreen.id : (context) => RegisterScreen(),
      ChatScreen.id: (context) => ChatScreen()
    },
   )
  );
}

