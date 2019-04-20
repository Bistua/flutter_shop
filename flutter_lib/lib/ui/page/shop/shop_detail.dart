import 'package:flutter/material.dart';
import 'package:flutter_lib/logic/bloc/product_bloc.dart';
import 'package:flutter_lib/logic/viewmodel/comment_view_model.dart';
import 'package:flutter_lib/model/comment.dart';
import 'package:flutter_lib/model/productitem.dart';
import 'package:flutter_lib/ui/page/order/shop_order.dart';
import 'package:flutter_lib/ui/widgets/rating_bar.dart';
import 'package:flutter_lib/utils/uidata.dart';
import 'package:flutter_lib/logic/viewmodel/shop_cart_manager.dart';
import 'package:flutter_lib/ui/page/shop/shop_cart_list.dart';

class ShopDetailPage extends StatefulWidget {
  int productId;

  ShopDetailPage(int productId, {Key key}) : super(key: key) {
    this.productId = productId;
  }

  @override
  ShopDetailPageState createState() => new ShopDetailPageState(productId);
}

class ShopDetailPageState extends State<ShopDetailPage>
    with WidgetsBindingObserver {
  int productId;
  ProductBloc productBloc = ProductBloc();

  ShopDetailPageState(int productId) {
    this.productId = productId;
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
  Future<bool> didPopRoute() {
    print("didPopRoute");
    setState(() {
      _updateShopCartCount();
    });
    return super.didPopRoute();
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

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: UIData.getCenterTitleAppBar("商品名称", context),
      body: bodyData(),
    );
  }

  Widget bodyData() {
    return StreamBuilder<List<ProductItem>>(
        stream: productBloc.productItems,
        builder: (context, snapshot) {
          return snapshot.hasData
              ? buidBody(snapshot.data[0])
              : Center(child: CircularProgressIndicator());
        });
  }

  Container buidBody(ProductItem product) {
    return Container(
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
                                  cartCount.toString(), UIData.fff, 10),
                            ),
                            decoration:
                                UIData.getCircleBoxDecoration(UIData.fffa4848)),
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
                UIData.getShapeButton(UIData.fffa4848, UIData.fff, 125, 50,
                    "加入购物车", 16, 0, () {}),
                UIData.getShapeButton(
                    UIData.ffffa517, UIData.fff, 110, 50, "立即购买", 16, 0, () {
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
            child: buildCustomScrollView(product),
          ),
        ],
      ),
    );
  }

  CustomScrollView buildCustomScrollView(ProductItem product) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverList(
          delegate: SliverChildListDelegate(
            [
              buildHeader(product),
            ],
          ),
        ),
        SliverList(
          delegate: SliverChildListDelegate(
            [
              buildVipInfo(product),
            ],
          ),
        ),
        SliverList(
          delegate: SliverChildListDelegate(
            [
              buildFriendsPayInfoList(),
            ],
          ),
        ),
        buildCommentSliverList(),
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
              Image.network(product.medias.alt1.url),
            ],
          ),
        ),
      ],
    );
  }

  Padding buildHeader(ProductItem product) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
      child: new Container(
        color: UIData.fff,
        child: new Center(
          child: new Column(
            children: <Widget>[
              Image.network(product.medias.alt1.url),
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
                                  text: product.price.toString(),
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
                                  text: product.price.toString(),
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

  SliverList buildCommentSliverList() {
    List<Comment> rankList = CommentViewModel().getMenuItems();
    return SliverList(
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
                          backgroundImage: NetworkImage(rankList[index].avator),
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
                                Container(
                                  width: 8.0,
                                ),
                                StaticRatingBar(
                                  size: 10.0,
                                  rate: rankList[index].star,
                                )
                              ],
                            ),
                          ),
                          UIData.getTextWidget(
                              rankList[index].time, UIData.ff999999, 10),
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
    );
  }

  _updateShopCartCount() {
    setState(() {
      cartCount = ShopCartManager.instance.size();
    });
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
            InkWell(
              child: Text(
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

  int sizeIndex = 0;
  int colorIndex = 0;
  int chooseCount = 1;
  String chooseCountStr = "1";
  int cartCount = ShopCartManager.instance.size();

  List<int> size = [37, 40, 41];
  List<String> color = ["红色", "黑色", "蓝色"];

  Padding buildVipInfo(ProductItem product) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
      child: new Container(
        color: UIData.fff,
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(15),
              child: GestureDetector(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "规格数量选择（大小:" +
                          "1" +
                          "  颜色:" +
                          "写死的黑丝" +
                          "  数量:" +
                          chooseCount.toString() +
                          "）",
                      style: TextStyle(color: UIData.ff353535, fontSize: 15),
                    ),
                    Icon(Icons.arrow_forward_ios),
                  ],
                ),
                onTap: () {
                  showChooseDialog(product);
                },
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
                    "在线支付运费0元",
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

  showChooseDialog(ProductItem product) {
    showDialog(
        context: context,
        builder: (context) => Center(
              child: Material(
                borderRadius: BorderRadius.circular(8.0),
                color: Colors.black12,
                elevation: 5.0,
                child: Container(
                  height: 450,
                  color: UIData.fff,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Image.network(
                              product.medias.alt1.url,
                              width: 90,
                              height: 90,
                            ),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      product.name,
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 15),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      product.price.toString(),
                                      style: TextStyle(
                                          color: UIData.fffa4848, fontSize: 15),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        padding: EdgeInsets.fromLTRB(14, 14, 14, 14),
                      ),
                      Divider(),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "规格",
                              style: TextStyle(
                                  color: UIData.ff666666, fontSize: 15),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: size.map((s) {
                            return GestureDetector(
                              child: Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Text(s.toString()),
                                ),
                              ),
                              onTap: () {
                                setState(() {
                                  this.sizeIndex = size.indexOf(s);
                                });
                              },
                            );
                          }).toList(),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: color.map((color) {
                            return GestureDetector(
                              child: Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Text(color.toString()),
                                ),
                              ),
                              onTap: () {
                                setState(() {
                                  this.colorIndex = color.indexOf(color);
                                });
                              },
                            );
                          }).toList(),
                        ),
                      ),
                      Divider(),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Text(
                                  "使用数量",
                                  style: TextStyle(
                                      color: UIData.ff666666, fontSize: 15),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: GestureDetector(
                                child: Container(
                                  width: 40,
                                  height: 40,
                                  child: Center(
                                    child: UIData.getTextWidget(
                                        "-", UIData.ff999999, 11),
                                  ),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: UIData.fff7f7f7, width: 1.0),
                                    shape: BoxShape.rectangle,
                                  ),
                                ),
                                onTap: () {
                                  setState(() {
                                    print("-");
                                    chooseCount--;
                                    setState(() {
                                      chooseCountStr = chooseCount.toString();
                                    });
                                  });
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Container(
                                width: 50,
                                height: 40,
                                child: Center(
                                  child: Text(
                                    chooseCountStr,
                                    style: TextStyle(
                                        color: UIData.ff666666, fontSize: 15),
                                  ),
                                ),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: UIData.fff7f7f7, width: 1.0),
                                  shape: BoxShape.rectangle,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: GestureDetector(
                                child: Container(
                                  width: 40,
                                  height: 40,
                                  child: Center(
                                    child: UIData.getTextWidget(
                                        "+", UIData.ff999999, 11),
                                  ),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: UIData.fff7f7f7, width: 1.0),
                                    shape: BoxShape.rectangle,
                                  ),
                                ),
                                onTap: () {
                                  setState(() {
                                    chooseCount++;
                                    setState(() {
                                      chooseCountStr = chooseCount.toString();
                                    });
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      UIData.getShapeButton(
                        UIData.fffa4848,
                        UIData.fff,
                        345,
                        45,
                        "加入购物车",
                        18,
                        5,
                        () {},
                      )
                    ],
                  ),
                ),
              ),
            ));
  }
}
