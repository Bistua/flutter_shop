import 'package:flutter/material.dart';
import 'package:flutter_lib/utils/uidata.dart';

class InviteInputPage extends StatefulWidget {
  InviteInputPage({Key key}) : super(key: key);

  @override
  InviteInputPageState createState() => new InviteInputPageState();
}

class InviteInputPageState extends State<InviteInputPage> {

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: UIData.getCenterTitleAppBar("输入邀请码", context),
      body: Container(
        color: Color(0xFFF5F5F5),
        padding: EdgeInsets.fromLTRB(0.0, 6.0, 0.0, 12.0),
//        child: new ListView.builder(
//          itemCount: items.length,
//          itemBuilder: (context, index) {
//            return MineCollectionItem(item: items[index]);
//          },
//        ),
      ),
    );
  }
}