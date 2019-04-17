import 'package:flutter_lib/model/comment.dart';

class CommentViewModel {
  List<Comment> commentList;

  CommentViewModel({this.commentList});

  getMenuItems() {
    return commentList = <Comment>[
      Comment(
          avator: "http://uploads.5068.com/allimg/1711/151-1G130093R1.jpg",
          name: "一路向北",
          star: 5,
          time: "2018-07-14 10:53",
          comment: "用了一段时间了，非常不错，特意过来点赞、好评。希望越卖越好！"),
      Comment(
          avator: "http://uploads.5068.com/allimg/1711/151-1G130093R1.jpg",
          name: "一路向北",
          star: 3,
          time: "2018-07-14 10:53",
          comment: "用了一段时间了，非常不错，特意过来点赞、好评。希望越卖越好！"),
    ];
  }

  getListItems() {
    return commentList = <Comment>[
      Comment(
          avator: "http://uploads.5068.com/allimg/1711/151-1G130093R1.jpg",
          name: "一路向北",
          star: 5,
          time: "2018-07-14 10:53",
          comment: "用了一段时间了，非常不错，特意过来点赞、好评。希望越卖越好！"),
      Comment(
          avator: "http://uploads.5068.com/allimg/1711/151-1G130093R1.jpg",
          name: "一路向北",
          star: 3,
          time: "2018-07-14 10:53",
          comment: "用了一段时间了，非常不错，特意过来点赞、好评。希望越卖越好！"),
      Comment(
          avator: "http://uploads.5068.com/allimg/1711/151-1G130093R1.jpg",
          name: "一路向北",
          star: 1,
          time: "2018-07-14 10:53",
          comment: "用了一段时间了，非常不错，特意过来点赞、好评。希望越卖越好！"),
      Comment(
          avator: "http://uploads.5068.com/allimg/1711/151-1G130093R1.jpg",
          name: "一路向北",
          star: 2,
          time: "2018-07-14 10:53",
          comment: "用了一段时间了，非常不错，特意过来点赞、好评。希望越卖越好！"),
      Comment(
          avator: "http://uploads.5068.com/allimg/1711/151-1G130093R1.jpg",
          name: "一路向北",
          star: 3,
          time: "2018-07-14 10:53",
          comment: "用了一段时间了，非常不错，特意过来点赞、好评。希望越卖越好！"),
      Comment(
          avator: "http://uploads.5068.com/allimg/1711/151-1G130093R1.jpg",
          name: "一路向北",
          star: 4,
          time: "2018-07-14 10:53",
          comment: "用了一段时间了，非常不错，特意过来点赞、好评。希望越卖越好！"),
      Comment(
          avator: "http://uploads.5068.com/allimg/1711/151-1G130093R1.jpg",
          name: "一路向北",
          star: 5,
          time: "2018-07-14 10:53",
          comment: "用了一段时间了，非常不错，特意过来点赞、好评。希望越卖越好！"),
      Comment(
          avator: "http://uploads.5068.com/allimg/1711/151-1G130093R1.jpg",
          name: "一路向北",
          star: 3,
          time: "2018-07-14 10:53",
          comment: "用了一段时间了，非常不错，特意过来点赞、好评。希望越卖越好！"),
      Comment(
          avator: "http://uploads.5068.com/allimg/1711/151-1G130093R1.jpg",
          name: "一路向北",
          star: 2.5,
          time: "2018-07-14 10:53",
          comment: "用了一段时间了，非常不错，特意过来点赞、好评。希望越卖越好！"),
      Comment(
          avator: "http://uploads.5068.com/allimg/1711/151-1G130093R1.jpg",
          name: "一路向北",
          star: 1.5,
          time: "2018-07-14 10:53",
          comment: "用了一段时间了，非常不错，特意过来点赞、好评。希望越卖越好！"),
    ];
  }
}
