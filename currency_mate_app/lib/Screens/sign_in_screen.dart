import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'home_screen.dart';

class SignupScreen extends StatefulWidget {
  SignupScreen({Key? key}) : super(key: key);


  @override
  _SignupScreenState createState() => _SignupScreenState();
}


class _SignupScreenState extends State<SignupScreen>{

  final signupEmailController=TextEditingController();
  final signupPasswordController=TextEditingController();
  bool loading=false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF1FAEE),

      appBar: AppBar(
        title: const Text("Sign-In Page"),
        centerTitle: true,
        backgroundColor: const Color(0xff1D3557),
      ),

      body: SingleChildScrollView(
        child: Column(
          children:[
            Padding(
              padding: const EdgeInsets.only(top: 80.0),
              child: Center(
                child: SizedBox(
                    width: 200,
                    height: 150,
                    child: Image.asset('assets/SplashLogo.png')),
              ),
            ),
            const SizedBox(
                height: 70
            ),
            Padding(
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: TextField(

                controller: signupEmailController,

                decoration:  InputDecoration(

                  border: OutlineInputBorder(
                     borderRadius: BorderRadius.circular(10.0)

                  ),
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
                decoration:  InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0)
                  ),
                  labelText: 'Password',
                ),
              ),
            ),

            const SizedBox(
                height: 20
            ),
            StatefulBuilder(builder: (context,setState){
              return loading
                  ? const LinearProgressIndicator()
                  :Container(
                height: 50,
                width: 250,
                decoration: BoxDecoration(
                    color: const Color(0xff1D3557),borderRadius: BorderRadius.circular(20)),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: const Color(0xff1D3557),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)
                      )),
                  onPressed: () async{
                    setState((){
                      loading=true;
                    });
                    try{
                      await FirebaseAuth.instance.createUserWithEmailAndPassword(email: signupEmailController.text, password: signupPasswordController.text).then((value) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const HomeScreen())
                        );
                      });

                    }on FirebaseAuthException catch (e){
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content:Text(e.message.toString()),
                            backgroundColor: Colors.red,)
                      );
                    }

                    setState((){
                      loading=false;
                    });

                  },
                  child: const Text(
                    'Sign-In',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),),
              );
            }),
            const SizedBox(
              height: 130,
            ),
            
          ],


        ),


      ),
    );


  }


  
}
