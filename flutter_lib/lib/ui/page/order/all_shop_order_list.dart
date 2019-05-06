import 'package:flutter/material.dart';
import 'package:flutter_lib/logic/bloc/oder_list_bloc.dart';
import 'package:flutter_lib/model/orderListItem.dart';
import 'package:flutter_lib/ui/page/order/order_action_widget.dart';
import 'package:flutter_lib/ui/widgets/empty_widget.dart';
import 'package:flutter_lib/utils/uidata.dart';

class AllShopOrderPage extends StatefulWidget {
  final int initialIndex;

  AllShopOrderPage(this.initialIndex);

  @override
  State<StatefulWidget> createState() {
    List<Widget> pages = List();
    pages.add(Container(child: TagOrderPage(0)));
    pages.add(Container(child: TagOrderPage(1)));
    pages.add(Container(child: TagOrderPage(2)));
    pages.add(Container(child: TagOrderPage(3)));
    pages.add(Container(child: TagOrderPage(4)));

    return _ShopCartListState(pages);
  }
}

class TagOrderPage extends StatefulWidget {
  int type;
  TagOrderPage(int i) {
    this.type = i;
  }

  OrderListBloc orderListBloc;

  @override
  State<StatefulWidget> createState() {
    return TagState();
  }
}

class TagState extends State<TagOrderPage> {
  @override
  void initState() {
    super.initState();
    widget.orderListBloc = OrderListBloc();
    widget.orderListBloc.getOrderListList(widget.type);
  }

  @override
  void dispose() {
    widget.orderListBloc?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return getOrderList(widget.type);
  }

  Widget getOrderList(int type) {
    return StreamBuilder<List<OrderItem>>(
        stream: widget.orderListBloc.productItems,
        builder: (context, snapshot) {
          List<OrderItem> list = snapshot.data;
          if (snapshot.hasData) {
            if (snapshot.data.isNotEmpty) {
              return buildListView(type, list);
            } else {
              return EmptyWidget("无数据,点击重试", () {
                widget.orderListBloc.getOrderListList(type);
              });
            }
          } else if (snapshot.hasError) {
            return EmptyWidget(snapshot.error, () {
              widget.orderListBloc.getOrderListList(type);
            });
          } else {
            return center();
          }
        });
  }

  Center center() {
    widget.orderListBloc.getOrderListList(widget.type);
    return Center(child: CircularProgressIndicator());
  }

  Widget buildListView(int type, List<OrderItem> orders) {
    return ListView.builder(
      itemCount: orders == null ? 0 : orders.length,
      itemBuilder: (context, index) {
        return buildOrderItem(orders, index, type);
      },
    );
  }

  GestureDetector buildOrderItem(List<OrderItem> orders, int index, int type) {
    OrderItem orderItem = orders[index];
    List<Good> prducts = orderItem.products;
    String status = "无状态";
//    1:待付款，2:待发货，3:待收货，4:待评价,0:全部
    switch (orderItem.status) {
      case 1:
        status = "待付款";
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
                            "商品，总价：￥" +
                            orderItem.payPrice.toString(),
                        style: TextStyle(color: UIData.ff353535, fontSize: 14),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
                    child: OrderActionWidget(orderItem, type, () {
                      widget.orderListBloc.getOrderListList(type);
                    }),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      onTap: () {
        Navigator.pushNamed(context, UIData.OrderDetailPage,
            arguments: orderItem.orderNumber);
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
                          width: 100,
                          height: 20,
                          child: Center(
                            child: Text("数量：x " + count.toString(),
                                style: TextStyle(
                                  fontSize: 11,
                                  color: UIData.ff999999,
                                )),
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: UIData.fff7f7f7, width: 1.0),
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
  List<Widget> pages;
  _ShopCartListState(pages) {
    this.pages = pages;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: widget.initialIndex,
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
                    style: TextStyle(color: UIData.ff666666, fontSize: 12),
                  ),
                ),
              ),
              Tab(
                child: Container(
                  color: UIData.fff,
                  child: Text(
                    "待付款",
                    style: TextStyle(color: UIData.ff666666, fontSize: 12),
                  ),
                ),
              ),
              Tab(
                child: Container(
                  color: UIData.fff,
                  child: Text(
                    "待发货",
                    style: TextStyle(color: UIData.ff666666, fontSize: 12),
                  ),
                ),
              ),
              Tab(
                child: Container(
                  color: UIData.fff,
                  child: Text(
                    "待收货",
                    style: TextStyle(color: UIData.ff666666, fontSize: 12),
                  ),
                ),
              ),
              Tab(
                child: Container(
                  color: UIData.fff,
                  child: Text(
                    "待评价",
                    style: TextStyle(color: UIData.ff666666, fontSize: 12),
                  ),
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: pages,
        ),
      ),
      length: 5,
    );
  }
}
