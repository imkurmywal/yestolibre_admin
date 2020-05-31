import 'dart:convert';

Offer offerFromJson(String str) => Offer.fromJson(json.decode(str));

// String offerToJson(Offer data) => json.encode(data.toJson());

List<Offer> parsePhotos(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Offer>((json) => Offer.fromJson(json)).toList();
}

class Offer {
  String offerId;
  String title;
  String code;
  String type;
  String offPercent;
  String imageUrl;
  // String totalClaims;
  String countedClaims;
  String termsConditions;

  Offer({
    this.offerId,
    this.title,
    this.code,
    this.type,
    this.offPercent,
    this.imageUrl,
    // this.totalClaims,
    this.countedClaims,
    this.termsConditions,
  });

  factory Offer.fromJson(Map<dynamic, dynamic> json) => Offer(
        offerId: json["offer_id"],
        title: json["title"],
        type: json["type"],
        code: json["promo_code"],
        offPercent: json["off_discount"],
        imageUrl: json["image_url"],
        // totalClaims: json["total_claims"],
        countedClaims: json["counted_claims"],
        termsConditions: json["terms_conditions"],
      );

  // Map<dynamic, dynamic> toJson() => {
  //       "offer_id": offerId,
  //       "title": title,
  //       "type": type,
  //       "total_claims": totalClaims,
  //       "counted_claims": countedClaims,
  //       "terms_conditions": termsConditions,
  //     };
}
