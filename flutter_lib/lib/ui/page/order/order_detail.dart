import 'package:flutter/material.dart';
import 'package:flutter_lib/logic/bloc/oder_list_bloc.dart';
import 'package:flutter_lib/model/orderListItem.dart';
import 'package:flutter_lib/model/orderdetail.dart';
import 'package:flutter_lib/ui/page/order/order_action_widget.dart';
import 'package:flutter_lib/ui/widgets/empty_widget.dart';
import 'package:flutter_lib/utils/uidata.dart';

class OrderDetailPage extends StatefulWidget {
  String orderId;

  OrderDetailPage(this.orderId);

  @override
  OrderDetailPageState createState() => new OrderDetailPageState();
}

class OrderDetailPageState extends State<OrderDetailPage> {
  OrderListBloc orderListBloc = OrderListBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UIData.getCenterTitleAppBar("订单详情", context),
      body: Container(
        child: getDetail(),
      ),
    );
  }

  Widget getDetail() {
    orderListBloc.getOrderDetail(widget.orderId);
    return StreamBuilder<OrderDetail>(
        stream: orderListBloc.orderDetail,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return EmptyWidget(snapshot.error, () {
              orderListBloc.getOrderDetail(widget.orderId);
            });
          } else if (snapshot.hasData) {
            if (snapshot.data != null && snapshot.data.orderId.isNotEmpty) {
              return buildStack(snapshot.data);
            } else {
              return EmptyWidget("无数据", () {
                orderListBloc.getOrderDetail(widget.orderId);
              });
            }
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }

  Stack buildStack(OrderDetail _orderDetail) {
    return Stack(
      children: <Widget>[
        Container(
          color: Color(0xFFF5F5F5),
        ),
        buildHeader(_orderDetail),
        Positioned(
          top: 78.0,
          left: 10.0,
          right: 10.0,
          bottom: _orderDetail.status == 0 ? 0 : 49.0,
          child: CustomScrollView(
            slivers: <Widget>[
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    _orderDetail.status != 0
                        ? buildLogistics(_orderDetail)
                        : Container(
                            height: 0.0,
                          ),
                    buildAddress(_orderDetail),
                  ],
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) =>
                      ProductItem(item: _orderDetail.goods[index]),
                  childCount: _orderDetail.goods.length,
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    buildOrderInfo(_orderDetail),
                    buildPayInfo(_orderDetail),
                    buildServiceInfo(),
                  ],
                ),
              ),
            ],
          ),
        ),
        buildBottomBar(_orderDetail),
      ],
    );
  }

  Container buildHeader(OrderDetail _orderDetail) {
    return Container(
      color: Color(0xFFF33D3C),
      height: 100.0,
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 31.0,
            left: 26.0,
            child: Text(
              _orderDetail.getStatusName() == null
                  ? "名称不可为空"
                  : _orderDetail.getStatusName(),
              style: TextStyle(color: Colors.white, fontSize: 18.0),
            ),
          ),
          Positioned(
            top: 35.0,
            right: 26.0,
            child: InkWell(
              child: Text(
                _orderDetail.status == 0 ? "名称不可为空" : "邀请好友下单返现金",
                style: TextStyle(color: Color(0xFFFF9796), fontSize: 12.0),
              ),
              onTap: () {
                Navigator.pushNamed(context, UIData.IviteFriendsPage);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildLogistics(OrderDetail _orderDetail) {
    if (_orderDetail.express == null) {
      return Container(
        width: 0,
        height: 0,
      );
    }
    return Card(
      child: Container(
        height: 45.0,
        padding: EdgeInsets.fromLTRB(16.0, 0.0, 11.0, 0.0),
        child: Row(
          children: <Widget>[
            Text(
              "物流信息",
              style: TextStyle(color: Color(0xFF999999), fontSize: 12.0),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.fromLTRB(6.0, 0.0, 6.0, 0.0),
                child: Text(
                  _orderDetail.express == null
                      ? "名称不可为空"
                      : _orderDetail.express,
                  style: TextStyle(color: Color(0xFF353535), fontSize: 12.0),
                  maxLines: 1,
                ),
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: UIData.ff999999,
            ),
          ],
        ),
      ),
    );
  }

  Card buildAddress(OrderDetail _orderDetail) {
    return Card(
      child: Padding(
        padding: EdgeInsets.fromLTRB(10, 15, 10, 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Icon(
              Icons.location_on,
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
                    _orderDetail.receiveGoods.name +
                        _orderDetail.receiveGoods.phone,
                    style: TextStyle(color: UIData.ff353535, fontSize: 13),
                  ),
                  Text(
                    "地址：" + _orderDetail.receiveGoods.address,
                    style: TextStyle(color: UIData.ff999999, fontSize: 12),
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
    );
  }

  Card buildOrderInfo(OrderDetail _orderDetail) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(0, 15.0, 0, 15.0),
            child: Row(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.fromLTRB(0, 0, 11.0, 0),
                  width: 3.0,
                  color: Color(0xFFFA4848),
                  height: 13.0,
                ),
                Text(
                  "订单信息",
                  style: TextStyle(color: Color(0xFF353535), fontSize: 12.0),
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(15.0, 0, 15.0, 0),
            color: Color(0xFFEEEEEE),
            height: 1.0,
          ),
          Padding(
              padding: EdgeInsets.fromLTRB(16.0, 15.0, 0, 15.0),
              child: Text(
                "订单编号：" + _orderDetail.orderId == null
                    ? "名称不可为空"
                    : _orderDetail.orderId,
                style: TextStyle(color: Color(0xFF777777), fontSize: 12.0),
              )),
          Container(
            margin: EdgeInsets.fromLTRB(15.0, 0, 15.0, 0),
            color: Color(0xFFEEEEEE),
            height: 1.0,
          ),
          Padding(
              padding: EdgeInsets.fromLTRB(16.0, 15.0, 0, 15.0),
              child: Text(
                "下单时间：" + _orderDetail.createTime == null
                    ? "名称不可为空"
                    : _orderDetail.createTime,
                style: TextStyle(color: Color(0xFF777777), fontSize: 12.0),
              )),
          Container(
            margin: EdgeInsets.fromLTRB(15.0, 0, 15.0, 0),
            color: Color(0xFFEEEEEE),
            height: 1.0,
          ),
        ],
      ),
    );
  }

  Card buildPayInfo(OrderDetail _orderDetail) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
              padding: EdgeInsets.fromLTRB(16.0, 15.0, 0, 15.0),
              child: Text(
                "支付方式：" +
                    (_orderDetail.payType == null
                        ? "名称不可为空"
                        : _orderDetail.payType),
                style: TextStyle(color: Color(0xFF777777), fontSize: 12.0),
              )),
          Container(
            margin: EdgeInsets.fromLTRB(15.0, 0, 15.0, 0),
            color: Color(0xFFEEEEEE),
            height: 1.0,
          ),
          Padding(
              padding: EdgeInsets.fromLTRB(16.0, 15.0, 0, 15.0),
              child: Text(
                "商品合计：¥" +
                    (_orderDetail.orderPrice == null
                        ? "名称不可为空"
                        : _orderDetail.orderPrice),
                style: TextStyle(color: Color(0xFF777777), fontSize: 12.0),
              )),
          Container(
            margin: EdgeInsets.fromLTRB(15.0, 0, 15.0, 0),
            color: Color(0xFFEEEEEE),
            height: 1.0,
          ),
          Padding(
              padding: EdgeInsets.fromLTRB(16.0, 15.0, 0, 15.0),
              child: Text(
                "运费：¥" +
                    (_orderDetail.freight == null
                        ? "名称不可为空"
                        : _orderDetail.freight),
                style: TextStyle(color: Color(0xFF777777), fontSize: 12.0),
              )),
          Container(
            margin: EdgeInsets.fromLTRB(15.0, 0, 15.0, 0),
            color: Color(0xFFEEEEEE),
            height: 1.0,
          ),
          Padding(
              padding: EdgeInsets.fromLTRB(16.0, 15.0, 0, 15.0),
              child: Text(
                "实付款：¥" +
                    (_orderDetail.payFee == null
                        ? "名称不可为空"
                        : _orderDetail.payFee),
                style: TextStyle(color: Color(0xFFFF2E2E), fontSize: 12.0),
              )),
          Container(
            margin: EdgeInsets.fromLTRB(15.0, 0, 15.0, 0),
            color: Color(0xFFEEEEEE),
            height: 1.0,
          ),
        ],
      ),
    );
  }

  Card buildServiceInfo() {
    return Card(
        child: Padding(
      padding: EdgeInsets.fromLTRB(16.0, 15.0, 15.0, 15.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Text(
              "服务时间：9:00-24:00",
              style: TextStyle(color: Color(0xFF353535), fontSize: 12.0),
            ),
          ),
          Icon(
            Icons.phone_forwarded,
            color: UIData.ff999999,
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(10.0, 0, 0, 0),
            child: Text(
              "电话客服",
              style: TextStyle(color: Color(0xFF353535), fontSize: 12.0),
            ),
          ),
        ],
      ),
    ));
  }

  Positioned buildBottomBar(OrderDetail _orderDetail) {
    OrderItem orderItem = OrderItem();
    orderItem.status = _orderDetail.status;
    orderItem.payPrice = _orderDetail.orderPrice;
    orderItem.orderNumber = _orderDetail.orderId;
    orderItem.products = _orderDetail.goods;
    return _orderDetail.status == 0
        ? Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            height: 0,
          )
        : Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 49,
              color: Colors.white,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Container(),
                  ),
                  OrderActionWidget(orderItem, _orderDetail.status, () {}),
                ],
              ),
            ),
          );
  }
}

