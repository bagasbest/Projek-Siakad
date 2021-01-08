import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class JadwalMengajarDanBimbingan extends StatefulWidget {
  JadwalMengajarDanBimbingan({this.options});
  final String options;

  @override
  _JadwalMengajarDanBimbinganState createState() =>
      _JadwalMengajarDanBimbinganState();
}

class _JadwalMengajarDanBimbinganState
    extends State<JadwalMengajarDanBimbingan> {
  bool visible = false;

  String user = FirebaseAuth.instance.currentUser.uid;
  DateTime _dueDate = DateTime.now();
  String _dateText = "";

  Future<Null> _selectDueDate(BuildContext context) async {
    final picked = await showDatePicker(
        context: context,
        initialDate: _dueDate,
        firstDate: DateTime(2021),
        lastDate: DateTime(2025));

    if (picked != null) {
      setState(() {
        _dueDate = picked;
        _dateText = "${picked.day}/${picked.month}/${picked.year}";
      });
    }
  }

  String newTask = "";
  String note = "";
  String hint1;
  String hint2;

  void _addData() {
    FirebaseFirestore.instance.runTransaction((transaction) async {
      CollectionReference ref =
          FirebaseFirestore.instance.collection(widget.options);
      await ref.add({
        "uid": user,
        "title": newTask,
        "dueDate": _dueDate,
        "note": note,
      });
    });
    Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();
    _dateText = "${_dueDate.day}/${_dueDate.month}/${_dueDate.year}";

    if (widget.options == "jadwalmengajar") {
      hint1 = "Mata kuliah";
      hint2 = "Tanggal Mengajar";
    } else {
      hint1 = "Nama mahasiswa bimbingan";
      hint2 = "Tanggal bimbingan";
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.blueGrey,
          title: Text("Tambah Jadwal"),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 10),
              child: TextFormField(
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 1.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.orange, width: 2.0),
                  ),
                  hintText: hint1,
                  prefixIcon: Icon(
                    Icons.dashboard,
                    color: Colors.grey,
                  ),
                ),
                // validator: (val) =>
                //     val.isEmpty ? "Enter a valid email address" : null,
                onChanged: (val) {
                  setState(() {
                    newTask = val;
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: Icon(Icons.date_range),
                  ),
                  Expanded(
                    child: Text(
                      hint2,
                      style: TextStyle(fontSize: 18, color: Colors.black54),
                    ),
                  ),
                  FlatButton(
                    onPressed: () => _selectDueDate(context),
                    child: Text(
                      _dateText,
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black54),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
              child: TextFormField(
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 1.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.orange, width: 2.0),
                  ),
                  hintText: 'Keterangan',
                  prefixIcon: Icon(
                    Icons.note,
                    color: Colors.grey,
                  ),
                ),
                // validator: (val) =>
                //     val.isEmpty ? "Enter a valid email address" : null,
                onChanged: (val) {
                  setState(() {
                    note = val;
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 100),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                      icon: Icon(
                        Icons.check,
                        size: 40,
                      ),
                      onPressed: () {
                        if (newTask.isEmpty || note.isEmpty) {
                          toast("Kolom tidak boleh kosong");
                        } else {
                          _addData();
                        }
                      }),
                  IconButton(
                      icon: Icon(
                        Icons.close,
                        size: 40,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      }),
                ],
              ),
            ),
          ],
        ),
      ),
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
