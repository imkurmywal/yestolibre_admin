import 'dart:io';
import 'dart:async';
import 'package:firebase_storage/firebase_storage.dart';

class MerchantST {
  static MerchantST shared = MerchantST();
  StorageReference ref = FirebaseStorage.instance.ref();

  Future<String> getImageURL({String path, File file}) async {
    StorageReference pathRef = ref.child("$path.jpg");
    StorageUploadTask uploadTask = pathRef.putFile(file);
    return await (await uploadTask.onComplete).ref.getDownloadURL();
  }

  deleteImage({String url, Function deleted}) {
    FirebaseStorage.instance
        .getReferenceFromUrl(url)
        .then((res) => {
              res.delete().then((value) {
                deleted(true);
              })
            })
        .catchError((error) {
      deleted(false);
    }).catchError((error) {
      deleted(false);
    });
  }
}
