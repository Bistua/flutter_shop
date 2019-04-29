import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_lib/bridge/cart_bridge.dart';
import 'package:flutter_lib/bridge/common_bridge.dart';
import 'package:flutter_lib/bridge/sku_bridge.dart';
import 'package:flutter_lib/logic/bloc/product_bloc.dart';
import 'package:flutter_lib/logic/inherited/product_provider.dart';
import 'package:flutter_lib/logic/viewmodel/comment_view_model.dart';
import 'package:flutter_lib/model/Result.dart';
import 'package:flutter_lib/model/skuresult.dart';
import 'package:flutter_lib/model/cart.dart';
import 'package:flutter_lib/model/comment.dart';
import 'package:flutter_lib/model/productitem.dart';
import 'package:flutter_lib/model/skuinfo.dart';
import 'package:flutter_lib/ui/page/order/shop_order.dart';
import 'package:flutter_lib/ui/widgets/rating_bar.dart';
import 'package:flutter_lib/utils/uidata.dart';

class ShopDetailPage extends StatefulWidget {
  int productId;

  String skuInfoSelect;
  Map mapForUI = new Map<String, dynamic>();

  ShopDetailPage(int productId, {Key key}) : super(key: key) {
    this.productId = productId;
  }

  @override
  ShopDetailPageState createState() => new ShopDetailPageState(productId);
}

class ShopDetailPageState extends State<ShopDetailPage> {
//    with WidgetsBindingObserver {
  int productId;
  ProductBloc productBloc;

  SkuInfo skuInfo;

  int chooseCount = 1;
  String chooseCountStr = "1";
  int cartCount = 0;

  ShopDetailPageState(int productId) {
    this.productId = productId;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
//    productBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("ShopDetailPage build");
    productBloc = ProductBloc();
    return ProductProvider(
        productBloc: productBloc,
        child: new Scaffold(
          appBar: UIData.getCenterTitleAppBar("商品名称", context),
          body: bodyData(),
        ));
  }

  Widget bodyData() {
    productBloc.getProduct(productId);
    return StreamBuilder<List<ProductItem>>(
        stream: productBloc.productItems,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            print("getProduct hasdata");
            return buidBody(snapshot.data[0]);
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }

  Container buidBody(ProductItem product) {

    productBloc.getProductSkuInfo(productId);
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
                                Navigator.pushNamed(
                                    context, UIData.ShopCartListPage);
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
                UIData.getShapeButton(
                    UIData.fffa4848, UIData.fff, 125, 50, "加入购物车", 16, 0, () {
                  getSkuResult(product);
                }),
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
              ProductProvider(
                productBloc: productBloc,
                child: buildSKUStreamBuilder(product),
              )
            ],
          ),
        ),
        SliverList(
          delegate: SliverChildListDelegate(
            [],
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
              UIData.getImage(product.medias.alt1.url),
            ],
          ),
        ),
      ],
    );
  }

  StreamBuilder<SkuInfo> buildSKUStreamBuilder(ProductItem product) {
    return StreamBuilder<SkuInfo>(
        stream: productBloc.skuInfo,
        builder: (context, snapshot) {
          if(snapshot.hasData){
            print("getProduct sku hasdata");
            return buildVipInfo(product, snapshot.data);
          }else{
            return Center(child: CircularProgressIndicator());
          }
        });
  }

  Padding buildHeader(ProductItem product) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
      child: new Container(
        color: UIData.fff,
        child: new Center(
          child: new Column(
            children: <Widget>[
              UIData.getImage(product.medias.alt1.url),
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
                                  text: "￥" + product.price.toString(),
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
                                  text: "￥" + product.price.toString(),
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

  Padding buildVipInfo(ProductItem product, SkuInfo data) {
    this.skuInfo = data;
    String skuInfoSelect = "";
    for (int i = 0; i < this.skuInfo.options.length; i++) {
      var o = this.skuInfo.options[i];
      List<ValuesListBean> vs = this.skuInfo.options[i].values;
      for (int j = 0; j < vs.length; j++) {
        var v = vs[j];
        if (j == 0) {
          widget.mapForUI[o.key] = v;
          skuInfoSelect = skuInfoSelect + "  " + o.key + ":" + v.name;
        }
      }
    }
    widget.skuInfoSelect = skuInfoSelect;

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
                      widget.skuInfoSelect + "  数量：" + chooseCount.toString(),
                      style: TextStyle(color: UIData.ff353535, fontSize: 15),
                    ),
                    Icon(Icons.arrow_forward_ios),
                  ],
                ),
                onTap: () {
                  if (skuInfo == null) {
                    getSkuResult(product);
                    return;
                  }
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

  getSkuSelectInfo() {
    String skuInfoSelect = "";
    widget.mapForUI.forEach((k, v) {
      skuInfoSelect = skuInfoSelect + "  " + k + ":" + v.name;
    });
    print(widget.skuInfoSelect);
    setState(() {
      widget.skuInfoSelect = skuInfoSelect;
      print("刷新getSkuSelectInfo:" + widget.skuInfoSelect);
    });
  }

  showChooseDialog(ProductItem product) {
    showModalBottomSheet(
        context: context,
        builder: (context) => Center(
              child: Material(
                borderRadius: BorderRadius.circular(8.0),
                color: Colors.black12,
                elevation: 5.0,
                child: Container(
                  height: 450,
                  color: UIData.fff,
                  child: buildBody(product),
                ),
              ),
            ));
  }

  Widget buildBody(ProductItem product) {
    return Stack(
      children: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  UIData.getImageWithWH(
                    product.medias.alt1.url,
                    90,
                    90,
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
                            style: TextStyle(color: Colors.black, fontSize: 15),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            product.price.toString(),
                            style:
                                TextStyle(color: UIData.fffa4848, fontSize: 15),
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
            buildSkuInfoWidget(skuInfo)
          ],
        ),
        Positioned(
          bottom: 20,
          left: 0,
          right: 0,
          child: UIData.getShapeButton(
            UIData.fffa4848,
            UIData.fff,
            345,
            45,
            "加入购物车",
            18,
            5,
            () {
              getSkuResult(product);
            },
          ),
        ),
      ],
    );
  }

  Column buildSkuInfoWidget(SkuInfo data) {
    return Column(
      children: data.options.map(
        (option) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  option.key,
                  style: TextStyle(fontSize: 15, color: UIData.ff353535),
                ),
              ),
              Row(
                children: option.values.map((value) {
                  return Card(
                    child: GestureDetector(
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(value.name),
                      ),
                      onTap: () {
                        widget.mapForUI[option.key] = value;
                        getSkuSelectInfo();
                        print(widget.mapForUI.toString());
                        Navigator.of(context).pop();
                      },
                    ),
                  );
                }).toList(),
              )
            ],
          );
        },
      ).toList(),
    );
  }
