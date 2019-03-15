import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:flutter_lib/bridge.dart';

import 'package:flutter_lib/ui/page/shop/search_shop_list.dart';
import 'package:flutter_lib/ui/page/shop/shop_list.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_lib/ui/widgets/banner/banner_widget.dart';
import 'package:flutter_lib/ui/widgets/banner/banner_evalutor.dart';
import 'package:flutter_lib/ui/page/invite/invite_friends.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class Model extends Object with BannerWithEval {
  final String imgUrl;

  Model({this.imgUrl});

  @override
  get bannerUrl => imgUrl;
}

class Choice {
  const Choice({this.title, this.icon});
  final String title;
  final IconData icon;
}

const List<Choice> choices = const <Choice>[
  const Choice(title: '热销精品', icon: Icons.directions_car),
  const Choice(title: '上新好货', icon: Icons.directions_bike),
  const Choice(title: '全部分类', icon: Icons.directions_boat),
  const Choice(title: '邀请返利', icon: Icons.directions_bus)
];

class _MyHomePageState extends State<MyHomePage> {
  final List<Model> data = [
    new Model(
        imgUrl:
            'https://img01.sogoucdn.com/app/a/100520093/60d2f4fe0275d790-007c9f9485c5acfd-bdc6566f9acf5ba2a7e7190734c38920.jpg'),
    new Model(
        imgUrl:
            'http://img4.duitang.com/uploads/item/201502/27/20150227083741_w5YjR.jpeg'),
    new Model(
        imgUrl:
            'http://img4.duitang.com/uploads/item/201501/06/20150106081248_ae4Rk.jpeg'),
    new Model(imgUrl: 'http://pic1.win4000.com/wallpaper/a/59322eda4daf0.jpg'),
    new Model(imgUrl: 'http://uploads.5068.com/allimg/1711/151-1G130093R1.jpg'),
  ];

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

  Future post() async {
    String result = await bridge.httpRequest(1, "发送一个post请求");
    setState(() {
      print("TTT " + result);
      bridge.showShortToast(result);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("home"),
        centerTitle: true,
      ),
      body: Container(
        child: buildCustomScrollView(),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Increment',
        child: Icon(Icons.add),
        onPressed: () {
          final navigator = Navigator.of(context);
          navigator.push(new MaterialPageRoute(
              builder: (context) => new SearchShopList()));
        },
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  CustomScrollView buildCustomScrollView() {
    return CustomScrollView(slivers: <Widget>[
      SliverList(
        delegate: SliverChildListDelegate(
          [
            buildBanner(),
            buildDefaultTabController(),
            Text(
              "热销精品",
            ),
          ],
        ),
      ),
      SliverGrid(
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        delegate: SliverChildListDelegate(
          [
            Image.network(data[1].bannerUrl),
            Image.network(data[1].bannerUrl),
            Image.network(data[1].bannerUrl),
            Image.network(data[1].bannerUrl),
            Image.network(data[1].bannerUrl),
            Image.network(data[1].bannerUrl),
          ],
        ),
      ),
      SliverList(
        delegate: SliverChildListDelegate(
          [
            Text(
              "\n热销商品榜>\n",
            ),
            Text(
              "上新好货",
            ),
          ],
        ),
      ),
      SliverGrid(
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        delegate: SliverChildListDelegate(
          [
            Image.network(data[2].bannerUrl),
            Image.network(data[2].bannerUrl),
            Image.network(data[2].bannerUrl),
            Image.network(data[2].bannerUrl),
            Image.network(data[2].bannerUrl),
            Image.network(data[2].bannerUrl),
          ],
        ),
      ),
      SliverList(
        delegate: SliverChildListDelegate(
          [
            Text(
              "所有上新好货>\n\n",
            ),
          ],
        ),
      ),
    ]);
  }

  DefaultTabController buildDefaultTabController() {
    return DefaultTabController(
      length: choices.length,
      child: new TabBar(
        isScrollable: false,
        labelColor: Colors.blue,
        onTap: (int i) {
          switch (i) {
            case 0:
            case 1:
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => new ShopListPage(
                            title: choices[i].title,
                          )));
              break;
            case 2:
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => new SearchShopList()));

              break;
            case 3:
              Navigator.push(context, new MaterialPageRoute(builder: (context) => new IviteFriendsPage()));

              break;
          }
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

  BannerWidget buildBanner() {
    return BannerWidget(
        data: data,
        curve: Curves.linear,
        onClick: (position, bannerWithEval) {
          print(position);
        });
  }
}
