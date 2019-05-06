import 'package:flutter/material.dart';
import 'package:flutter_lib/logic/bloc/rebate_bloc.dart';
import 'package:flutter_lib/logic/bloc/userinfo_bloc.dart';
import 'package:flutter_lib/model/rebateList.dart';
import 'package:flutter_lib/model/userinfo.dart';
import 'package:flutter_lib/ui/widgets/empty_widget.dart';
import 'package:flutter_lib/utils/uidata.dart';
import 'package:clipboard_manager/clipboard_manager.dart';

class InviteFriendsPage extends StatefulWidget {
  @override
  InviteFriendsPageState createState() => new InviteFriendsPageState();
}

class InviteFriendsPageState extends State<InviteFriendsPage> {
  UserInfoBloc userInfoBloc = new UserInfoBloc();
  RebateBloc rebateBloc = new RebateBloc();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: UIData.getCenterTitleAppBar("邀请好友下单", context),
        body: bodyData());
  }

  /*
   * 获取用户信息
   */
  Widget bodyData() {
    userInfoBloc.getUserInfo();
    return StreamBuilder<Userinfo>(
        stream: userInfoBloc.userInfo,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return getCustomScroll(snapshot.data);
          } else if (snapshot.hasError) {
            return EmptyWidget.WithSliverList(snapshot.error, () {
              userInfoBloc.getUserInfo();
            });
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }

  /*
   * 获取返现的列表数据
   */
  Widget getSliverDelegate() {
    rebateBloc.getRebatList();
    return StreamBuilder<List<RebateInfo>>(
        stream: rebateBloc.rebateInfo,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data == null || snapshot.data.isEmpty) {
              return EmptyWidget.WithSliverList(snapshot.error, () {
                userInfoBloc.getUserInfo();
              });
            } else {
              return getSliverChild(snapshot.data);
            }
          } else if (snapshot.hasError) {
            return EmptyWidget.WithSliverList(snapshot.error, () {
              rebateBloc.getRebatList();
            });
          } else {
            return progress();
          }
        });
  }

  Widget progress() {
    return SliverList(
      delegate: SliverChildListDelegate(
        [
          Center(child: CircularProgressIndicator()),
        ],
      ),
    );
  }

  /*
   * 获取 SliverChildBuilderDelegate
   */
  Widget getTextFromW() {
//    print("rankList:" + rankList.length.toString());
    return Text("123");
  }

  Widget getSliverChild(List<RebateInfo> data) {
//    print("rankList:" + rankList.length.toString());

    return SliverFixedExtentList(
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
                        child: Container(
                          width: 25,
                          height: 25,
                          child: Center(
                            child: UIData.getTextWidget(
                                data[index].userName, UIData.fff, 15),
                          ),
                          decoration: new BoxDecoration(
                            color: UIData.fffa4848,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                      new Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            child: UIData.getTextWidget(
                                data[index].iegralNum, UIData.ff353535, 12),
                            padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
                          ),
                          Padding(
                            child: UIData.getTextWidget(
                                data[index].consumeAmt, UIData.ff353535, 12),
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
        childCount: data.length,
      ),
    );
  }

  /*
   * 获取ui
   */
  CustomScrollView getCustomScroll(Userinfo userInfo) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverList(
          delegate: SliverChildListDelegate(
            [
              buildHeader(userInfo),
              buildVipInfo(userInfo),
              buildPayInfo(userInfo),
              buildFriendsPayInfoList(),
            ],
          ),
        ),
        getSliverDelegate(),
      ],
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

  Padding buildPayInfo(Userinfo userInfo) {
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
                    userInfo == null ? "" : userInfo.totalConsume,
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

  Padding buildVipInfo(Userinfo userInfo) {
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
                    userInfo == null ? "" : userInfo.balanceAmt,
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
              child: UIData.getMaxWidthButton("立即成为VIP", () {}),
            ),
          ],
        ),
      ),
    );
  }

  Padding buildHeader(Userinfo userInfo) {
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
              GestureDetector(
                child: new Padding(
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 14),
                  child: Text(
                    userInfo == null ? "" : userInfo.userCode,
                    style: TextStyle(color: UIData.ffffe116, fontSize: 30),
                  ),
                ),
                onTap: () {
                  if (userInfo != null && userInfo.userCode.isNotEmpty) {
                    ClipboardManager.copyToClipBoard(
                            userInfo == null ? "" : userInfo.userCode)
                        .then((result) {
                      final snackBar = SnackBar(
                        content: Text('已复制到粘贴板'),
                      );
                      Scaffold.of(context).showSnackBar(snackBar);
                    });
                  }
                },
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
