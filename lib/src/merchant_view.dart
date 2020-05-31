import 'package:flutter/material.dart';
import 'package:yestolibre_admin/src/models/merchant.dart';
import 'package:yestolibre_admin/widgets/carousel.dart';
import 'package:yestolibre_admin/widgets/offer_in_list.dart';

class MerchantView extends StatefulWidget {
  Merchant merchant;
  MerchantView({@required this.merchant});
  @override
  _MerchantViewState createState() => _MerchantViewState();
}

class _MerchantViewState extends State<MerchantView> {
  var list = List<ListItem>();

  @override
  void initState() {
    super.initState();
    generateListItems();
  }

  void generateListItems() {
    setState(() {
      list = List<ListItem>.generate(
          widget.merchant.offers.length + 1,
          (i) => i == 0
              ? CreateCarousel(merchant: widget.merchant)
              : OfferInList(merchant: widget.merchant, index: i));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Partner Details"),
      ),
      body: ListView.builder(
          itemCount: list.length,
          itemBuilder: (context, index) {
            final item = list[index];
            if (index == 0) {
              return Container(
                child: item.buildCarousel(context),
              );
            }
            return GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {},
              child: Container(
                child: item.buildOfferInList(context),
              ),
            );
          }),
    );
  }
}

abstract class ListItem {
  Widget buildCarousel(BuildContext context);
  Widget buildOfferInList(BuildContext context);
}
