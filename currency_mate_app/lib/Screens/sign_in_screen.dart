import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'home_screen.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({Key? key}) : super(key: key);
  final signupEmailController=TextEditingController();
  final signupPasswordController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF1FAEE),

      appBar: AppBar(
        title: const Text("Sign-up Page"),
        centerTitle: true,
        backgroundColor: const Color(0xff1D3557),
      ),

      body: SingleChildScrollView(
        child: Column(
          children:[
            Padding(
              padding: const EdgeInsets.only(top: 60.0),
              child: Center(
                child: SizedBox(
                    width: 200,
                    height: 150,
                    child: Image.asset('assets/SplashLogo.png')),
              ),
            ),

             Padding(
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: TextField(

                controller: signupEmailController,

                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Email',
                ),
              ),
            ),

             Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 0),
              //padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(

                controller: signupPasswordController,

                obscureText: true,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                ),
              ),
            ),

            const SizedBox(
                height: 20
            ),
            Container(
              height: 50,
              width: 250,
              decoration: BoxDecoration(
                  color: const Color(0xff1D3557),borderRadius: BorderRadius.circular(20)),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xff1D3557)),
                onPressed: () {
                  FirebaseAuth.instance.createUserWithEmailAndPassword(email: signupEmailController.text, password: signupPasswordController.text).then((value) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const HomeScreen())
                    );
                  });

                },
                child: const Text(
                  'Sign-in',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),),
            ),

            const SizedBox(
              height: 130,
            ),
          ],
        ),
      ),
    );
  }
}
