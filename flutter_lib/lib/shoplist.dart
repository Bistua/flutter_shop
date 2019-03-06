import 'package:flutter/material.dart';

class ShopList extends StatelessWidget {
  const ShopList({Key key, this.title}) : super(key: key);
  final title;

  @override
  Widget build(BuildContext context) {
    return ShopListPage(title: title);
  }
}

class ShopListPage extends StatefulWidget {
  ShopListPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  ShopListState createState() => ShopListState();
}

class ShopListState extends State<ShopListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
        leading: Builder(builder: (BuildContext context) {
          return IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          );
        }),
      ),
      body: Container(),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
