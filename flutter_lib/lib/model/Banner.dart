import 'package:flutter_lib/ui/widgets/banner/banner_evalutor.dart';

class DataListBean implements BannerWithEval{
  String indexImgUrlId;
  int status;
  String createTime;
  String title;
  int sortNum;
  String indexImgUrl;

  DataListBean({this.indexImgUrlId, this.status, this.createTime, this.title, this.sortNum, this.indexImgUrl});

  DataListBean.fromJson(Map<String, dynamic> json) {
    this.indexImgUrlId = json['indexImgUrlId'];
    this.status = json['status'];
    this.createTime = json['createTime'];
    this.title = json['title'];
    this.sortNum = json['sortNum'];
    this.indexImgUrl = json['indexImgUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['indexImgUrlId'] = this.indexImgUrlId;
    data['status'] = this.status;
    data['createTime'] = this.createTime;
    data['title'] = this.title;
    data['sortNum'] = this.sortNum;
    data['indexImgUrl'] = this.indexImgUrl;
    return data;
  }

  @override
  get bannerUrl => indexImgUrl;
}
