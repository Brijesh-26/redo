import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class Contact extends StatelessWidget {
  Contact({super.key});

  final List item = ['Contact Us', 'Our Other Apps'];

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(

        title: Text('Tudu'),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
        body: SafeArea(
      child: ListView.builder(
        
        itemCount: 2,
        itemBuilder: ((context, index) {
          return Padding(
            padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
            child: GestureDetector(
              onTap: () {
                if (index == 0) {
                  // connect gmail to brijeshkumarv598@gmail.com
                  launch('mailto:brijeshkumarv598@gmail.com?subject= Regarding TuDu app query&body=<-------Please write your comment here with your name------->>>');
                } else if (index == 1) {
                  Fluttertoast.showToast(
                      msg: "we will soon update the link",
                      toastLength: Toast.LENGTH_LONG,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 3,
                      backgroundColor: Colors.black26,
                      textColor: Colors.white,
                      fontSize: 16.0);
                }
                
              },
              child: Card(
                elevation: 3,
                child: ListTile(
                  
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  title: Text(
                    item[index],
                    style: GoogleFonts.workSans(color: Colors.black),
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    ));
  }
}
