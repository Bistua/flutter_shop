import 'package:flutter/material.dart';
import 'package:flutter_lib/model/collection.dart';
import 'package:flutter_lib/utils/uidata.dart';

class MineCollectionPage extends StatefulWidget {
  MineCollectionPage({Key key}) : super(key: key);

  @override
  MineCollectionPageState createState() => new MineCollectionPageState();
}

class MineCollectionPageState extends State<MineCollectionPage> {
  List<Collection> items = TestDataFactory.getCollectionItems();

  _upItems(List<Collection> items) {
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
  final Collection item;

  MineCollectionItem({Key key, @required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
                        style:
                            TextStyle(color: Color(0xFFFF2E2E), fontSize: 12.0),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TestDataFactory {
  static List<Collection> getCollectionItems() {
    //生成假数据
    List<Collection> items = List<Collection>();
    items.add(new Collection(
        name: "情趣内衣服女性感小胸兔女郎女仆装开档制服诱惑午夜魅力激情套装",
        image:
            "https://gd4.alicdn.com/imgextra/i4/2927333027/O1CN01EW7p0O1YEPNUYL65B_!!2927333027.jpg_400x400.jpg_.webp",
        price: "¥49.00"));
    items.add(new Collection(
        name: "Alice W花花家蝴蝶结一字肩抹胸上衣露肩性感打底内衣女无肩带",
        image:
            "https://img.alicdn.com/imgextra/i2/115232883/O1CN01EQXrw41XASMSEzjB9_!!115232883.jpg",
        price: "¥59.00"));
    items.add(new Collection(
        name: "性感夜店情趣内衣女秘书ol紧身包臀短裙制服诱惑白领职业装睡衣裙",
        image:
            "https://gd3.alicdn.com/imgextra/i2/0/TB1xcJ3kbsTMeJjSszdXXcEupXa_!!0-item_pic.jpg_400x400.jpg",
        price: "¥27.00"));
    items.add(new Collection(
        name: "情趣内衣蕾丝女仆极度诱惑性感女佣制服夜店兔女郎小胸激情套装骚",
        image:
        "https://gd2.alicdn.com/imgextra/i2/2873137436/TB2gX2DrDmWBKNjSZFBXXXxUFXa_!!2873137436.png_400x400.jpg",
        price: "¥29.00"));
    items.add(new Collection(
        name: "情趣内衣制服骚学生可爱套装激情水手服jk学院风女仆装性感老师",
        image:
        "https://gd2.alicdn.com/imgextra/i1/842112630/TB2Su1sxkKWBuNjy1zjXXcOypXa_!!842112630.jpg",
        price: "¥89.00"));
    items.add(new Collection(
        name: "jk学生制服女套装软妹服装内衣情趣水手服性感骚短可爱学生妹女装",
        image:
        "https://gd1.alicdn.com/imgextra/i4/842112630/TB2HDRvjb1YBuNjSszeXXablFXa_!!842112630.jpg",
        price: "¥89.00"));
    items.add(new Collection(
        name: "性感女仆情趣内衣服小胸激情套装血滴子透视开档紧身夜店制服诱惑",
        image:
        "https://gd3.alicdn.com/imgextra/i3/2873137436/TB2R7juDeySBuNjy1zdXXXPxFXa_!!2873137436.jpg",
        price: "¥38.00"));
    items.add(new Collection(
        name: "大moss 露肩性感裹胸内衣打底韩版外穿针织黑色抹胸上衣女无肩带",
        image:
        "https://gd1.alicdn.com/imgextra/i1/173752284/O1CN01a8IsUi1Sk774g4TgD_!!173752284.jpg",
        price: "¥59.00"));
    items.add(new Collection(
        name: "情趣性感内衣cosplay女佣制服诱惑围裙女仆装洛丽塔撩汉可爱套装",
        image:
        "https://gd2.alicdn.com/imgextra/i2/2393144150/TB2w5wMoiMnBKNjSZFoXXbOSFXa_!!2393144150.jpg",
        price: "¥35.80"));
    return items;
  }
}
