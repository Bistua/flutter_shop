import 'package:flutter/material.dart';
import 'package:flutter_lib/bridge.dart';



class PreferreSizeWidget extends PreferredSize {


  @override
  Size get preferredSize =>  new Size.fromHeight(48);


  @override
  Widget build(BuildContext context) {
    return  Container(
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          new GestureDetector(
            onTap: ()=>{
              bridge.showLongToast("click")
            },
            child: new Row(
              children: <Widget>[
                new Text(
                  '综合排序',
                ),
                new Icon(Icons.arrow_drop_down),
              ],
            ),
          ),
          new GestureDetector(
            child: new Text(
              '销量',
            ),
          ),
          new GestureDetector(
            child: new Text(
              '价格',
            ),
          ),
        ],
      ),
    );
  }


}