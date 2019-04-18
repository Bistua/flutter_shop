import 'package:flutter/material.dart';
import 'package:flutter_lib/logic/bloc/product_bloc.dart';
import 'package:flutter_lib/logic/viewmodel/tab_view_model.dart';
import 'package:flutter_lib/model/product.dart';
import 'package:flutter_lib/ui/widgets/shop_grid.dart';
import 'package:flutter_lib/ui/widgets/shop_tab_item.dart';
import 'package:flutter_lib/utils/uidata.dart';

class SearchShopList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SearchShopListPage();
  }
}

class SearchShopListPage extends StatefulWidget {
//  ShopListPage({Key key, this.title}) : super(key: key);
//  final String title;

  @override
  SearchShopListState createState() => SearchShopListState();
}

class SearchShopListState extends State<SearchShopListPage> {
  ProductBloc productBloc = ProductBloc();
  Widget appBarTitle;
  final TextEditingController _searchQuery = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: buildSearchAppBar(context),
        body: Container(
          child: bodyData(),
        ),
        // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }

  Widget bodyData() {
    print(productBloc.productItems);
    return StreamBuilder<List<Product>>(
        stream: productBloc.productItems,
        builder: (context, snapshot) {
          return snapshot.hasData
              ? new ShopGridPage(snapshot.data)
              : Center(child: CircularProgressIndicator());
        });
  }

  AppBar buildSearchAppBar(BuildContext context) {
    TabViewModel tabViewModel = TabViewModel();
    tabViewModel.getMenuItems();
    return new AppBar(
      centerTitle: false,
      title: buildTextField(),
      bottom: new PreferreSizeWidget((v) {
        productBloc.getProduct(v);
      }),
      leading: new IconButton(
        icon: UIData.back,
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
        padding: new EdgeInsets.fromLTRB(16.0, 7, 15.0, 8),
        child: new Center(
          child: Container(
            alignment: Alignment.center,
            width: 60,
            height: 28,
            child: new Text(
              '搜索',
              style: TextStyle(color: Colors.white),
            ),
            decoration: UIData.buildBoxDecoration(UIData.fffa4848, 14),
          ),
        ),
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
              suffixIcon: new IconButton(
                color: UIData.ffcccccc,
                icon: Icon(Icons.close),
                onPressed: () {
                  _searchQuery.clear();
                },
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
        setState(() {
          productBloc.getProduct(true);
        });
      }
    });
  }
}
