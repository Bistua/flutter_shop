import 'package:flutter/material.dart';

class ShopList extends StatelessWidget {
//  const ShopList({Key key, this.title}) : super(key: key);
//  final title;

  @override
  Widget build(BuildContext context) {
    return ShopListPage();
  }
}

class ShopListPage extends StatefulWidget {
//  ShopListPage({Key key, this.title}) : super(key: key);
//  final String title;

  @override
  ShopListState createState() => ShopListState();
}

class ShopListState extends State<ShopListPage> {
  Widget appBarTitle;
  final TextEditingController _searchQuery = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildSearchAppBar(context),
      body: Container(),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  AppBar buildSearchAppBar(BuildContext context) {
    return new AppBar(
      centerTitle: true,
      title: new Center(
        child: new TextField(
          controller: _searchQuery,
          style: new TextStyle(
            color: Colors.grey,
          ),
          decoration: new InputDecoration(
              suffixIcon: new Icon(Icons.search, color: Colors.black),
              hintText: "请输入搜索内容",
              hintStyle: new TextStyle(color: Colors.white)),
        ),
      ),
      leading: new IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () => Navigator.pop(context, false),
      ),
      actions: <Widget>[
        new GestureDetector(
          onTap:(){
            _doSearch(_searchQuery);
          },
          child: new Container(
            margin: EdgeInsets.fromLTRB(8, 12, 8, 12),
            child: new Center(
              child: new Text(
                "搜索",
                textAlign: TextAlign.center,
                style: new TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            decoration: new BoxDecoration(
              color: Colors.red,
              shape: BoxShape.rectangle,
              borderRadius: new BorderRadius.circular(8.0),
              border: new Border.all(
                width: 5.0,
                color: Colors.red,
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _doSearch(TextEditingController searchQuery) {
    searchQuery.addListener(() {
      if (searchQuery.text.isEmpty) {
        setState(() {

        });
      } else {
        setState(() {

        });
      }
    });

  }
}
