import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:yestolibre_admin/src/add_offer.dart';
import 'package:yestolibre_admin/src/add_partner.dart';
import 'package:yestolibre_admin/src/models/merchant.dart';
import 'package:yestolibre_admin/src/view_offer.dart';
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
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        ViewOffer(merchant: widget.merchant, index: index - 1),
                  ),
                );
              },
              child: Container(
                child: item.buildOfferInList(context),
              ),
            );
          }),
      floatingActionButton: _getFAB(),
    );
  }

  Widget _getFAB() {
    return SpeedDial(
      animatedIcon: AnimatedIcons.menu_close,
      animatedIconTheme: IconThemeData(size: 22),
      backgroundColor: Theme.of(context).primaryColor,
      visible: true,
      curve: Curves.bounceIn,
      children: [
        // FAB 1
        SpeedDialChild(
          child: Icon(Icons.edit),
          backgroundColor: Theme.of(context).primaryColor,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddPartner(
                  merchant: widget.merchant,
                ),
              ),
            );
          },
          label: 'Edit Partner',
          labelStyle: TextStyle(
              fontWeight: FontWeight.w500, color: Colors.white, fontSize: 16.0),
          labelBackgroundColor: Theme.of(context).primaryColor,
        ),
        // FAB 2
        SpeedDialChild(
          child: Icon(Icons.add),
          backgroundColor: Theme.of(context).primaryColor,
          onTap: () {
            setState(() {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (cotnext) => AddOffer(),
                  ));
            });
          },
          label: 'Add Offer',
          labelStyle: TextStyle(
              fontWeight: FontWeight.w500, color: Colors.white, fontSize: 16.0),
          labelBackgroundColor: Theme.of(context).primaryColor,
        )
      ],
    );
  }
}

abstract class ListItem {
  Widget buildCarousel(BuildContext context);
  Widget buildOfferInList(BuildContext context);
}
