import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_lib/logic/bloc/home_bloc.dart';
import 'package:flutter_lib/logic/bloc/product_bloc.dart';
import 'package:flutter_lib/logic/viewmodel/product_view_model.dart';
import 'package:flutter_lib/model/Banner.dart';
import 'package:flutter_lib/model/product.dart';
import 'package:flutter_lib/model/productitem.dart';
import 'package:flutter_lib/ui/inherited/product_provider.dart';
import 'package:flutter_lib/ui/widgets/banner/banner_widget.dart';
import 'package:flutter_lib/ui/widgets/empty_widget.dart';
import 'package:flutter_lib/utils/uidata.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class Choice {
  const Choice({this.title, this.icon, this.action});

  final String title;
  final IconData icon;
  final String action;
}

const List<Choice> choices = const <Choice>[
  const Choice(
      title: '热销精品', icon: Icons.directions_car, action: UIData.ShopListPage),
  const Choice(
      title: '上新好货', icon: Icons.directions_bike, action: UIData.ShopListPage),
  const Choice(
      title: '全部分类',
      icon: Icons.directions_boat,
      action: UIData.ShopCategoryList),
  const Choice(
      title: '邀请返利',
      icon: Icons.directions_bus,
      action: UIData.IviteFriendsPage)
];

class _MyHomePageState extends State<MyHomePage> {
  ProductBloc productBloc = ProductBloc();

  HomeBloc homeBloc = HomeBloc();

  final List<Product> discountList = ProductViewModel().getDiscountList();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {}

  @override
  Widget build(BuildContext context) {
    return new SafeArea(
      top: true,
      child: buildCustomScrollView(),
    );
  }

