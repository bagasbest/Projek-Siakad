import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';

class DatabaseServices {
  static Future<String> uploadImage(File imageFile) async {
    String filename = basename(imageFile.path);

    FirebaseStorage storage = FirebaseStorage.instance;
    final Reference ref = storage.ref().child(filename);
    await ref.putFile(imageFile);

    User user = FirebaseAuth.instance.currentUser;

    FirebaseFirestore.instance
        .collection("users")
        .doc(user.uid)
        .update({"image": await ref.getDownloadURL()});

    return await ref.getDownloadURL();
  }
}
