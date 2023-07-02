// ignore_for_file: prefer_const_constructors, duplicate_ignore, unused_import
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flower_app/pages/check_screen.dart';
import 'package:flower_app/pages/home.dart';
import 'package:flower_app/pages/login.dart';
import 'package:flower_app/pages/product_details.dart';
import 'package:flower_app/pages/register.dart';
import 'package:flower_app/pages/verify_email.dart';
import 'package:flower_app/provider/cart.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flower_app/provider/google_signin.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:flower_app/shared/snackpar.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:firebase_storage/firebase_storage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) {
          return Cart();
        }),
        ChangeNotifierProvider(create: (context) {
          return GoogleSignInProvider();
        }),
      ],
      child: MaterialApp(
          title: "myApp",
          debugShowCheckedModeBanner: false,
          home: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                    child: CircularProgressIndicator(
                  color: Colors.white,
                ));
              } else if (snapshot.hasError) {
                return showSnackBar(context, "Something went wrong");
              } else if (snapshot.hasData) {
                // return VerifyEmailPage();
                return Home(); // home() OR verify email
              } else {
                return Login();
              }
            },
          )),
    );
  }
}
