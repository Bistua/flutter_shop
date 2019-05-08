import 'package:flutter/material.dart';

class Countdown extends AnimatedWidget {
  Countdown({Key key, this.animation,this.color}) : super(key: key, listenable: animation);
  Animation<int> animation;
  Color color;


  @override
  build(BuildContext context) {
    return new Text(
      animation.value.toString() + "后重试",
      style: new TextStyle(fontSize: 10.0,color: Colors.white),
    );
  }
}
