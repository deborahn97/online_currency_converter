import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'occ.dart';

// Splash Page

class SplashPage extends StatefulWidget {
  const SplashPage({ Key? key }) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
 @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 3),
      () => Navigator.pushReplacement(
        context, MaterialPageRoute(
          builder: (content) => const OnlineCurrencyConverter(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/splash_logo.png', scale: 2),
              const SizedBox(height: 30),
              const Text(
                "Online Currency Converter",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFFFA000),
                ),
              ),
              const SizedBox(height: 50),
              const Text(
                "Version 0.1",
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              const Text(
                "designed by nightingale",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}