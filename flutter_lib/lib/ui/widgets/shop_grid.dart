import 'package:flutter/material.dart';
import 'package:flutter_lib/model/product.dart';
import 'package:flutter_lib/ui/page/shop/shop_detail.dart';
import 'package:flutter_lib/utils/uidata.dart';

class ShopGridPage extends StatefulWidget {
  List<Product> productList;

  ShopGridPage(List<Product> data) {
    this.productList = data;
  }

  @override
  ProductGridState createState() => ProductGridState(productList);
}

class ProductGridState extends State<ShopGridPage> {
  List<Product> productList;

  ProductGridState(List<Product> productList) {
    this.productList = productList;
  }
  @override
  Widget build(BuildContext context) {
    return buildContainer();
  }

  Widget buildContainer() {
    return productGrid(this.productList);
  }

  Widget productGrid(List<Product> data) {
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
            return new GestureDetector(
              child: new Card(
                elevation: 5.0,
                child: new Container(
                  alignment: Alignment.center,
                  child: new Column(
                    children: <Widget>[
                      new Stack(
                        children: <Widget>[
                          Image.network(
                            data[index].image,
                            fit: BoxFit.contain,
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
                                        data[index].price,
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
                        builder: (context) => new ShopDetailPage(data[index])));
              },
            );
          }),
    );
  }
}
