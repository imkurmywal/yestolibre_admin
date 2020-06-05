import 'package:flutter/material.dart';
import 'package:yestolibre_admin/src/Firebase/merchant_db.dart';
import 'package:yestolibre_admin/src/add_partner.dart';
import 'package:yestolibre_admin/src/merchant_view.dart';
import 'package:yestolibre_admin/src/models/merchant.dart';
import 'package:yestolibre_admin/widgets/view_merchant_inlist.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<Merchant> allMerchants = List<Merchant>();
  List<Merchant> filteredMerchants = List<Merchant>();
  bool _isFetching = true;
  bool _isSearching = false;

  void getList() async {
    MerchantDB.shared.getMerchants(fetched: (List<Merchant> merchants) {
      setState(() {
        allMerchants = merchants;
        _isFetching = false;
      });
    });
  }

  filterByKeyword({String keyword}) {
    String keywd = keyword.toLowerCase();
    filteredMerchants.clear();
    allMerchants.forEach((merchant) {
      merchant.offers.forEach((offer) {
        if (offer.title.toLowerCase().contains(keywd) ||
            merchant.name.toLowerCase().contains(keywd) ||
            merchant.address.toLowerCase().contains(keywd)) {
          filteredMerchants.add(merchant);
        }
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          margin: EdgeInsets.fromLTRB(14, 10, 14, 10),
          padding: EdgeInsets.fromLTRB(14, 0, 14, 0),
          color: Colors.white,
          child: Row(
            children: <Widget>[
              Icon(
                Icons.search,
                color: Colors.black,
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: TextField(
                  textInputAction: TextInputAction.search,
                  decoration: InputDecoration(
                      hintText: "Search Name", border: InputBorder.none),
                  onChanged: (keyword) {
                    setState(() {
                      _isSearching = true;
                      filterByKeyword(keyword: keyword);
                      // _isSearching = false;
                    });
                  },
                ),
              )
            ],
          ),
        ),
      ),
      body: _isFetching
          ? Center(
              child: CircularProgressIndicator(),
            )
          : allMerchants.length == 0
              ? Center(
                  child: Text("No Partners found"),
                )
              : Container(
                  child: ListView.builder(
                      itemCount: _isSearching
                          ? filteredMerchants.length
                          : allMerchants.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MerchantView(
                                          merchant: _isSearching
                                              ? filteredMerchants[index]
                                              : allMerchants[index],
                                        )));
                          },
                          child: ViewMerchantInList(
                            merchant: _isSearching
                                ? filteredMerchants[index]
                                : allMerchants[index],
                          ),
                        );
                      }),
                ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (cotnext) => AddPartner(),
              ));
        },
      ),
    );
  }
}
