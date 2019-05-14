import 'package:flutter/material.dart';
import 'package:flutter_lib/bridge/common_bridge.dart';
import 'package:flutter_lib/bridge/invite_bridge.dart';
import 'package:flutter_lib/bridge/order_bridge.dart';
import 'package:flutter_lib/model/Result.dart';
import 'package:flutter_lib/model/order_result.dart';
import 'package:flutter_lib/ui/widgets/common_dialogs.dart';
import 'package:flutter_lib/utils/BristuaRouter.dart';
import 'package:flutter_lib/utils/uidata.dart';

class VipApplyPage extends StatefulWidget {
  VipApplyPage({Key key}) : super(key: key);

  @override
  VipApplyPageState createState() => new VipApplyPageState();
}

class VipApplyPageState extends State<VipApplyPage> {
  bool _isVip = false;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar:
            UIData.getCenterTitleAppBar(!_isVip ? "申请VIP" : "我的VIP", context),
        body: !_isVip ? buildApplyVipBody() : buildMineVipBody());
  }

  Stack buildApplyVipBody() {
    return Stack(
      children: <Widget>[
        Container(
          color: Color(0xFFF5F5F5),
        ),
        Image.asset(
          'images/icon_vip_bg.png',
          width: double.infinity,
          height: 197.0,
          fit: BoxFit.cover,
        ),
        Positioned(
          top: 37.0,
          left: 0.0,
          right: 0.0,
          child: Text(
            "成为VIP",
            style: TextStyle(color: Colors.white, fontSize: 24.0),
            textAlign: TextAlign.center,
          ),
        ),
        Positioned(
          top: 75.0,
          left: 0.0,
          right: 0.0,
          child: Text(
            "立享好友消费返积分",
            style: TextStyle(color: Colors.white, fontSize: 18.0),
            textAlign: TextAlign.center,
          ),
        ),
        Positioned(
          top: 122.0,
          left: 15.0,
          right: 15.0,
          child: Container(
              alignment: Alignment.center,
              width: 346.0,
              height: 169.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    'images/icon_vip_crown.png',
                    width: 80.0,
                    height: 66.0,
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
                    child: RichText(
                      text: TextSpan(
                        text: '389.00',
                        style: TextStyle(color: Colors.white, fontSize: 30.0),
                        children: <TextSpan>[
                          TextSpan(
                            text: ' 元/年',
                            style:
                                TextStyle(color: Colors.white, fontSize: 15.0),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              decoration: new BoxDecoration(
                borderRadius: new BorderRadius.circular(8.0),
                gradient: LinearGradient(colors: [
                  Color(0xFFDABC86),
                  Color(0xFF937C54),
                ], begin: FractionalOffset(1, 0), end: FractionalOffset(0, 1)),
              )),
        ),
        Positioned(
            top: 305.0,
            left: 15.0,
            right: 15.0,
            child: InkWell(
              child: Container(
                  alignment: Alignment.center,
                  height: 45.0,
                  child: Text(
                    "立即开通",
                    style: TextStyle(color: Colors.white, fontSize: 18.0),
                  ),
                  decoration: new BoxDecoration(
                      borderRadius: new BorderRadius.circular(8.0),
                      color: Color(0xFF9E8B69))),
              onTap: () {
                Future<Result> future = OrderBridge.orderVip(1);
                future.then((result) {
                  if (result.code == 200) {
                    if (result.data == null) {
                      Bridge.showLongToast("订单号获取失败");
                      return;
                    }
                    showPayDialog(context, 389.00,
                        OrderResult.fromJson(result.data).orderId,"vip");
                  } else {
                    if (result.code == 401) {
                      BristuaRouter.routerUserLogin(context);
                    } else {
                      Bridge.showLongToast(result.msg);
                    }
                  }
                });
              },
            )),
      ],
    );
  }

  Stack buildMineVipBody() {
    return Stack(
      children: <Widget>[
        Container(
          color: Color(0xFFF5F5F5),
        ),
        Image.asset(
          'images/icon_vip_bg.png',
          width: double.infinity,
          height: 197.0,
          fit: BoxFit.cover,
        ),
        Positioned(
          top: 45.0,
          left: 0.0,
          right: 0.0,
          child: Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(64, 0, 18, 0),
                child: Image.asset(
                  'images/icon_vip_crown.png',
                  width: 67.0,
                  height: 54.0,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "您已是VIP",
                    style: TextStyle(color: Colors.white, fontSize: 20.0),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 2, 0, 4),
                    child: Text(
                      "用户立享自己/好友消费返积分",
                      style: TextStyle(color: Colors.white, fontSize: 12.0),
                    ),
                  ),
                  Text(
                    "VIP有效期:2019.01.01-2019.12.31",
                    style: TextStyle(color: Color(0xFF948F85), fontSize: 12.0),
                  ),
                ],
              ),
            ],
          ),
        ),
        Positioned(
            top: 130.0,
            left: 15.0,
            right: 15.0,
            child: InkWell(
              child: Container(
                  alignment: Alignment.center,
                  height: 45.0,
                  child: Text(
                    "立即体验特权",
                    style: TextStyle(color: Colors.white, fontSize: 18.0),
                  ),
                  decoration: new BoxDecoration(
                      borderRadius: new BorderRadius.circular(8.0),
                      color: Color(0xFF9E8B69))),
              onTap: () {},
            )),
      ],
    );
  }

  _navigateToPerfectInfo(BuildContext context, String inviteCode) async {
    Future<Result> future = InviteBridge.invitedParent(inviteCode);
    future.then((result) {
      if (result.code == 200) {
        Navigator.pop(context, false);
      } else {
        Bridge.showLongToast(result.msg == null ? "未返回错误信息" : result.msg);
      }
    });
  }
}