  CustomScrollView buildCustomScrollView() {
    return CustomScrollView(slivers: <Widget>[
      SliverList(
        delegate: SliverChildListDelegate(
          [
            buildHeader(),
          ],
        ),
      ),
      buildBanner(),
      SliverList(
        delegate: SliverChildListDelegate(
          [
            buildType(),
            buildAdvertisement(
                "https://img20.360buyimg.com/mobilecms/s350x128_jfs/t8554/10/1668315357/28454/82af77f0/59be2c79Ne4502dcf.jpg!q90!cc_350x128.webp"),
            buildDiscount(),
            Container(
              height: 1.0,
              width: double.infinity,
            ),
          ],
        ),
      ),
      SliverGrid(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 1.0,
          mainAxisSpacing: 1.0,
          childAspectRatio: 1.88,
        ),
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            return Container(
              color: Colors.white,
              child: buildDiscountItem(index, discountList[index]),
            );
          },
          childCount: discountList.length,
        ),
      ),
      SliverList(
        delegate: SliverChildListDelegate(
          [
            Container(
              height: 10.0,
              width: double.infinity,
            ),
            buildMustBay(
                "https://img11.360buyimg.com/mobilecms/s350x250_jfs/t1/23441/6/14922/36622/5cac1223Edaf540b0/7df256141224531d.jpg!q90!cc_350x250.webp",
                "https://img11.360buyimg.com/mobilecms/s350x250_jfs/t1/30730/6/10877/44332/5cb34d0cE9e0fcea6/9c3cde5807ab4186.jpg!q90!cc_350x250.webp"),
            buildActivity(),
            buildHotShop(),
          ],
        ),
      ),
      getFeatureGrid(),
    ]);
  }

  DefaultTabController buildDefaultTabController() {
    return DefaultTabController(
      length: choices.length,
      child: new TabBar(
        isScrollable: false,
        labelColor: Colors.blue,
        onTap: (int i) {
          Navigator.pushNamed(context, choices[i].action,
              arguments: choices[i].title);
        },
        tabs: choices.map((Choice choice) {
          return new Tab(
            text: choice.title,
            icon: new Icon(
              choice.icon,
              color: Colors.blue,
            ),
          );
        }).toList(),
      ),
    );
  }

  buildHeader() {
    return Container(
      height: 44.0,
      color: Colors.white,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "速易销",
                  style: TextStyle(
                      color: Color(0xFFFA4848),
                      fontSize: 16,
                      fontStyle: FontStyle.italic),
                ),
                Text(
                  "SU YI TRADE",
                  style: TextStyle(color: Color(0xFFFA4848), fontSize: 6),
                ),
              ],
            ),
          ),
          Expanded(
            child: InkWell(
              child: Stack(
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    height: 30.0,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Color(0xFFF5F5F5), width: 15.0),
                      borderRadius:
                          new BorderRadius.all(new Radius.circular(15.0)),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(11.0, 0.0, 0.0, 0.0),
                    alignment: Alignment.centerLeft,
                    height: 30.0,
                    child: Icon(
                      Icons.search,
                      color: Color(0xFF999999),
                      size: 16.0,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(32.0, 0.0, 0.0, 0.0),
                    height: 30.0,
                    child: new Text(
                      "请输入搜索商品",
                      style: TextStyle(color: Color(0xFF999999), fontSize: 12),
                    ),
                    alignment: Alignment.centerLeft,
                  ),
                ],
              ),
              //搜索框点击事件
              onTap: () {
                Navigator.pushNamed(context, UIData.SearchShopList);
              },
            ),
          ),
          InkWell(
            child: Padding(
              padding: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
              child: Image.asset(
                'images/icon_code.png',
                width: 20.0,
                height: 20.0,
              ),
            ),
            //二维码图标点击事件
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget buildBanner() {
    homeBloc.getImages();
    return SliverList(
      delegate: SliverChildListDelegate(
        [
          StreamBuilder<List<DataListBean>>(
              stream: homeBloc.tabItems,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return EmptyWidget(snapshot.error, () {
                    homeBloc.getImages();
                  });
                } else if (snapshot.hasData) {
                  if (snapshot.data.isNotEmpty) {
                    return BannerWidget(
                        data: snapshot.data,
                        curve: Curves.linear,
                        onClick: (position, bannerWithEval) {
                          print(position);
                        });
                  } else {
                    return EmptyWidget("暂无数据", () {
                      homeBloc.getImages();
                    });
                  }
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              })
        ],
      ),
    );
  }

  Container buildType() {
    return Container(
      padding: EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 4.0),
      color: Colors.white,
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: buildTypeChild(
                  0,
                  "服饰",
                  "images/shop_type_hat.png",
                ),
              ),
              Expanded(
                child: buildTypeChild(1, "鞋帽箱包", "images/shop_type_hat.png"),
              ),
              Expanded(
                child: buildTypeChild(2, "丽人", "images/shop_type_beauty.png"),
              ),
              Expanded(
                child:
                    buildTypeChild(3, "家具家装", "images/shop_type_furniture.png"),
              ),
              Expanded(
                child: buildTypeChild(4, "生活服务", "images/shop_type_life.png"),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: buildTypeChild(5, "数码", "images/shop_type_hat.png"),
              ),
              Expanded(
                child: buildTypeChild(6, "办公", "images/shop_type_office.png"),
              ),
              Expanded(
                child: buildTypeChild(7, "百货超市", "images/shop_type_store.png"),
              ),
              Expanded(
                child:
                    buildTypeChild(8, "教育培训", "images/shop_type_education.png"),
              ),
              Expanded(
                child: buildTypeChild(
                    9, "分类", "images/shop_type_classification.png"),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Container buildAdvertisement(String imageUrl) {
    return Container(
      padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
      color: Color(0xFFF6F6F6),
      child: InkWell(
        child: UIData.getImageWithWHFit(imageUrl, BoxFit.cover, 100, 100),
        onTap: () {},
      ),
    );
  }

  Container buildDiscount() {
    return Container(
      height: 46.0,
      color: Colors.white,
      child: InkWell(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              width: 80.0,
              height: 25.0,
              child: Text(
                "优惠好品",
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
              decoration: new BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(15.0),
                      bottomRight: Radius.circular(15.0)),
                  gradient: RadialGradient(
                      colors: [Color(0xFFFF5341), Color(0xFFFF873E)],
                      radius: 12.5,
                      tileMode: TileMode.mirror)),
            ),
            Expanded(
              child: Container(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Text(
                  "更多",
                  style: TextStyle(color: UIData.ff999999, fontSize: 12),
                ),
                Padding(
                  child: Icon(
                    Icons.arrow_forward_ios,
                    color: UIData.ff999999,
                    size: 9,
                  ),
                  padding: EdgeInsets.fromLTRB(2, 0, 12, 0),
                ),
              ],
            ),
          ],
        ),
        onTap: () {},
      ),
    );
  }

  Widget getFeatureGrid() {
    productBloc.getFeatures(1, 10);
    return ProductProvider(
      productBloc: productBloc,
      child: StreamBuilder<List<ProductItem>>(
          stream: productBloc.productItems,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data.isNotEmpty) {
                return getFeatursGrid(snapshot.data);
              } else {
                return EmptyWidget.WithSliverList("暂无数据", () {
                  productBloc.getFeatures(1, 10);
                });
              }
            } else if (snapshot.hasError) {
              return EmptyWidget.WithSliverList(snapshot.error, () {
                productBloc.getFeatures(1, 10);
              });
            } else {
              return SliverList(
                delegate: SliverChildListDelegate(
                  [
                    Center(child: CircularProgressIndicator()),
                  ],
                ),
              );
            }
          }),
    );
  }

  SliverGrid getFeatursGrid(List<ProductItem> items) {
    return SliverGrid(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: (0.7), //item长宽比
        mainAxisSpacing: 5.0,
        crossAxisSpacing: 5.0,
      ),
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.all(2.0),
            child: Container(
              child: productGrid(items[index], index),
            ),
          );
        },
        childCount: items.length,
      ),
    );
  }

  Container buildTypeChild(int type, String typeName, String typeImg) {
    return Container(
        child: InkWell(
      child: Column(
        children: <Widget>[
          Image.asset(
            typeImg,
            width: 43.0,
            height: 43.0,
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 16.0),
            child: Text(
              typeName,
              style: TextStyle(color: Color(0xFF666666), fontSize: 11),
            ),
          ),
        ],
      ),
      //每一个类别点击事件
      onTap: () {
        switch (type) {
          case 0:
            break;
          case 1:
            break;
          case 2:
            break;
          case 3:
            break;
          case 4:
            break;
          case 5:
            break;
          case 6:
            break;
          case 7:
            break;
          case 8:
            break;
          case 9:
            Navigator.pushNamed(context, UIData.ShopCategoryList,
                arguments: "全部分类");
            break;
        }
      },
    ));
  }

  Container buildDiscountItem(int index, Product product) {
    return Container(
      child: InkWell(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(12.0, 16.0, 0.0, 4.0),
                    child: Text(
                      product.name,
                      maxLines: 1,
                      style: TextStyle(color: Color(0xFF353535), fontSize: 13),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(12.0, 0.0, 0.0, 0.0),
                    child: Text(
                      product.description,
                      maxLines: 1,
                      style: TextStyle(color: Color(0xFF999999), fontSize: 11),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(12.0, 8.0, 0.0, 0.0),
                    child: Text(
                      product.price,
                      style: TextStyle(color: Color(0xFFEF2F2F), fontSize: 15),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(3.0, 12.0, 6.0, 0.0),
              child: UIData.getImageWithWHFit(
                product.image,
                BoxFit.cover,
                75.0,
                75.0,
              ),
            ),
//            index % 2 == 0
//                ? Container()
//                : Container(
//                    width: 1.0,
//                    color: Color(0xFFEEEEEE),
//                  ),
          ],
        ),
        onTap: () {
          Navigator.pushNamed(context, UIData.ShopDetailPage,
              arguments: product.skuId);
        },
      ),
    );
  }

  Container buildMustBay(String leftImage, String rightImage) {
    return Container(
      height: 130.0,
      child: Row(
        children: <Widget>[
          Expanded(
              child: Stack(
            children: <Widget>[
              UIData.getImageWithWHFit(
                leftImage,
                BoxFit.cover,
                double.infinity,
                130.0,
              ),
              Container(
                alignment: Alignment.center,
                width: 80.0,
                height: 25.0,
                child: Text(
                  "必买清单",
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
                decoration: new BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(15.0),
                        bottomRight: Radius.circular(15.0)),
                    gradient: RadialGradient(
                        colors: [Color(0xFF2CB4B9), Color(0xFF82E6D0)],
                        radius: 12.5,
                        tileMode: TileMode.mirror)),
              ),
            ],
          )),
          Container(
            color: Colors.white,
            padding: EdgeInsets.fromLTRB(2.0, 0.0, 0.0, 0.0),
            child: UIData.getImageWithWHFit(
              rightImage,
              BoxFit.cover,
              166.0,
              130.0,
            ),
          ),
        ],
      ),
    );
  }

  Container buildActivity() {
    return Container(
      color: Colors.white,
      height: 270.0,
      child: Column(
        children: <Widget>[
          Expanded(
            child: Row(
              children: <Widget>[
                Expanded(
                  child: InkWell(
                    child: buildActivityTopLeft(),
                    //天天特价栏点击事件
                    onTap: () {},
                  ),
                ),
                Container(
                  width: 1.0,
                  color: Color(0xFFEEEEEE),
                ),
                Expanded(
                  child: InkWell(
                    child: buildActivityTopRight(),
                    //品牌闪购点击事件
                    onTap: () {},
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: <Widget>[
                Expanded(
                  child: buildActivityBottom(0, "天猫Outlets", "大品牌79元购",
                      "https://img11.360buyimg.com/mobilecms/s110x110_jfs/t1/22034/24/5708/134994/5c41416cE61e9ab02/358c89e09077ac5c.png!q90!cc_110x110.webp"),
                ),
                Container(
                  width: 1.0,
                  color: Color(0xFFEEEEEE),
                ),
                Expanded(
                  child: buildActivityBottom(1, "量贩优选", "1分钱疯抢",
                      "https://img11.360buyimg.com/mobilecms/s110x110_jfs/t1/14748/13/13064/114779/5c9dc90fEcd69f15a/9a3ae485e894bf66.jpg!q90!cc_110x110.webp"),
                ),
                Container(
                  width: 1.0,
                  color: Color(0xFFEEEEEE),
                ),
                Expanded(
                  child: buildActivityBottom(2, "淘宝心选", "官方自营品牌",
                      "https://img11.360buyimg.com/mobilecms/s110x110_jfs/t1/23443/5/10735/27836/5c88a96aE59ff0726/5f43bec36e308837.jpg!q90!cc_110x110.webp"),
                ),
                Container(
                  width: 1.0,
                  color: Color(0xFFEEEEEE),
                ),
                Expanded(
                  child: buildActivityBottom(3, "聚名品", "轻奢限量抢",
                      "https://img11.360buyimg.com/mobilecms/s110x110_jfs/t1/29836/32/1174/55982/5c0fbfe7E5d0a5db9/3226b9a61def3bb3.jpg!q90!cc_110x110.webp"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Column buildActivityTopLeft() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 4.0),
          child: Text(
            "天天特价",
            style: TextStyle(color: Color(0xFFFF3507), fontSize: 14),
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 4.0),
          child: Text(
            "9.9元包邮好货随心抢",
            style: TextStyle(color: Color(0xFF999999), fontSize: 11),
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
          child: Row(
            children: <Widget>[
              UIData.getImageWithWHFit(
                "https://img13.360buyimg.com/mobilecms/s140x140_jfs/t1/5542/25/10695/184499/5bcc0adcE903a8a97/c43423eedf3039cf.jpg!q90.webp",
                BoxFit.cover,
                70.0,
                70.0,
              ),
              Expanded(
                child: Container(),
              ),
              UIData.getImageWithWHFit(
                "https://img12.360buyimg.com/mobilecms/s140x140_jfs/t28132/336/144040487/125605/531bc317/5be9427dN7a38cc7f.jpg!q90.webp",
                BoxFit.cover,
                70.0,
                70.0,
              ),
            ],
          ),
        ),
        Expanded(
          child: Container(),
        ),
        Container(
          height: 1.0,
          color: Color(0xFFEEEEEE),
        )
      ],
    );
  }

  Column buildActivityTopRight() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 4.0),
          child: Text(
            "品牌闪购",
            style: TextStyle(color: Color(0xFF333333), fontSize: 14),
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 4.0),
          child: Text(
            "每日签到 可抢5折卷",
            style: TextStyle(color: Color(0xFF999999), fontSize: 11),
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
          child: Row(
            children: <Widget>[
              UIData.getImageWithWHFit(
                "https://img11.360buyimg.com/mobilecms/s140x140_jfs/t1/36973/38/1895/117319/5cb453e9E93fc31a1/6edd54fcfd32ce9c.png!q90.webp",
                BoxFit.cover,
                70.0,
                70.0,
              ),
              Expanded(
                child: Container(),
              ),
              UIData.getImageWithWHFit(
                "https://img11.360buyimg.com/mobilecms/s140x140_jfs/t1/9339/14/3383/296696/5bd69f43E5078db49/40af3283649c059e.jpg!q90.webp",
                BoxFit.cover,
                70.0,
                70.0,
              ),
            ],
          ),
        ),
        Expanded(
          child: Container(),
        ),
        Container(
          height: 1.0,
          color: Color(0xFFEEEEEE),
        )
      ],
    );
  }

  InkWell buildActivityBottom(
      int type, String title, String subTitle, String imageUrl) {
    return InkWell(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 4.0),
            child: Text(
              title,
              style: TextStyle(color: Color(0xFF333333), fontSize: 14),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 4.0),
            child: Text(
              subTitle,
              style: TextStyle(color: Color(0xFF999999), fontSize: 11),
            ),
          ),
          Container(
            alignment: Alignment.center,
            child: UIData.getImageWithWHFit(
              imageUrl,
              BoxFit.cover,
              70.0,
              70.0,
            ),
          ),
        ],
      ),
      onTap: () {
        switch (type) {
          case 0:
            break;
          case 1:
            break;
          case 2:
            break;
          case 3:
            break;
        }
      },
    );
  }

  Container buildHotShop() {
    return Container(
      color: Color(0xFFF6F6F6),
      alignment: Alignment.center,
      height: 62.0,
      child: Image.asset(
        "images/icon_home_hot_shop.png",
        height: 15.0,
      ),
    );
  }

  Widget productGrid(ProductItem product, int index) {
    String imageUrl = "";
    if (product.medias.length > 0) {
      imageUrl = product.medias[0].toString();
    }
    return Padding(
      padding: EdgeInsets.fromLTRB(
          index % 2 == 0 ? 5.0 : 0.0, 0.0, index % 2 == 0 ? 0.0 : 5.0, 0.0),
      child: new GestureDetector(
        child: new Card(
          elevation: 5.0,
          child: new Container(
            child: new Stack(
              children: <Widget>[
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: UIData.getImage(
                    imageUrl,
                  ),
                ),
                Positioned(
                    bottom: 8,
                    child: new Container(
                      color: Colors.white,
                      child: new Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          new Padding(
                            padding: EdgeInsets.fromLTRB(4, 0, 4, 4),
                            child: new Text(
                              product.name,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: TextStyle(
                                  fontSize: 12, color: UIData.ff353535),
                            ),
                          ),
                          new Padding(
                            padding: EdgeInsets.fromLTRB(4, 4, 4, 4),
                            child: new Text(
                              "￥" + product.price.toString(),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(color: Colors.red, fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                    )),
              ],
            ),
          ),
        ),
        onTap: () {
          Navigator.pushNamed(context, UIData.ShopDetailPage,
              arguments: product.id.toString());
        },
      ),
    );
  }
}
