import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:yestolibre_admin/src/models/merchant.dart';

class AddPartner extends StatefulWidget {
  Merchant merchant;
  AddPartner({this.merchant});

  @override
  _AddPartnerState createState() => _AddPartnerState();
}

class _AddPartnerState extends State<AddPartner> {
  TextStyle style = TextStyle(fontSize: 18, fontWeight: FontWeight.w600);
  TextEditingController _partnerName = new TextEditingController();
  TextEditingController _category = new TextEditingController();
  TextEditingController _address = new TextEditingController();
  TextEditingController _latitude = new TextEditingController();
  TextEditingController _longitude = new TextEditingController();
  TextEditingController _contactNumber = new TextEditingController();
  TextEditingController _link = new TextEditingController();

  Image _image;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      _image = Image.file(File(pickedFile.path));
    });
  }

  setupUpdateMerchant() {
    _partnerName.text = widget.merchant.name;
    _address.text = widget.merchant.address;
    _latitude.text = widget.merchant.latitude.toString();
    _longitude.text = widget.merchant.longitude.toString();
    _category.text = widget.merchant.category;
    _contactNumber.text = widget.merchant.phoneNumber;
    _link.text = widget.merchant.fbUrl;
    _image = Image.network(widget.merchant.logoUrl);
  }

  @override
  void initState() {
    super.initState();
    if (widget.merchant != null) {
      setupUpdateMerchant();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Partner Details"),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.fromLTRB(14, 16, 14, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Parnter's Name",
                style: style,
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: this._partnerName,
                style: style,
                decoration: decoration(hint: "Pizza Hut"),
              ),
              SizedBox(
                height: 14,
              ),
              Text(
                "Parnter's Category",
                style: style,
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: this._category,
                style: style,
                decoration: decoration(hint: "Eat, Trends, Services"),
              ),
              SizedBox(
                height: 14,
              ),
              Text(
                "Complete Address",
                style: style,
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                maxLines: 4,
                controller: this._address,
                style: style,
                decoration: decoration(hint: "Address"),
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
                            "Latitude",
                            style: style,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextField(
                            controller: this._latitude,
                            style: style,
                            decoration: decoration(hint: "Latitude"),
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
                            "Longitude",
                            style: style,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextField(
                            controller: this._longitude,
                            style: style,
                            decoration: decoration(hint: "Longitude"),
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
              Text(
                "Contact Number",
                style: style,
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: this._contactNumber,
                style: style,
                decoration: decoration(hint: "+923120962362"),
              ),
              SizedBox(
                height: 14,
              ),
              SizedBox(
                height: 14,
              ),
              Text(
                "Website / Page URL",
                style: style,
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: this._link,
                style: style,
                decoration: decoration(hint: "https://"),
              ),
              SizedBox(
                height: 14,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RaisedButton(
                    child: Text(
                      "Brand Icon",
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
                        width: 200,
                        child: FittedBox(
                          child: _image,
                          fit: BoxFit.contain,
                        ),
                      ),
                    )
                  :
                  // widget.merchant != null
                  //     ? Center(
                  //         child: Container(
                  //           height: 200,
                  //           width: 200,
                  //           child: FittedBox(
                  //             child: Image.network(widget.merchant.logoUrl),
                  //             fit: BoxFit.contain,
                  //           ),
                  //         ),
                  //       )
                  //     :
                  Text(""),
              // ListView(
              //   children: [Text("First Elememnt"), Text("First Elememnt")],
              // ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ButtonTheme(
                    child: RaisedButton(
                      color: Theme.of(context).primaryColor,
                      child: Text(
                        "Add Merchant",
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
