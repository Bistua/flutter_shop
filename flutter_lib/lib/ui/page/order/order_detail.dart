import 'package:flutter/material.dart';
import 'package:flutter_lib/logic/viewmodel/product_view_model.dart';
import 'package:flutter_lib/model/address.dart';
import 'package:flutter_lib/model/orderDetail.dart';
import 'package:flutter_lib/model/product.dart';
import 'package:flutter_lib/utils/uidata.dart';

class OrderDetailPage extends StatefulWidget {
  OrderDetailPage({Key key}) : super(key: key);

  @override
  OrderDetailPageState createState() => new OrderDetailPageState();
}

class OrderDetailPageState extends State<OrderDetailPage> {
  OrderDetail _orderDetail;

  @override
  Widget build(BuildContext context) {
    _orderDetail = getOrderDetail();
    return new Scaffold(
      appBar: UIData.getCenterTitleAppBar("订单详情", context),
      body: Container(
        child: Stack(
          children: <Widget>[
            Container(
              color: Color(0xFFF5F5F5),
            ),
            buildHeader(),
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
                            ? buildLogistics()
                            : Container(
                                height: 0.0,
                              ),
                        buildAddress(),
                      ],
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) =>
                          ProductItem(item: _orderDetail.products[index]),
                      childCount: _orderDetail.products.length,
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildListDelegate(
                      [
                        buildOrderInfo(),
                        buildPayInfo(),
                        buildServiceInfo(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            buildBottomBar(),
          ],
        ),
      ),
    );
  }

  Container buildHeader() {
    return Container(
      color: Color(0xFFF33D3C),
      height: 100.0,
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 31.0,
            left: 26.0,
            child: Text(
              _orderDetail.getStatusName(),
              style: TextStyle(color: Colors.white, fontSize: 18.0),
            ),
          ),
          Positioned(
            top: 35.0,
            right: 26.0,
            child: InkWell(
              child: Text(
                _orderDetail.status == 0 ? "" : "邀请好友下单返现金",
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

  Card buildLogistics() {
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
                  _orderDetail.express,
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

  Card buildAddress() {
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
                    _orderDetail.address.name + _orderDetail.address.phone,
                    style: TextStyle(color: UIData.ff353535, fontSize: 13),
                  ),
                  Text(
                    "地址：" +
                        _orderDetail.address.area +
                        _orderDetail.address.address,
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

  Card buildOrderInfo() {
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
                "订单编号：" + _orderDetail.orderNumber,
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
                "下单时间：" + _orderDetail.orderTime,
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

  Card buildPayInfo() {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
              padding: EdgeInsets.fromLTRB(16.0, 15.0, 0, 15.0),
              child: Text(
                "支付方式：" + _orderDetail.payMode,
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
                "商品合计：¥" + _orderDetail.productTotal.toStringAsFixed(2),
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
                "运费：¥" + _orderDetail.freight.toStringAsFixed(2),
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
                "实付款：¥" + _orderDetail.payPrice.toStringAsFixed(2),
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

  Positioned buildBottomBar() {
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
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 10.0, 0),
                    child: Stack(
                      alignment: Alignment.center,
                      children: <Widget>[
                        Container(
                          alignment: Alignment.center,
                          width: 90.0,
                          height: 30.0,
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: Color(0xFFEEEEEE), width: 1.0),
                            borderRadius:
                                new BorderRadius.all(new Radius.circular(15.0)),
                          ),
                        ),
                        InkWell(
                          child: new Container(
                            width: 90.0,
                            height: 30.0,
                            child: new Text(
                              _orderDetail.getStatusButtonName(),
                              style: TextStyle(
                                  color: Color(0xFF353535), fontSize: 14),
                            ),
                            alignment: Alignment.center,
                          ),
                          //圆角大小,与BoxDecoration保持一致，更美观
                          onTap: () {},
                        ),
                      ],
                    ),
                  ),
                  !(_orderDetail.status == 2 || _orderDetail.status == 3)
                      ? Container(
                          height: 0,
                        )
                      : Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 10.0, 0),
                          child: Stack(
                            alignment: Alignment.center,
                            children: <Widget>[
                              Container(
                                alignment: Alignment.center,
                                width: 90.0,
                                height: 30.0,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Color(0xFFFF2E2E), width: 15.0),
                                  borderRadius: new BorderRadius.all(
                                      new Radius.circular(15.0)),
                                ),
                              ),
                              InkWell(
                                child: new Container(
                                  width: 90.0,
                                  height: 30.0,
                                  child: new Text(
                                    _orderDetail.status == 2 ? "确认收货" : "评价",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 14),
                                  ),
                                  alignment: Alignment.center,
                                ),
                                //圆角大小,与BoxDecoration保持一致，更美观
                                onTap: () {},
                              ),
                            ],
                          ),
                        ),
                ],
              ),
            ),
          );
  }

  OrderDetail getOrderDetail() {
    OrderDetail orderDetail = new OrderDetail();
    orderDetail.status = 2;
    orderDetail.express = "离开【太原中心】，下一站【广州中心】";
    Address address = new Address();
    address.name = "王大锤";
    address.phone = "12345678901";
    address.area = "金牛区";
    address.address = "四川省成都市金牛区西雅图";
    orderDetail.address = address;
    orderDetail.products = ProductViewModel().getOderDetailProducts();
    orderDetail.orderNumber = "2539129895";
    orderDetail.orderTime = "2018.12.22 09:32";
    orderDetail.payMode = "支付宝";
    orderDetail.productTotal = 195.00;
    orderDetail.freight = 12.00;
    orderDetail.payPrice = 165.00;
    return orderDetail;
  }
}

class ProductItem extends StatelessWidget {
  final Product item;

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
                  width: 88.0,
                  height: 88.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(8.0),
                    image: DecorationImage(
                        image: NetworkImage(item.image), fit: BoxFit.cover),
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        item.name,
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
                                  "米白色, 36码", UIData.ff999999, 11),
                            )),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                item.price,
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
                                      "x " + item.count.toString(),
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
        Navigator.pushNamed(context, UIData.ShopDetailPage, arguments: item.skuId);
      },
    );
  }
}
