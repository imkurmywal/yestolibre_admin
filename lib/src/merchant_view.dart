import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:yestolibre_admin/src/Firebase/merchant_db.dart';
import 'package:yestolibre_admin/src/add_carousel.dart';
import 'package:yestolibre_admin/src/add_offer.dart';
import 'package:yestolibre_admin/src/add_partner.dart';
import 'package:yestolibre_admin/src/models/merchant.dart';
import 'package:yestolibre_admin/src/view_offer.dart';
import 'package:yestolibre_admin/widgets/alert.dart';
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
    listenToMerchant();
  }

  void generateListItems() {
    setState(() {
      list = List<ListItem>.generate(
          widget.merchant.offers != null
              ? widget.merchant.offers.length + 1
              : 1,
          (i) => i == 0
              ? CreateCarousel(merchant: widget.merchant)
              : OfferInList(merchant: widget.merchant, index: i));
    });
  }

  listenToMerchant() {
    MerchantDB.shared.listenToMerchant(
        path: "merchants/${widget.merchant.merchantId}",
        fetched: (merchant) {
          setState(() {
            widget.merchant = merchant;
            generateListItems();
          });
        });
  }

  deletePartnerNow(ProgressDialog pr) {
    MerchantDB.shared.deletionPartner(
        merchant: widget.merchant,
        done: (value) {
          if (value) {
            pr.hide().whenComplete(() {
              Navigator.pop(context);
            });
          } else {
            Alert.shared.showError(
                context: context,
                message: "Error whilte deleting partner",
                title: "Error");
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    // progress indicator.
    ProgressDialog pr = ProgressDialog(context);
    pr = ProgressDialog(
      context,
      type: ProgressDialogType.Normal,
      isDismissible: false,
      showLogs: false,
    );
    pr.style(
      message: 'Deleting partner',
    );

    return WillPopScope(
      onWillPop: () async {
        MerchantDB.shared.stopListenToMerchant();
        return true;
      },
      child: Scaffold(
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
                      builder: (context) => ViewOffer(
                          merchant: widget.merchant, index: index - 1),
                    ),
                  );
                },
                child: Container(
                  child: item.buildOfferInList(context),
                ),
              );
            }),
        floatingActionButton: _getFAB(pr),
      ),
    );
  }

  Widget _getFAB(ProgressDialog pr) {
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
                    builder: (cotnext) => AddOffer(
                      merchanntId: widget.merchant.merchantId,
                    ),
                  ));
            });
          },
          label: 'Add Offer',
          labelStyle: TextStyle(
              fontWeight: FontWeight.w500, color: Colors.white, fontSize: 16.0),
          labelBackgroundColor: Theme.of(context).primaryColor,
        ),
        SpeedDialChild(
          child: Icon(Icons.edit),
          backgroundColor: Theme.of(context).primaryColor,
          onTap: () {
            setState(() {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (cotnext) => AddCarousel(
                      carousel: widget.merchant.carousel,
                      merchantId: widget.merchant.merchantId,
                      toFirst: false,
                    ),
                  ));
            });
          },
          label: 'Edit Carousel',
          labelStyle: TextStyle(
              fontWeight: FontWeight.w500, color: Colors.white, fontSize: 16.0),
          labelBackgroundColor: Theme.of(context).primaryColor,
        ),
        SpeedDialChild(
          child: Icon(Icons.delete),
          backgroundColor: Theme.of(context).primaryColor,
          onTap: () {
            Alert.shared.askYesNo(
                context: context,
                title: "Warning",
                message: "Are you sure want to delete this partner?",
                btnTitle: "Delete",
                done: (value) async {
                  if (value) {
                    Navigator.pop(context);
                    await pr.show();
                    deletePartnerNow(pr);
                  }
                });
          },
          label: 'Delete Partner',
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
