import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: camel_case_types
class Add_Task extends StatefulWidget {
  const Add_Task({super.key});

  @override
  State<Add_Task> createState() => _Add_TaskState();
}

// ignore: camel_case_types
class _Add_TaskState extends State<Add_Task> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();
  dynamic title = '';
  dynamic desc = '';

  submitTaskToDB() async {
    FirebaseAuth auth = FirebaseAuth.instance;

    String? uid =
        auth.currentUser?.uid; // bc iss pr 2 ghnte barbaad kiya chutiya error
    // String uid = user.uid;

    var time = DateTime.now();
    await FirebaseFirestore.instance
        .collection('tasks')
        .doc(uid)
        .collection('mytasks')
        .doc(time.toString())
        .set({
      'title': titleController.text,
      'description': descController.text,
      'time': time.toString()
    });

    const snackBar = SnackBar(
      content: Text('Yay! new task added'),
      backgroundColor: Colors.green,
      behavior: SnackBarBehavior.floating,
    );
    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context).showSnackBar(snackBar);

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Takkss..'),
          centerTitle: true,
          backgroundColor: Color.fromARGB(211, 57, 56, 56),
        ),
        body: Padding(
          padding: EdgeInsets.all(10.0),
          child: Column(
            children: [
              Container(
                child: TextField(
                    controller: titleController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        labelText: 'Enter Title For Task',
                        labelStyle: GoogleFonts.josefinSans())),
              ),
              SizedBox(
                height: 10.0,
              ),
              Container(
                child: TextField(
                    maxLines: 3,
                    controller: descController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        labelText: 'Enter Description For Task',
                        labelStyle: GoogleFonts.josefinSans())),
              ),
              SizedBox(
                height: 20.0,
              ),
              Container(
                width: MediaQuery.of(context).size.width * .89,
                height: MediaQuery.of(context).size.height * .065,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Color.fromARGB(255, 177, 175, 175),
                      onPrimary: Colors.black87,
                      elevation: 6.0,
                      shadowColor: Colors.black,
                    ),
                    onPressed: () {
                      print('start');
                      submitTaskToDB();
                      print('end');
                    },
                    child: Text(
                      'save',
                      style: GoogleFonts.workSans(
                          color: Colors.black,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold),
                    )),
              ),
            ],
          ),
        ));
  }
}
