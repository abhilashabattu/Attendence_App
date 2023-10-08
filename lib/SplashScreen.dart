import 'dart:async';

import 'package:attendence/Mark.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'main.dart';
import 'loginPage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState(){
    super.initState();

    Timer(Duration(seconds: 5), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Mark()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
            body: Container(
              child:Center(child: Image.asset('assets/Images/Logo.jpg',height: 100, width: 100)),
            ),
    );
  }
}
