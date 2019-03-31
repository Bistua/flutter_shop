import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_lib/logic/viewmodel/shop_cart_manager.dart';
import 'package:flutter_lib/ui/page/order/shop_order.dart';
import 'package:flutter_lib/utils/uidata.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ShopCartListPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ShopCartListState();
  }
}

class _ShopCartListState extends State<ShopCartListPage> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      statusBarColor: UIData.fffa4848, //or set color with: Color(0xFF0000FF)
    ));

    return Scaffold(
      appBar: new AppBar(
        backgroundColor: UIData.fffa4848,
        centerTitle: false,
        title: Text(
          "购物车",
          style: TextStyle(color: UIData.fff, fontSize: 18),
        ),
        elevation: 0,
        leading: new IconButton(
          icon: Icon(Icons.arrow_back_ios, color: UIData.fff),
          color: UIData.fff,
          onPressed: () => Navigator.pop(context, false),
        ),
      ),
      body: buildBody(),
    );
  }

  Container buildBody() {
    return Container(
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 45,
              color: UIData.fffa4848,
              child: Text("."),
            ),
          ),
          Positioned(
            top: 0,
            bottom: 50,
            left: 10,
            right: 10,
            child: buildListView(),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 50,
              child: Row(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Checkbox(
                        activeColor: UIData.fffa4848,
                        value: ShopCartManager.instance.isAllChecked(),
                        onChanged: (bool value) {
                          setState(() {
                            ShopCartManager.instance.products.forEach((f) {
                              f.isChecked = value;
                            });
                          });
                        },
                      ),
                      Text(
                        "全选",
                        style: TextStyle(color: UIData.ff353535, fontSize: 15),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Padding(
                            child: Text(
                              "￥" +
                                  ShopCartManager.instance
                                      .getTotalPrice()
                                      .toStringAsFixed(2),
                              style: TextStyle(
                                  color: UIData.fffa4848, fontSize: 18),
                            ),
                            padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 15, 0),
                    child: UIData.getShapeButton(
                        UIData.fffa4848, UIData.fff, 90, 33, "提交订单", 15, 17,
                        () {
                      print("ontap");
                      if (ShopCartManager.instance
                          .getCheckedProducts()
                          .isEmpty) {
                        Fluttertoast.showToast(
                            msg: "请至少选择一个商品",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIos: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0
                        );
                        return;
                      }
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (context) => new ShopOrderListPage()));
                    }),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 50,
            left: 0,
            right: 0,
            child: Divider(),
          ),
        ],
      ),
    );
  }

  ListView buildListView() {
    return ListView.builder(
            itemCount: ShopCartManager.instance.products.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                child: Container(
                  child: Card(
                    color: UIData.fff,
                    child: Row(
                      children: <Widget>[
                        Checkbox(
                          activeColor: UIData.fffa4848,
                          value: ShopCartManager
                              .instance.products[index].isChecked,
                          onChanged: (bool value) {
                            setState(() {
                              print(value);
                              ShopCartManager
                                  .instance.products[index].isChecked = value;
                            });
                          },
                        ),
                        Image.network(
                          ShopCartManager.instance.products[index].image,
                          fit: BoxFit.cover,
                          width: 88,
                          height: 88,
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.fromLTRB(12, 18, 12, 8),
                                child: Text(
                                    ShopCartManager
                                        .instance.products[index].name,
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: UIData.ff353535)),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(12, 0, 13, 0),
                                child: Container(
                                    height: 18,
                                    width: 92,
                                    decoration: BoxDecoration(
                                        color: UIData.fff7f7f7,
                                        shape: BoxShape.rectangle,
                                        borderRadius:
                                            BorderRadius.circular(3)),
                                    child: Center(
                                      child: UIData.getTextWidget(
                                          ShopCartManager
                                              .instance.products[index].name,
                                          UIData.ff999999,
                                          11),
                                    )),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(15, 6, 15, 17),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: <Widget>[
                                    Expanded(
                                      child: Text(
                                        "￥" +
                                            ShopCartManager.instance
                                                .products[index].priceNum
                                                .toStringAsFixed(2),
                                        style: TextStyle(
                                            color: UIData.fffa4848,
                                            fontSize: 15),
                                      ),
                                    ),
                                    GestureDetector(
                                      child: Container(
                                        width: 20,
                                        height: 20,
                                        child: Center(
                                          child: UIData.getTextWidget(
                                              "-", UIData.ff999999, 11),
                                        ),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: UIData.fff7f7f7,
                                              width: 1.0),
                                          shape: BoxShape.rectangle,
                                        ),
                                      ),
                                      onTap: () {
                                        setState(() {
                                          ShopCartManager.instance.remove(
                                              ShopCartManager
                                                  .instance.products[index]);
                                        });
                                      },
                                    ),
                                    Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(3, 0, 3, 0),
                                      child: Container(
                                        width: 50,
                                        height: 20,
                                        child: Center(
                                          child: UIData.getTextWidget(
                                              ShopCartManager.instance
                                                  .products[index].count
                                                  .toString(),
                                              UIData.ff999999,
                                              11),
                                        ),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: UIData.fff7f7f7,
                                              width: 1.0),
                                          shape: BoxShape.rectangle,
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      child: Container(
                                        width: 20,
                                        height: 20,
                                        child: Center(
                                          child: UIData.getTextWidget(
                                              "+", UIData.ff999999, 11),
                                        ),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: UIData.fff7f7f7,
                                              width: 1.0),
                                          shape: BoxShape.rectangle,
                                        ),
                                      ),
                                      onTap: () {
                                        setState(() {
                                          ShopCartManager.instance.addProduct(
                                              ShopCartManager
                                                  .instance.products[index]);
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                onTap: () {},
              );
            },
          );
  }
}
