import 'package:dotted_border/dotted_border.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:yestolibre_admin/src/models/merchant.dart';

class ViewCoupon extends StatefulWidget {
  Merchant merchant;
  int index;
  ViewCoupon({@required this.merchant, @required this.index});
  @override
  _ViewCouponState createState() => _ViewCouponState();
}

class _ViewCouponState extends State<ViewCoupon> {
  final ref = FirebaseDatabase.instance.reference();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Coupon"),
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(14, 20, 14, 30),
        width: MediaQuery.of(context).size.width,
        child: DottedBorder(
          borderType: BorderType.Rect,
          dashPattern: [10],
          strokeWidth: 3,
          strokeCap: StrokeCap.square,
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.fromLTRB(14, 10, 14, 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 20,
                  ),
                  // Text(
                  //   "Total: ${widget.merchant.offers[widget.index].totalClaims} Remaining: ${widget.merchant.offers[widget.index].countedClaims}",
                  //   style: TextStyle(
                  //     fontSize: 16,
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: 15,
                  // ),
                  Text(
                    "Your Promo Code",
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      color: Colors.grey[500],
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    color: Color(0xff01A233),
                    width: MediaQuery.of(context).size.width / 1.5,
                    padding: EdgeInsets.all(20),
                    child: Center(
                      child: Text(
                        widget.merchant.offers[widget.index].code == "free"
                            ? "FREE"
                            : widget.merchant.offers[widget.index].code,
                        style: TextStyle(
                            fontSize: 26,
                            color: Colors.white,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    widget.merchant.name,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.blue[500],
                      fontSize: 24,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ClipOval(
                    child: Image.network(
                      widget.merchant.logoUrl,
                      height: 140,
                      width: 140,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Present this eCoupon at the counter or use the promo CODE on your online transactions to avail a Freebie or a Discount.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    "ENJOY YOUR",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).primaryColor,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    "TREAT!",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).primaryColor,
                      fontSize: 50,
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    widget.merchant.offers[widget.index].title.toUpperCase(),
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 26,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  // FlatButton(
                  //   onPressed: () {
                  //     Navigator.of(context).popUntil((route) => route.isFirst);
                  //   },
                  //   child: Container(
                  //     color: Colors.black,
                  //     padding: EdgeInsets.all(10),
                  //     child: Text(
                  //       "Checkout out more awesome deals",
                  //       style: TextStyle(
                  //         color: Colors.white,
                  //         fontSize: 17,
                  //       ),
                  //     ),
                  //   ),
                  // )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
