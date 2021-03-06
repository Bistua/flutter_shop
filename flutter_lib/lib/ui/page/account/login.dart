import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_lib/bridge/account_bridge.dart';
import 'package:flutter_lib/bridge/common_bridge.dart';
import 'package:flutter_lib/model/Result.dart';
import 'package:flutter_lib/ui/page/account/register.dart';
import 'package:flutter_lib/ui/widgets/countdown.dart';

class LoginPage extends StatefulWidget {
  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<LoginPage> with TickerProviderStateMixin {
  TextEditingController smsCodeEditingController = new TextEditingController();
  TextEditingController inviteCodeEditingController =
  new TextEditingController();
  Color _verifycodecolor = Color(0xFF999999);
  Color _verifybordercolor = Color(0xFFEEEEEE);
  var _verifyborderwidth = 1.0;

  int time_cutdown = 60;
  bool isGetingSms = false;
  AnimationController _animationController;

  var _scaffoldkey = new GlobalKey<ScaffoldState>();

  void showSnackBar(String message) {
    var snackBar = SnackBar(content: Text(message));
    _scaffoldkey.currentState.showSnackBar(snackBar);
  }

  @override
  void initState() {
    _animationController = new AnimationController(
      duration: new Duration(seconds: time_cutdown),
      vsync: this,
    );
    _animationController.addStatusListener((v) {
      AnimationStatus a = v;
      if (a == AnimationStatus.completed) {
        setState(() {
          isGetingSms = false;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        key: _scaffoldkey,
        body: Stack(
          children: <Widget>[
            ConstrainedBox(
              child: Image.asset(
                'images/icon_login_bg.webp',
                fit: BoxFit.cover,
              ),
              constraints: BoxConstraints.expand(),
            ),
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
              top: 195.0,
              left: 30.0,
              right: 30.0,
              child: InputLayout(hint: "请输入手机号码", controller: _controller1),
            ),
            Positioned(
              top: 258.0,
              left: 30.0,
              right: 30.0,
              child: buildGetSms(),
            ),
            Positioned(
              top: 356.0,
              left: 30.0,
              right: 30.0,
              child: RaisedButton(
                child: new Container(
                  child: new Text(
                    "登录",
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
                  Future<Result> future = AccountBridge.login(
                      _controller1.text, _controller2.text, "0");
                  future.then((v) {
                    if (v.code == 200) {
                      Bridge.showShortToast("登录成功");
                      Navigator.pop(context, false);
                    } else {
                      Bridge.showShortToast(v.msg);
                    }
                  });
                },
                textColor: Colors.white,
              ),
            ),
            Positioned(
              bottom: 26.0,
              left: 0.0,
              right: 0.0,
              child: Container(
                alignment: Alignment.center,
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Divider(
                            color: Color.fromARGB(51, 255, 255, 255),
                          ),
                        ),
                        Text(
                          " 第三方登录 ",
                          style: TextStyle(fontSize: 12.0, color: Colors.white),
                        ),
                        Expanded(
                          child: Divider(
                            color: Color.fromARGB(51, 255, 255, 255),
                          ),
                        ),
                      ],
                    ),
                    FlatButton(
                      child: Column(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.fromLTRB(0, 17.0, 0, 9.0),
                            child: Image.asset(
                              'images/icon_login_wx.png',
                              width: 46.0,
                              height: 46.0,
                            ),
                          ),
                          Text(
                            "微信登录",
                            style:
                                TextStyle(fontSize: 12.0, color: Colors.white),
                          ),
                        ],
                      ),
                      onPressed: () {
                        _navigateToPerfectInfo(context);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }



  Container buildGetSms() {
    return Container(
      height: 50,
      margin: EdgeInsets.fromLTRB(0.0, 18.0, 16.0, 13.0),
      child: Stack(
        children: <Widget>[
          InputLayout(
            controller: _controller2,
            hint: "请输入验证码",
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
                        color: _verifybordercolor, width: _verifyborderwidth),
                    borderRadius:
                        new BorderRadius.all(new Radius.circular(11.0)),
                  ),
                ),
                FlatButton(
                  child: new Container(
                    width: 71.0,
                    height: 22.0,
                    child: isGetingSms
                        ? new Countdown(
                            color: Colors.white,
                            animation: new StepTween(
                              begin: time_cutdown,
                              end: 0,
                            ).animate(_animationController),
                          )
                        : new Text(
                            "获取验证码",
                            style: TextStyle(
                                color: _verifybordercolor, fontSize: 10),
                          ),
                    alignment: Alignment.center,
                  ),
                  //圆角大小,与BoxDecoration保持一致，更美观
                  onPressed: () {
                    if (_controller1.text.isEmpty) {
                      Bridge.showShortToast("请输入手机号");
                      return;
                    }
                    Future<Result> future =
                        AccountBridge.getSmsCode("0", _controller1.text);
                    future.then((v) {
                      if (v.code == 200) {
                        Bridge.showShortToast("短信发送成功");
                        _animationController.forward(from: 0.0);
                        this.setState(() {
                          isGetingSms = true;
                        });
                      } else {
                        Bridge.showShortToast(v.msg);
                      }
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _navigateToRegister(BuildContext context) async {
    //async是启用异步方法
    final result = await Navigator.push(
        //等待
        context,
        MaterialPageRoute(builder: (context) => Register()));
    showSnackBar('$result');
  }

  _navigateToPerfectInfo(BuildContext context) async {
    Future<Result> future = AccountBridge.wxLogin();
    future.then((v) {
      if (v.code == 200) {
        Navigator.pop(context, false);
      } else {
        Bridge.showShortToast(v.msg);
      }
    });
  }
}

final TextEditingController _controller1 = new TextEditingController();

final TextEditingController _controller2 = new TextEditingController();

class InputLayout extends StatelessWidget {
  final String hint;
  final TextEditingController controller;

  InputLayout({Key key, @required this.hint, this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        ClipRRect(
          borderRadius: const BorderRadius.all(const Radius.circular(25.0)),
          child: Container(
            color: Color.fromARGB(51, 255, 255, 255),
            height: 50.0,
          ),
        ),
        Positioned(
          top: 2.0,
          left: 23.0,
          right: 10.0,
          child: TextField(
            keyboardType: TextInputType.number,
            controller: controller,
            maxLength: 11,
            //最大长度，设置此项会让TextField右下角有一个输入数量的统计字符串
            maxLines: 1,
            //最大行数
            obscureText: identical(hint, "请输入密码"),
            //是否是密码
            style: TextStyle(
                fontSize: 15.0, color: Color.fromARGB(255, 213, 209, 206)),
            //输入文本的样式
            decoration: new InputDecoration(
                border: InputBorder.none,
                counterStyle: TextStyle(color: Colors.transparent),
                hintText: '$hint',
                hintStyle: TextStyle(
                    fontSize: 15.0, color: Color.fromARGB(255, 213, 209, 206))),
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
      ],
    );
  }
}
