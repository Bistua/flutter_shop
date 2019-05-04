import 'package:flutter/material.dart';
import 'package:flutter_lib/bridge/common_bridge.dart';
import 'package:flutter_lib/bridge/order_bridge.dart';
import 'package:flutter_lib/model/OrderComment.dart';
import 'package:flutter_lib/model/Result.dart';
import 'package:flutter_lib/ui/widgets/rating_bar.dart';
import 'package:flutter_lib/utils/uidata.dart';

class OrderCommentPage extends StatefulWidget {
  OrderComment orderComment;

  OrderCommentPage(this.orderComment);

  @override
  OrderCommentPageState createState() => new OrderCommentPageState();
}

class OrderCommentPageState extends State<OrderCommentPage> {
  int _value = 0;
  final TextEditingController _controller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: UIData.getCenterTitleAppBar("评价商品", context),
      body: Container(
        color: Color(0xFFF5F5F5),
        padding: EdgeInsets.fromLTRB(0.0, 11.0, 0.0, 0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              color: Colors.white,
              padding: EdgeInsets.fromLTRB(0.0, 45.0, 0.0, 60.0),
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 36.0),
                    child: Text(
                      "请选择星级评价",
                      style:
                          TextStyle(color: Color(0xFF353535), fontSize: 15.0),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      RatingBar(
                        size: 25.0,
                        radiusRatio: 1.4,
                        interval: 20.0,
                        onChange: (int value) {
                          setState(() {
                            _value = value;
                            widget.orderComment.goodsEvaluates.forEach((f) {
                              f.level = _value.toString();
                            });
                          });
                        },
                      ),
                      Text(
                        _value.toString() + ".0",
                        style:
                            TextStyle(color: Color(0xFFFFBE0D), fontSize: 24.0),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              color: Colors.white,
              margin: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
              padding: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
              height: 150.0,
              child: TextField(
                keyboardType: TextInputType.text,
                controller: _controller,
                maxLength: 130,
                maxLines: 7,
                //最大行数
                style: TextStyle(fontSize: 15.0, color: Color(0xFF333333)),
                //输入文本的样式
                decoration: new InputDecoration(
                    //fillColor: Color(0xFFEEEEEE),
                    border: InputBorder.none,
                    counterStyle: TextStyle(color: Colors.transparent),
                    hintText: '填写你要发表的评语',
                    hintStyle:
                        TextStyle(fontSize: 15.0, color: Color(0xFFCCCCCC))),
                onChanged: (text) {
                  widget.orderComment.goodsEvaluates.forEach((f) {
                    f.content = text;
                  });
                },
                onSubmitted: (text) {
                  //内容提交(按回车)的回调
                  //print('submit $text');
                },
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(15.0, 16.0, 15.0, 0.0),
              height: 50,
              child: UIData.getShapeButton(
                  UIData.fffa4848, UIData.fff, 345, 45, "提交评价", 18, 5, () {
                Future<Result> future =
                    OrderBridge.submitComment(widget.orderComment);
                future.then((r) {
                  if (r.code == 200) {
                    Navigator.of(context).pop();
                  } else {
                    Bridge.showLongToast(r.msg);
                  }
                });
              }),
            )
          ],
        ),
      ),
    );
  }
}
