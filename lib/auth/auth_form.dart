import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo/home.dart';

// ignore: depend_on_referenced_packages

class AuthForm extends StatefulWidget {
  const AuthForm({super.key});

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formkey = GlobalKey<FormState>();
  dynamic email = '';
  dynamic password = '';
  dynamic username = '';
  bool isLoginPage = false;

  signUp() async {
    final validity = _formkey.currentState!.validate();

    FocusScope.of(context).unfocus();

    if (validity) {
      _formkey.currentState!.save();
      submit(email, password, username);
    }
  }

  logIn() async {
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
  }

  submit(String email, String password, String username) async {
    try {
      if (isLoginPage) {
        UserCredential result = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);
      } else {
        UserCredential result = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);

        String uid = result.user!.uid;

        await FirebaseFirestore.instance
            .collection('users')
            .doc(uid)
            .set({'username': username, 'email': email, 'password': password});
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: ListView(
        children: [
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Container(
              child: Form(
                key: _formkey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        key: const ValueKey('email'),
                        validator: (value) {
                          if (value!.isEmpty || !value.contains('@')) {
                            return 'Please Enter a Valid Email Address';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          setState(() {
                            email = value;
                          });
                        },
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                            labelText: 'Enter Your Email',
                            labelStyle: GoogleFonts.josefinSans())),
                    SizedBox(height: 10.0),
                    TextFormField(
                        keyboardType: TextInputType.visiblePassword,
                        key: const ValueKey('password'),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please Enter a Valid Email Address';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          setState(() {
                            password = value;
                          });
                        },
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                            labelText: 'Enter Your Password',
                            labelStyle: GoogleFonts.josefinSans())),
                    SizedBox(
                      height: 10.0,
                    ),
                    if (!isLoginPage)
                      TextFormField(
                          key: const ValueKey('username'),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please Enter a Valid Nickname';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            setState(() {
                              username = value;
                            });
                          },
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0)),
                              labelText: 'Enter Nick Name',
                              labelStyle: GoogleFonts.josefinSans())),
                    Container(
                      child: ElevatedButton(
                          onPressed: () {
                            isLoginPage ? logIn() : signUp();

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Home()),
                            );
                          },
                          child: isLoginPage
                              ? const Text('Log In')
                              : const Text('Sign Up')),
                    ),
                    Container(
                      child: TextButton(
                        onPressed: () {
                          setState(() {
                            isLoginPage = !isLoginPage;
                          });
                        },
                        child: isLoginPage
                            ? const Text('Not A Member? ')
                            : const Text('Already a Member'),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
