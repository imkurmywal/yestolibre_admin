import 'package:flutter/material.dart';
import 'package:yestolibre_admin/src/merchant_view.dart';
import 'package:yestolibre_admin/src/models/merchant.dart';
import 'package:yestolibre_admin/src/view_offer.dart';

class OfferInList implements ListItem {
  Merchant merchant;
  int index;
  OfferInList({@required this.merchant, @required this.index});

  Widget buildCarousel(BuildContext context) => null;
  Widget buildOfferInList(BuildContext context) {
    return Container(
      // height: 170,
      margin: EdgeInsets.fromLTRB(10, 14, 10, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 120,
            height: 105,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fitHeight,
                image: NetworkImage(merchant.offers[index - 1].imageUrl),
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
                  merchant.offers[index - 1].title,
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "${merchant.offers[index - 1].type == "free" ? "FREE" : merchant.offers[index - 1].offPercent + " OFF"}",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 3,
                ),
                // RaisedButton(
                //   color: Theme.of(context).primaryColor,
                //   textColor: Colors.white,
                //   shape: RoundedRectangleBorder(
                //       borderRadius: BorderRadius.circular(4)),
                //   onPressed: () {
                //     Navigator.push(
                //         context,
                //         MaterialPageRoute(
                //             builder: (context) => ViewOffer(
                //                   merchant: merchant,
                //                   index: index - 1,
                //                 )));
                //   },
                //   child: Container(
                //     width: 80,
                //     height: 30,
                //     child: Center(
                //       child: Text(
                //         "Claim",
                //         style: TextStyle(fontSize: 17),
                //       ),
                //     ),
                //     // padding: EdgeInsets.all(2),
                //   ),
                // ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
