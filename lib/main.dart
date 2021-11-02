import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:online_currency_converter/splash.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Online Currency Converter',
      theme: ThemeData(
        primarySwatch: Colors.orange, 
        scaffoldBackgroundColor: const Color(0xFFE8EAF6),
        textTheme: GoogleFonts.acmeTextTheme(Theme.of(context).textTheme,),
      ),
      home: const SplashPage(),
    );
  }
}