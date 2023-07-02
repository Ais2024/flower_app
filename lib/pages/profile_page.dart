// ignore_for_file: unused_import, prefer_const_constructors, avoid_print, depend_on_referenced_packages, prefer_const_literals_to_create_immutables

import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flower_app/shared/colors.dart';
import 'package:flower_app/shared/info_firestore.dart';
import 'package:flower_app/shared/profile_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' show basename;

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final credential = FirebaseAuth.instance.currentUser;
  File? imgPath;
  String? imgName;
  CollectionReference users = FirebaseFirestore.instance.collection('userSSSS');

  uploadImage2Screen() async {
    final pickedImg = await ImagePicker().pickImage(source:ImageSource.gallery);
    try {
      if (pickedImg != null) {
        setState(() {
          imgPath = File(pickedImg.path);
          imgName = basename(pickedImg.path);
          int random = Random().nextInt(9999999);
          imgName = "$random$imgName";
          print(imgName);
        });
      } else {
        print("NO img selected");
      }
    } catch (e) {
      print("Error => $e");
    }

    if (!mounted) return;
    Navigator.pop(context);
  }

  // showmodel() {
  //   return showModalBottomSheet(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return Container(
  //         padding: EdgeInsets.all(22),
  //         height: 170,
  //         child: Column(
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           children: [
  //             GestureDetector(
  //               onTap: () async {
  //                 await uploadImage2Screen(ImageSource.camera);
  //               },
  //               child: Row(
  //                 children: [
  //                   Icon(
  //                     Icons.camera,
  //                     size: 30,
  //                   ),
  //                   SizedBox(
  //                     width: 11,
  //                   ),
  //                   Text(
  //                     "From Camera",
  //                     style: TextStyle(fontSize: 20),
  //                   )
  //                 ],
  //               ),
  //             ),
  //             SizedBox(
  //               height: 22,
  //             ),
  //             GestureDetector(
  //               onTap: () {
  //                 uploadImage2Screen(ImageSource.gallery);
  //               },
  //               child: Row(
  //                 children: [
  //                   Icon(
  //                     Icons.photo_outlined,
  //                     size: 30,
  //                   ),
  //                   SizedBox(
  //                     width: 11,
  //                   ),
  //                   Text(
  //                     "From Gallery",
  //                     style: TextStyle(fontSize: 20),
  //                   )
  //                 ],
  //               ),
  //             ),
  //           ],
  //         ),
  //       );
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton.icon(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              if (!mounted) return;
              Navigator.pop(context);
            },
            label: const Text(
              "logout",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            icon: const Icon(
              Icons.logout,
              color: Colors.white,
            ),
          )
        ],
        backgroundColor: appbargreen,
        title: const Text("Profile Page"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(22.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  padding: EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey,
                  ),
                  child: Stack(
                    children: [
                      imgPath == null
                          ? userimg()
                          : ClipOval(
                              child: Image.file(imgPath!,
                                  width: 145, height: 145, fit: BoxFit.cover),
                            ),
                      Positioned(
                        bottom: -5,
                        right: -10,
                        child: IconButton(
                            onPressed: () async{
                               await uploadImage2Screen();
                               if( imgPath!=null){
                                 final storageRef = FirebaseStorage.instance.ref(imgName);
                                 await storageRef.putFile(imgPath!);
                                 String url = await storageRef.getDownloadURL();
                                 users.doc(credential!.uid).update({"imgLink": url,});
                               }

                              //showmodel();
                            },
                            icon: Icon(Icons.add_a_photo)),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              Center(
                  child: Container(
                padding: const EdgeInsets.all(11),
                decoration: BoxDecoration(
                    color: Colors.blue[300],
                    borderRadius: BorderRadius.circular(11)),
                child: const Text(
                  "Info from firebase Auth",
                  style: TextStyle(
                    fontSize: 22,
                    color: Colors.black,
                  ),
                ),
              )),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 28,
                  ),
                  Text(
                    "Email: ${credential!.email}",
                    style: TextStyle(
                      fontSize: 22,
                    ),
                  ),
                  SizedBox(
                    height: 11,
                  ),
                  Text(
                    "Created date:  ${credential!.metadata.creationTime}    ",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(
                    height: 11,
                  ),
                  Text(
                    "Last Signed In: ${credential!.metadata.lastSignInTime} ",
                    style: TextStyle(
                      fontSize: 19,
                    ),
                  ),
                  SizedBox(
                    height: 11,
                  ),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          CollectionReference users =
                              FirebaseFirestore.instance.collection('userSSSS');
                          credential!.delete();
                          users.doc(credential!.uid).delete();
                          Navigator.pop(context);
                        });
                      },
                      child: Text(
                        "Dlete user",
                        style: TextStyle(fontSize: 19),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Center(
                  child: Container(
                      padding: const EdgeInsets.all(11),
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 131, 177, 255),
                          borderRadius: BorderRadius.circular(11)),
                      child: const Text(
                        "Info from firebase firestore",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ))),
              GetDataFromFirestore(
                documentId: credential!.uid,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
