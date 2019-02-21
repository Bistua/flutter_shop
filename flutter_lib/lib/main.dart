import 'package:flutter/material.dart';
import 'dart:ui';
import './bridge.dart';

import 'package:flutter_test/flutter_test.dart';
import './widget/banner/banner_widget.dart';
import './widget/banner/banner_evalutor.dart';

void main() => runApp(_widgetForRoute(window.defaultRouteName));

Widget _widgetForRoute(String route) {
  switch (route) {
    case 'route1':
      return MyApp();
    case 'route2':
      return MyApp();
    default:
      return Center(
        child: Text('Unknown route: $route', textDirection: TextDirection.ltr),
      );
  }
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

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
  int _counter = 0;
  String _batteryLevel = 'Unknown battery level.';

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

//
//  Future<Null> _getBatteryLevel() async {
//    String batteryLevel;
//    batteryLevel = await bridge.getBatteryLevel();
//    setState(() {
//      _batteryLevel = batteryLevel;
//    });
//  }
  @override
  void initState() {
    super.initState();
    Future<String> future = bridge.getBatteryLevel();
    future.then((value) {
      setState(() {
        _batteryLevel = value;
      });
    });
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
      post();
      if (_counter > 5) {
        print("TTT: +$_counter");
        bridge.gotoVideoPage();
      }
    });
  }

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
        title: Text(widget.title),
      ),
      body: Container(
        child: CustomScrollView(slivers: <Widget>[
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
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  DefaultTabController buildDefaultTabController() {
    return DefaultTabController(
      length: choices.length,
      child: new TabBar(
        isScrollable: false,
        labelColor: Colors.blue,
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
