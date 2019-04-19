import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_lib/logic/viewmodel/deliver_address_manager.dart';
import 'package:flutter_lib/logic/viewmodel/shop_cart_manager.dart';
import 'package:flutter_lib/model/address.dart';
import 'package:flutter_lib/ui/page/address/add_edit_address.dart';
import 'package:flutter_lib/ui/page/address/address_list.dart';
import 'package:flutter_lib/utils/uidata.dart';

class ShopOrderListPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ShopOrderListState();
  }
}

class _ShopOrderListState extends State<ShopOrderListPage> {
  double get deliverPrice => 10;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      statusBarColor: UIData.fffa4848, //or set color with: Color(0xFF0000FF)
    ));

    return Scaffold(
      appBar: new AppBar(
        centerTitle: true,
        title: Text(
          "提交订单",
          style: TextStyle(color: UIData.ff353535, fontSize: 18),
        ),
        elevation: 0,
        leading: new IconButton(
          icon: Icon(Icons.arrow_back_ios, color: UIData.ff353535),
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
            bottom: 50,
            left: 10,
            right: 10,
            child: CustomScrollView(
              slivers: <Widget>[
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      buildHeader(),
                    ],
                  ),
                ),
                SliverFixedExtentList(
                  itemExtent: 111,
                  delegate: SliverChildBuilderDelegate(
                    (context, index) => buildListIItem(index),
                    childCount:
                        ShopCartManager.instance.getCheckedProducts().length,
                  ),
                ),
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      buildDeliverPrive(),
                    ],
                  ),
                ),
              ],
            ),
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
                      Padding(
                        child: Text(
                          "合计",
                          style:
                              TextStyle(color: UIData.ff353535, fontSize: 15),
                        ),
                        padding: EdgeInsets.fromLTRB(13, 13, 8, 13),
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
                                  (deliverPrice +
                                          ShopCartManager.instance
                                              .getTotalPrice())
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
                        UIData.fffa4848, UIData.fff, 90, 33, "提交订单", 15, 0, () {
                      showPayDialog(context);
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


  showPayDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => Center(
          child: Material(
            borderRadius: BorderRadius.circular(8.0),
            color: Colors.white,
            elevation: 5.0,
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Center(child: Text("确认付款")),
                  Text(
                    "￥" +
                        (deliverPrice + ShopCartManager.instance.getTotalPrice())
                            .toStringAsFixed(2),
                    style: TextStyle(color: UIData.ff353535, fontSize: 33),
                  ),
                  Divider(),
                  Padding(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Text(
                          "订单信息",
                          style: TextStyle(color: UIData.ff666666, fontSize: 15),
                        ),
                        Text(
                          "商品组合",
                          style: TextStyle(color: Colors.black, fontSize: 15),
                        )
                      ],
                    ),
                    padding: EdgeInsets.fromLTRB(14, 14, 14, 14),
                  ),
                  Divider(),
                  Padding(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Text(
                          "付款方式",
                          style: TextStyle(color: UIData.ff666666, fontSize: 15),
                        ),
                        Text(
                          "支付宝",
                          style: TextStyle(color: Colors.black, fontSize: 15),
                        )
                      ],
                    ),
                    padding: EdgeInsets.fromLTRB(14, 14, 14, 14),
                  ),
                  Divider(),
                  UIData.getShapeButton(
                    UIData.fffa4848,
                    UIData.fff,
                    345,
                    45,
                    "立即付款",
                    18,
                    5,
                        () {
                      goToPay();
                    },
                  )
                ],
              ),
            ),
          ),
        ));
  }


  GestureDetector buildListIItem(int index) {
    return GestureDetector(
      child: Container(
        child: Card(
          color: UIData.fff,
          child: Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(16, 15, 0, 16),
                child: Image.network(
                  ShopCartManager.instance.getCheckedProducts()[index].image,
                  fit: BoxFit.cover,
                  width: 88,
                  height: 88,
                ),
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
                          ShopCartManager.instance
                              .getCheckedProducts()[index]
                              .name,
                          style:
                              TextStyle(fontSize: 12, color: UIData.ff353535)),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(12, 0, 13, 0),
                      child: Container(
                          height: 18,
                          width: 92,
                          decoration: BoxDecoration(
                              color: UIData.fff7f7f7,
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(3)),
                          child: Center(
                            child: UIData.getTextWidget(
                                ShopCartManager.instance
                                    .getCheckedProducts()[index]
                                    .name,
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
                                      .getCheckedProducts()[index]
                                      .priceNum
                                      .toStringAsFixed(2),
                              style: TextStyle(
                                  color: UIData.fffa4848, fontSize: 15),
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
                                    color: UIData.fff7f7f7, width: 1.0),
                                shape: BoxShape.rectangle,
                              ),
                            ),
                            onTap: () {
                              setState(() {
                                ShopCartManager.instance.remove(ShopCartManager
                                    .instance
                                    .getCheckedProducts()[index]);
                              });
                            },
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(3, 0, 3, 0),
                            child: Container(
                              width: 50,
                              height: 20,
                              child: Center(
                                child: UIData.getTextWidget(
                                    ShopCartManager.instance
                                        .getCheckedProducts()[index]
                                        .count
                                        .toString(),
                                    UIData.ff999999,
                                    11),
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: UIData.fff7f7f7, width: 1.0),
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
                                    color: UIData.fff7f7f7, width: 1.0),
                                shape: BoxShape.rectangle,
                              ),
                            ),
                            onTap: () {
                              setState(() {
                                ShopCartManager.instance.addProduct(
                                    ShopCartManager.instance
                                        .getCheckedProducts()[index]);
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
  }

  Widget buildHeader() {
    Address address = AddressManager.instance.getDefaultAddress();

    return GestureDetector(
      child: Card(
        child: Padding(
          padding: EdgeInsets.fromLTRB(10, 15, 10, 15),
          child: address == null
              ? Text(
                  "添加地址",
                  style: TextStyle(color: UIData.ff353535, fontSize: 13),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Icon(
                      Icons.my_location,
                      color: UIData.fffa4848,
                    ),
                    Expanded(
                        child: Padding(
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            address.name + address.phone,
                            style:
                                TextStyle(color: UIData.ff353535, fontSize: 13),
                          ),
                          Text(
                            address.area + address.address,
                            style:
                                TextStyle(color: UIData.ff999999, fontSize: 12),
                          ),
                        ],
                      ),
                    )),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: UIData.ff999999,
                    ),
                  ],
                ),
        ),
      ),
      onTap: () {
        if (address == null) {
          Navigator.push(
              context,
              new MaterialPageRoute(
                  builder: (context) => new AddAddressListPage(null)));
        } else {
          Navigator.push(
              context,
              new MaterialPageRoute(
                  builder: (context) => new AddressListPage()));
        }
      },
    );
  }

  Widget buildDeliverPrive() {
    return GestureDetector(
      child: Card(
        child: Padding(
          padding: EdgeInsets.fromLTRB(10, 15, 10, 15),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(13, 13, 10, 10),
                    child: Text(
                      "商品小计",
                      style: TextStyle(color: UIData.ff353535, fontSize: 12),
                    ),
                  ),
                  Padding(
                    child: Text(
                      "￥" +
                          ShopCartManager.instance
                              .getTotalPrice()
                              .toStringAsFixed(2),
                      style: TextStyle(color: UIData.fffa4848, fontSize: 18),
                    ),
                    padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                  ),
                ],
              ),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(13, 13, 10, 10),
                    child: Text(
                      "运费",
                      style: TextStyle(color: UIData.ff353535, fontSize: 12),
                    ),
                  ),
                  Padding(
                    child: Text(
                      "￥" + deliverPrice.toStringAsFixed(2),
                      style: TextStyle(color: UIData.fffa4848, fontSize: 18),
                    ),
                    padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void goToPay() {}
}
