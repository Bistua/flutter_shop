import 'package:flutter/material.dart';
import 'package:flutter_lib/utils/uidata.dart';
import 'package:flutter_lib/logic/bloc/product_bloc.dart';
import 'package:flutter_lib/model/product.dart';
import 'package:flutter_lib/ui/widgets/shop_tab_item.dart';

class IviteFriendsPage extends StatefulWidget {
  IviteFriendsPage({Key key}) : super(key: key);

  @override
  IviteFriendsPageState createState() => new IviteFriendsPageState();
}

class IviteFriendsPageState extends State<IviteFriendsPage> {
  BuildContext _context;
  @override
  Widget build(BuildContext context) {
    _context = context;
    ProductBloc productBloc = ProductBloc();

    print(productBloc.productItems);
    return new Scaffold(
      appBar: UIData.getCenterTitleAppBar("邀请好友下单", context),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildListDelegate(
              [
                buildHeader(),
                buildVipInfo(),
                buildPayInfo(),
                buildFriendsPayInfoList(),
              ],
            ),
          ),
          SliverFixedExtentList(
            itemExtent: 78, // I'm forcing item heights
            delegate: SliverChildBuilderDelegate(
              (context, index) => Container(
                    color: UIData.fff,
                    child: new Column(
                      children: <Widget>[
                        ListTile(
                          title: Text(
                            generatedList[index],
                            style: TextStyle(fontSize: 20.0),
                          ),
                        ),
                        Divider(),
                      ],
                    ),
                  ),
              childCount: generatedList.length,
            ),
          ),
        ],
      ),
    );
  }

  final generatedList = List.generate(5, (index) => 'Item $index');

  Padding buildFriendsPayInfoList() {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
      child: new Container(
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(0, 13, 0, 15),
              child: new Column(
                children: <Widget>[
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.cloud_upload),
                      Padding(
                        padding: EdgeInsets.fromLTRB(7, 0, 0, 0),
                        child: UIData.getTextWidget(
                            "好友成功消费排行版", UIData.ff353535, 15),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget productListView(List<Product> data) {
    var size = MediaQuery.of(context).size;
    return new Padding(
      padding: EdgeInsets.all(5),
      child: new GridView.builder(
          itemCount: data.length,
          gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: (0.7), //item长宽比
            mainAxisSpacing: 5.0,
            crossAxisSpacing: 5.0, // add some space
          ),
          itemBuilder: (BuildContext context, int index) {
            return new GestureDetector(
              child: new Card(
                elevation: 5.0,
                child: new Container(
                  alignment: Alignment.center,
                  child: new Column(
                    children: <Widget>[
                      new Stack(
                        children: <Widget>[
                          Image.network(
                            data[index].image,
                            fit: BoxFit.contain,
                          ),
                          Positioned(
                              bottom: 0,
                              left: 0,
                              right: 0,
                              child: new Container(
                                color: Colors.white,
                                child: new Column(
                                  children: <Widget>[
                                    new Padding(
                                      padding: EdgeInsets.fromLTRB(0, 12, 0, 6),
                                      child: new Text(
                                        data[index].name,
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: UIData.ff353535),
                                      ),
                                    ),
                                    new Padding(
                                      padding: EdgeInsets.fromLTRB(0, 6, 0, 12),
                                      child: new Text(
                                        data[index].price,
                                        style: TextStyle(
                                            color: Colors.red, fontSize: 16),
                                      ),
                                    ),
                                  ],
                                ),
                              )),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              onTap: () {},
            );
          }),
    );
  }

  Padding buildPayInfo() {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
      child: new Container(
        color: UIData.fff,
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "我的成功消费金额",
                    style: TextStyle(color: UIData.ff353535, fontSize: 15),
                  ),
                  Text(
                    "累计1560.0",
                    style: TextStyle(color: UIData.fffa4848, fontSize: 15),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
              child: Divider(),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(15, 8, 15, 10),
              child: Text(
                "成功消费金额指的是所有确认收货的订单累计金额。",
                style: TextStyle(color: UIData.ff999999, fontSize: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Padding buildVipInfo() {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
      child: new Container(
        color: UIData.fff,
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "我的金币",
                    style: TextStyle(color: UIData.ff353535, fontSize: 15),
                  ),
                  Text(
                    "0个",
                    style: TextStyle(color: UIData.ff353535, fontSize: 15),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
              child: Divider(),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(15, 8, 15, 10),
              child: Text(
                "我不是VIP，仅当好友成功消费金额大于我时，为我返现1次。成为VIP立享好友消费立即返积分",
                style: TextStyle(color: UIData.ff999999, fontSize: 12),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(15, 8, 15, 10),
              child: new Center(
                child: RaisedButton(
                  color: UIData.fffa4848,
                  textColor: UIData.fff,
                  child: UIData.getTextWidget("立即成为VIP", UIData.fff, 18),
                  onPressed: () {},
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Padding buildHeader() {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
      child: new Container(
        color: UIData.fffa4848,
        child: new Center(
          child: new Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(0, 24, 0, 15),
                child: Text(
                  "邀请好友下单返金币",
                  style: TextStyle(color: UIData.fff, fontSize: 15),
                ),
              ),
              Text(
                "专属邀请码",
                style: TextStyle(color: UIData.ffffa5a5, fontSize: 12),
              ),
              new Padding(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 14),
                child: Text(
                  "GX10100166",
                  style: TextStyle(color: UIData.ffffe116, fontSize: 30),
                ),
              ),
              new Padding(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 26),
                child: Text(
                  "好友注册或接受邀请时使用，点击邀请码复制",
                  style: TextStyle(color: UIData.ffffa5a5, fontSize: 12),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
