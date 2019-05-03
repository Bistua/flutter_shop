import 'package:flutter/material.dart';
import 'package:flutter_lib/bridge/common_bridge.dart';
import 'package:flutter_lib/bridge/invite_bridge.dart';
import 'package:flutter_lib/model/Result.dart';
import 'package:flutter_lib/utils/uidata.dart';

class InviteInputPage extends StatefulWidget {
  InviteInputPage({Key key}) : super(key: key);

  @override
  InviteInputPageState createState() => new InviteInputPageState();
}

class InviteInputPageState extends State<InviteInputPage> {
  bool _hasSuper = true;
  String _superName = "用户1";
  final TextEditingController _controller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: UIData.getCenterTitleAppBar("输入邀请码", context),
      body: Container(
        color: Color(0xFFF5F5F5),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.fromLTRB(15.0, 17.0, 15.0, 12.0),
              child: Text(
                _hasSuper ? "你已经是" + _superName + "的下级用户" : "你暂未成为任何用户的下级用户",
                style: TextStyle(color: Color(0xFF999999), fontSize: 12.0),
              ),
            ),
            Container(
              color: Color(0xFFFFFFFF),
              height: 50.0,
              padding: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
              child: Row(
                children: <Widget>[
                  Text(
                    "邀请码",
                    style: TextStyle(color: Color(0xFF666666), fontSize: 15.0),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.fromLTRB(15.0, 2.5, 15.0, 0.0),
                      child: TextField(
                        keyboardType: TextInputType.number,
                        controller: _controller,
                        maxLength: 11,
                        //最大长度，设置此项会让TextField右下角有一个输入数量的统计字符串
                        maxLines: 1,
                        //最大行数
                        obscureText: false,
                        //是否是密码
                        style:
                            TextStyle(fontSize: 15.0, color: Color(0xFF666666)),
                        //输入文本的样式
                        decoration: new InputDecoration(
                            border: InputBorder.none,
                            counterStyle: TextStyle(color: Colors.transparent),
                            hintText: '请输入',
                            hintStyle: TextStyle(
                                fontSize: 15.0, color: Color(0xFFCCCCCC))),
                        onChanged: (text) {
                          //内容改变的回调
                          //print('change $text');
                        },
                        onSubmitted: (text) {
                          //
                          _navigateToPerfectInfo(context, _controller.text);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(15.0, 16.0, 15.0, 0.0),
              height: 50,
              child: UIData.getShapeButton(
                  UIData.fffa4848, UIData.fff, 345, 45, "提交", 18, 5, () {
                setState(() {});
                Navigator.of(context).pop();
              }),
            )
          ],
        ),
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
