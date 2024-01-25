import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:eduventure_video_call/constants/colors.dart';
import 'join_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const JoinScreen(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorWhite,
      appBar: PreferredSize(
        preferredSize: Size.zero,
        child: AppBar(
          backgroundColor: colorWhite,
        ),
      ),
      body: Container(
          height: double.infinity,
          width: double.infinity,
          color: colorWhite,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  width: 220,
                  height: 220,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25)
                  ),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(200),
                      child: Image.asset("assets/logo.png", ))
              ),
              SizedBox(
                height: 26,
              ),
              Text(
                "Eduventure",
                style: TextStyle(
                    color: colorBlack,
                    fontSize: 25, fontWeight: FontWeight.w500),
              )
            ],
          )),
    );
  }
}
