import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../Utils/style.dart';
import 'login_screen.dart';


class ForgotPassword extends StatelessWidget {
   ForgotPassword({Key? key}) : super(key: key);

  final resetEmailController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF1FAEE),
      appBar: AppBar(
        backgroundColor: const Color(0xff1D3557),
      ),
      body: SingleChildScrollView(
        child: Column(
          children:[
            Padding(
              padding: const EdgeInsets.only(top: 40),
              child: Center(
                child: Image.asset('assets/SplashLogo.png'),
              ),
            ),
            const Gap(10),
            Text("currencyMate".toUpperCase(),
              style: Style.loadingStyle,),

            const SizedBox(height: 20,),

            const Padding(
              padding: EdgeInsets.only(top: 0),
              child: Align(
                alignment: Alignment.center,
                child: Text("Reset Password",textAlign: TextAlign.center,style: TextStyle(fontSize: 30,fontFamily: "Arial"),
                ),
              ),
            ),
             const SizedBox(height: 10,),
             const Center(
               child: Text("Fear not. We'll email you instructions to reset your password.Make sure you enter a valid E-mail",
               style: TextStyle(fontFamily: "Arial"),
                 textAlign: TextAlign.center,
               ),
             ),
             Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 0),
              child: TextField(

                controller: resetEmailController,
                obscureText: true,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Email',
                ),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xff1D3557)),
              onPressed: () async {

                try{
                  await FirebaseAuth.instance.sendPasswordResetEmail(email: resetEmailController.text).then((value) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const LoginScreen())
                  );
                });

                }on FirebaseAuthException catch (e){
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content:Text(e.message.toString()),
                        backgroundColor: Colors.red,)
                  );
                }



              },
              child: const Text('Reset Password',
              style: TextStyle(fontFamily: "Arial"),),
            ),
          ],
        ),
      ),
    );
  }
}
