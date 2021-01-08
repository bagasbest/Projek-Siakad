import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_siakad/JadwalMengajarDanBimbingan.dart';
import 'package:project_siakad/TaskList.dart';

class JadwalBimbingan extends StatefulWidget {
  @override
  _JadwalBimbinganState createState() => _JadwalBimbinganState();
}

class _JadwalBimbinganState extends State<JadwalBimbingan> {
  User user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          backgroundColor: Colors.blueGrey,
          onPressed: () {
            Route route = MaterialPageRoute(
                builder: (context) =>
                    JadwalMengajarDanBimbingan(options: "jadwalbimbingan"));
            Navigator.push(context, route);
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomAppBar(
          shape: CircularNotchedRectangle(),
          elevation: 20.0,
          color: Colors.blueGrey,
          child: ButtonBar(
            children: [],
          ),
        ),
        appBar: AppBar(
          backgroundColor: Colors.blueGrey,
          title: Text("Jadwal Bimbingan"),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Stack(
          children: [
            StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("jadwalbimbingan")
                  .where("uid", isEqualTo: user.uid)
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Container(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return TaskList(
                    document: snapshot.data.docs,
                    options: "jadwalbimbingan",
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
