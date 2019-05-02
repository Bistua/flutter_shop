class RebateList {
  int totalCount;
  List<ListListBean> list;

  RebateList({this.totalCount, this.list});

  RebateList.fromJson(Map<String, dynamic> json) {
    this.totalCount = json['totalCount'];
    this.list = (json['list'] as List)!=null?(json['list'] as List).map((i) => ListListBean.fromJson(i)).toList():null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalCount'] = this.totalCount;
    data['list'] = this.list != null?this.list.map((i) => i.toJson()).toList():null;
    return data;
  }

}

class ListListBean {
  String userName;
  String consumeAmt;
  String iegralNum;

  ListListBean({this.userName, this.consumeAmt, this.iegralNum});

  ListListBean.fromJson(Map<String, dynamic> json) {    
    this.userName = json['userName'];
    this.consumeAmt = json['consumeAmt'];
    this.iegralNum = json['iegralNum'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userName'] = this.userName;
    data['consumeAmt'] = this.consumeAmt;
    data['iegralNum'] = this.iegralNum;
    return data;
  }
}
