import 'package:flutter/material.dart';
import 'package:flutter_lib/bridge/common_bridge.dart';
import 'package:flutter_lib/bridge/invite_bridge.dart';
import 'package:flutter_lib/model/Result.dart';
import 'package:flutter_lib/model/record.dart';
import 'package:flutter_lib/utils/uidata.dart';

class MineWalletPage extends StatefulWidget {
  MineWalletPage({Key key}) : super(key: key);

  @override
  MineWalletPageState createState() => new MineWalletPageState();
}

class MineWalletPageState extends State<MineWalletPage> {
  List<Record> list = new List();

  @override
  Widget build(BuildContext context) {
    //测试数据
    list.add(new Record(name: "某某交易", status: "已提现", time: "2019-01-01 12:35"));
    list.add(new Record(name: "某某交易", status: "已提现", time: "2019-01-01 12:35"));
    list.add(new Record(name: "某某交易", status: "已提现", time: "2019-01-01 12:35"));
    list.add(new Record(name: "某某交易", status: "已提现", time: "2019-01-01 12:35"));
    list.add(new Record(name: "某某交易", status: "已提现", time: "2019-01-01 12:35"));

    return new Scaffold(
        appBar: UIData.getCenterTitleAppBar("我的钱包", context),
        body: Stack(
          children: <Widget>[
            Container(
              color: Color(0xFFF5F5F5),
            ),
            CustomScrollView(
              slivers: <Widget>[
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      buildHeader(),
                      Container(
                        height: 10.0,
                      ),
                    ],
                  ),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) => RecordItem(item: list[index]),
                    childCount: list.length,
                  ),
                ),
              ],
            ),
          ],
        ));
  }

  Container buildHeader() {
    return Container(
      color: Colors.white,
      width: double.infinity,
      height: 269.0,
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 67.0,
            left: 0.0,
            right: 0.0,
            child: Text(
              "1356",
              style: TextStyle(color: Color(0xFFFA4848), fontSize: 50.0),
              textAlign: TextAlign.center,
            ),
          ),
          Positioned(
            top: 124.0,
            left: 0.0,
            right: 0.0,
            child: Text(
              "我的余额",
              style: TextStyle(color: Color(0xFF666666), fontSize: 15.0),
              textAlign: TextAlign.center,
            ),
          ),
          Positioned(
              top: 208.0,
              left: 15.0,
              right: 15.0,
              child: InkWell(
                child: Container(
                    alignment: Alignment.center,
                    height: 45.0,
                    child: Text(
                      "全部提现",
                      style: TextStyle(color: Colors.white, fontSize: 20.0),
                    ),
                    decoration: new BoxDecoration(
                        borderRadius: new BorderRadius.circular(8.0),
                        color: Color(0xFFFA4848))),
                onTap: () {},
              )),
        ],
      ),
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

class RecordItem extends StatelessWidget {
  final Record item;

  RecordItem({Key key, @required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Column(
        children: <Widget>[
          Container(
            color: Colors.white,
            padding: EdgeInsets.fromLTRB(15, 12, 15, 12),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    item.name,
                    style: TextStyle(color: Color(0xFF353535), fontSize: 15.0),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      item.status,
                      style:
                          TextStyle(color: Color(0xFF353535), fontSize: 12.0),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 3, 0, 0),
                      child: Text(
                        item.time,
                        style:
                            TextStyle(color: Color(0xFFCCCCCC), fontSize: 12.0),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          Container(
            width: double.infinity,
            height: 1.0,
            color: Color(0xFFEEEEEE),
          )
        ],
      ),
      onTap: () {},
    );
  }
}
