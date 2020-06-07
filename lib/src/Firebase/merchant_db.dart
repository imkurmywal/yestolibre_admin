import 'package:firebase_database/firebase_database.dart';
import 'package:yestolibre_admin/src/Firebase/merchant_storage.dart';
import 'dart:async';

import 'package:yestolibre_admin/src/models/merchant.dart';
import 'package:yestolibre_admin/src/models/offer.dart';

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

  saveOffer(
      {String uid,
      String offerId,
      Map<String, dynamic> value,
      Function saved}) {
    ref.child("merchants/$uid/offers/$offerId").update(value).then((value) {
      saved(true);
    }).catchError((onError) {
      saved(false);
    });
  }

  deletingOffer({Offer offer, String merchantId, Function done}) {
    MerchantST.shared.deleteImage(
        url: offer.imageUrl,
        deleted: (value) {
          if (value) {
            ref
                .child("merchants/$merchantId/offers/${offer.offerId}")
                .set(null)
                .then((value) => {done(true)})
                .catchError((onError) => {done(false)});
          } else {
            done(false);
          }
        });
  }

  deletionPartner({Merchant merchant, Function done}) {
    MerchantST.shared.deleteImage(
        url: merchant.logoUrl,
        deleted: (value) {
          if (value) {
            deleteCarousel(
                // will delete carousel
                merchant: merchant,
                done: (value) {
                  if (value) {
                    deleteAllOffersImages(
                        // will delete all the offers.
                        merchant: merchant,
                        done: (value) {
                          if (value) {
                            MerchantDB.shared
                                .stopListenToMerchant(); // Stoping listner
                            ref
                                .child(
                                    "merchants/${merchant.merchantId}") // clearing database data.
                                .set(null)
                                .then((value) {
                              done(true);
                            }).catchError((error) {
                              done(false);
                            });
                          } else {
                            done(false);
                          }
                        });
                  } else {
                    done(false);
                  }
                });
          } else {
            done(false);
          }
        });
  }

  deleteCarousel({Merchant merchant, Function done}) {
    if (merchant.carousel == null) {
      done(true);
      return;
    }
    int i = 0;
    for (String url in merchant.carousel) {
      MerchantST.shared.deleteImage(
          url: url,
          deleted: (value) {
            if (value) {
              i++;
              if (i == merchant.carousel.length) {
                done(true);
              }
            } else {
              done(false);
            }
          });
    }
  }

  deleteAllOffersImages({Merchant merchant, Function done}) {
    if (merchant.offers == null) {
      done(true);
      return;
    }
    int i = 0;
    for (Offer offer in merchant.offers) {
      MerchantST.shared.deleteImage(
          url: offer.imageUrl,
          deleted: (value) {
            if (value) {
              i++;
              if (i == merchant.offers.length) {
                done(true);
              }
            } else {
              done(false);
            }
          });
    }
  }

  stopListenToMerchant() {
    _merchantListner.cancel();
  }

  cancel() {
    _merchantsSubscription.cancel();
  }
}
