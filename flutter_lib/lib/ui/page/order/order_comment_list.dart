import 'package:flutter/material.dart';
import 'package:flutter_lib/logic/viewmodel/comment_view_model.dart';
import 'package:flutter_lib/model/comment.dart';
import 'package:flutter_lib/ui/widgets/rating_bar.dart';
import 'package:flutter_lib/utils/uidata.dart';

class OrderCommentListPage extends StatefulWidget {
  OrderCommentListPage({Key key}) : super(key: key);

  @override
  OrderCommentPageState createState() => new OrderCommentPageState();
}

class OrderCommentPageState extends State<OrderCommentListPage> {
  List<Comment> items = CommentViewModel().getListItems();

//  _upItems(List<Comment> items) {
//    setState(() {
//      this.items = items;
//    });
//  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: UIData.getCenterTitleAppBar("所有评论", context),
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.fromLTRB(0.0, 6.0, 0.0, 12.0),
        child: new ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            return OrderCommentItem(item: items[index]);
          },
        ),
      ),
    );
  }
}

class OrderCommentItem extends StatelessWidget {
  final Comment item;

  OrderCommentItem({Key key, @required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(15, 15, 9, 11),
                child: CircleAvatar(
                  radius: 15,
                  backgroundImage: NetworkImage(item.avator),
                  backgroundColor: Colors.transparent,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
                    child: Row(
                      children: <Widget>[
                        UIData.getTextWidget(item.name, UIData.ff666666, 12),
                        Container(
                          width: 8.0,
                        ),
                        StaticRatingBar(
                          size: 10.0,
                          rate: item.star,
                        )
                      ],
                    ),
                  ),
                  UIData.getTextWidget(item.time, UIData.ff999999, 10),
                ],
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(15, 0, 15, 11),
            child: UIData.getTextWidget(item.comment, UIData.ff353535, 12),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
            height: 1.0,
            color: Color(0xFFEAEAEA),
          ),
        ],
      ),
      onTap: () {
        Navigator.of(context).pop();
      },
    );
  }
}
