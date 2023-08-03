import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaselearningapp/ui/auth/login_screen.dart';
import 'package:firebaselearningapp/ui/upload_image_screen.dart';
import 'package:flutter/material.dart';

class SplashServices {
  void islogin(BuildContext context) {
    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;

    if (user != null) {
      // Timer(                                     use these when you need to use these screens
      //     const Duration(seconds: 3),
      //     () => Navigator.push(context,
      //         MaterialPageRoute(builder: (context) => const PostScreen())));
      //         if (user != null) {
      // Timer(
      //     const Duration(seconds: 3),
      //     () => Navigator.push(context,
      //         MaterialPageRoute(builder: (context) => const FirestoreListScreen())));
      //         if (user != null) {
      Timer(
          const Duration(seconds: 3),
          () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const UploadImageScreen())));
    } else {
      Timer(
          const Duration(seconds: 3),
          () => Navigator.push(context,
              MaterialPageRoute(builder: (context) => const LoginScreen())));
    }
  }
}
