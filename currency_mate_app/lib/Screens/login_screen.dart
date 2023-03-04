import 'package:flutter/material.dart';

import '../Utils/style.dart';
import 'home_screen.dart';
import 'sign_in_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Style.bgColor,

      appBar: AppBar(
        title: const Text("Login Page"),
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

            const Padding(
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Email',
                ),
              ),
            ),

            const Padding(
              padding: EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 0),
              //padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(

                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                ),
              ),
            ),

            TextButton(
              onPressed: (){},
              child: const Text(
                'Forgot Password',
                style: TextStyle(color:Color(0xff1D3557), fontSize: 15),
              ),
            ),

            Container(
              height: 50,
              width: 250,
              decoration: BoxDecoration(
                  color: const Color(0xff1D3557),borderRadius: BorderRadius.circular(20)),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xff1D3557)),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const HomeScreen())
                  );
                },
                child: const Text(
                  'Login',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),),
            ),

            const SizedBox(
              height: 130,
            ),

            Column(
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(onPressed: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>   SignupScreen()),
                        );
                      },
                        child: const Text("create account",
                            style: TextStyle(color: Color(0xff1D3557))),
                      )
                    ]
                )
              ],
            )

          ],
        ),
      ),
    );
  }
}
