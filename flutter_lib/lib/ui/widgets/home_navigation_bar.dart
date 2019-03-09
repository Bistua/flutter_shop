import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeNavigationBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: [
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
        BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
            title: Text(
              'HOME',
            )),
      ],
      currentIndex: 0,
    );
  }
}
