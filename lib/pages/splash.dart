import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mussabihati/pages/home.dart';
import 'package:mussabihati/theme/app_theme.dart';
import 'package:mussabihati/theme/theme_types.dart';
import 'package:provider/provider.dart';


class SplashScreen extends StatefulWidget {


  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer t;
  @override
  void initState() {
    t = Timer(Duration(milliseconds: 1200), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => Home()));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppTheme>(
      builder: (context, AppTheme appTheme, child) {
        return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors:appTheme.themeType == ThemeType.CAFFEINE ?  [
                  Color.fromARGB(255, 19, 98,155),
                  Color.fromARGB(255, 0, 52,89),
                  Color.fromARGB(255, 19, 98,155)
                ]:[
                  Color.fromARGB(255, 2, 30,50),
                  Color.fromARGB(255, 10, 63,100),
                  Color.fromARGB(255, 2, 30,50),

                ],
                transform: GradientRotation(4),
              ),
            ),
            child: Scaffold(backgroundColor: Colors.transparent,body: Center(child: Image.asset('assets/logo.png', height: 160, width: 160))));
      }
    );
  }
}
