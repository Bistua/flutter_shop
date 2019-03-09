
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//主页为有状态的
class HomePage extends StatefulWidget {


  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return HomePageState();
  }
}

//此处是交互
class HomePageState extends State<HomePage> {
  get controller => null;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: [        BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
            title: Text(
              'HOME',
            )),
        BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
            title: Text(
              'HOME',
            )),
        BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
            title: Text(
              'HOME',
            )),
        ],
        currentIndex: 0,
      ),appBar: AppBar(
      title: Text('hello'),
    ),);
  }
}