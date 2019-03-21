import 'package:flutter/material.dart';
import 'package:flutter_lib/utils/uidata.dart';
import 'package:flutter_lib/logic/bloc/product_bloc.dart';
import 'package:flutter_lib/model/product.dart';
import 'package:flutter_lib/ui/widgets/shop_tab_item.dart';
import 'package:flutter_lib/model/rankList.dart';
import 'package:flutter_lib/logic/viewmodel/rank_view_model.dart';

class IviteFriendsPage extends StatefulWidget {
  IviteFriendsPage({Key key}) : super(key: key);

  @override
  IviteFriendsPageState createState() => new IviteFriendsPageState();
}

class IviteFriendsPageState extends State<IviteFriendsPage> {
  BuildContext _context;

  @override
  Widget build(BuildContext context) {
    _context = context;
    ProductBloc productBloc = ProductBloc();
    RankViewModel rankViewModel = RankViewModel();
    List<Rank> rankList = rankViewModel.getMenuItems();
    print(productBloc.productItems);
    return new Scaffold(
      appBar: UIData.getCenterTitleAppBar("邀请好友下单", context),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildListDelegate(
              [
                buildHeader(),
                buildVipInfo(),
                buildPayInfo(),
                buildFriendsPayInfoList(),
              ],
            ),
          ),
          SliverFixedExtentList(
            itemExtent: 77, // I'm forcing item heights
            delegate: SliverChildBuilderDelegate(
              (context, index) => Container(
                    color: UIData.fff,
                    child: new Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.fromLTRB(17, 18, 15, 18),
                              child:  Container(
                                width: 25,
                                height: 25,
                                child: Center(
                                  child:  UIData.getTextWidget((index+1).toString(), UIData.fff, 15),
                                ),
                                decoration: new BoxDecoration(
                                  color: rankList[index].color,
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                            new Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  child: UIData.getTextWidget(rankList[index].name,
                                      UIData.ff353535, 12),
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
                                ),
                                Padding(
                                  child: UIData.getTextWidget(rankList[index].xiaofei,
                                      UIData.ff353535, 12),
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Divider(),
                      ],
                    ),
                  ),
              childCount: rankList.length,
            ),
          ),
        ],
      ),
    );
  }

  Padding buildFriendsPayInfoList() {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
      child: new Container(
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(0, 13, 0, 15),
              child: new Column(
                children: <Widget>[
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.cloud_upload),
                      Padding(
                        padding: EdgeInsets.fromLTRB(7, 0, 0, 0),
                        child: UIData.getTextWidget(
                            "好友成功消费排行版", UIData.ff353535, 15),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Padding buildPayInfo() {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
      child: new Container(
        color: UIData.fff,
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "我的成功消费金额",
                    style: TextStyle(color: UIData.ff353535, fontSize: 15),
                  ),
                  Text(
                    "累计1560.0",
                    style: TextStyle(color: UIData.fffa4848, fontSize: 15),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
              child: Divider(),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(15, 8, 15, 10),
              child: Text(
                "成功消费金额指的是所有确认收货的订单累计金额。",
                style: TextStyle(color: UIData.ff999999, fontSize: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Padding buildVipInfo() {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
      child: new Container(
        color: UIData.fff,
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "我的金币",
                    style: TextStyle(color: UIData.ff353535, fontSize: 15),
                  ),
                  Text(
                    "0个",
                    style: TextStyle(color: UIData.ff353535, fontSize: 15),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
              child: Divider(),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(15, 8, 15, 10),
              child: Text(
                "我不是VIP，仅当好友成功消费金额大于我时，为我返现1次。成为VIP立享好友消费立即返积分",
                style: TextStyle(color: UIData.ff999999, fontSize: 12),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(15, 8, 15, 10),
              child:UIData.getMaxWidthButton("立即成为VIP", (){

              }),
            ),
          ],
        ),
      ),
    );
  }

  Padding buildHeader() {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
      child: new Container(
        color: UIData.fffa4848,
        child: new Center(
          child: new Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(0, 24, 0, 15),
                child: Text(
                  "邀请好友下单返金币",
                  style: TextStyle(color: UIData.fff, fontSize: 15),
                ),
              ),
              Text(
                "专属邀请码",
                style: TextStyle(color: UIData.ffffa5a5, fontSize: 12),
              ),
              new Padding(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 14),
                child: Text(
                  "GX10100166",
                  style: TextStyle(color: UIData.ffffe116, fontSize: 30),
                ),
              ),
              new Padding(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 26),
                child: Text(
                  "好友注册或接受邀请时使用，点击邀请码复制",
                  style: TextStyle(color: UIData.ffffa5a5, fontSize: 12),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
