import 'package:flutter/material.dart';
import 'package:flutter_lib/bridge.dart';

class PreferreSizeWidget extends StatelessWidget implements PreferredSize {
  @override
  Size get preferredSize => new Size.fromHeight(48);

  @override
  Widget get child => new TabItemPage();

  @override
  Widget build(BuildContext context) {
    return new TabItemPage();
  }
}

class TabItemPage extends StatefulWidget {
  @override
  TabItemState createState() => TabItemState();
}

class TabItemState extends State<TabItemPage> {
  var isArrowDown = true;
  @override
  Widget build(BuildContext context) {
    return buildContainer();
  }

  Container buildContainer() {
    return Container(
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          buildArrowDownUpText("综合"),
          buildGestureDetector("销量"),
          buildGestureDetector("价格"),
        ],
      ),
    );
  }



  GestureDetector buildGestureDetector(String s) {
    return new GestureDetector(
      child: new Text(
        s,
      ),
    );
  }



  GestureDetector buildArrowDownUpText(String s) {

    return new GestureDetector(
      child:new Row(
        children: <Widget>[
          new Text(
            s,
          ),
          isArrowDown?new Icon(Icons.arrow_drop_down):new Icon(Icons.arrow_drop_up)
        ],
      ),
      onTap: ()=>{
        this.setState((){
          isArrowDown = !isArrowDown;
        })
      },
    );
  }

  String value = "综合";

  Widget buildDropdownButton() {
    return DropdownButtonHideUnderline(
        child:  DropdownButton<String>(
          value: value,
          onChanged: (String newValue) {
            setState(() {
              value = newValue;
            });
          },
          items: <String>['综合', '价格', '热门']
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),

    );
  }
}
