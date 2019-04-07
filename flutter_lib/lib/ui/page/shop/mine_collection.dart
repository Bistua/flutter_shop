import 'package:flutter/material.dart';
import 'package:flutter_lib/logic/viewmodel/product_view_model.dart';
import 'package:flutter_lib/model/product.dart';
import 'package:flutter_lib/utils/uidata.dart';

class MineCollectionPage extends StatefulWidget {
  MineCollectionPage({Key key}) : super(key: key);

  @override
  MineCollectionPageState createState() => new MineCollectionPageState();
}

class MineCollectionPageState extends State<MineCollectionPage> {
  List<Product> items = ProductViewModel().getProductTests();

  _upItems(List<Product> items) {
    setState(() {
      this.items = items;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: UIData.getCenterTitleAppBar("我的收藏", context),
      body: Container(
        color: Color(0xFFF5F5F5),
        padding: EdgeInsets.fromLTRB(0.0, 6.0, 0.0, 12.0),
        child: new ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            return MineCollectionItem(item: items[index]);
          },
        ),
      ),
    );
  }
}

class MineCollectionItem extends StatelessWidget {
  final Product item;

  MineCollectionItem({Key key, @required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        padding: EdgeInsets.fromLTRB(6.0, 1.0, 6.0, 1.0),
        child: Card(
          child: Container(
            padding: EdgeInsets.all(15.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 0.0),
                  width: 88.0,
                  height: 88.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(8.0),
                    image: DecorationImage(
                        image: NetworkImage(item.image), fit: BoxFit.cover),
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        item.name,
                        style:
                            TextStyle(color: Color(0xFF353535), fontSize: 12.0),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
                        child: Text(
                          item.price,
                          style: TextStyle(
                              color: Color(0xFFFF2E2E), fontSize: 12.0),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      onTap: () {
        Navigator.pushNamed(context, UIData.ShopDetailPage, arguments: item);
      },
    );
  }
}
