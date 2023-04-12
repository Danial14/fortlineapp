import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fortline_app/Screen/AdsAndMenuTwo.dart';

import 'Login_Screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void dispose() {
    // TODO: implement dispose

    _controller.dispose();
    super.dispose();
  }

  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = AnimationController(vsync: this,duration: const Duration(seconds: 3))..repeat();
    Timer(const Duration(
        seconds: 3),
            (){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginView(),),);
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child:Container(
          decoration: const BoxDecoration(
              image: DecorationImage(image: AssetImage("assets/images/splash.png"),fit: BoxFit.cover)
          ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.end,
          children:  [
            SizedBox(height: 40,),

            SpinKitFadingCircle(
               color: Colors.red,
                size: 40.0,
              controller: _controller,
            ),

          ],
        ),
      ),
    ),
    );
  }
}
