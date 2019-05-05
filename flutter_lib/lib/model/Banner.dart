import 'package:flutter_lib/ui/widgets/banner/banner_evalutor.dart';

class Images {
  String msg;
  int code;
  List<DataListBean> data;

  Images({this.msg, this.code, this.data});

  Images.fromJson(Map<String, dynamic> json) {
    this.msg = json['msg'];
    this.code = json['code'];
    this.data = (json['data'] as List)!=null?(json['data'] as List).map((i) => DataListBean.fromJson(i)).toList():null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['msg'] = this.msg;
    data['code'] = this.code;
    data['data'] = this.data != null?this.data.map((i) => i.toJson()).toList():null;
    return data;
  }

  @override
  String toString() {
    return 'Images{msg: $msg, code: $code, data: $data}';
  }


}

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
