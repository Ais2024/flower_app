// ignore_for_file: camel_case_types, prefer_const_constructors_in_immutables, prefer_const_constructors, use_build_context_synchronously, duplicate_ignore

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flower_app/pages/login.dart';
import 'package:flower_app/shared/colors.dart';
import 'package:flower_app/shared/constants.dart';
import 'package:flower_app/shared/snackpar.dart';
import 'package:flutter/material.dart';

class resetpassword extends StatefulWidget {
  resetpassword({Key? key}) : super(key: key);

  @override
  State<resetpassword> createState() => _resetpasswordState();
}

class _resetpasswordState extends State<resetpassword> {
  final emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isloading = false;
  resetpassword() async {
    setState(() {
      isloading = true;
    });
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailController.text);
      if (!mounted) return;
      showSnackBar(context, "Check your Email");
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, 'error : ${e.code}');
    }
    setState(() {
      isloading = false;
    });
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appbargreen,
        title: Text(
          "Reset password",
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Form(
            key: _formKey,
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(
                "Enter your Email to Reset your Password",
                style: TextStyle(fontSize: 15, color: Colors.black),
              ),
              SizedBox(
                height: 15,
              ),
              TextField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  obscureText: false,
                  decoration: decorationTextfield.copyWith(
                      hintText: "Enter Your email :",
                      suffixIcon: Icon(Icons.email))),
              const SizedBox(
                height: 30,
              ),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    await resetpassword();
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => Login()),
                    );
                  } else {
                    showSnackBar(context, "ERROR IN VALIDATION");
                  }
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(BTNgreen),
                  padding: MaterialStateProperty.all(EdgeInsets.all(12)),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8))),
                ),
                // ignore: prefer_const_constructors
                child: isloading
                    ? CircularProgressIndicator(
                        color: Colors.cyan,
                      )
                    : Text(
                        "Reset the password",
                        style: TextStyle(fontSize: 19),
                      ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
