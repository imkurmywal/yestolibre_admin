import 'package:firebase_database/firebase_database.dart';
import 'dart:async';

import 'package:yestolibre_admin/src/models/merchant.dart';

// client added furthor requirements so I have to add this classs.
class MerchantDB {
  static MerchantDB shared = MerchantDB();
  final ref = FirebaseDatabase.instance.reference();
  StreamSubscription<Event> _merchantsSubscription;
  StreamSubscription<Event> _merchantListner;

  getMerchants({Function fetched}) {
    List<Merchant> allMerchants = new List<Merchant>();
    _merchantsSubscription =
        ref.child("merchants").onValue.listen((Event event) {
      allMerchants.clear();
      for (Map<dynamic, dynamic> value in event.snapshot.value.values) {
        allMerchants.add(new Merchant.fromJson(value));
      }
      fetched(allMerchants);
    });
    _merchantsSubscription.onError((error) {
      print(error);
    });
  }

  listenToMerchant({String path, Function fetched}) {
    _merchantListner = ref.child(path).onValue.listen((Event event) {
      Merchant merchant = new Merchant.fromJson(event.snapshot.value);
      fetched(merchant);
    });
  }

  saveMerchantData({String uid, Map<String, dynamic> value, Function saved}) {
    ref.child("merchants/$uid").update(value).then((value) {
      saved(true);
    }).catchError((onError) {
      saved(false);
    });
  }
  
  stopListenToMerchant() {
    _merchantListner.cancel();
  }

  cancel() {
    _merchantsSubscription.cancel();
  }
}
