import 'package:flutter/material.dart';
import 'package:yestolibre_admin/src/models/merchant.dart';

class ViewMerchantInList extends StatelessWidget {
  Merchant merchant;
  ViewMerchantInList({@required this.merchant});
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
                merchant.logoUrl,
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
                  merchant.name,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  maxLines: 2,
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  merchant.address,
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
                      merchant.category,
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
