import 'package:flutter/material.dart';
import 'package:flutter_lib/logic/bloc/product_bloc.dart';
import 'package:flutter_lib/logic/viewmodel/tab_view_model.dart';
import 'package:flutter_lib/model/Result.dart';
import 'package:flutter_lib/model/productitem.dart';
import 'package:flutter_lib/ui/page/shop/shop_detail.dart';
import 'package:flutter_lib/ui/widgets/empty_widget.dart';
import 'package:flutter_lib/ui/widgets/error_status_widget.dart';
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
              return Container(
                width: 0,
                height: 0,
              );
            } else {
              return buildWrapChips();
            }
          } else {
            if (snapshot.hasError) {
              Result result = snapshot.error;
              return ErrorStatusWidget.search(result.code, result.msg, null);
            } else if (snapshot.hasData) {
              if (snapshot.data == null || snapshot.data.isEmpty) {
                return ErrorStatusWidget.search(0, "暂无搜索结果\n换个搜索词试试", null);
              } else {
                return productGrid(snapshot.data);
              }
            } else {
              return Center(child: CircularProgressIndicator());
            }
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
            ProductItem product = data[index];
            String imgUrl;
            if (product.medias.isNotEmpty) {
              imgUrl = product.medias[0].url;
            }
            return new GestureDetector(
              child: new Card(
                elevation: 5.0,
                child: new Container(
                  child: new Stack(
                    children: <Widget>[
                      Positioned(
                        top: 0,
                        left: 0,
                        child: UIData.getImage(
                          imgUrl,
                        ),
                      ),
                      Positioned(
                          bottom: 8,
                          left: 10,
                          right: 10,
                          child: new Container(
                            width: 140,
                            color: Colors.white,
                            child: new Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                new Padding(
                                  padding: EdgeInsets.fromLTRB(5, 5, 5, 4),
                                  child: Container(
                                    width: 140,
                                    child: new Text(
                                      product.name,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: 12, color: UIData.ff353535),
                                    ),
                                  ),
                                ),
                                new Padding(
                                  padding: EdgeInsets.fromLTRB(5, 4, 5, 4),
                                  child: new Text(
                                    "￥" + product.price.toString(),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
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
                        builder: (context) => new ShopDetailPage(product.id)));
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
    return Stack(
      children: <Widget>[
        Center(
          child: Container(
            decoration: BoxDecoration(
              color: Color(0xFFF5F5F5),
              border: Border.all(color: Color(0xFFF5F5F5), width: 1),
              borderRadius: BorderRadius.circular(13.0),
            ),
            height: 30.0,
            child: new TextField(
              controller: _searchQuery,
              cursorColor: Colors.transparent,
              cursorWidth: 0,
              decoration: new InputDecoration(
                focusedBorder: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.transparent, width: 0)),
                hintText: "请输入搜索内容",
                fillColor: Colors.transparent,
                contentPadding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                hintStyle: new TextStyle(color: UIData.ffcccccc, fontSize: 12),
              ),
              maxLines: 1,
              textAlign: TextAlign.left,
            ),
            alignment: Alignment.centerLeft,
          ),
        ),
        Positioned(
          top: 0,
          bottom: 0,
          right: 1,
          child: new IconButton(
            color: UIData.ffcccccc,
            icon: Icon(Icons.close),
            onPressed: () {
              _searchQuery.clear();
            },
          ),
        ),
      ],
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