//
//  void getSkuList(int productId) {
//    Future<Result> skuFuture = SkuBridge.findGoodsSku(productId.toString());
//    skuFuture.then((result) {
//      if (result.code == 200) {
//        SkuInfo skuResult = SkuInfo.fromJson(result.data);
//        this.skuInfo = skuResult;
//        for (int i = 0; i < this.skuInfo.options.length; i++) {
//          var o = this.skuInfo.options[i];
//          List<ValuesListBean> vs = this.skuInfo.options[i].values;
//          for (int j = 0; j < vs.length; j++) {
//            var v = vs[j];
//            if (j == 0) {
//              mapForUI[o.key] = v;
//            }
//          }
//        }
//      } else {
//        Bridge.showLongToast(result.msg);
//      }
//    });
//  }

  void getSkuResult(ProductItem product) {
    if (skuInfo != null) {
      Set set = new Set<int>();
      widget.mapForUI.forEach((k, v) {
        set.add(v.id);
      });
      Int64List int64list = Int64List.fromList(set.toList());
      print(int64list);
      Future<Result> skuFuture =
          SkuBridge.findGoodsSkuInfo(productId.toString(), int64list);

      skuFuture.then((result) {
        if (result.code == 200) {
          SkuResult skuResult = SkuResult.fromJson(result.data);
          addCart(product, skuResult.id.toString());
        } else {
          Bridge.showLongToast(result.msg);
        }
      });
    } else {
      addCart(product, product.skuId.toString());
    }
  }

  void addCart(ProductItem product, String skuId) {
    Future<Result> future = CartBridge.addSku(
        productId,
        product.skuId.toString(),
        chooseCount,
        product.price,
        0,
        "规格",
        product.name,
        product.medias.alt1.url);
    future.then((result) {
      if (result.code == 200) {
        Cart categoryList = Cart.fromJson(result.data);
        setState(() {
          print("setState" + categoryList.totalCounts.toString());
          cartCount = categoryList.totalCounts;
        });
      } else {
        Bridge.showLongToast(result.msg);
      }
    });
  }
}
