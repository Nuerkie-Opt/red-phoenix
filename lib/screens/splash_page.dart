import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Color(0xFF721727), Color(0xFF7b2635)],
                end: Alignment.bottomCenter,
                begin: Alignment.topCenter),
          ),
          child: Center(
            child: Image.asset(
              "assets/images/logo_transparent.png",
              width: 300,
            ),
          ),
        ),
      ),
    );
  }
}
