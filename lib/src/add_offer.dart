import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:yestolibre_admin/src/models/offer.dart';

class AddOffer extends StatefulWidget {
  Offer offer;
  AddOffer({this.offer});
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

  File _image;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      _image = File(pickedFile.path);
    });
  }

  @override
  void initState() {
    super.initState();
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
                  ? FittedBox(
                      child: Image.file(_image),
                      fit: BoxFit.contain,
                    )
                  : Text(""),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ButtonTheme(
                    child: RaisedButton(
                      color: Theme.of(context).primaryColor,
                      child: Text(
                        "Add Offer",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: Colors.white),
                      ),
                      onPressed: () {},
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
}
