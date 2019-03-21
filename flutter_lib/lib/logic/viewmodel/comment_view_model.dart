import 'package:flutter_lib/model/comment.dart';

class CommentViewModel {
  List<Comment> commentList;

  CommentViewModel({this.commentList});

  getMenuItems() {

    return commentList = <Comment>[
      Comment(
          avator:"http://uploads.5068.com/allimg/1711/151-1G130093R1.jpg",
          name: "一路向北",
          star:5,
          time:  new DateTime.now().millisecond,
          comment: "用了一段时间了，非常不错，特意过来点赞、好评。希望越卖越好！"),

      Comment(
          avator:"http://uploads.5068.com/allimg/1711/151-1G130093R1.jpg",
          name: "一路向北",
          star:5,
          time:  new DateTime.now().millisecond,
          comment: "用了一段时间了，非常不错，特意过来点赞、好评。希望越卖越好！"),
    ];
  }
}
