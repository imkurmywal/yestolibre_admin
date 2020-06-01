import 'package:firebase_database/firebase_database.dart';
import 'dart:async';

import 'package:yestolibre_admin/src/models/merchant.dart';

// client added furthor requirements so I have to add this classs.
class MerchantDB {
  static MerchantDB shared = MerchantDB();
  final ref = FirebaseDatabase.instance.reference();
  StreamSubscription<Event> _merchantsSubscription;

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
  }

  cancel() {
    _merchantsSubscription.cancel();
  }
}
