import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

class _ShopCartListState extends State<AllShopOrderPage> {
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
            Container(child: getOrderList(0)),
            Container(child: getOrderList(0)),
            Container(child: getOrderList(0)),
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

  Widget getOrderList(int type) {
    OrderViewModel orderViewModel = OrderViewModel();
    List<OrderItem> orders = orderViewModel.getOrders();

    if (type == 0) {
      return buildListView(orders);
    }
  }

  Widget buildListView(List<OrderItem> orders) {
    return ListView.builder(
      itemCount: orders.length,
      itemBuilder: (context, index) {
        return buildOrderItem(orders, index);
      },
    );
  }

  GestureDetector buildOrderItem(List<OrderItem> orders, int index) {
    OrderItem orderItem = orders[index];
    List<Product> prducts = orderItem.products;
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
                        "待发货",
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
                        "取消订单",
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

  GestureDetector buildListIItem(Product product) {
    return GestureDetector(
      child: Container(
        child: Row(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(16, 15, 0, 16),
              child: Image.network(
                product.image,
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
                    child: Text(product.name,
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
                              product.description, UIData.ff999999, 11),
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
                            "￥" + product.priceNum.toStringAsFixed(2),
                            style:
                                TextStyle(color: UIData.fffa4848, fontSize: 15),
                          ),
                        ),
                        Container(
                          width: 20,
                          height: 20,
                          child: Center(
                            child: UIData.getTextWidget(
                                "x" + product.count.toString(),
                                UIData.ff999999,
                                11),
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
        Navigator.pushNamed(context, UIData.ShopDetailPage,arguments: product);
      },
    );
  }
}
