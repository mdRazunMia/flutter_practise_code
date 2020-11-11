import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Parctise App Home Page', 
          style: TextStyle(
            color: Colors.amber, 
            fontSize: 25, 
            fontWeight: FontWeight.bold,
          ),
      ),
      )
    );
  }
}