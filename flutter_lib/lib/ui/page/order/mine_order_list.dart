//import 'package:flutter/material.dart';
//import 'package:flutter_lib/logic/viewmodel/product_view_model.dart';
//import 'package:flutter_lib/model/mineOrderTab.dart';
//import 'package:flutter_lib/model/orderdetail.dart';
//import 'package:flutter_lib/model/orderListItem.dart';
//import 'package:flutter_lib/model/product.dart';
//import 'package:flutter_lib/utils/uidata.dart';
//
//class MineOrderList extends StatefulWidget {
//  @override
//  MineOrderList({this.orderType, this.pageKey});
//
//  final PageStorageKey<MineOrderTab> pageKey; //当前控件唯一标识Key
//  final String orderType;
//
//  MineOrderState createState() => new MineOrderState(orderType: orderType);
//}
//
//class MineOrderState extends State<MineOrderList> {
//  final String orderType;
//  List<OrderDetail> items = new List<OrderDetail>();
//
//  _upItems(List<OrderDetail> items) {
//    setState(() {
//      this.items = items;
//    });
//  }
//
//  @override
//  MineOrderState({this.orderType});
//
//  @override
//  Widget build(BuildContext context) {
//    List<OrderDetail> list = ProductViewModel().getOrderDetailList();
//    items.clear();
//    switch (orderType) {
//      case "all":
//        items.addAll(list);
//        break;
//      case "shipped":
//        for (OrderDetail orderDetail in list) {
//          if (orderDetail.status == 1) {
//            items.add(orderDetail);
//          }
//        }
//        break;
//      case "received":
//        for (OrderDetail orderDetail in list) {
//          if (orderDetail.status == 2) {
//            items.add(orderDetail);
//          }
//        }
//        break;
//      case "evaluated":
//        for (OrderDetail orderDetail in list) {
//          if (orderDetail.status == 3 || orderDetail.status == 4) {
//            items.add(orderDetail);
//          }
//        }
//        break;
//    }
//    return ListView.builder(
//      itemCount: items.length,
//      itemBuilder: (context, index) {
//        return MineOrderListItem(item: items[index]);
//      },
//    );
//  }
//}
//
//class MineOrderListItem extends StatelessWidget {
//  final OrderDetail item;
//
//  MineOrderListItem({Key key, @required this.item}) : super(key: key);
//
//  @override
//  Widget build(BuildContext context) {
//    return GestureDetector(
//      child: Container(
//        padding: EdgeInsets.fromLTRB(6.0, 1.0, 6.0, 1.0),
//        child: Card(
//          child: Column(
//            children: <Widget>[
//              Container(
//                height: 38.0,
//                padding: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
//                child: Row(
//                  children: <Widget>[
//                    Expanded(
//                      child: Text(
//                        "订单号:" + item.orderNumber,
//                        style:
//                            TextStyle(color: Color(0xFF353535), fontSize: 13.0),
//                      ),
//                    ),
//                    Text(
//                      item.getListStatusName(),
//                      style:
//                          TextStyle(color: Color(0xFFF94847), fontSize: 13.0),
//                    ),
//                  ],
//                ),
//              ),
//              Container(
//                margin: EdgeInsets.fromLTRB(15.0, 0, 15.0, 0),
//                color: Color(0xFFEEEEEE),
//                height: 1.0,
//              ),
//              ListView.builder(
//                shrinkWrap: true,
//                physics: NeverScrollableScrollPhysics(),
//                itemCount: item.goods.length,
//                itemBuilder: (context, index) {
//                  return ProductItemWidget(item: item.goods[index]);
//                },
//              ),
//              Container(
//                alignment: Alignment.centerRight,
//                margin: EdgeInsets.fromLTRB(15.0, 14.0, 15.0, 0.0),
//                child: Text(
//                  "共" +
//                      item.goods.length.toString() +
//                      "件商品已付款：¥" +
//                      item.orderPrice,
//                  style: TextStyle(color: Color(0xFF353535), fontSize: 12.0),
//                ),
//              ),
//              Container(
//                alignment: Alignment.centerRight,
//                height: item.status == 0 ? 14.0 : 45.0,
//                child: Stack(
//                  children: <Widget>[buildBottomBar(context)],
//                ),
//              )
//            ],
//          ),
//        ),
//      ),
//      onTap: () {
//        //Navigator.pushNamed(context, UIData.ShopDetailPage, arguments: item);
//      },
//    );
//  }
//
//  Positioned buildBottomBar(BuildContext context) {
//    return item.status == 0
//        ? Positioned(
//            bottom: 0,
//            left: 0,
//            right: 0,
//            child: Container(),
//          )
//        : Positioned(
//            bottom: 0,
//            left: 0,
//            right: 0,
//            child: Container(
//              height: 45,
//              color: Colors.white,
//              child: Row(
//                children: <Widget>[
//                  Expanded(
//                    child: Container(),
//                  ),
//                  Container(
//                    margin: EdgeInsets.fromLTRB(0, 0, 10.0, 0),
//                    child: Stack(
//                      alignment: Alignment.center,
//                      children: <Widget>[
//                        Container(
//                          alignment: Alignment.center,
//                          width: 85.0,
//                          height: 25.0,
//                          decoration: BoxDecoration(
//                            border: Border.all(
//                                color: Color(0xFFEEEEEE), width: 1.0),
//                            borderRadius:
//                                new BorderRadius.all(new Radius.circular(12.5)),
//                          ),
//                        ),
//                        InkWell(
//                          child: new Container(
//                            width: 85.0,
//                            height: 25.0,
//                            child: new Text(
//                              item.getListStatusButtonName(),
//                              style: TextStyle(
//                                  color: Color(0xFF353535), fontSize: 13),
//                            ),
//                            alignment: Alignment.center,
//                          ),
//                          //圆角大小,与BoxDecoration保持一致，更美观
//                          onTap: () {},
//                        ),
//                      ],
//                    ),
//                  ),
//                  !(item.status == 2 || item.status == 3)
//                      ? Container(
//                          height: 0,
//                        )
//                      : Container(
//                          margin: EdgeInsets.fromLTRB(0, 0, 10.0, 0),
//                          child: Stack(
//                            alignment: Alignment.center,
//                            children: <Widget>[
//                              Container(
//                                alignment: Alignment.center,
//                                width: 85.0,
//                                height: 25.0,
//                                decoration: BoxDecoration(
//                                  border: Border.all(
//                                      color: Color(0xFFF94847), width: 1.0),
//                                  borderRadius: new BorderRadius.all(
//                                      new Radius.circular(12.5)),
//                                ),
//                              ),
//                              InkWell(
//                                child: new Container(
//                                  width: 85.0,
//                                  height: 25.0,
//                                  child: new Text(
//                                    item.status == 2 ? "确认收货" : "评价",
//                                    style: TextStyle(
//                                        color: Color(0xFFF94847), fontSize: 13),
//                                  ),
//                                  alignment: Alignment.center,
//                                ),
//                                //圆角大小,与BoxDecoration保持一致，更美观
//                                onTap: () {
//                                  if(item.status == 2){
//
//                                  }else{
//                                    Navigator.pushNamed(context, UIData.OrderCommentPage);
//                                  }
//                                },
//                              ),
//                            ],
//                          ),
//                        ),
//                ],
//              ),
//            ),
//          );
//  }
//}
//
//class ProductItemWidget extends StatelessWidget {
//  final Goods item;
//
//  ProductItemWidget({Key key, @required this.item}) : super(key: key);
//
//  @override
//  Widget build(BuildContext context) {
//    return GestureDetector(
//      child: Container(
//        child: Container(
//          padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 0.0),
//          child: Row(
//            crossAxisAlignment: CrossAxisAlignment.start,
//            children: <Widget>[
//              Container(
//                margin: EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 0.0),
//                width: 88.0,
//                height: 88.0,
//                decoration: BoxDecoration(
//                  shape: BoxShape.rectangle,
//                  borderRadius: BorderRadius.circular(8.0),
//                  image: DecorationImage(
//                      image: NetworkImage(item.goodsImgUrl), fit: BoxFit.cover),
//                ),
//              ),
//              Expanded(
//                child: Column(
//                  crossAxisAlignment: CrossAxisAlignment.start,
//                  children: <Widget>[
//                    Text(
//                      item.goodsName,
//                      style:
//                          TextStyle(color: Color(0xFF353535), fontSize: 12.0),
//                    ),
//                    Padding(
//                      padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
//                      child: Container(
//                          height: 18,
//                          width: 92,
//                          decoration: BoxDecoration(
//                              color: UIData.fff7f7f7,
//                              shape: BoxShape.rectangle,
//                              borderRadius: BorderRadius.circular(3)),
//                          child: Center(
//                            child: UIData.getTextWidget(
//                                "米白色, 36码", UIData.ff999999, 11),
//                          )),
//                    ),
//                    Container(
//                      margin: EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
//                      child: Row(
//                        children: <Widget>[
//                          Expanded(
//                            child: Text(
//                              item.goodsPrice,
//                              style: TextStyle(
//                                  color: Color(0xFFFF2E2E), fontSize: 12.0),
//                            ),
//                          ),
//                          Padding(
//                            padding: EdgeInsets.fromLTRB(3, 0, 3, 0),
//                            child: Container(
//                              width: 50,
//                              height: 20,
//                              child: Center(
//                                child: UIData.getTextWidget(
//                                    "x " + item.buyNum.toString(),
//                                    UIData.ff999999,
//                                    11),
//                              ),
//                              decoration: BoxDecoration(
//                                border: Border.all(
//                                    color: UIData.fff7f7f7, width: 1.0),
//                                shape: BoxShape.rectangle,
//                              ),
//                            ),
//                          ),
//                        ],
//                      ),
//                    ),
//                  ],
//                ),
//              ),
//            ],
//          ),
//        ),
//      ),
//      onTap: () {
//        Navigator.pushNamed(context, UIData.ShopDetailPage, arguments: item.goodsId);
//      },
//    );
//  }
//}
