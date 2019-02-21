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
  const Choice(title: 'CAR', icon: Icons.directions_car),
  const Choice(title: 'BICYCLE', icon: Icons.directions_bike),
  const Choice(title: 'BOAT', icon: Icons.directions_boat),
  const Choice(title: 'BUS', icon: Icons.directions_bus),
  const Choice(title: 'TRAIN', icon: Icons.directions_railway),
  const Choice(title: 'WALK', icon: Icons.directions_walk),
];

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  String _batteryLevel = 'Unknown battery level.';

  final List<Model> data = [
    new Model(
        imgUrl:'https://img01.sogoucdn.com/app/a/100520093/60d2f4fe0275d790-007c9f9485c5acfd-bdc6566f9acf5ba2a7e7190734c38920.jpg'),
    new Model(
        imgUrl:'http://img4.duitang.com/uploads/item/201502/27/20150227083741_w5YjR.jpeg'),
    new Model(
        imgUrl:'http://img4.duitang.com/uploads/item/201501/06/20150106081248_ae4Rk.jpeg'),
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
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            BannerWidget(
                data: data,
                curve: Curves.linear,
                onClick: (position, bannerWithEval) {
                  print(position);
                }),
            DefaultTabController(
              length: choices.length,
              child: new TabBar(
                isScrollable: true,
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
            ),
            Text(
              "剩余电量" + _batteryLevel + "%",
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
