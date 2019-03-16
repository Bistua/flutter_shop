import 'package:flutter/material.dart';
import 'package:flutter_lib/logic/viewmodel/comment_view_model.dart';
import 'package:flutter_lib/model/product.dart';
import 'package:flutter_lib/model/comment.dart';
import 'package:flutter_lib/utils/uidata.dart';

class ShopDetailPage extends StatefulWidget {
  Product product;

  ShopDetailPage(Product data, {Key key}) : super(key: key) {
    this.product = data;
  }

  @override
  ShopDetailPageState createState() => new ShopDetailPageState(product);
}

class ShopDetailPageState extends State<ShopDetailPage> {
  BuildContext _context;
  Product product;

  ShopDetailPageState(Product product) {
    this.product = product;
  }

  Padding buildHeader() {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
      child: new Container(
        color: UIData.fff,
        child: new Center(
          child: new Column(
            children: <Widget>[
              Image.network(this.product.image),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            product.price,
                            style:
                                TextStyle(color: UIData.fffa4848, fontSize: 18),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            product.price,
                            style:
                                TextStyle(color: UIData.ff999999, fontSize: 15),
                          ),
                        ),
                        UIData.getShapeButton(UIData.fffff6f6, UIData.fffa4848, 115, 20, "邀请好友下单返金币", 12, 0, (){

                        }),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(15, 6, 15, 6),
                    child: Text(
                      product.name,
                      style: TextStyle(color: UIData.ff353535, fontSize: 16),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(15, 6, 15, 15),
                    child: Text(
                      product.description,
                      style: TextStyle(color: UIData.ff999999, fontSize: 12),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    _context = context;
    CommentViewModel rankViewModel = CommentViewModel();
    List<Comment> rankList = rankViewModel.getMenuItems();
    return new Scaffold(
      appBar: UIData.getCenterTitleAppBar(product.name, context),
      body: product == null
          ? CircularProgressIndicator()
          : Container(
              child: Stack(
                children: <Widget>[
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Expanded(
                          child: Icon(
                            Icons.shopping_cart,
                            color: Colors.black,
                          ),
                        ),
                        Expanded(
                          child: Icon(Icons.star, color: Colors.black),
                        ),
                        UIData.getShapeButton(UIData.fffa4848, UIData.fff, 125,
                            50, "加入购物车", 16, 0, () {}),
                        UIData.getShapeButton(UIData.ffffa517, UIData.fff, 110,
                            50, "立即购买", 16, 0, () {}),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 50,
                    left: 0,
                    right: 0,
                    top: 0,
                    child: buildCustomScrollView(rankList),
                  ),
                ],
              ),
            ),
    );
  }

  CustomScrollView buildCustomScrollView(List<Comment> rankList) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverList(
          delegate: SliverChildListDelegate(
            [
              buildHeader(),
              buildVipInfo(),
              buildFriendsPayInfoList(),
            ],
          ),
        ),
        SliverFixedExtentList(
          itemExtent: 101, // I'm forcing item heights
          delegate: SliverChildBuilderDelegate(
            (context, index) => Container(
                  color: UIData.fff,
                  child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.fromLTRB(15, 15, 9, 11),
                            child: CircleAvatar(
                              radius: 15,
                              backgroundImage:
                                  NetworkImage(rankList[index].avator),
                              backgroundColor: Colors.transparent,
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
                                child: UIData.getTextWidget(
                                    rankList[index].name, UIData.ff666666, 12),
                              ),
                              UIData.getTextWidget(
                                  rankList[index].time.toString(),
                                  UIData.ff999999,
                                  10),
                            ],
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(15, 0, 15, 11),
                        child: UIData.getTextWidget(
                            rankList[index].comment, UIData.ff353535, 12),
                      ),
                      Divider(),
                    ],
                  ),
                ),
            childCount: rankList.length,
          ),
        ),
        SliverList(
          delegate: SliverChildListDelegate(
            [
              Container(
                color: UIData.fff,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(15, 17, 15, 12),
                  child: Text(
                    "商品详情",
                    style: TextStyle(color: UIData.ff353535, fontSize: 15),
                  ),
                ),
              ),
              Image.network(this.product.image),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildFriendsPayInfoList() {
    return Container(
      color: UIData.fff,
      child: Padding(
        padding: EdgeInsets.fromLTRB(15, 17, 15, 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "用户评价(15)",
              style: TextStyle(color: UIData.ff353535, fontSize: 15),
            ),
            Text(
              "查看全部>",
              style: TextStyle(color: UIData.ff999999, fontSize: 12),
            )
          ],
        ),
      ),
    );
  }

  Padding buildPayInfo() {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
      child: new Container(
        color: UIData.fff,
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "我的成功消费金额",
                    style: TextStyle(color: UIData.ff353535, fontSize: 15),
                  ),
                  Text(
                    "累计1560.0",
                    style: TextStyle(color: UIData.fffa4848, fontSize: 15),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
              child: Divider(),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(15, 8, 15, 10),
              child: Text(
                "成功消费金额指的是所有确认收货的订单累计金额。",
                style: TextStyle(color: UIData.ff999999, fontSize: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Padding buildVipInfo() {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
      child: new Container(
        color: UIData.fff,
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "规格数量选择(黑色,大号，1件)",
                    style: TextStyle(color: UIData.ff353535, fontSize: 15),
                  ),
                  Icon(Icons.arrow_forward_ios),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
              child: Divider(),
            ),
            Padding(
              padding: EdgeInsets.all(15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "在线支付运费10元",
                    style: TextStyle(color: UIData.ff353535, fontSize: 15),
                  ),
                  Icon(Icons.arrow_forward_ios),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
