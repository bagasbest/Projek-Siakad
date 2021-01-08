import 'package:flutter/material.dart';
import 'package:project_siakad/OpenPDF.dart';

class KaryaIlmiah extends StatefulWidget {
  @override
  _KaryaIlmiahState createState() => _KaryaIlmiahState();
}

class _KaryaIlmiahState extends State<KaryaIlmiah> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.blueGrey,
          title: Text("Daftar Karya Ilmiah"),
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context)),
        ),
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      Route route = MaterialPageRoute(
                          builder: (context) => OpenPDF(
                                options: "lib/pdf/1.pdf",
                                title:
                                    "Understanding Domain Driven Design Comma",
                              ));
                      Navigator.push(context, route);
                    },
                    child: Container(
                      margin: EdgeInsets.all(5.0),
                      child: Card(
                        elevation: 10,
                        child: Row(
                          children: [
                            SizedBox(
                              height: 100,
                              width: 100,
                              child: Icon(
                                Icons.picture_as_pdf,
                                size: 70,
                                color: Colors.red,
                              ),
                            ),
                            SizedBox(width: 5),
                            Expanded(
                              child: Text(
                                  "Understanding Domain Driven Design Comma",
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Route route = MaterialPageRoute(
                          builder: (context) => OpenPDF(
                                options: "lib/pdf/2.pdf",
                                title:
                                    "Overview of a Domain-Driven Design Approach to Build Microservice-Based Applications",
                              ));
                      Navigator.push(context, route);
                    },
                    child: Container(
                      margin: EdgeInsets.all(5.0),
                      child: Card(
                        elevation: 10,
                        child: Row(
                          children: [
                            SizedBox(
                              height: 100,
                              width: 100,
                              child: Icon(
                                Icons.picture_as_pdf,
                                size: 70,
                                color: Colors.red,
                              ),
                            ),
                            SizedBox(width: 5),
                            Expanded(
                              child: Text(
                                  "Overview of a Domain-Driven Design Approach to Build Microservice-Based Applications",
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Route route = MaterialPageRoute(
                          builder: (context) => OpenPDF(
                                options: "lib/pdf/3.pdf",
                                title:
                                    "Domain-Driven Design Reference, Definition and Pattern Summaries",
                              ));
                      Navigator.push(context, route);
                    },
                    child: Container(
                      margin: EdgeInsets.all(5.0),
                      child: Card(
                        elevation: 10,
                        child: Row(
                          children: [
                            SizedBox(
                              height: 100,
                              width: 100,
                              child: Icon(
                                Icons.picture_as_pdf,
                                size: 70,
                                color: Colors.red,
                              ),
                            ),
                            SizedBox(width: 5),
                            Expanded(
                              child: Text(
                                  "Domain-Driven Design Reference, Definition and Pattern Summaries",
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Route route = MaterialPageRoute(
                          builder: (context) => OpenPDF(
                                options: "lib/pdf/4.pdf",
                                title:
                                    "Domain Driven Development and Feature Driven Development for development of credit risk evaluation DSS",
                              ));
                      Navigator.push(context, route);
                    },
                    child: Container(
                      margin: EdgeInsets.all(5.0),
                      child: Card(
                        elevation: 10,
                        child: Row(
                          children: [
                            SizedBox(
                              height: 100,
                              width: 100,
                              child: Icon(
                                Icons.picture_as_pdf,
                                size: 70,
                                color: Colors.red,
                              ),
                            ),
                            SizedBox(width: 5),
                            Expanded(
                              child: Text(
                                  "Domain Driven Development and Feature Driven Development for development of credit risk evaluation DSS",
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
