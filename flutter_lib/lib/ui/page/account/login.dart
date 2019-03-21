import 'package:flutter/material.dart';
import 'package:flutter_lib/logic/bloc/tab_bloc.dart';
import 'package:flutter_lib/model/searchTab.dart';
import 'package:flutter_lib/logic/viewmodel/tab_view_model.dart';

class Login extends StatelessWidget {
//  const ShopList({Key key, this.title}) : super(key: key);
//  final title;

  @override
  Widget build(BuildContext context) {
    return LoginPage();
  }
}

class LoginPage extends StatefulWidget {
//  ShopListPage({Key key, this.title}) : super(key: key);
//  final String title;

  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<LoginPage> {
  Widget appBarTitle;
  final TextEditingController _searchQuery = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: buildSearchAppBar(context),
        body: Container(
          child: Text("我是登录页"),
        ),
        // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }

  AppBar buildSearchAppBar(BuildContext context) {
    TabViewModel tabViewModel = TabViewModel();
    tabViewModel.getMenuItems();
    return new AppBar(
      centerTitle: true,
      title: Text("登录"),
      leading: new IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () => Navigator.pop(context, false),
      ),
    );
  }


}
