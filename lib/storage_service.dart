import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class Storage {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  Future uploadFile(String filePath, String fileName) async {
    try {
      File file = File(filePath);
      await _storage.ref('exercise/$fileName').putFile(file);
    } on FirebaseException catch (e) {
      print(e);
    }
  }

  Future downloadFile(String fileName) async {
    try {
      String downloadURL =
          await _storage.ref('exercise/$fileName').getDownloadURL();
      return downloadURL;
    } on FirebaseException catch (e) {
      print(e);
    }
  }
}

Future downloadFoodFile(String fileName) async {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  try {
    String downloadURL = await _storage.ref('food/$fileName').getDownloadURL();
    return downloadURL;
  } on FirebaseException catch (e) {
    print(e);
  }
}
