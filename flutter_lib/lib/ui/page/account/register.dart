import 'package:flutter/material.dart';
import 'package:flutter_lib/bridge.dart';
import 'package:flutter_lib/bridge/account.dart';
import 'package:flutter_lib/utils/uidata.dart';

class Register extends StatelessWidget {
//  const ShopList({Key key, this.title}) : super(key: key);
//  final title;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: RegisterPage(),
      onWillPop: () {
        Navigator.pop(context);
        return Future.value(false);
      },
    );
  }
}

class RegisterPage extends StatefulWidget {
//  ShopListPage({Key key, this.title}) : super(key: key);
//  final String title;

  @override
  RegisterState createState() => RegisterState();
}

class RegisterState extends State<RegisterPage> {
  final TextEditingController _controller = new TextEditingController();
  Color _registercolor = Color(0xFFFF7B7B);
  Color _verifycodecolor = Color(0xFF999999);
  Color _verifybordercolor = Color(0xFFEEEEEE);
  var _verifyborderwidth = 1.0;
  String _phonenum = "";

  _upRegisterTextColor(bool is_phone) {
    if (is_phone) {
      //输入手机号正确
      if (_registercolor.value != 0xFFFFFFFF) {
        setState(() {
          _registercolor = Color(0xFFFFFFFF);
          _verifycodecolor = Color(0xFFFFFFFF);
          _verifybordercolor = Color(0xFFFA4848);
          _verifyborderwidth = 11.0;
        });
      }
    } else {
      //输入手机号不正确
      if (_registercolor.value != 0xFFFF7B7B) {
        setState(() {
          _registercolor = Color(0xFFFF7B7B);
          _verifycodecolor = Color(0xFF999999);
          _verifybordercolor = Color(0xFFEEEEEE);
          _verifyborderwidth = 1.0;
        });
      }
    }
  }

