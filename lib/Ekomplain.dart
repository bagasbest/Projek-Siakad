import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Ekomplain extends StatefulWidget {
  @override
  _EkomplainState createState() => _EkomplainState();
}

class _EkomplainState extends State<Ekomplain> {
  String title = "";
  String description = "";
  String user = FirebaseAuth.instance.currentUser.uid;
  DateTime _dueDate = DateTime.now();

  TextEditingController _controller1 = TextEditingController();
  TextEditingController _controller2 = TextEditingController();

  void _addData() {
    FirebaseFirestore.instance.runTransaction((transaction) async {
      CollectionReference ref =
          FirebaseFirestore.instance.collection("ekomplain");
      await ref.add({
        "uid": user,
        "title": title,
        "description": description,
        "date": _dueDate,
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            backgroundColor: Colors.blueGrey,
            title: Text("Kirim Pengaduan"),
            leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () => Navigator.pop(context)),
          ),
          body: Container(
            margin: EdgeInsets.all(20.0),
            child: Column(
              children: [
                TextFormField(
                  maxLength: 50,
                  controller: _controller1,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 1.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.blueGrey[200], width: 2.0),
                    ),
                    hintText: 'Subjek',
                    prefixIcon: Icon(
                      Icons.email,
                      color: Colors.grey,
                    ),
                  ),
                  onChanged: (val) {
                    setState(() {
                      title = val;
                    });
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  maxLength: 200,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  controller: _controller2,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 1.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.blueGrey[200], width: 2.0),
                    ),
                    hintText: 'Deskripsi',
                    prefixIcon: Icon(
                      Icons.text_format,
                      color: Colors.grey,
                    ),
                  ),
                  onChanged: (val) {
                    setState(() {
                      description = val;
                    });
                  },
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: RaisedButton(
                    color: Colors.blueGrey,
                    onPressed: () {
                      if (title.isNotEmpty && description.isNotEmpty) {
                        _addData();
                        setState(() {
                          _controller1.clear();
                          _controller2.clear();
                        });
                        toast("Komplain berhasil disampaikan");
                      } else {
                        toast("Kolom tidak boleh kosong");
                      }
                    },
                    child: Text(
                      "Kirim",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                )
              ],
            ),
          )),
    );
  }
}

void toast(String pesan) {
  Fluttertoast.showToast(
      msg: pesan,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.orange,
      textColor: Colors.white,
      fontSize: 16.0);
}
