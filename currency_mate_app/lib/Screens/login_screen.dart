import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../Service/auth_service.dart';
import '../Utils/style.dart';
import 'forgot_password_screen.dart';
import 'home_screen.dart';
import 'sign_in_screen.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  LoginScreenState createState() => LoginScreenState();
}
class LoginScreenState extends State<LoginScreen>{

  final loginEmailController=TextEditingController();
  final loginPasswordController=TextEditingController();
  bool loading =false;
  bool isLoggedIn=false;
  AuthClass authClass=AuthClass();



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Style.bgColor,

      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("LOGIN",
        style: TextStyle(fontFamily: "Arial"),),
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
            const Gap(10),
            Text("currencyMate".toUpperCase(),
              style: Style.loadingStyle,),

            Padding(padding: const EdgeInsets.symmetric(horizontal: 15),
              child:ElevatedButton(
                  onPressed: ()async{
                    try{
                      await authClass.googleSignIn(context).then((value) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) =>  const HomeScreen())
                        );
                      });
                    }on FirebaseAuthException catch (e){
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content:Text(e.message.toString()),
                            backgroundColor: Colors.red,)
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Style.bgColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        side: const BorderSide(color: Color(0xff1D3557))
                      )
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset("assets/google_logo.png",
                        height: 40,),
                      const SizedBox(width: 10),
                      const Text("Sign In with Google",
                        style: TextStyle(fontSize: 18,color: Colors.black,fontFamily: "Arial"))

                    ],
                  )),
            ),
            const SizedBox(
                width: 200,
                height: 20,
                ),

             Row(
               mainAxisAlignment: MainAxisAlignment.center,
               children: const [
                 Text("----------------------------- or ----------------------------",
                 style: TextStyle(color:Color(0xff1D3557),fontSize: 20),)
               ],
             ),
            const SizedBox(
              width: 200,
              height: 20,
            ),
             Padding(
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: TextField(

                controller: loginEmailController,

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

                controller: loginPasswordController,

                obscureText: true,
                decoration:  InputDecoration(
                  border: OutlineInputBorder(

                    borderRadius: BorderRadius.circular(10.0)
                  ),
                  labelText: 'Password',
                ),
              ),
            ),

            TextButton(
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ForgotPassword()),
                );
              },
              child: const Text(
                'Forgot Password',
                style: TextStyle(color:Color(0xff1D3557), fontSize: 15),
              ),
            ),

            StatefulBuilder(builder: (context,setState){
              return loading
                  ?const LinearProgressIndicator()
                  :Container(
                height: 50,
                width: 250,
                decoration: BoxDecoration(
                    color: const Color(0xff1D3557),borderRadius: BorderRadius.circular(20)),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(

                      backgroundColor: const Color(0xff1D3557),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)
                      )),
                  onPressed: ()async {
                    setState((){
                      loading=true;
                    });
                    try{
                      await FirebaseAuth.instance.signInWithEmailAndPassword(email: loginEmailController.text, password: loginPasswordController.text).then((value) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) =>  const HomeScreen())
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
                    'Login',
                    style: TextStyle(color: Colors.white, fontSize: 20,fontFamily: "Arial"),
                  ),),

              );
            }),


            const SizedBox(
              height: 10,
            ),

            Column(
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(onPressed: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>   const SignupScreen()),
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
