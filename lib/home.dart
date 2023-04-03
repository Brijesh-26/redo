import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo/add_task.dart';
import 'package:todo/contact.dart';
import 'package:todo/description.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String? uid = '';
  // dynamic _usersStream;

  @override
  void initState() {
    getUID();
    // getData(uid);
    super.initState();
  }

  getUID() async {
    setState(() {
      uid = FirebaseAuth.instance.currentUser?.uid;
    });
  }

  // getData(String? uid) async {
  //   setState(() {
  //     _usersStream = FirebaseFirestore.instance
  //         .collection('tasks')
  //         .doc(uid)
  //         .collection('mytasks')
  //         .snapshots();
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('--Tu Du--'),
      //   centerTitle: true,
      //   backgroundColor: Colors.black,
      // ),
      body: SafeArea(
        child: Column(
          children: 
          [
      
      
            Padding(
              padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: (){
                        Navigator.push(
    context,
    CupertinoPageRoute(builder: (context) => Contact()),
  );
                      },
                      child: Icon(Icons.golf_course)),
                    Text('Tudu', style: GoogleFonts.workSans(color: Colors.black, fontSize: 28.0, fontWeight: FontWeight.bold),)
                  ],
                )
              ),
            ),

            SizedBox(
              height: 10.0,
            ),
            StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('tasks')
                .doc(FirebaseAuth.instance.currentUser?.uid)
                .collection('mytasks')
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                print('has error');
                return const Text('Something went wrong');
              }
        
              if (snapshot.connectionState == ConnectionState.waiting) {
                print('connection started');
                return const Center(child: CircularProgressIndicator());
              }
        
              if (snapshot.data!.size == 0) {
                return Center(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Image.network(
                            'https://tse3.mm.bing.net/th?id=OIP.IExYTb1KrK9Sw3mPlsYSCgHaE8&pid=Api&P=0'),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text('Each day I will accomplish one thing on my to do list.', style: GoogleFonts.dancingScript(color: Colors.black, fontSize: 20.0),)
                      ],
                    ),
                  ),
                );
              }
        
              if (snapshot.connectionState == ConnectionState.active) {
                print('connection activated 1');
                // final documents = snapshot.data?.docs;
                return Expanded(
                  child: ListView.builder(
                    // itemCount: documents?.length,
                    physics: BouncingScrollPhysics(),
                    itemCount: snapshot.data?.docs.length,
                    itemBuilder: ((context, index) {
                      print('connection activated 2');
                      return Padding(
                        padding: EdgeInsets.all(5.0),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              CupertinoPageRoute(
                                  builder: (context) => Description(
                                      description: snapshot.data?.docs[index]
                                          ['description'])),
                            );
                          },
                          child: ListTile(
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0))),
                            selectedTileColor: Colors.black12,
                            selected: true,
                            leading: Icon(
                              Icons.task_rounded,
                              color: Colors.greenAccent.withOpacity(.7),
                            ),
                            title: Text(
                              snapshot.data?.docs[index]['title'],
                              // ignore: prefer_const_constructors
                              style: GoogleFonts.dancingScript(
                                  fontSize: 25.0,
                                  // fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                            subtitle: Text(
                              snapshot.data?.docs[index]['description'],
                              style:
                                  GoogleFonts.dancingScript(color: Colors.black),
                            ),
                            trailing: IconButton(
                              icon: Icon(
                                Icons.delete,
                                color: Colors.redAccent.withOpacity(.7),
                              ),
                              onPressed: () {
                                FirebaseFirestore.instance
                                    .collection('tasks')
                                    .doc(FirebaseAuth.instance.currentUser?.uid)
                                    .collection('mytasks')
                                    .doc(snapshot.data?.docs[index]['time'])
                                    .delete();
                              },
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                );
              }
              if (snapshot.connectionState == ConnectionState.done) {
                return Text('connection done');
              }
              print('chl htt');
              return Text('chl na lvde hlwa h kya');
            },
          ),
          ]
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.push(
                context,
                CupertinoPageRoute(
                    fullscreenDialog: true,
                    builder: (context) {
                      return Add_Task();
                    }));
          },
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          label: Text(
            'add new task',
            style: GoogleFonts.workSans(color: Colors.black),
          ),
          icon: Icon(Icons.add)
          // child: const Icon(Icons.add),
          ),
    );
  }
}
