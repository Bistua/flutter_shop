import 'package:flutter/material.dart';
import 'package:flutter_lib/logic/bloc/product_bloc.dart';
import 'package:flutter_lib/logic/viewmodel/tab_view_model.dart';
import 'package:flutter_lib/model/productitem.dart';
import 'package:flutter_lib/ui/page/shop/shop_detail.dart';
import 'package:flutter_lib/ui/widgets/empty_widget.dart';
import 'package:flutter_lib/ui/widgets/shop_tab_item.dart';
import 'package:flutter_lib/utils/uidata.dart';

class SearchShopListPage extends StatefulWidget {
  @override
  SearchShopListState createState() => SearchShopListState();
}

class SearchShopListState extends State<SearchShopListPage> {
  ProductBloc productBloc = ProductBloc();
  Widget appBarTitle;
  bool showHistory = true;
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

  var chips = [];

  Widget bodyData() {
    print(productBloc.productItems);
    return StreamBuilder<List<ProductItem>>(
        stream: productBloc.productItems,
        builder: (context, snapshot) {
          if (showHistory) {
            if (chips.isEmpty) {
              return EmptyWidget("无数据", () {});
            } else {
              return buildWrapChips();
            }
          } else {
            return snapshot.hasData
                ? productGrid(snapshot.data)
                : Center(child: CircularProgressIndicator());
          }
        });
  }

  Column buildWrapChips() {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 16, 16, 11),
              child: Text(
                "搜索记录",
                style: TextStyle(fontSize: 12, color: UIData.ff353535),
              ),
            ),
            GestureDetector(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 16, 16, 11),
                child: Text(
                  "清空搜索记录",
                  style: TextStyle(fontSize: 12, color: UIData.ff999999),
                ),
              ),
              onTap: () {
                setState(() {
                  chips.clear();
                });
              },
            ),
          ],
        ),
        Wrap(
          children: chips.map((chip) {
            return GestureDetector(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 5, 10, 5),
                child: Chip(
                  backgroundColor: UIData.fff6f6f6,
                  label: Text(
                    chip,
                    style: TextStyle(fontSize: 12, color: UIData.ff666666),
                  ),
                ),
              ),
              onTap: () {
                setState(() {
                  _searchQuery.text = chip;
                  chips.add(_searchQuery.text);
                  _doSearch();
                });
              },
            );
          }).toList(),
          alignment: WrapAlignment.start,
        )
      ],
    );
  }

  Widget productGrid(List<ProductItem> data) {
    return new Padding(
      padding: EdgeInsets.all(10),
      child: new GridView.builder(
          itemCount: data.length,
          gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: (0.7), //item长宽比
            mainAxisSpacing: 10.0,
            crossAxisSpacing: 10.0,
          ),
          itemBuilder: (BuildContext context, int index) {
            ProductItem productItem = data[index];
            String imgUrl;
            if (productItem.medias.isNotEmpty) {
              imgUrl = productItem.medias[0].url;
            }
            return new GestureDetector(
              child: new Card(
                elevation: 5.0,
                child: new Container(
                  alignment: Alignment.bottomLeft,
                  child: new Stack(
                    children: <Widget>[
                      Positioned(
                        top: 0,
                        left: 0,
                        right: 0,
                        child: UIData.getImage(
                          imgUrl,
                        ),
                      ),
                      Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: new Container(
                            color: Colors.white,
                            child: new Column(
                              children: <Widget>[
                                new Padding(
                                  padding: EdgeInsets.fromLTRB(12, 12, 12, 6),
                                  child: new Text(
                                    data[index].name,
                                    style: TextStyle(
                                        fontSize: 12, color: UIData.ff353535),
                                  ),
                                ),
                                new Padding(
                                  padding: EdgeInsets.fromLTRB(0, 6, 0, 12),
                                  child: new Text(
                                    productItem.price.toString(),
                                    style: TextStyle(
                                        color: Colors.red, fontSize: 16),
                                  ),
                                ),
                              ],
                            ),
                          )),
                    ],
                  ),
                ),
              ),
              onTap: () {
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) =>
                            new ShopDetailPage(productItem.id)));
              },
            );
          }),
    );
  }

  AppBar buildSearchAppBar(BuildContext context) {
    TabViewModel tabViewModel = TabViewModel();
    tabViewModel.getMenuItems();
    return new AppBar(
      centerTitle: false,
      title: buildTextField(),
      bottom: new PreferreSizeWidget((v) {
        productBloc.queryProducts(_searchQuery.text, v);
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
    _searchQuery.addListener(() {
      _doSearch();
    });
    return new GestureDetector(
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
      onTap: () {
        chips.add(_searchQuery.text);
        _doSearch();
      },
    );
  }

  Widget buildTextField() {
    return Center(
      child: Stack(
        children: <Widget>[
          Center(
            child: Container(
              alignment: Alignment.center,
              height: 30.0,
              decoration: BoxDecoration(
                border: Border.all(color: Color(0xFFF5F5F5), width: 15.0),
                borderRadius: new BorderRadius.all(new Radius.circular(15.0)),
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
              child: TextField(
                maxLines: 1,
                controller: _searchQuery,
                cursorColor: Colors.transparent,
                style: new TextStyle(color: UIData.ff353535, fontSize: 12),
                decoration: new InputDecoration(
                    focusedBorder: null,
                    errorBorder: null,
                    disabledBorder: null,
                    focusedErrorBorder: null,
                    border: null,
                    fillColor: Color(0xfff5f5f5),
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
          )
        ],
      ),
    );
  }

  void _doSearch() {
    if (_searchQuery.text.isEmpty) {
      setState(() {
        showHistory = true;
        print("showHistory:" + showHistory.toString());
      });
    } else {
      productBloc.queryProducts(_searchQuery.text, true);
      setState(() {
        showHistory = false;
        print("showHistory:" + showHistory.toString());
      });
    }
  }
}
