import 'package:flutter/material.dart';
//import './screens/home_screen.dart';
import './screens/sign_up_screen.dart';
//import './screens/login_screen.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Practise App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        accentColor: Colors.green,
      ),
      //home: HomeScreen(),
      routes: {
        '/': (_) => SignUpSCreen(),
       // SignUpSCreen.logInRoute: (_) => LoginScreen(),
      },
    );
  }
}