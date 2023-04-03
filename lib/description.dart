import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Description extends StatelessWidget {
  String description;

  Description({required this.description});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About......'),
        backgroundColor: Colors.black,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Expanded(
           
            child: Center(
              child: Card(
                elevation: 3,
                child: Text(description, style: GoogleFonts.workSans(color: Colors.black),),
              ),
            ),
          )
        ),
      ),
    );
  }
}
