import 'package:flutter/material.dart';
import 'package:flutter_lib/logic/viewmodel/comment_view_model.dart';
import 'package:flutter_lib/model/product.dart';
import 'package:flutter_lib/model/comment.dart';
import 'package:flutter_lib/ui/page/order/shop_order.dart';
import 'package:flutter_lib/ui/widgets/rating_bar.dart';
import 'package:flutter_lib/utils/uidata.dart';
import 'package:flutter_lib/logic/viewmodel/shop_cart_manager.dart';
import 'package:flutter_lib/ui/page/shop/shop_cart_list.dart';

class ShopDetailPage extends StatefulWidget {
  Product product;

  ShopDetailPage(Product data, {Key key}) : super(key: key) {
    this.product = data;
  }

  @override
  ShopDetailPageState createState() => new ShopDetailPageState(product);
}

class ShopDetailPageState extends State<ShopDetailPage>
    with WidgetsBindingObserver {
  BuildContext _context;
  Product product;

  ShopDetailPageState(Product product) {
    this.product = product;
  }
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    print("didChangeDependencies");

    super.didChangeDependencies();
  }

  @override
  Future<bool> didPopRoute() {
    print("didPopRoute");
    setState(() {
      _updateShopCartCount();
    });
    return super.didPopRoute();
  }

  @override
  Future<bool> didPushRoute(String route) {
    print("didPushRoute");
    return super.didPushRoute(route);
  }

  @override
  void didUpdateWidget(ShopDetailPage oldWidget) {
    print("didUpdateWidget");
    super.didUpdateWidget(oldWidget);
  }

  @override
  void deactivate() {
    print("deactivate");

    super.deactivate();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print("didChangeAppLifecycleState");
    setState(() {
      switch (state) {
        case AppLifecycleState.inactive:
        case AppLifecycleState.paused:
        case AppLifecycleState.suspending:
          break;
        case AppLifecycleState.resumed:
          print("1resumed");
          _updateShopCartCount();
          break;
      }
    });
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
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Expanded(
                          child: RichText(
                            text: new TextSpan(
                              children: <TextSpan>[
                                TextSpan(
                                  text: product.price,
                                  style: TextStyle(
                                      color: UIData.fffa4848, fontSize: 18),
                                ),
                              ],
                            ),
                          ),
                          flex: 1,
                        ),
                        Expanded(
                          child: RichText(
                            text: new TextSpan(
                              children: <TextSpan>[
                                new TextSpan(
                                  text: product.price,
                                  style: new TextStyle(
                                    color: UIData.ff999999,
                                    decoration: TextDecoration.lineThrough,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          flex: 2,
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {},
                            child: Container(
                              width: 115,
                              height: 20,
                              color: UIData.fffff6f6,
                              child: Center(
                                child: Text(
                                  "邀请好友下单返金币",
                                  style: TextStyle(
                                      color: UIData.fffa4848, fontSize: 12),
                                ),
                              ),
                            ),
                          ),
                          flex: 2,
                        ),
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
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: Stack(
                            children: <Widget>[
                              Center(
                                  child: IconButton(
                                      icon: Icon(
                                        Icons.shopping_cart,
                                        color: Colors.black,
                                      ),
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            new MaterialPageRoute(
                                                builder: (context) =>
                                                    new ShopCartListPage()));
                                      })),
                              Positioned(
                                right: 8,
                                top: 8,
                                child: new Container(
                                    width: 13,
                                    height: 13,
                                    child: Center(
                                      child: UIData.getTextWidget(
                                          count.toString(), UIData.fff, 10),
                                    ),
                                    decoration: UIData.getCircleBoxDecoration(
                                        UIData.fffa4848)),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: IconButton(
                            icon: Icon(Icons.star, color: Colors.black),
                            onPressed: () {},
                          ),
                        ),
                        UIData.getShapeButton(UIData.fffa4848, UIData.fff, 125,
                            50, "加入购物车", 16, 0, () {
                          product.isChecked = true;
                          ShopCartManager.instance.addProduct(product);
                          _updateShopCartCount();
                        }),
                        UIData.getShapeButton(UIData.ffffa517, UIData.fff, 110,
                            50, "立即购买", 16, 0, () {
                              product.isChecked = true;
                              ShopCartManager.instance.addProduct(product);
                              _updateShopCartCount();
                              Navigator.push(
                                  context,
                                  new MaterialPageRoute(
                                      builder: (context) => new ShopOrderListPage()));
                            }),
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
        SliverList(
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
                                child: Row(
                                  children: <Widget>[
                                    UIData.getTextWidget(
                                        rankList[index].name, UIData.ff666666, 12),
                                    Container(width: 8.0,),
                                    StaticRatingBar(
                                      size: 10.0,
                                      rate: rankList[index].star,
                                    )
                                  ],
                                ),
                              ),
                              UIData.getTextWidget(
                                  rankList[index].time,
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
                      Container(
                        margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
                        height: 1.0,
                        color: Color(0xFFEAEAEA),
                      ),
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

  _updateShopCartCount() {
    setState(() {
      count = ShopCartManager.instance.size();
    });
  }

  int count = ShopCartManager.instance.size();

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
            InkWell(
              child:  Text(
                "查看全部>",
                style: TextStyle(color: UIData.ff999999, fontSize: 12),
              ),
              onTap: () {
                Navigator.pushNamed(context, UIData.OrderCommentListPage);
              },
            ),
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
