import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import 'package:yestolibre_admin/src/Firebase/merchant_db.dart';
import 'package:yestolibre_admin/src/Firebase/merchant_storage.dart';
import 'package:yestolibre_admin/widgets/alert.dart';
import 'package:yestolibre_admin/widgets/animated_btn.dart';

class AddCarousel extends StatefulWidget {
  List<dynamic> carousel;
  String merchantId;
  bool toFirst;
  AddCarousel(
      {this.carousel, @required this.merchantId, @required this.toFirst});
  @override
  _AddCarouselState createState() => _AddCarouselState();
}

class _AddCarouselState extends State<AddCarousel> {
  List<CarouselModel> _images = List<CarouselModel>();
  final picker = ImagePicker();
  int state = 0;
  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      _images.add(
        CarouselModel(
          type: "file",
          file: File(pickedFile.path),
        ),
      );
    });
  }

  @override
  void initState() {
    super.initState();
    if (widget.carousel != null) {
      setupCarousel();
    }
  }

  setupCarousel() {
    _images.clear();
    widget.carousel.forEach((url) {
      setState(() {
        _images.add(CarouselModel(type: "url", url: url));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Carousel Images"),
      ),
      body: Container(
        child: ListView.builder(
            itemCount: _images.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                  onDoubleTap: () {
                    showAlertDialog(context, index);
                  },
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(14, 10, 14, 0),
                        height: 220,
                        child: FittedBox(
                            fit: BoxFit.fill,
                            child: _images[index].type == "url"
                                ? Image.network(_images[index].url)
                                : Image.file(_images[index].file)),
                      ),
                      index == _images.length - 1
                          ? Container(
                              margin: EdgeInsets.all(10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ButtonTheme(
                                    child: RaisedButton(
                                      color: Theme.of(context).primaryColor,
                                      child: AnimateBtn(
                                        state: state,
                                        title: "Save Carousel",
                                      ),
                                      onPressed: () {
                                        if (_images.length == 0) {
                                          Alert.shared.showError(
                                              context: context,
                                              message:
                                                  "Atleast one image is required to add carousel",
                                              title: "Error");
                                          return;
                                        }
                                        saveCarousel();
                                      },
                                    ),
                                  )
                                ],
                              ),
                            )
                          : Container()
                    ],
                  ));
            }),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          getImage();
        },
      ),
    );
  }

  saveCarousel() async {
    setState(() {
      state = 1;
    });
    // save images and get their urls
    List<String> urls = List<String>();
    for (CarouselModel image in _images) {
      if (image.type == "url") {
        urls.add(image.url);
      } else {
        String url = await MerchantST.shared.getImageURL(
            path: "banner_images/${Uuid().v4()}", file: image.file);
        urls.add(url);
      }
    }
    // save urls in the database.
    MerchantDB.shared.saveMerchantData(
        uid: widget.merchantId,
        value: {"carousel": urls},
        saved: (value) {
          if (value) {
            setState(() {
              state = 2;
            });
            if (widget.toFirst) {
              Navigator.popUntil(context, (route) => route.isFirst);
            } else {
              Navigator.pop(context);
            }
          } else {
            setState(() {
              state = 0;
            });
            Alert.shared.showError(
                context: context,
                message: "Error while saving carousel",
                title: "Error");
          }
        });
  }

  showAlertDialog(BuildContext context, int index) {
    // set up the button
    Widget okButton = FlatButton(
      child: Text("Delete"),
      onPressed: () {
        Navigator.pop(context);
        setState(() {
          _images.removeAt(index);
        });
      },
    );
    Widget cancelButton = FlatButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Delete"),
      content: Text("Are you sure want to remove this photo??"),
      actions: [okButton, cancelButton],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}

class CarouselModel {
  String url;
  String type;
  File file;
  CarouselModel({@required this.type, this.url, this.file});
}
