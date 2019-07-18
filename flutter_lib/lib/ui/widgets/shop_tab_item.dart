import 'package:flutter/material.dart';
import 'package:flutter_lib/utils/uidata.dart';

class PreferreSizeWidget extends StatelessWidget implements PreferredSize {
  final ValueChanged<int> onChanged;
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
  final ValueChanged<int> onChanged;

  const TabItemPage({Key key, this.onChanged}) : super(key: key);
  @override
  TabItemState createState() => TabItemState(onChanged);
}

class TabItemState extends State<TabItemPage> {
  var isArrowDown = true;
  var isArrowDown1 = true;
  var isArrowDown2 = true;

  int lastSelectType = 1;
  final ValueChanged<int> onChanged;

  TabItemState(this.onChanged);

  void _handleTap(int type) {
    onChanged(type);
  }

  @override
  Widget build(BuildContext context) {
    return buildContainer();
  }

  Container buildContainer() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          buildArrowDownUpText(1, "综合"),
          buildArrowDownUpText(3, "销量"),
          buildArrowDownUpText(5, "价格"),
        ],
      ),
    );
  }

  GestureDetector buildArrowDownUpText(int type, String s) {
    return new GestureDetector(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: new Row(
          children: <Widget>[buildText(type,s), getIcon(type)],
        ),
      ),
      onTap: () {
        this.setState(() {
          lastSelectType = type;
          if (type == 1) {
            isArrowDown = !this.isArrowDown;
            _handleTap(isArrowDown ? type : (type + 1));
          } else if (type == 3) {
            isArrowDown1 = !this.isArrowDown1;
            _handleTap(isArrowDown1 ? type : (type + 1));
          } else {
            isArrowDown2 = !this.isArrowDown2;
            _handleTap(isArrowDown2 ? type : (type + 1));
          }
        });
      },
    );
  }

  Text buildText(int type, String s) {
    Color color = UIData.ff353535;
    if (lastSelectType == type) {
      color = UIData.fffa4848;
    } else {
      color = UIData.ff353535;
    }
    return new Text(
      s,
      style: TextStyle(color: color),
    );
  }

  Icon getIcon(int type) {
    bool arrow = true;
    Color color = UIData.ff353535;

    if (lastSelectType == type) {
      color = UIData.fffa4848;
    } else {
      color = UIData.ff353535;
    }
    switch (type) {
      case 1:
        arrow = isArrowDown;
        break;
      case 3:
        arrow = isArrowDown1;
        break;
      case 5:
        arrow = isArrowDown2;
        break;
    }
    return arrow
        ? new Icon(
            Icons.arrow_drop_down,
            color: color,
          )
        : new Icon(
            Icons.arrow_drop_up,
            color: color,
          );
  }
}
