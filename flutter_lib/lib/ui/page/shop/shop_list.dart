import 'package:flutter/material.dart';
import 'package:flutter_lib/logic/bloc/product_bloc.dart';
import 'package:flutter_lib/model/Result.dart';
import 'package:flutter_lib/model/productitem.dart';
import 'package:flutter_lib/ui/page/shop/shop_detail.dart';
import 'package:flutter_lib/ui/widgets/error_status_widget.dart';
import 'package:flutter_lib/ui/widgets/shop_tab_item.dart';
import 'package:flutter_lib/utils/uidata.dart';

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
    print("ShopListPage build");
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
          if (snapshot.hasData) {
            if (snapshot.data.isEmpty) {
              return ErrorStatusWidget.order(0, "暂无数据", "点击重试", () {
                productBloc.getProducts(widget.categoryId, true);
              });
            } else {
              return productGrid(snapshot.data);
            }
          } else if (snapshot.hasError) {
            Result result = snapshot.error;
            return ErrorStatusWidget.order(result.code, result.msg, "点击重试",
                () {
              productBloc.getProducts(widget.categoryId, true);
            });
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
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
}
