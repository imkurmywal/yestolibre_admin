import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import 'package:yestolibre_admin/src/Firebase/merchant_db.dart';
import 'package:yestolibre_admin/src/Firebase/merchant_storage.dart';
import 'package:yestolibre_admin/src/models/offer.dart';
import 'package:yestolibre_admin/widgets/alert.dart';
import 'package:yestolibre_admin/widgets/animated_btn.dart';

class AddOffer extends StatefulWidget {
  Offer offer;
  String merchanntId;
  AddOffer({@required this.merchanntId, this.offer});
  @override
  _AddOfferState createState() => _AddOfferState();
}

class _AddOfferState extends State<AddOffer> {
  TextStyle style = TextStyle(fontSize: 18, fontWeight: FontWeight.w600);
  TextEditingController _offerTitle = new TextEditingController();
  TextEditingController _code = new TextEditingController();
  TextEditingController _termsAndConditions = new TextEditingController();
  TextEditingController _type = new TextEditingController();
  TextEditingController _offPercent = new TextEditingController();
  // TextEditingController _contactNumber = new TextEditingController();
  // TextEditingController _link = new TextEditingController();
  File _imageFile;
  Image _image;
  final picker = ImagePicker();
  String offerId = "";
  int state = 0;

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      _image = Image.file(File(pickedFile.path));
      _imageFile = File(pickedFile.path);
    });
  }

  @override
  void initState() {
    super.initState();
    offerId = Uuid().v4();
    if (widget.offer != null) {
      setupUpdateOffer();
    }
  }

  setupUpdateOffer() {
    _offerTitle.text = widget.offer.title;
    _type.text = widget.offer.type;
    _code.text = widget.offer.code;
    _termsAndConditions.text = widget.offer.termsConditions;
    _offPercent.text = widget.offer.offPercent;
    _image = Image.network(widget.offer.imageUrl);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Offer Details"),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.fromLTRB(14, 16, 14, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Offer Title",
                style: style,
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: this._offerTitle,
                style: style,
                decoration: decoration(hint: "Pizza Hut 20% Discount"),
              ),
              SizedBox(
                height: 14,
              ),
              Text(
                "Promo Code",
                style: style,
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: this._code,
                style: style,
                decoration: decoration(hint: "WERXT"),
              ),
              SizedBox(
                height: 14,
              ),
              Text(
                "Terms And Conditions",
                style: style,
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                maxLines: 4,
                controller: this._termsAndConditions,
                style: style,
                decoration: decoration(hint: ""),
              ),
              SizedBox(
                height: 14,
              ),
              Container(
                width: MediaQuery.of(context).size.width - 32,
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Offer Type",
                            style: style,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextField(
                            controller: this._type,
                            style: style,
                            decoration: decoration(hint: "Free/Discount"),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Off Percentage",
                            style: style,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextField(
                            controller: this._offPercent,
                            style: style,
                            decoration: decoration(hint: "Free or 25%"),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 14,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RaisedButton(
                    child: Text(
                      "Upload Offer Image",
                      style: style,
                    ),
                    onPressed: () {
                      getImage();
                    },
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              _image != null
                  ? Center(
                      child: Container(
                        height: 200,
                        // width: 200,
                        child: _image,
                      ),
                    )
                  : Text(""),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ButtonTheme(
                    child: RaisedButton(
                      color: Theme.of(context).primaryColor,
                      child: AnimateBtn(
                          state: state,
                          title: widget.offer == null
                              ? "Add Offer"
                              : "Update Offer"),
                      onPressed: () {
                        if (!runValidation()) {
                          Alert.shared.showError(
                              context: context,
                              message: "All the input data are required",
                              title: "Error");
                          return;
                        }
                        saveOffer();
                      },
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration decoration({String hint}) {
    return InputDecoration(
      filled: true,
      fillColor: Colors.grey[300],
      hintText: hint,
      border: InputBorder.none,
    );
  }

  saveOffer() async {
    setState(() {
      state = 1;
    });

    if (widget.offer != null) {
      offerId = widget.offer.offerId;
    }

    String urlString = await getURL(offerId: offerId);

    Map<String, dynamic> map = {
      "offer_id": offerId,
      "title": _offerTitle.text,
      "type": _type.text,
      "terms_conditions": _termsAndConditions.text,
      "image_url": urlString,
      "off_discount": _offPercent.text,
      "promo_code": _code.text,
      "counted_claims": widget.offer != null ? widget.offer.countedClaims : "0"
    };
    Map<String, dynamic> offer = {
      "offers": {offerId: map}
    };
    MerchantDB.shared.saveMerchantData(
        uid: widget.merchanntId,
        value: offer,
        saved: (value) {
          if (value) {
            setState(() {
              state = 2;
            });
            Navigator.pop(context);
          } else {
            setState(() {
              state = 0;
              Alert.shared.showError(
                  context: context,
                  title: "Error",
                  message: "Offer data saving error occured.");
            });
          }
        });
  }

  Future<String> getURL({String offerId}) async {
    if (_imageFile != null) {
      return MerchantST.shared
          .getImageURL(path: "offer_images/$offerId", file: _imageFile);
    } else {
      return widget.offer.imageUrl;
    }
  }

  bool runValidation() {
    if (_offerTitle.text.length == 0 ||
        _code.text.length == 0 ||
        _type.text.length == 0 ||
        _termsAndConditions.text.length == 0 ||
        _offPercent.text.length == 0) {
      return false;
    }
    if (_image == null) {
      return false;
    }
    return true;
  }
}
