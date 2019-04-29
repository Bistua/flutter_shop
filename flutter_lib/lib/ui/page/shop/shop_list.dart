import 'package:flutter/material.dart';
import 'package:flutter_lib/logic/bloc/product_bloc.dart';
import 'package:flutter_lib/model/product.dart';
import 'package:flutter_lib/model/productitem.dart';
import 'package:flutter_lib/ui/page/shop/shop_detail.dart';
import 'package:flutter_lib/ui/widgets/shop_tab_item.dart';
import 'package:flutter_lib/utils/uidata.dart';

class ShopList extends StatelessWidget {
  String title;
  int categoryId;
  ShopList(String title, int categoryId) {
    this.title = title;
    this.categoryId = categoryId;
  }

  @override
  Widget build(BuildContext context) {
    return ShopListPage(
      title: title,
      categoryId: categoryId,
    );
  }
}

//分页参考https://medium.com/saugo360/flutter-creating-a-listview-that-loads-one-page-at-a-time-c5c91b6fabd3
class ShopListPage extends StatefulWidget {
  ShopListPage({Key key, this.title, this.categoryId}) : super(key: key);
  final String title;
  final int categoryId;

  @override
  ShopListState createState() => ShopListState();
}

class ShopListState extends State<ShopListPage> {
  Widget appBarTitle;
  ProductBloc productBloc = ProductBloc();

  @override
  Widget build(BuildContext context) {

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: new AppBar(
          centerTitle: true,
          title: Text(widget.title),
          bottom: new PreferreSizeWidget((v) {
            print("点击回调：" + v.toString());
            productBloc.getProducts(widget.categoryId, v);
          }),
          leading: new IconButton(
            icon: UIData.back,
            onPressed: () => Navigator.pop(context, false),
          ),
        ),
        body: Container(
          child: bodyData(),
        ),
        // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }

  Widget bodyData() {
    productBloc.getProducts(widget.categoryId, true);
    return StreamBuilder<List<ProductItem>>(
        stream: productBloc.productItems,
        builder: (context, snapshot) {
          return snapshot.hasData
              ? (snapshot.data.isEmpty ? empty() : productGrid(snapshot.data))
              : Center(child: CircularProgressIndicator());
        });
  }

  Widget empty() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: GestureDetector(
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Text("无数据,点击重试"),
          ),
          onTap: () {
            productBloc.getProducts(widget.categoryId, true);
          },
        ),
      ),
    );
  }

  Widget productGrid(List<ProductItem> data) {
    return new Padding(
      padding: EdgeInsets.all(5),
      child: new GridView.builder(
          itemCount: data.length,
          gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: (0.7), //item长宽比
            mainAxisSpacing: 5.0,
            crossAxisSpacing: 5.0, // add some space
          ),
          itemBuilder: (BuildContext context, int index) {
            ProductItem productItem = data[index];
            return new GestureDetector(
              child: new Card(
                elevation: 5.0,
                child: new Container(
                  alignment: Alignment.center,
                  child: new Column(
                    children: <Widget>[
                      new Stack(
                        children: <Widget>[
                          UIData.getImage(
                            productItem.medias.alt1.url,
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
                                      padding: EdgeInsets.fromLTRB(0, 12, 0, 6),
                                      child: new Text(
                                        data[index].name,
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: UIData.ff353535),
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
}
