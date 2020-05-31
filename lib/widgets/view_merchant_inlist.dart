import 'package:flutter/material.dart';

class ViewMerchantInList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            width: 10,
          ),
          ClipRRect(
            // borderRadius: BorderRadius.circular(30.0),
            child: FittedBox(
              fit: BoxFit.contain,
              child: Image.network(
                "https://1000logos.net/wp-content/uploads/2016/10/Burger-King-Logo.png",
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
                  "merchant name",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  maxLines: 2,
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "SomeAddress",
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
                      "Eat",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
