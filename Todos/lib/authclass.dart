// ignore_for_file: await_only_futures, non_constant_identifier_names, prefer_const_constructors, unnecessary_null_comparison

import 'package:cloud_firestore/cloud_firestore.dart';
import 'database.dart';
import 'databasehelper.dart';
import 'home.dart';
import 'signin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthMethons {
  final FirebaseAuth auth = FirebaseAuth.instance;

  getcurrentuser() async {
    return (await auth.currentUser);
  }

  signoutgoogle(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const SignIn()));
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
        Sharepref().saveUserEmail(uemail!);
        Sharepref().saveUserId(user.uid);
        Sharepref().saveUserName(user.email!.replaceAll("@gmail.com", ""));
        Sharepref().saveDisplayName(dname!);
        Sharepref().saveUserProfileUrl(photourl!);
        final snapshot = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();
        if (snapshot.exists) {
        } else {
          DatabaseMethod().addUserdata(
            userID: user.uid,
            email: uemail,
            username: user.email!.replaceAll("@gmail.com", ""),
            name: dname,
            profileUrl: photourl,
          );
        }

        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const Home()));
      }
    }
  }
}
