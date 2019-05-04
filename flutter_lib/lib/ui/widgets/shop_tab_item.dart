import 'package:flutter/material.dart';

class PreferreSizeWidget extends StatelessWidget implements PreferredSize {
  final ValueChanged<bool> onChanged;
  @override
  Size get preferredSize => new Size.fromHeight(48);

  @override
  Widget get child => new TabItemPage();

  @override
  Widget build(BuildContext context) {
    return new TabItemPage(
      onChanged: onChanged,
    );
  }

  PreferreSizeWidget(this.onChanged);
}

class TabItemPage extends StatefulWidget {
  final ValueChanged<bool> onChanged;

  const TabItemPage({Key key, this.onChanged}) : super(key: key);
  @override
  TabItemState createState() => TabItemState(onChanged);
}

class TabItemState extends State<TabItemPage> {
  var isArrowDown = true;

  final ValueChanged<bool> onChanged;

  TabItemState(this.onChanged);

  void _handleTap() {
    onChanged(isArrowDown);
  }

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
      child: new Row(
        children: <Widget>[
          new Text(
            s,
            style: TextStyle(color: Colors.red),
          ),
          isArrowDown
              ? new Icon(
                  Icons.arrow_drop_down,
                  color: Colors.red,
                )
              : new Icon(
                  Icons.arrow_drop_up,
                  color: Colors.red,
                )
        ],
      ),
      onTap: () {
        this.setState(() {
          print("点击前：" + isArrowDown.toString());
          isArrowDown = !this.isArrowDown;
          print("点击后：" + isArrowDown.toString());
          _handleTap();
        });
      },
    );
  }
}
