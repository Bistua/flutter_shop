import 'package:flutter/material.dart';
import 'package:flutter_lib/myapp.dart';
import 'package:flutter_lib/ui/page/account/perfectinfo.dart';
import 'package:flutter_lib/ui/page/account/register.dart';

class Login extends StatelessWidget {
//  const ShopList({Key key, this.title}) : super(key: key);
//  final title;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
//  ShopListPage({Key key, this.title}) : super(key: key);
//  final String title;

  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<LoginPage> {
  var _scaffoldkey = new GlobalKey<ScaffoldState>();

  void showSnackBar(String message) {
    var snackBar = SnackBar(content: Text(message));
    _scaffoldkey.currentState.showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        key: _scaffoldkey,
        //appBar: buildSearchAppBar(context),
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
                right: -15.0,
                child: FlatButton(
                  child: Text(
                    '注册',
                    style: TextStyle(color: Colors.white, fontSize: 16.0),
                  ),
                  onPressed: () {
                    _navigateToRegister(context);
                  },
                )),
            Positioned(
              top: 188.0,
              left: 30.0,
              right: 30.0,
              child: InputLayout(hint: "请输入手机号码"),
            ),
            Positioned(
              top: 268.0,
              left: 30.0,
              right: 30.0,
              child: InputLayout(hint: "请输入密码"),
            ),
            Positioned(
              top: 348.0,
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
                  Navigator.pop(context, false);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MyApp()));
                },
                textColor: Colors.white,
              ),
            ),
            Positioned(
              top: 423.0,
              left: 37.0,
              child: Row(
                children: <Widget>[
                  Text(
                    "登录代表您已同意",
                    style: TextStyle(fontSize: 12.0, color: Color(0xFFD5D1CE)),
                  ),
                  Text(
                    "《某某条款》",
                    style: TextStyle(fontSize: 12.0, color: Color(0xFFFFFFFF)),
                  ),
                ],
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

  _navigateToRegister(BuildContext context) async {
    //async是启用异步方法
    final result = await Navigator.push(
        //等待
        context,
        MaterialPageRoute(builder: (context) => Register()));
    showSnackBar('$result');
  }

  _navigateToPerfectInfo(BuildContext context) async {
    //async是启用异步方法
    final result = await Navigator.push(
        //等待
        context,
        MaterialPageRoute(builder: (context) => PerfectInfo()));
    showSnackBar('$result');
  }
}

class InputLayout extends StatelessWidget {
  final TextEditingController _controller = new TextEditingController();
  final String hint;

  InputLayout({Key key, @required this.hint}) : super(key: key);

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
            controller: _controller,
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
