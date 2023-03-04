import 'package:currency_mate_app/Screens/camera_screen.dart';
import 'package:currency_mate_app/Screens/forgot_password_screen.dart';
import 'package:currency_mate_app/Screens/home_screen.dart';
import 'package:currency_mate_app/Screens/loading_screen.dart';
import 'package:currency_mate_app/Screens/login_screen.dart';
import 'package:currency_mate_app/Screens/record.dart';
import 'package:currency_mate_app/Screens/sign_in_screen.dart';
import 'package:currency_mate_app/Utils/style.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme:ThemeData(
        primaryColor: primary,
      ),
      initialRoute: '/login' ,
      routes: {
        '/loading':(context)=> const LoadingScreen(),
        '/home':(context)=> const HomeScreen(),
        '/detect_currency':(context)=> const DetectCurrency(),
        '/login':(context)=>  LoginScreen(),
        '/sign_in':(context)=>  SignupScreen(),
        '/forgot_password':(context)=>  const ForgotPassword(),
        '/record':(context)=> const MainPage(),

      },
    );
  }
}
