import 'package:currency_mate_app/Screens/camera_screen.dart';
import 'package:currency_mate_app/Screens/forgot_password_screen.dart';
import 'package:currency_mate_app/Screens/home_screen.dart';
import 'package:currency_mate_app/Screens/loading_screen.dart';
import 'package:currency_mate_app/Screens/login_screen.dart';
import 'package:currency_mate_app/Screens/sign_in_screen.dart';
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
      initialRoute: '/sign_in' ,
      routes: {
        '/loading':(context)=> const LoadingScreen(),
        '/home':(context)=> const HomeScreen(),
        '/detect_currency':(context)=> const DetectCurrency(),
        '/login':(context)=> const LoginScreen(),
        '/sign_in':(context)=> const SignupScreen(),
        '/forgot_password':(context)=>  const ForgotPassword(),

      },
    );
  }
}
