import 'package:flutter/material.dart';

class shoplist extends StatelessWidget {
  const shoplist({Key key, this.title}) : super(key: key);
  final title;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "ter",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: shoplistpage(title: 'Flutter Demo Home Page'),
    );
  }
}

class shoplistpage extends StatefulWidget {
  shoplistpage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _shopliststate createState() => _shopliststate();
}

class _shopliststate extends State<shoplistpage> {
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
