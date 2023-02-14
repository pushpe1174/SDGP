import 'package:currency_mate_app/Screens/camera_screen.dart';
import 'package:currency_mate_app/Screens/home_screen.dart';
import 'package:currency_mate_app/Screens/loading_screen.dart';
import 'package:currency_mate_app/Utils/style.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme:ThemeData(
        primaryColor: primary,
      ),
      initialRoute: '/home' ,
      routes: {
        '/loading':(context)=> const LoadingScreen(),
        '/home':(context)=> const HomeScreen(),
        '/detect_currency':(context)=>  const DetectCurrency(),
      },
    );
  }
}
