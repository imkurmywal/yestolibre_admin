import 'dart:io';
import 'dart:async';
import 'package:firebase_storage/firebase_storage.dart';

class MerchantST {
  static MerchantST shared = MerchantST();

  Future<String> getImageURL({String path, File file}) async {
    StorageReference ref =
        FirebaseStorage.instance.ref().child("$path.jpg");
    StorageUploadTask uploadTask = ref.putFile(file);
    return await (await uploadTask.onComplete).ref.getDownloadURL();
  }
}
