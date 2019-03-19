import 'package:flutter/material.dart';
import 'package:flutter_lib/logic/bloc/tab_bloc.dart';
import 'package:flutter_lib/model/searchTab.dart';
import 'package:flutter_lib/logic/viewmodel/tab_view_model.dart';
import 'package:flutter_lib/utils/uidata.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LoginPage();
  }
}

class LoginPage extends StatefulWidget {
  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<LoginPage> {
  Widget appBarTitle;

  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      Container(
        decoration: new BoxDecoration(
          image: new DecorationImage(
            image: new AssetImage("assets/image/login.jpeg"),
            fit: BoxFit.cover,
          ),
        ),
      ),
      Scaffold(
        backgroundColor: Colors.black38,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: new IconButton(
            icon: UIData.back_white,
            onPressed: () => Navigator.pop(context, false),
          ),
          actions: <Widget>[
            Center(
              child: Padding(
                child: RaisedButton(
                  color: Colors.transparent,
                  textColor: Colors.white,
                  elevation: 0,
                  highlightElevation: 0,
                  disabledElevation: 0,
                  child: new Container(
                    child: Center(
                      child: UIData.getTextWidget("注册", Colors.white, 16),
                    ),
                  ),
                  onPressed: () {},
                ),
                padding: new EdgeInsets.fromLTRB(16.0, 7, 0, 8),
              ),
            ),
          ],
        ),
        body: Container(
          color: Colors.transparent,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(0, 30, 0, 60),
                child: Center(
                  child: UIData.getTextWidget("用户登录", UIData.fffff6f6, 30),
                ),
              ),
              buildTextField("请输入手机号码",_searchQuery),
              Padding(
                child: buildTextField("请输入密码",_searchQuery1),
                padding: EdgeInsets.fromLTRB(0, 30, 0, 30),
              ),
              UIData.getMaxWidthButtonWithRadius("登录",25, (){

              })
            ],
          ),
        ),
        // This trailing comma makes auto-formatting nicer for build methods.
      ),
    ]);
  }

  final TextEditingController _searchQuery = new TextEditingController();
  final TextEditingController _searchQuery1 = new TextEditingController();

  Widget buildTextField(String text,TextEditingController query) {
    return new Container(
      alignment: Alignment.centerLeft,
      width: 315,
      child: new Center(
        child: new TextField(
          textAlign: TextAlign.start,
          controller: query,
          cursorColor: Colors.white30,
          cursorWidth: 0,
          style: new TextStyle(color: UIData.fff, fontSize: 15),
          decoration: new InputDecoration(
              fillColor: Colors.white30,
              filled: true,
              suffixIcon: IconButton(
                  icon: new Icon(
                    Icons.close,
                    color: UIData.fff,
                    size: 16,
                  ),
                  onPressed: () {
                    setState(() {
                      query.clear();
                    });
                  }),
              border: new OutlineInputBorder(
                borderRadius: new BorderRadius.circular(14.0),
                borderSide: new BorderSide(color: UIData.ff353535, width: 0),
              ),
              hintText: text,
              hintStyle: new TextStyle(color: UIData.fff)),
        ),
      ),
    );
  }
}
