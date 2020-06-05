import 'dart:convert';

import 'package:yestolibre_admin/src/models/offer.dart';

Merchant merchantFromJson(String str) => Merchant.fromJson(json.decode(str));

// String merchantToJson(Merchant data) => json.encode(data.toJson());

class Merchant {
  String merchantId;
  String name;
  String category;
  String address;
  String logoUrl;
  String phoneNumber;
  double latitude;
  double longitude;
  String fbUrl;
  List<dynamic> carousel;
  List<Offer> offers;

  Merchant({
    this.merchantId,
    this.name,
    this.category,
    this.address,
    this.logoUrl,
    this.phoneNumber,
    this.latitude,
    this.longitude,
    this.fbUrl,
    this.carousel,
    this.offers,
  });

  factory Merchant.fromJson(Map<dynamic, dynamic> json) => Merchant(
      merchantId: json["merchant_id"],
      name: json["name"],
      category: json["category"],
      address: json["address"],
      logoUrl: json["logo_url"],
      phoneNumber: json["phone_number"],
      latitude: json["latitude"].toDouble(),
      longitude: json["longitude"].toDouble(),
      fbUrl: json["fb_url"],
      carousel: json["carousel"],
      offers: json["offers"] != null
          ? Map.from(json["offers"])
              .map((k, v) => MapEntry<dynamic, Offer>(k, Offer.fromJson(v)))
              .values
              .toList()
          : null);
  // Map<dynamic, dynamic> toJson() => {
  //       "merchant_id": merchantId,
  //       "name": name,
  //       "category": category,
  //       "address": address,
  //       "logo_url": logoUrl,
  //       "phone_number": phoneNumber,
  //       "latitude": latitude,
  //       "longitude": longitude,
  //       "fb_url": fbUrl,
  //       "offers": Map.from(offers)
  //           .map((k, v) => MapEntry<dynamic, dynamic>(k, v.toJson())),
  //     };
}
