import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:project_siakad/HomePage.dart';
import 'package:project_siakad/net/flutterfire.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String name = '';
  String email = '';
  String password = '';
  String confirmPassword = '';

  bool visible = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.blueGrey,
        appBar: AppBar(
          title: Text("Halaman Register"),
          backgroundColor: Colors.blueGrey,
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              }),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Stack(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 40, right: 40),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Masukkan data diri anda dengan benar",
                        style: TextStyle(color: Colors.white),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 1.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.blueGrey[200], width: 2.0),
                          ),
                          hintText: 'Nama Lengkap',
                          prefixIcon: Icon(
                            Icons.person,
                            color: Colors.grey,
                          ),
                        ),
                        onChanged: (val) {
                          setState(() {
                            name = val;
                          });
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.grey, width: 1.0)),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.blueGrey[200], width: 2.0),
                            ),
                            hintText: 'Email',
                            prefixIcon: Icon(
                              Icons.email,
                              color: Colors.grey,
                            )),
                        onChanged: (val) {
                          setState(() {
                            email = val;
                          });
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                          obscureText: true,
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.grey, width: 1.0)),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.blueGrey[200], width: 2.0),
                            ),
                            hintText: "Password",
                            prefixIcon: Icon(
                              Icons.lock,
                              color: Colors.grey,
                            ),
                          ),
                          onChanged: (val) {
                            setState(() {
                              password = val;
                            });
                          }),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                          obscureText: true,
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.grey, width: 1.0)),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.blueGrey[200], width: 2.0),
                            ),
                            hintText: "Konfirmasi Password",
                            prefixIcon: Icon(
                              Icons.lock,
                              color: Colors.grey,
                            ),
                          ),
                          onChanged: (val) {
                            setState(() {
                              confirmPassword = val;
                            });
                          }),
                      SizedBox(
                        height: 20,
                      ),
                      Column(
                        children: [
                          Visibility(
                            visible: visible,
                            child: SpinKitRipple(
                              color: Colors.white,
                            ),
                          ),
                          Container(
                            width: 260,
                            height: 45,
                            child: RaisedButton(
                              onPressed: () async {
                                if (name.isEmpty) {
                                  toast(email, password,
                                      "Nama Lengkap tidak boleh kosong");
                                } else if (email.isEmpty) {
                                  toast(email, password,
                                      "Email tidak boleh kosong");
                                } else if (password.isEmpty ||
                                    confirmPassword.isEmpty) {
                                  toast(email, password,
                                      "Password tidak boleh kosong");
                                } else if (password.length < 6 ||
                                    confirmPassword.length < 6) {
                                  toast(email, password,
                                      "Password minimum 6 karakter");
                                } else if (!email.contains('@') ||
                                    !email.contains('.')) {
                                  toast(email, password, "Email tidak valid");
                                } else if (password != confirmPassword) {
                                  toast(email, password, "Password tidak sama");
                                } else {
                                  setState(() {
                                    visible = true;
                                  });

                                  bool shouldNavigate =
                                      await register(name, email, password);

                                  if (shouldNavigate) {
                                    //Navigate
                                    setState(() {
                                      visible = false;
                                    });
                                    Route route = MaterialPageRoute(
                                        builder: (context) => HomePage());
                                    Navigator.pushReplacement(context, route);
                                  }
                                }
                              },
                              child: Text(
                                "Mendaftar",
                                style: TextStyle(color: Colors.white),
                              ),
                              shape: StadiumBorder(),
                              color: Colors.blueGrey[200],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void toast(String email, String password, String pesan) {
  Fluttertoast.showToast(
      msg: pesan,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.orange,
      textColor: Colors.white,
      fontSize: 16.0);
}
