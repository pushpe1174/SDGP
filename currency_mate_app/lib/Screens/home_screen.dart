import 'package:currency_mate_app/Screens/login_screen.dart';
import 'package:currency_mate_app/Service/auth_service.dart';
import 'package:currency_mate_app/Utils/style.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:flutter_tts/flutter_tts.dart';

class HomeScreen extends StatefulWidget{
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}
class HomeScreenState extends State<HomeScreen>{
  late AuthClass authClass;

  _printUserID(){
    authClass = AuthClass();
    print(FirebaseAuth.instance.currentUser?.uid.toString());
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _printUserID();

  }



  @override
  Widget build(BuildContext context) {
    FlutterTts flutterTts = FlutterTts();
    return Scaffold(
      backgroundColor: Style.bgColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          "Home",
          style: Style.headingStyle,
        ),
        actions: <Widget>[
          IconButton(onPressed:() async{
            await authClass.logout().then((value) {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => const LoginScreen())
              );
            });
          },
              icon: const Icon(Icons.logout),
          )
        ],
        centerTitle: true,
        backgroundColor: const Color(0xff1D3557),
        elevation: 0,
      ),

      body: Padding(
        padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 0.0),
        child: Center(
          child: Column(
            children: [
              const Gap(15),
              SizedBox(
                width: 300,
                height: 170,
                child: ElevatedButton(

                  onPressed: (){
                    Navigator.pushNamed(context, '/detect_currency');
                  },

                  onLongPress: (){
                    flutterTts.speak('Detect Currency');
                  },

                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[300],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/DetectCurrency.png',
                        height: 100,
                        width: 200,
                        fit: BoxFit.cover,
                      ),
                      Text(
                        "Detect Currency",
                        style: Style.headingStyle2,
                      )
                    ],
                  ),
                ),
              ),
              const Gap(15),
              SizedBox(
                width: 300,
                height: 170,
                child: ElevatedButton(
                  onPressed: (){
                    Navigator.pushNamed(context, '/record');
                  },

                  onLongPress: (){
                    flutterTts.speak('Previous Records');
                  },

                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[300],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),

                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/PreviousRecord.png',
                        height: 100,
                        width: 100,
                        fit: BoxFit.cover,
                      ),
                      Text(
                        " Records",
                        style: Style.headingStyle2,
                      )
                    ],
                  ),
                ),
              ),
              const Gap(15),
              SizedBox(
                width: 300,
                height: 170,
                child: ElevatedButton(
                  onPressed: (){
                    Navigator.pushNamed(context, '/upload_currency');
                  },

                  onLongPress: (){
                    flutterTts.speak('Open Camera');
                  },

                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[300],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/camera_icon.png',
                        height: 80,
                        width: 110,
                        scale: 0.2,
                        fit: BoxFit.cover,
                      ),
                      const Gap(10),
                      Text(
                        "Camera",
                        style: Style.headingStyle2,
                      )
                    ],
                  ),
                ),
              ),
              const Gap(15),
              SizedBox(
                width: 360,
                height: 60,
                child: TextButton(
                  onPressed: (){
                    flutterTts.speak('Tap and hold the buttons to hear the instructions');
                  },

                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1D3557),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Gap(10),
                      Text(
                        "Voice Instructions",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      )
    );
  }
}
