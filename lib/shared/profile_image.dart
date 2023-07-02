// ignore_for_file: prefer_const_constructors, camel_case_types

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class userimg extends StatefulWidget {
  const userimg({Key? key}) : super(key: key);

  @override
  State<userimg> createState() => _userimgState();
}

class _userimgState extends State<userimg> {
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
          return CircleAvatar(
            backgroundColor: Colors.white,
            radius: 70,
            backgroundImage: NetworkImage("${data["imgLink"]}"),
          );
        }
        return Text("loading");
      },
    );
  }
}
