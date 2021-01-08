import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_siakad/database/database_services.dart';

class IdentityCard extends StatefulWidget {
  @override
  _IdentityCardState createState() => _IdentityCardState();
}

class _IdentityCardState extends State<IdentityCard> {
  String imagePath;
  User user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Kartu Identitas"),
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              }),
          actions: [
            Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () async {
                  File file = await getImage();
                  imagePath = await DatabaseServices.uploadImage(file);
                  setState(() {});
                },
                child: Icon(
                  Icons.add_a_photo,
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
        body: Column(
          children: [
            (imagePath != null)
                ? Container(
                    margin: EdgeInsets.all(20),
                    height: MediaQuery.of(context).size.height * 0.8,
                    width: MediaQuery.of(context).size.width * 0.9,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        image: DecorationImage(
                          image: NetworkImage(imagePath),
                          fit: BoxFit.cover,
                        )),
                  )
                : StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('users')
                        .doc(user.uid)
                        .snapshots(),
                    builder: (context, snapshot) {
                      var userDocument = snapshot.data;
                      String url = userDocument["image"];

                      if (url == "") {
                        return Container(
                          margin: EdgeInsets.all(20),
                          height: MediaQuery.of(context).size.height * 0.8,
                          width: MediaQuery.of(context).size.width * 0.9,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black),
                              image: DecorationImage(
                                image: AssetImage(
                                  "img/id-card-icon.png",
                                ),
                                fit: BoxFit.cover,
                              )),
                        );
                      } else {
                        return Container(
                          margin: EdgeInsets.all(20),
                          height: MediaQuery.of(context).size.height * 0.8,
                          width: MediaQuery.of(context).size.width * 0.9,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black),
                              image: DecorationImage(
                                image: NetworkImage(url),
                                fit: BoxFit.cover,
                              )),
                        );
                      }
                    }),
          ],
        ),
      ),
    );
  }
}

Future<File> getImage() async {
  return await ImagePicker.pickImage(source: ImageSource.camera);
}
