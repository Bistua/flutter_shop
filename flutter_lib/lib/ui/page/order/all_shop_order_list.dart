import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_lib/bridge/common_bridge.dart';
import 'package:flutter_lib/bridge/order_bridge.dart';
import 'package:flutter_lib/bridge/pay_bridge.dart';
import 'package:flutter_lib/logic/bloc/oder_list_bloc.dart';
import 'package:flutter_lib/logic/viewmodel/order_view_model.dart';
import 'package:flutter_lib/model/OrderComment.dart';
import 'package:flutter_lib/model/Result.dart';
import 'package:flutter_lib/model/orderListItem.dart';
import 'package:flutter_lib/model/product.dart';
import 'package:flutter_lib/utils/uidata.dart';

class AllShopOrderPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ShopCartListState();
  }
}

class TagOrderPage extends StatefulWidget {
  int type;
  TagOrderPage(int i) {
    this.type = i;
  }

  @override
  State<StatefulWidget> createState() {
    return TagState();
  }
}

class TagState extends State<TagOrderPage> {
  OrderListBloc orderListBloc = OrderListBloc();

  @override
  Widget build(BuildContext context) {
    return getOrderList(widget.type);
  }

  Widget getOrderList(int type) {
//    todo type
    orderListBloc.getOrderListList(type);
    return StreamBuilder<List<OrderItem>>(
        stream: orderListBloc.productItems,
        builder: (context, snapshot) {
          List<OrderItem> list = snapshot.data;
          return snapshot.hasData
              ? ((list == null || list.isEmpty)
                  ? empty(type)
                  : buildListView(type, list))
              : Center(child: CircularProgressIndicator());
        });
  }

  Widget empty(int type) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: GestureDetector(
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Text("无数据,点击重试"),
          ),
          onTap: () {
            orderListBloc.getOrderListList(type);
          },
        ),
      ),
    );
  }

  Widget buildListView(int type, List<OrderItem> orders) {
    return ListView.builder(
      itemCount: orders == null ? 0 : orders.length,
      itemBuilder: (context, index) {
        return buildOrderItem(orders, index, type);
      },
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

  GestureDetector buildOrderItem(List<OrderItem> orders, int index, int type) {
    OrderItem orderItem = orders[index];
    List<Good> prducts = orderItem.products;
    String status = "无状态";

//    1:待付款，2:待发货，3:待收货，4:待评价,0:全部
    switch (orderItem.status) {
      case 1:
        status = "已取消";
        break;
      case 2:
        status = "待发货";
        break;
      case 3:
        status = "待收货";
        break;
      case 4:
        status = "待评价";
        break;
      default:
        status = "已取消";
        break;
    }

    return GestureDetector(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "订单号：" + orderItem.orderNumber,
                        style: TextStyle(color: UIData.ff353535, fontSize: 14),
                      ),
                      Text(
                        status,
                        style: TextStyle(color: UIData.fffa4848, fontSize: 14),
                      ),
                    ],
                  ),
                  Divider(),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      return buildListIItem(prducts[index]);
                    },
                    itemCount: prducts.length,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        "共" +
                            prducts.length.toString() +
                            "商品，总价：" +
                            orderItem.payPrice.toString(),
                        style: TextStyle(color: UIData.ff353535, fontSize: 14),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
                    child: getActionBtn(orderItem, type),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      onTap: () {
        Navigator.pushNamed(context, UIData.OrderDetailPage);
      },
    );
  }

  GestureDetector buildListIItem(Good product) {
    String img = product.goodsImgUrl;
    String price = product.goodsPrice;
    String count = product.buyNum;
    return GestureDetector(
      child: Container(
        child: Row(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(16, 15, 0, 16),
              child: UIData.getImageWithWHFit(
                img,
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
                    child: Text(product.goodsName,
                        style: TextStyle(fontSize: 12, color: UIData.ff353535)),
                  ),
//规格信息未下发 这里删掉
//                  Padding(
//                    padding: EdgeInsets.fromLTRB(12, 0, 13, 0),
//                    child: Container(
//                        height: 18,
//                        width: 92,
//                        decoration: BoxDecoration(
//                            color: UIData.fff7f7f7,
//                            shape: BoxShape.rectangle,
//                            borderRadius: BorderRadius.circular(3)),
//                        child: Center(
//                          child: UIData.getTextWidget(
//                              description, UIData.ff999999, 11),
//                        )),
//                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(15, 6, 15, 17),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            "￥" + price,
                            style:
                                TextStyle(color: UIData.fffa4848, fontSize: 15),
                          ),
                        ),
                        Container(
                          width: 20,
                          height: 20,
                          child: Center(
                            child: UIData.getTextWidget(
                                "x" + count.toString(), UIData.ff999999, 11),
                          ),
                          decoration: BoxDecoration(
                            border:
                                Border.all(color: UIData.fff7f7f7, width: 1.0),
                            shape: BoxShape.rectangle,
                          ),
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
      onTap: () {
        Navigator.pushNamed(context, UIData.ShopDetailPage,
            arguments: product.goodsId);
      },
    );
  }

  Widget getActionBtn(OrderItem orderItem, int type) {
    //    1:待付款，2:待发货，3:待收货，4:待评价,0:全部
    switch (orderItem.status) {
      case 2:
        return Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
              child: Container(
                child: GestureDetector(
                    onTap: () {
                      Future<Result> future =
                          OrderBridge.cancelOrder(orderItem.orderNumber);
                      future.then((r) {
                        if (r.code == 200) {
                          Bridge.showLongToast("取消成功");
                          orderListBloc.getOrderListList(type);
                        } else {
                          Bridge.showLongToast(r.msg);
                        }
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                      child: Text(
                        "取消订单",
                        style: TextStyle(color: UIData.ff353535, fontSize: 13),
                      ),
                    )),
                decoration: BoxDecoration(
                  border: Border.all(color: UIData.ff353535, width: 1),
                  borderRadius: BorderRadius.circular(13.0),
                ),
              ),
            ),
          ],
        );
      case 3:
        return Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
              child: Container(
                child: GestureDetector(
                    onTap: () {
                      Bridge.webview("http://www.baidu.com");
                    },
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                      child: Text(
                        "查看物流",
                        style: TextStyle(color: UIData.ff353535, fontSize: 13),
                      ),
                    )),
                decoration: BoxDecoration(
                  border: Border.all(color: UIData.ff353535, width: 1),
                  borderRadius: BorderRadius.circular(13.0),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
              child: Container(
                child: GestureDetector(
                    onTap: () {
                      Future<Result> future =
                          OrderBridge.confirmOrder(orderItem.orderNumber);
                      future.then((r) {
                        if (r.code == 200) {
                          Bridge.showLongToast("已确认收货");
                          orderListBloc.getOrderListList(type);
                        } else {
                          Bridge.showLongToast(r.msg);
                        }
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                      child: Text(
                        "确认收货",
                        style: TextStyle(color: UIData.fffa4848, fontSize: 13),
                      ),
                    )),
                decoration: BoxDecoration(
                  border: Border.all(color: UIData.fffa4848, width: 1),
                  borderRadius: BorderRadius.circular(13.0),
                ),
              ),
            ),
          ],
        );
        break;
      case 4:
        return Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
//            Padding(
//              padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
//              child: Container(
//                child: GestureDetector(
//                    onTap: () {},
//                    child: Padding(
//                      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
//                      child: Text(
//                        "退换货",
//                        style: TextStyle(color: UIData.ff353535, fontSize: 13),
//                      ),
//                    )),
//                decoration: BoxDecoration(
//                  border: Border.all(color: UIData.ff353535, width: 1),
//                  borderRadius: BorderRadius.circular(13.0),
//                ),
//              ),
//            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
              child: Container(
                child: GestureDetector(
                    onTap: () {
                      var goods = orderItem.products.map((f) {
                        return Goods(f.goodsId, "", "");
                      }).toList();
                      var orderComment =
                          OrderComment(orderItem.orderNumber, goods);
                      Navigator.pushNamed(context, UIData.OrderCommentPage,
                          arguments: orderComment);
                    },
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                      child: Text(
                        "评价",
                        style: TextStyle(color: UIData.fffa4848, fontSize: 13),
                      ),
                    )),
                decoration: BoxDecoration(
                  border: Border.all(color: UIData.fffa4848, width: 1),
                  borderRadius: BorderRadius.circular(13.0),
                ),
              ),
            ),
          ],
        );
      default:
        return Text("");
    }
  }
}

