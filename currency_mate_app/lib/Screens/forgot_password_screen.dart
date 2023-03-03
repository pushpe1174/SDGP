import 'package:flutter/material.dart';

import 'login_screen.dart';


class ForgotPassword extends StatelessWidget {
  const ForgotPassword({Key? key}) : super(key: key);
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
            const Padding(
              padding: EdgeInsets.only(top: 0),
              child: Align(
                alignment: Alignment.center,
                child: Text("Reset Password",textAlign: TextAlign.center,style: TextStyle(fontSize: 30),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 0),
              child: TextField(
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Email',
                ),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xff1D3557)),
              onPressed: () {

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );

              },
              child: const Text('Reset Password'),
            ),
          ],
        ),
      ),
    );
  }
}
