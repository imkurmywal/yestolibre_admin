import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddCarousel extends StatefulWidget {
  List<dynamic> carousel;
  AddCarousel({this.carousel});
  @override
  _AddCarouselState createState() => _AddCarouselState();
}

class _AddCarouselState extends State<AddCarousel> {
  List<Image> _images = List<Image>();
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      _images.add(Image.file(File(pickedFile.path)));
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
        _images.add(Image.network(url));
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
                          child: _images[index],
                        ),
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
                                      child: Text(
                                        "Save Carousel",
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
