import 'package:flutter/material.dart';
import 'package:yestolibre_admin/widgets/view_merchant_inlist.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
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
                  onSubmitted: (keyword) {
                    setState(() {
                      // filterByKeyword(keyword: keyword);
                    });
                  },
                ),
              )
            ],
          ),
        ),
      ),
      body: Container(
        child: ListView.builder(
            itemCount: 120,
            itemBuilder: (context, index) {
              return ViewMerchantInList();
            }),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          print("Pressed..");
        },
      ),
    );
  }
}
