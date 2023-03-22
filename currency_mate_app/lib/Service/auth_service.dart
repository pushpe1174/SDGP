import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthClass{
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

  _displaySnackBar(BuildContext context , String text){
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content:Text(text),
          backgroundColor: Colors.red,)
    );
  }

  FirebaseAuth auth=FirebaseAuth.instance;
  final storage = const FlutterSecureStorage();

  Future<void> googleSignIn(BuildContext context)async{
    try{
      GoogleSignInAccount? googleSignInAccount=await _googleSignIn.signIn();
      if(googleSignInAccount!=null){
        GoogleSignInAuthentication googleSignInAuthentication=await googleSignInAccount.authentication;

        AuthCredential credential=GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken,
        );
        try{
          UserCredential userCredential=await auth.signInWithCredential(credential);
          storeTokenAndData(userCredential);
        }
        on FirebaseAuthException catch (e){
          _displaySnackBar(context,e.message.toString());
        }
      }
      else{
        _displaySnackBar(context,"Cannot Sign In");
      }
    }
    catch(e){
      print(e.toString());
    }
  }
  Future<void> storeTokenAndData(UserCredential  userCredential)async{
    await storage.write(key: "token", value: userCredential.credential?.token.toString());
    await storage.write(key: "userCredential", value: userCredential.toString());
  }
  Future<String?> getToken()async{

    return await storage.read(key: "token");
  }
  Future<void>logout()async{
    try{
      await _googleSignIn.signOut();
      await auth.signOut();
      await storage.delete(key: "token");
    }
    catch(e){
      print(e.toString());
    }
  }
}