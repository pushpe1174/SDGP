import 'package:currency_mate_app/Screens/camera_screen.dart';
import 'package:currency_mate_app/Screens/forgot_password_screen.dart';
import 'package:currency_mate_app/Screens/home_screen.dart';
import 'package:currency_mate_app/Screens/loading_screen.dart';
import 'package:currency_mate_app/Screens/login_screen.dart';
import 'package:currency_mate_app/Screens/sign_in_screen.dart';
import 'package:currency_mate_app/Screens/upload_screen.dart';
import 'package:currency_mate_app/Service/auth_service.dart';
import 'package:currency_mate_app/Utils/style.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'Screens/record_screen.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  MyAppState createState() => MyAppState();
}
class MyAppState extends State<MyApp> {
  AuthClass authClass=AuthClass();
  Widget currentPage=const LoginScreen();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkLogin();
  }

  void checkLogin()async{
    String? token=await authClass.getToken();
    if(token!=null){
      setState(() {
        currentPage= const HomeScreen();
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: primary,
      ),
      initialRoute: '/home',
      routes: {
        '/current_page':(context)=> currentPage,
        '/loading': (context) => const LoadingScreen(),
        '/home': (context) =>  const HomeScreen(),
        '/detect_currency': (context) => const DetectCurrency(),
        '/login': (context) => const LoginScreen(),
        '/sign_up': (context) => const SignupScreen(),
        '/forgot_password': (context) => ForgotPassword(),
        '/record': (context) => const PreviousRecord(),
        '/upload_currency': (context) => const CameraDetectCurrency(),
      },
    );
  }

}
