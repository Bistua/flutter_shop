import 'package:flutter/material.dart';
import 'package:flutter_lib/logic/bloc/tab_bloc.dart';
import 'package:flutter_lib/model/searchTab.dart';
import 'package:flutter_lib/logic/viewmodel/tab_view_model.dart';
import 'package:flutter_lib/utils/uidata.dart';
import 'package:flutter_lib/bridge.dart';
import 'package:flutter_lib/ui/widgets/shop_tab_item.dart';

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
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: buildSearchAppBar(context),
        body: Container(),
        // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }

  AppBar buildSearchAppBar(BuildContext context) {
    TabViewModel tabViewModel = TabViewModel();
    tabViewModel.getMenuItems();
    return new AppBar(
      centerTitle: true,
      title: buildTextField(),
      bottom: new PreferreSizeWidget(),
      leading: new IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () => Navigator.pop(context, false),
      ),
      actions: <Widget>[
        buildSearchBtn(),
      ],
    );
  }

  GestureDetector buildSearchBtn() {
    return new GestureDetector(
        onTap: () {
          _doSearch(_searchQuery);
        },
        child: Container(
          padding: new EdgeInsets.fromLTRB(15.0, 0, 15.0, 0),
          child: new Center(
            child: Container(
              alignment: Alignment.center,
              width: 60,
              height: 28,
              child: new Text(
                '搜索',
                style: TextStyle(color: Colors.white),
              ),
              decoration: new BoxDecoration(
                color: Colors.red,
                shape: BoxShape.rectangle,
                borderRadius: new BorderRadius.circular(14),
                border: new Border.all(
                  width: 5.0,
                  color: Colors.red,
                ),
              ),
            ),
          ),
        ),
      );
  }

  BoxDecoration buildBoxDecoration() {
    return new BoxDecoration(
      color: new Color(0xfff5f5f5),
      shape: BoxShape.rectangle,
      borderRadius: new BorderRadius.circular(5),
      border: new Border.all(
        color: new Color(0xfff5f5f5),
      ),
    );
  }

  Widget buildTextField() {
    return new Container(
      alignment: Alignment.centerLeft,
      height: 28,
      child: new Center(
        child: new TextField(
          textAlign: TextAlign.start,
          controller: _searchQuery,
          cursorColor: Colors.transparent,
          cursorWidth: 0,
          style: new TextStyle(color: UIData.ff353535, fontSize: 12),
          decoration: new InputDecoration(
              fillColor: Color(0xfff5f5f5),
              contentPadding: new EdgeInsets.fromLTRB(10.0, 4, 10.0, 4),
              filled: true,
              border: new OutlineInputBorder(
                borderRadius: new BorderRadius.circular(14.0),
                borderSide: new BorderSide(color: Colors.red, width: 0),
              ),
              suffixIcon: new Icon(
                Icons.search,
                color: UIData.ffcccccc,
                size: 18,
              ),
              hintText: "请输入搜索内容",
              hintStyle: new TextStyle(color: UIData.ffcccccc)),
        ),
      ),
    );
  }

  void _doSearch(TextEditingController searchQuery) {
    searchQuery.addListener(() {
      if (searchQuery.text.isEmpty) {
        setState(() {});
      } else {
        setState(() {});
      }
    });
  }
}
