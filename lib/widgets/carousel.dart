import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yestolibre_admin/src/merchant_view.dart';
import 'package:yestolibre_admin/src/models/merchant.dart';

class CreateCarousel implements ListItem {
  Merchant merchant;
  CreateCarousel({@required this.merchant});
  Widget buildOfferInList(BuildContext context) => null;
  Widget buildCarousel(BuildContext context) {
    return MyCarousel(
      merchant: merchant,
    );
  }
}

class MyCarousel extends StatefulWidget {
  Merchant merchant;
  MyCarousel({@required this.merchant});
  @override
  State<StatefulWidget> createState() {
    return _CarouselWithIndicatorState();
  }
}

class _CarouselWithIndicatorState extends State<MyCarousel> {
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      SizedBox(
        height: 10,
      ),
      CarouselSlider(
        items: imageSliders(),
        options: CarouselOptions(
            autoPlay: true,
            enlargeCenterPage: true,
            aspectRatio: 2.0,
            onPageChanged: (index, reason) {
              setState(() {
                _current = index;
              });
            }),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: widget.merchant.carousel.map((url) {
          int index = widget.merchant.carousel.indexOf(url);
          return Container(
            width: 8.0,
            height: 8.0,
            margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _current == index
                  ? Color.fromRGBO(0, 0, 0, 0.9)
                  : Color.fromRGBO(0, 0, 0, 0.4),
            ),
          );
        }).toList(),
      ),
      SizedBox(
        height: 20,
      ),
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            width: 10,
          ),
          ClipRRect(
            // borderRadius: BorderRadius.circular(30.0),
            child: FittedBox(
              fit: BoxFit.cover,
              child: Image.network(
                widget.merchant.logoUrl,
                width: 80,
                height: 80,
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  widget.merchant.name,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  maxLines: 2,
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  widget.merchant.address,
                  style: TextStyle(
                    fontSize: 15,
                  ),
                  maxLines: 2,
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: <Widget>[
                    Text(
                      "Category",
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      widget.merchant.category,
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          )
        ],
      ),
      // Row(
      //   crossAxisAlignment: CrossAxisAlignment.center,
      //   mainAxisAlignment: MainAxisAlignment.center,
      //   children: <Widget>[
      //     Spacer(),
      //     Text(
      //       "Call Now",
      //       style: TextStyle(fontSize: 17),
      //     ),
      //     SizedBox(
      //       width: 10,
      //     ),
      //     SizedBox.fromSize(
      //       size: Size(40, 40), // button width and height
      //       child: ClipOval(
      //         child: Material(
      //           color: Theme.of(context).primaryColor, // button color
      //           child: InkWell(
      //             splashColor: Colors.grey, // splash color
      //             onTap: () {
      //               launch("tel:+${widget.merchant.phoneNumber}");
      //             }, // button pressed
      //             child: Column(
      //               mainAxisAlignment: MainAxisAlignment.center,
      //               children: <Widget>[
      //                 Icon(Icons.call, color: Colors.white), // icon
      //               ],
      //             ),
      //           ),
      //         ),
      //       ),
      //     ),
      //     SizedBox(
      //       width: 10,
      //     ),
      //   ],
      // ),

      SizedBox(
        height: 10,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ButtonTheme(
            minWidth: 26,
            child: RaisedButton(
              color: Color(0xff49934D),
              textColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(3)),
              onPressed: () async {
                if (await canLaunch(widget.merchant.fbUrl)) {
                  launch(widget.merchant.fbUrl);
                }
              },
              child: Container(
                width: 105,
                height: 40,
                child: Center(
                  child: Text(
                    "VISIT PAGE",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                padding: EdgeInsets.fromLTRB(2, 5, 2, 5),
              ),
            ),
          ),
          SizedBox(
            width: 20,
          ),
          ButtonTheme(
            minWidth: 26,
            child: RaisedButton(
              color: Color(0xff49934D),
              textColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(3)),
              onPressed: () {
                launch("tel:+${widget.merchant.phoneNumber}");
              },
              child: Container(
                width: 105,
                height: 40,
                child: Center(
                  child: Text(
                    "CALL",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                padding: EdgeInsets.fromLTRB(2, 5, 2, 5),
              ),
            ),
          ),
        ],
      ),
      SizedBox(height: 10),
    ]);
  }

  List<Widget> imageSliders() {
    final List<Widget> imageSliders = widget.merchant.carousel
        .map((item) => Container(
              child: Container(
                // margin: EdgeInsets.all(5.0),
                child: Image.network(item, fit: BoxFit.cover, width: 1000.0),
              ),
            ))
        .toList();
    return imageSliders;
  }
}
