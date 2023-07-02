// ignore_for_file: prefer_const_constructors, camel_case_types

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flower_app/shared/profile_image.dart';
import 'package:flutter/material.dart';

class useremail extends StatefulWidget {
  const useremail({Key? key}) : super(key: key);

  @override
  State<useremail> createState() => _useremailState();
}

class _useremailState extends State<useremail> {
  final credential = FirebaseAuth.instance.currentUser;
  CollectionReference users = FirebaseFirestore.instance.collection('userSSSS');

  @override
  Widget build(BuildContext context) {
    CollectionReference users =
        FirebaseFirestore.instance.collection('userSSSS');

    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(credential!.uid).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/img/test.jpg"),
                    fit: BoxFit.cover),
              ),
              accountName: Text("${data["username"]}",
                  style: TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255),
                  )),
              accountEmail: Text("${data["email"]}"),
              currentAccountPicture: userimg());
        }
        return Text("loading");
      },
    );
  }
}
