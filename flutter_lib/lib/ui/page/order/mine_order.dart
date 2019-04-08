import 'package:flutter/material.dart';
import 'package:flutter_lib/model/mineOrderTab.dart';
import 'package:flutter_lib/ui/page/order/mine_order_list.dart';
import 'package:flutter_lib/utils/uidata.dart';

class MineOrderPage extends StatefulWidget {
  int page;

  MineOrderPage(int page, {Key key}) : super(key: key) {
    this.page = page;
  }

  @override
  MineOrderPageState createState() => new MineOrderPageState(page);
}

//定义tab页基本数据结构
final List<MineOrderTab> mineOrderTabs = <MineOrderTab>[
  new MineOrderTab('全部', 'all'),
  new MineOrderTab('待发货', 'shipped'),
  new MineOrderTab('待收货', 'received'),
  new MineOrderTab('待评价', 'evaluated'),
];

class MineOrderPageState extends State<MineOrderPage> {
  MineOrderTab _currenttab; //定义默认打开的Tab页
  MineOrderPageState(int page) {
    _currenttab = mineOrderTabs[page];
  }

  void _selectTab(MineOrderTab tab) {
    //修改状态值
    setState(() {
      _currenttab = tab;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: UIData.getCenterTitleAppBar("我的订单", context),
      body: Stack(
        children: <Widget>[
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: TabNavigation(
              currentTab: _currenttab,
              onSelectTab: _selectTab,
            ),
          ),
          Positioned(
            top: 45,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              color: Color(0xFFF5F5F5),
              child: Stack(
                  children: mineOrderTabs.map((item) {
                return Offstage(
                  offstage: _currenttab != item,
                  child: MineOrderList(
                      pageKey: PageStorageKey<MineOrderTab>(item),
                      orderType: item.tabDescribe),
                );
              }).toList()),
            ),
          ),
        ],
      ),
    );
  }
}

class TabNavigation extends StatelessWidget {
  TabNavigation({this.currentTab, this.onSelectTab});

  final MineOrderTab currentTab;
  final ValueChanged<MineOrderTab>
      onSelectTab; //这个参数比较关键，仔细理解下，省了setState()调用的环节

  @override
  Widget build(BuildContext context) {
    return Row(
        children: mineOrderTabs.map((item) {
      return Expanded(
          child: GestureDetector(
              //手势监听控件，用于监听各种手势
              child: Container(
                  color: Color(0xFFFFFFFF),
                  height: 45.0,
                  //alignment: Alignment.center,
                  child: Stack(
                    alignment: AlignmentDirectional.center,
                    children: <Widget>[
                      Text(
                        item.tabName,
                        style: TextStyle(
                            color: _colorTabMatching(item: item),
                            fontSize: 14.0),
                      ),
                      Positioned(
                        bottom: 0.0,
                        child: Container(
                          alignment: Alignment.center,
                          width: 60.0,
                          height: 2.0,
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: currentTab == item
                                    ? Color(0xFFFA4848)
                                    : Colors.transparent,
                                width: 1.0),
                            borderRadius:
                                new BorderRadius.all(new Radius.circular(1.0)),
                          ),
                        ),
                      ),
                    ],
                  )),
              onTap: () => onSelectTab(
                    item,
                  )
              //onSelectTab函数的使用非常巧妙，
              //相当于定义了一个接口，可操控当前控件以外的数据
              ));
    }).toList());
  }

  //定义tab被选中和没被选中的颜色样式
  Color _colorTabMatching({MineOrderTab item}) {
    return currentTab == item ? Color(0xffF94847) : Color(0xff666666);
  }
}
