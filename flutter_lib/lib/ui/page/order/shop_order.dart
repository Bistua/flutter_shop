import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_lib/bridge/common_bridge.dart';
import 'package:flutter_lib/bridge/order_bridge.dart';
import 'package:flutter_lib/bridge/pay_bridge.dart';
import 'package:flutter_lib/logic/bloc/cart_bloc.dart';
import 'package:flutter_lib/logic/viewmodel/deliver_address_manager.dart';
import 'package:flutter_lib/model/Result.dart';
import 'package:flutter_lib/model/address.dart';
import 'package:flutter_lib/model/cart.dart';
import 'package:flutter_lib/model/order_result.dart';
import 'package:flutter_lib/model/ordergoods.dart';
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
  CartBloc cartBloc = CartBloc();

  String userAddressId = "123123";

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
      body: bodyData(),
    );
  }

  Widget bodyData() {
    cartBloc.findCart();
    return StreamBuilder<Cart>(
        stream: cartBloc.productItems,
        builder: (context, snapshot) {
          Cart cart = snapshot.data;
          return snapshot.hasData
              ? (cart == null ? empty() : buildBody(cart))
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
            cartBloc.findCart();
          },
        ),
      ),
    );
  }

  Container buildBody(Cart cart) {
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
                    (context, index) => buildListIItem(cart.products[index]),
                    childCount: cart.products.length,
                  ),
                ),
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      buildDeliverPrive(cart),
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
                              "￥" + cart.totalMoney.toStringAsFixed(2),
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
                      List<OrderGoods> orderGoodses = cart.products
                          .map((sku) => new OrderGoods(
                              sku.skuId, sku.sku.amount.toString()))
                          .toList();
                      Future<Result> future = OrderBridge.submitOrder(
                          userAddressId, true, orderGoodses);
                      future.then((result) {
                        if (result.code == 200) {
                          if (result.data == null) {
                            Bridge.showLongToast("订单号获取失败");
                            return;
                          }
                          showPayDialog(
                              context, cart, OrderResult.fromJson(result.data));
                        } else {
                          Bridge.showLongToast(result.msg);
                        }
                      });
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

  showPayDialog(BuildContext context, Cart cart, OrderResult orderResult) {
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
                      Center(
                          child: Text("确认付款",
                              style: TextStyle(
                                  color: UIData.ff33333, fontSize: 18))),
                      Divider(),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 46, 0, 59),
                        child: Text(
                          "￥" + cart.totalMoney.toStringAsFixed(2),
                          style:
                              TextStyle(color: UIData.ff353535, fontSize: 33),
                        ),
                      ),
                      Divider(),
                      Padding(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Text(
                              "订单信息",
                              style: TextStyle(
                                  color: UIData.ff666666, fontSize: 15),
                            ),
                            Text(
                              "商品组合",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 15),
                            )
                          ],
                        ),
                        padding: EdgeInsets.fromLTRB(14, 14, 14, 14),
                      ),
                      Divider(),
                      Padding(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              "付款方式",
                              style: TextStyle(
                                  color: UIData.ff666666, fontSize: 15),
                            ),
                            Text(
                              "支付宝",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 15),
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
                          //"1555746236014000",
                          //"商品描述",
                          goToPay(
                              context,
                              orderResult.tradeOrderId,
                              "123.12.12.123",
                              orderResult.goodsDesc,
                              "附加数据，在查询API和支付通知中原样返回，该字段主要用于商户携带订单的自定义数据");
                        },
                      )
                    ],
                  ),
                ),
              ),
            ));
  }

  GestureDetector buildListIItem(SkuWapper sku) {
    CartProduct cartProduct = sku.sku;
    return GestureDetector(
      child: Container(
        child: Card(
          color: UIData.fff,
          child: Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(16, 15, 0, 16),
                child: UIData.getImageWithWHFit(
                  cartProduct.img,
                  BoxFit.cover,
                  88,
                  88,
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
                      child: Text(cartProduct.name,
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
                                cartProduct.name, UIData.ff999999, 11),
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
                              "￥" + cartProduct.price.toStringAsFixed(2),
                              style: TextStyle(
                                  color: UIData.fffa4848, fontSize: 15),
                            ),
                          ),
//                          GestureDetector(
//                            child: Container(
//                              width: 20,
//                              height: 20,
//                              child: Center(
//                                child: UIData.getTextWidget(
//                                    "-", UIData.ff999999, 11),
//                              ),
//                              decoration: BoxDecoration(
//                                border: Border.all(
//                                    color: UIData.fff7f7f7, width: 1.0),
//                                shape: BoxShape.rectangle,
//                              ),
//                            ),
//                            onTap: () {
//                              cartBloc.del2Cart(sku, 1);
//                            },
//                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(3, 0, 3, 0),
                            child: UIData.getTextWidget(
                                cartProduct.amount.toString(),
                                UIData.ff999999,
                                11),
                          ),
//                          GestureDetector(
//                            child: Container(
//                              width: 20,
//                              height: 20,
//                              child: Center(
//                                child: UIData.getTextWidget(
//                                    "+", UIData.ff999999, 11),
//                              ),
//                              decoration: BoxDecoration(
//                                border: Border.all(
//                                    color: UIData.fff7f7f7, width: 1.0),
//                                shape: BoxShape.rectangle,
//                              ),
//                            ),
//                            onTap: () {
//                              cartBloc.addSkuAmount(sku, 1);
//                            },
//                          ),
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

  Widget buildDeliverPrive(Cart cart) {
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
                      "￥" + cart.totalMoney.toStringAsFixed(2),
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

  goToPay(BuildContext context, String tradeOrderId, String spbillCreateIp,
      String goodsDesc, String attach) async {
    Future<Result> future =
        PayBridge.wxPay(tradeOrderId, spbillCreateIp, goodsDesc, attach);
    future.then((v) {
      if (v.code == 200) {
        Navigator.pop(context, false);
      } else {
        Bridge.showShortToast(v.msg);
      }
    });
  }
}
