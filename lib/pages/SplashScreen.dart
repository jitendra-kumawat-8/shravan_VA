import 'package:voice_assisstant/pages/Homescreen.dart';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SplashScreen extends StatefulWidget {
  static const routeName = '/splash';
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.deepPurpleAccent,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                FontAwesomeIcons.handHoldingHeart,
                color: Colors.white,
                size: 90,
              ),
              SizedBox(height: 50),
              TypewriterAnimatedTextKit(
                text: ["We are here for You"],
                textStyle: TextStyle(
                  fontSize: 35.0,
                  color: Colors.white,
                ),
                speed: Duration(milliseconds: 150),
              )
            ],
          ),
        ));
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 4), () {
      Navigator.pushReplacementNamed(context, "/home");
    });
  }
}
