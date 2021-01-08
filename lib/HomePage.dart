import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_siakad/BAP.dart';
import 'package:project_siakad/Ekomplain.dart';
import 'package:project_siakad/IdentityCard.dart';
import 'package:project_siakad/JadwalBimbingan.dart';
import 'package:project_siakad/JadwalMengajar.dart';
import 'package:project_siakad/KaryaIlmiah.dart';
import 'package:project_siakad/LoginPage.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FirebaseAuth auth = FirebaseAuth.instance;
  User user = FirebaseAuth.instance.currentUser;

  _signOut() async {
    await auth.signOut().then((_) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => LoginPage()),
          (Route<dynamic> route) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueGrey,
          title: Text("Menu Utama"),
          actions: [
            Padding(
                padding: EdgeInsets.only(right: 20.0),
                child: IconButton(
                    icon: Icon(Icons.logout),
                    onPressed: () {
                      _signOut();
                    }))
          ],
        ),
        body: Column(
          children: [
            Flexible(
                flex: 1,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20.0),
                        bottomRight: Radius.circular(20.0),
                      ),
                      color: Colors.blueGrey),
                  //color: Colors.blueGrey,
                  child: Row(
                    children: [
                      Flexible(
                          flex: 3,
                          child: Container(
                            child: Center(
                              child: StreamBuilder(
                                  stream: FirebaseFirestore.instance
                                      .collection('users')
                                      .doc(user.uid)
                                      .snapshots(),
                                  builder: (context, snapshot) {
                                    if (!snapshot.hasData) {
                                      return new Text(
                                        "Welcome ..." + "\nLoading",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      );
                                    }
                                    var userDocument = snapshot.data;
                                    return new Text(
                                      "Welcome ..." +
                                          "\n" +
                                          userDocument["name"],
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    );
                                  }),
                            ),
                          )),
                      Flexible(
                          flex: 1,
                          child: Container(
                            child: Center(
                              child: Image(
                                height: 60,
                                width: 60,
                                image: AssetImage("img/profil.png"),
                                fit: BoxFit.contain,
                              ),
                            ),
                          )),
                    ],
                  ),
                )),
            Flexible(
                flex: 1,
                child: Row(
                  children: [
                    Flexible(
                        child: Container(
                      child: Center(
                          child: GestureDetector(
                        onTap: () {
                          Route route = MaterialPageRoute(
                              builder: (context) => JadwalMengajar());
                          Navigator.push(context, route);
                        },
                        child: Column(
                          children: [
                            Image(
                              height: 80,
                              width: 80,
                              image: AssetImage(
                                "img/jadwal.png",
                              ),
                              fit: BoxFit.contain,
                            ),
                            SizedBox(
                              height: 7,
                            ),
                            Container(
                              width: 100,
                              height: 40,
                              padding: EdgeInsets.only(top: 5),
                              color: Colors.yellow,
                              child: Text(
                                "JADWAL MENGAJAR",
                                textAlign: TextAlign.center,
                              ),
                            )
                          ],
                        ),
                      )),
                    )),
                    Flexible(
                        child: Container(
                      child: Center(
                          child: GestureDetector(
                        onTap: () {
                          Route route = MaterialPageRoute(
                              builder: (context) => JadwalBimbingan());
                          Navigator.push(context, route);
                        },
                        child: Column(
                          children: [
                            Image(
                              height: 80,
                              width: 80,
                              image: AssetImage(
                                "img/bimbingan.png",
                              ),
                              fit: BoxFit.contain,
                            ),
                            SizedBox(
                              height: 7,
                            ),
                            Container(
                              width: 100,
                              height: 40,
                              padding: EdgeInsets.only(top: 5),
                              color: Colors.yellow,
                              child: Text(
                                "JADWAL BIMBINGAN",
                                textAlign: TextAlign.center,
                              ),
                            )
                          ],
                        ),
                      )),
                    ))
                  ],
                )),
            Flexible(
                flex: 1,
                child: Row(
                  children: [
                    Flexible(
                        child: Container(
                      child: Center(
                          child: GestureDetector(
                        onTap: () {
                          Route route = MaterialPageRoute(
                              builder: (context) => KaryaIlmiah());
                          Navigator.push(context, route);
                        },
                        child: Column(
                          children: [
                            Image(
                              height: 100,
                              width: 100,
                              image: AssetImage(
                                "img/karyailmiah.png",
                              ),
                              fit: BoxFit.contain,
                            ),
                            SizedBox(
                              height: 7,
                            ),
                            Container(
                              width: 100,
                              height: 30,
                              padding: EdgeInsets.only(top: 5),
                              color: Colors.yellow,
                              child: Text(
                                "KARYA ILMIAH",
                                textAlign: TextAlign.center,
                              ),
                            )
                          ],
                        ),
                      )),
                    )),
                    Flexible(
                        child: Container(
                      child: Center(
                          child: GestureDetector(
                        onTap: () {
                          Route route = MaterialPageRoute(
                              builder: (context) => Ekomplain());
                          Navigator.push(context, route);
                        },
                        child: Column(
                          children: [
                            Image(
                              height: 80,
                              width: 80,
                              image: AssetImage(
                                "img/komplain.png",
                              ),
                              fit: BoxFit.contain,
                            ),
                            SizedBox(
                              height: 7,
                            ),
                            Container(
                              width: 100,
                              height: 30,
                              padding: EdgeInsets.only(top: 5),
                              color: Colors.yellow,
                              child: Text(
                                "E - KOMPLAIN",
                                textAlign: TextAlign.center,
                              ),
                            )
                          ],
                        ),
                      )),
                    ))
                  ],
                )),
            Flexible(
                flex: 1,
                child: Row(
                  children: [
                    Flexible(
                        child: Container(
                      child: Center(
                          child: GestureDetector(
                        onTap: () {
                          Route route = MaterialPageRoute(
                              builder: (context) => IdentityCard());
                          Navigator.push(context, route);
                        },
                        child: Column(
                          children: [
                            Image(
                              height: 80,
                              width: 80,
                              image: AssetImage(
                                "img/id-card-icon.png",
                              ),
                              fit: BoxFit.contain,
                            ),
                            SizedBox(
                              height: 7,
                            ),
                            Container(
                              width: 100,
                              height: 40,
                              padding: EdgeInsets.only(top: 5),
                              color: Colors.yellow,
                              child: Text(
                                "KARTU IDENTITAS",
                                textAlign: TextAlign.center,
                              ),
                            )
                          ],
                        ),
                      )),
                    )),
                    Flexible(
                        child: Container(
                      child: Center(
                          child: GestureDetector(
                        onTap: () {
                          Route route =
                              MaterialPageRoute(builder: (context) => BAP());
                          Navigator.push(context, route);
                        },
                        child: Column(
                          children: [
                            Image(
                              height: 80,
                              width: 80,
                              image: AssetImage(
                                "img/beritaacara.png",
                              ),
                              fit: BoxFit.contain,
                            ),
                            SizedBox(
                              height: 7,
                            ),
                            Container(
                              width: 100,
                              height: 30,
                              padding: EdgeInsets.only(top: 5),
                              color: Colors.yellow,
                              child: Text(
                                "BAP",
                                textAlign: TextAlign.center,
                              ),
                            )
                          ],
                        ),
                      )),
                    ))
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
