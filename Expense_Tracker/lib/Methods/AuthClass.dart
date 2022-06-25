// ignore_for_file: non_constant_identifier_names, await_only_futures

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker/Components/Signup.dart';
import 'package:expense_tracker/HomePage.dart';
import 'package:expense_tracker/Methods/DatabseMethods.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthMethods {
  final FirebaseAuth auth = FirebaseAuth.instance;

  getcurrentuser() async {
    return (await auth.currentUser);
  }

  SignWithGoogle(BuildContext context) async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();
    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;
      final AuthCredential authCredential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken);

      // Getting users credential
      UserCredential result = await auth.signInWithCredential(authCredential);
      User? user = result.user;

      if (result == null) {
      } else {
        String? uemail = user!.email;
        String? dname = user.displayName;
        String? photourl = user.photoURL;
        final snapshot = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();
        if (snapshot.exists) {
        } else {
          DatabaseMethods().addUserdata(
            userID: user.uid,
            email: uemail!,
            username: user.email!.replaceAll("@gmail.com", ""),
            name: dname!,
            profileUrl: photourl!,
          );
        }

        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const HomePage()));
      }
    }
  }

  signoutgoogle(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const SignUp()));
  }
}
