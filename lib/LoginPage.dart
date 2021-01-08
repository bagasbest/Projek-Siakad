import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:project_siakad/HomePage.dart';
import 'package:project_siakad/RegisterPage.dart';
import 'package:project_siakad/net/flutterfire.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String hintText = "Password";

  String email = '';
  String password = '';

  bool _isHidden = true;
  bool visible = false;

  void _toggleVisibility() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.blueGrey,
        appBar: AppBar(
            title: Text("Halaman Login"), backgroundColor: Colors.blueGrey),
        body: Stack(
          children: [
            Container(
              margin: EdgeInsets.only(left: 20, right: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: Card(
                      color: Colors.blueGrey,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7)),
                      child: Container(
                        padding: EdgeInsets.all(20),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Masukkan ",
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.white),
                                ),
                                Text(
                                  "Email ",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: Colors.white),
                                ),
                                Text("dan ",
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.white)),
                                Text(
                                  "Password ",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: Colors.white),
                                ),
                              ],
                            ),
                            Text("untuk login ke SIAKAD",
                                style: TextStyle(
                                    fontSize: 16, color: Colors.white)),
                            SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              decoration: InputDecoration(
                                  fillColor: Colors.white,
                                  filled: true,
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.grey, width: 1.0)),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.blueGrey[200],
                                        width: 2.0),
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
                                obscureText:
                                    hintText == "Password" ? _isHidden : false,
                                decoration: InputDecoration(
                                  fillColor: Colors.white,
                                  filled: true,
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.grey, width: 1.0)),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.blueGrey[200],
                                        width: 2.0),
                                  ),
                                  hintText: hintText,
                                  prefixIcon: Icon(
                                    Icons.lock,
                                    color: Colors.grey,
                                  ),
                                  suffixIcon: IconButton(
                                    icon: _isHidden
                                        ? Icon(
                                            Icons.visibility_off,
                                            color: Colors.grey,
                                          )
                                        : Icon(
                                            Icons.visibility,
                                            color: Colors.blueGrey,
                                          ),
                                    onPressed: _toggleVisibility,
                                  ),
                                ),
                                onChanged: (val) {
                                  setState(() {
                                    password = val;
                                  });
                                }),
                            SizedBox(
                              height: 30,
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
                                  width: 300,
                                  height: 45,
                                  child: RaisedButton(
                                    onPressed: () async {
                                      if (email.isEmpty) {
                                        toast(email, password,
                                            "Email tidak boleh kosong");
                                      } else if (password.isEmpty) {
                                        toast(email, password,
                                            "Password tidak boleh kosong");
                                      } else if (password.length < 6) {
                                        toast(email, password,
                                            "Password minimum 6 karakter");
                                      } else if (!email.contains('@') ||
                                          !email.contains('.')) {
                                        toast(email, password,
                                            "Email tidak valid");
                                      } else {
                                        setState(() {
                                          visible = true;
                                        });
                                        bool shouldNavigate =
                                            await signIn(email, password);

                                        setState(() {
                                          visible = true;
                                        });

                                        if (shouldNavigate) {
                                          //Navigate

                                          Route route = MaterialPageRoute(
                                              builder: (context) => HomePage());
                                          Navigator.pushReplacement(
                                              context, route);
                                        }
                                      }
                                    },
                                    child: Text(
                                      "Login",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    shape: StadiumBorder(),
                                    color: Colors.blueGrey[200],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Container(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    "Lupa Password",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Route route = MaterialPageRoute(
                                          builder: (context) => RegisterPage());
                                      Navigator.push(context, route);
                                    },
                                    child: Text(
                                      "Mendaftar",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: EdgeInsets.only(bottom: 16),
                child: Text(
                  "Version 1.0",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
          ],
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
