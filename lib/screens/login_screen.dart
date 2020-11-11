import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('LogIn Page', style: TextStyle(color: Theme.of(context).accentColor)),
      ),
      body: Center(
        child:Text('This is the logIn page.', style: TextStyle(color: Colors.blueAccent),),
      ),
    );
  }
}