class ProductItem extends StatelessWidget {
  final Good item;

  ProductItem({Key key, @required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        child: Card(
          child: Container(
            padding: EdgeInsets.all(15.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 0.0),
                  child: UIData.getImageWithWH(
                      item.goodsImgUrl == null ? "名称不可为空" : item.goodsImgUrl,
                      88,
                      88),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        item.goodsName == null ? "名称不可为空" : item.goodsName,
                        style:
                            TextStyle(color: Color(0xFF353535), fontSize: 12.0),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
                        child: Container(
                            height: 18,
                            width: 92,
                            decoration: BoxDecoration(
                                color: UIData.fff7f7f7,
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(3)),
                            child: Center(
                              child: UIData.getTextWidget(
                                  item.specMsg == null
                                      ? "名称不可为空"
                                      : item.specMsg,
                                  UIData.ff999999,
                                  11),
                            )),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                item.goodsPrice == null
                                    ? "名称不可为空"
                                    : item.goodsPrice,
                                style: TextStyle(
                                    color: Color(0xFFFF2E2E), fontSize: 12.0),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(3, 0, 3, 0),
                              child: Container(
                                width: 50,
                                height: 20,
                                child: Center(
                                  child: UIData.getTextWidget(
                                      "x " +
                                          (item.buyNum == null
                                              ? "名称不可为空"
                                              : item.buyNum),
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
      ),
      onTap: () {
        Navigator.pushNamed(context, UIData.ShopDetailPage,
            arguments: item.goodsId);
      },
    );
  }
}
