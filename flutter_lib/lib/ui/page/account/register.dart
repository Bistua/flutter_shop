import 'package:flutter/material.dart';
import 'package:flutter_lib/logic/viewmodel/tab_view_model.dart';

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
  Widget appBarTitle;
  final TextEditingController _searchQuery = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: buildSearchAppBar(context),
        body: Container(
          child: Text("我是注册页"),
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
      title: Text("注册"),
      leading: new IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () => Navigator.pop(context, false),
      ),
    );
  }
}
