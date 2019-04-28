import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_lib/logic/bloc/oder_list_bloc.dart';
import 'package:flutter_lib/logic/viewmodel/order_view_model.dart';
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
  @override
  State<StatefulWidget> createState() {
    return TagState();
  }
}

class TagState extends State<TagOrderPage> {
  OrderListBloc orderListBloc = OrderListBloc();

  @override
  Widget build(BuildContext context) {
    return getOrderList(0);
  }

  Widget getOrderList(int type) {
//    todo type
    orderListBloc.getOrderListList(0);
    return StreamBuilder<List<OrderItem>>(
        stream: orderListBloc.productItems,
        builder: (context, snapshot) {
          List<OrderItem> list = snapshot.data;
          return snapshot.hasData
              ? (list == null ? empty(type) : buildListView(list))
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

  Widget buildListView(List<OrderItem> orders) {
    return ListView.builder(
      itemCount: orders == null ? 0 : orders.length,
      itemBuilder: (context, index) {
        return buildOrderItem(orders, index);
      },
    );
  }

  GestureDetector buildOrderItem(List<OrderItem> orders, int index) {
    OrderItem orderItem = orders[index];
    List<Good> prducts = orderItem.products;
//    0已取消，1等待发货，2已发货，3已收货，4完成交易
    String status = "无状态";
    String action = "无动作";
    switch (orderItem.status) {
      case 0:
        status = "已取消";
        break;
      case 1:
        status = "等待发货";
        break;
      case 2:
        status = "已发货";
        break;
      case 3:
        status = "已收货";
        break;
      case 4:
        status = "完成交易";
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
                            "商品，已付款：" +
                            orderItem.payPrice.toString(),
                        style: TextStyle(color: UIData.ff353535, fontSize: 14),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        action,
                        style: TextStyle(color: UIData.ff353535, fontSize: 14),
                      ),
                    ],
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
    String img = "";
    String description = "没有";
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
                              description, UIData.ff999999, 11),
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
            //1:待付款，2:待发货，3:待收货，4:待评价,0:全部
            Container(child: TagOrderPage()),
            Container(child: TagOrderPage()),
            Container(child: TagOrderPage()),
          ],
        ),
      ),
      length: 3,
    );
  }

  Container buildBody() {
    return Container(
      child: Text("sadsa"),
    );
  }
}