  TextEditingController smsCodeEditingController = new TextEditingController();
  TextEditingController inviteCodeEditingController =
      new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          body: Stack(
            children: <Widget>[
              Positioned(
                top: 0.0,
                left: -15.0,
                child: FlatButton(
                  child: Image.asset(
                    'images/icon_back.png',
                    width: 20.0,
                    height: 20.0,
                  ),
                  onPressed: () {
                    Navigator.pop(context, "取消注册");
                  },
                ),
              ),
              Positioned(
                  top: 0.0,
                  right: -15.0,
                  child: FlatButton(
                    child: Text(
                      '取消',
                      style:
                          TextStyle(color: Color(0xFF353535), fontSize: 16.0),
                    ),
                    onPressed: () {
                      Navigator.pop(context, "取消注册");
                    },
                  )),
              Positioned(
                  top: 60.0,
                  left: 30.0,
                  right: 30.0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "新用户注册",
                        style:
                            TextStyle(color: Color(0xFF353535), fontSize: 24.0),
                      ),
                      Container(
                        height: 40,
                        margin: EdgeInsets.fromLTRB(0.0, 44.0, 0.0, 0.0),
                        child: TextField(
                          keyboardType: TextInputType.number,
                          controller: _controller,
                          maxLength: 11,
                          //最大长度，设置此项会让TextField右下角有一个输入数量的统计字符串
                          maxLines: 1,
                          //最大行数
                          style: TextStyle(
                              fontSize: 15.0, color: Color(0xFF333333)),
                          //输入文本的样式
                          decoration: new InputDecoration(
                              //fillColor: Color(0xFFEEEEEE),
                              border: InputBorder.none,
                              counterStyle:
                                  TextStyle(color: Colors.transparent),
                              hintText: '请输入手机号',
                              hintStyle: TextStyle(
                                  fontSize: 15.0, color: Color(0xFFBBBBBB))),
                          onChanged: (text) {
                            _phonenum = text;
                            //内容改变的回调
                            if (_phonenum != null &&
                                _phonenum.length == 11 &&
                                UIData.isPhone(_phonenum)) {
                              _upRegisterTextColor(true);
                            } else {
                              _upRegisterTextColor(false);
                            }
                          },
                          onSubmitted: (text) {
                            //内容提交(按回车)的回调
                            //print('submit $text');
                          },
                        ),
                      ),
                      Divider(),
                      Container(
                        height: 40,
                        margin: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                        child: Stack(
                          children: <Widget>[
                            TextField(
                              controller: smsCodeEditingController,
                              keyboardType: TextInputType.number,
                              maxLength: 6,
                              //最大长度，设置此项会让TextField右下角有一个输入数量的统计字符串
                              maxLines: 1,
                              //最大行数
                              style: TextStyle(
                                  fontSize: 15.0, color: Color(0xFF333333)),
                              //输入文本的样式
                              decoration: new InputDecoration(
                                  //fillColor: Color(0xFFEEEEEE),
                                  border: InputBorder.none,
                                  counterStyle:
                                      TextStyle(color: Colors.transparent),
                                  hintText: '短信验证码',
                                  hintStyle: TextStyle(
                                      fontSize: 15.0,
                                      color: Color(0xFFBBBBBB))),
                              onChanged: (text) {
                                //内容改变的回调
                                //print('change $text');
                              },
                              onSubmitted: (text) {
                                //内容提交(按回车)的回调
                                //print('submit $text');
                              },
                            ),
                            Positioned(
                              top: 0.0,
                              right: 0.0,
                              child: Stack(
                                alignment: Alignment.center,
                                children: <Widget>[
                                  Container(
                                    alignment: Alignment.center,
                                    width: 71.0,
                                    height: 22.0,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: _verifybordercolor,
                                          width: _verifyborderwidth),
                                      borderRadius: new BorderRadius.all(
                                          new Radius.circular(11.0)),
                                    ),
                                  ),
                                  FlatButton(
                                    child: new Container(
                                      width: 71.0,
                                      height: 22.0,
                                      child: new Text(
                                        "获取验证码",
                                        style: TextStyle(
                                            color: _verifycodecolor,
                                            fontSize: 10),
                                      ),
                                      alignment: Alignment.center,
                                    ),
                                    //圆角大小,与BoxDecoration保持一致，更美观
                                    onPressed: () {
                                      Future<String> future = AccountBridge.getSmsCode(
                                          "0", _controller.text);
                                      future.then((result) {
                                        //todo 短信验证码是否获取成功
                                      }).catchError((e) {
                                        print(e.toString());
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(),
                      Container(
                        height: 40,
                        margin: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                        child: TextField(
                          controller: inviteCodeEditingController,
                          keyboardType: TextInputType.number,
                          maxLength: 11,
                          //最大长度，设置此项会让TextField右下角有一个输入数量的统计字符串
                          maxLines: 1,
                          //最大行数
                          style: TextStyle(
                              fontSize: 15.0, color: Color(0xFF333333)),
                          //输入文本的样式
                          decoration: new InputDecoration(
                              //fillColor: Color(0xFFEEEEEE),
                              border: InputBorder.none,
                              counterStyle:
                                  TextStyle(color: Colors.transparent),
                              hintText: '请输入邀请码(选填)',
                              hintStyle: TextStyle(
                                  fontSize: 15.0, color: Color(0xFFBBBBBB))),
                          onChanged: (text) {
                            //内容改变的回调
                            //print('change $text');
                          },
                          onSubmitted: (text) {
                            //内容提交(按回车)的回调
                            //print('submit $text');
                          },
                        ),
                      ),
                      Divider(),
                      Container(
                        margin: EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 0.0),
                        child: RaisedButton(
                          child: new Container(
                            child: new Text(
                              "注册",
                              style: TextStyle(fontSize: 18.0),
                            ),
                            alignment: Alignment.center,
                            height: 50.0,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          color: Color.fromARGB(255, 250, 72, 72),
                          //圆角大小,与BoxDecoration保持一致，更美观
                          onPressed: () {
                            if (_phonenum != null &&
                                _phonenum.length == 11 &&
                                UIData.isPhone(_phonenum)) {
                              Future<String> future = AccountBridge.register(
                                  _controller.text,
                                  smsCodeEditingController.text,
                                  inviteCodeEditingController.text);
                              future.then((result) {
                                //todo 解析结果
                              }).catchError((e) {
                                print(e.toString());
                              });
                            } else {}
                          },
                          textColor: _registercolor,
                        ),
                      ),
                    ],
                  )),
            ],
          ),
        ));
  }
}