class _ShopCartListState extends State<AllShopOrderPage> {
  OrderListBloc orderListBloc = OrderListBloc();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      statusBarColor: UIData.fffa4848, //or set color with: Color(0xFF0000FF)
    ));

    return DefaultTabController(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: UIData.fff,
          centerTitle: true,
          title: Text(
            "我的订单",
            style: TextStyle(
                color: UIData.ff353535,
                fontSize: 18,
                fontWeight: FontWeight.bold),
          ),
          elevation: 0,
          leading: new IconButton(
            icon: Icon(Icons.arrow_back_ios, color: UIData.ff353535),
            color: UIData.fff,
            onPressed: () => Navigator.pop(context, false),
          ),
          bottom: TabBar(
            indicatorColor: UIData.fffa4848,
            labelColor: UIData.fffa4848,
            unselectedLabelColor: UIData.ff666666,
            tabs: <Widget>[
              // No of Tab() Widgets Should be equal to length
              Tab(
                child: Container(
                  color: UIData.fff,
                  child: Text(
                    "全部",
                    style: TextStyle(color: UIData.ff666666, fontSize: 14),
                  ),
                ),
              ),
              Tab(
                child: Container(
                  color: UIData.fff,
                  child: Text(
                    "待发货",
                    style: TextStyle(color: UIData.ff666666, fontSize: 14),
                  ),
                ),
              ),
              Tab(
                child: Container(
                  color: UIData.fff,
                  child: Text(
                    "待评价",
                    style: TextStyle(color: UIData.ff666666, fontSize: 14),
                  ),
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            //    1:待付款，2:待发货，3:待收货，4:待评价,0:全部
            Container(child: TagOrderPage(0)),
            Container(child: TagOrderPage(2)),
            Container(child: TagOrderPage(4)),
          ],
        ),
      ),
      length: 3,
    );
  }
}
