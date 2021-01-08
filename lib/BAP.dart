import 'dart:io';

import 'package:dio/dio.dart';
import 'package:ext_storage/ext_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:permission_handler/permission_handler.dart';

class BAP extends StatefulWidget {
  @override
  _BAPState createState() => _BAPState();
}

class _BAPState extends State<BAP> {
  @override
  void initState() {
    super.initState();
    _getPermission();
  }

  void _getPermission() async {
    await PermissionHandler().requestPermissions([PermissionGroup.storage]);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.blueGrey,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text("BAP"),
        ),
        body: tampilBAP(context),
      ),
    );
  }
}

Widget tampilBAP(BuildContext context) {
  final imgUrl = "http://www.pdf995.com/samples/pdf.pdf";
  var dio = Dio();

  Future download2(Dio dio, String url, String savePath) async {
    void showDownloadProgress(received, total) {
      if (total != -1) {
        print((received / total * 100).toStringAsFixed(0) + "%");
      }
    }

    try {
      Response response = await dio.get(url,
          onReceiveProgress: showDownloadProgress,
          options: Options(
            responseType: ResponseType.bytes,
            followRedirects: false,
            validateStatus: (status) {
              return status < 500;
            },
          ));

      File file = File(savePath);
      var raf = file.openSync(mode: FileMode.write);
      raf.writeFromSync(response.data);
      await raf.close();

      toast(
          "File telah teruduh di perangkat anda, silahkan cari di Storage/download dengan nama FILE_BAP.pdf");
    } catch (e) {
      print("error is: ");
      print(e);
    }
  }

  return Container(
    margin: EdgeInsets.all(16.0),
    child: Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.9,
          height: 350,
          decoration: BoxDecoration(
              image: DecorationImage(
            image: AssetImage("img/cover_bap.png"),
            fit: BoxFit.contain,
          )),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          child: RaisedButton(
            color: Colors.blueGrey,
            onPressed: () async {
              String path = await ExtStorage.getExternalStoragePublicDirectory(
                  ExtStorage.DIRECTORY_DOWNLOADS);

              String fullPath = "$path/FILE_BAP.pdf";
              download2(dio, imgUrl, fullPath);
            },
            child: Row(
              children: [
                Icon(Icons.file_download, color: Colors.white),
                SizedBox(
                  width: 5,
                ),
                Text(
                  "Download file",
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        )
      ],
    ),
  );
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
