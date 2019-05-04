class RebateList {
  int totalCount;
  List<RebateInfo> list;

  RebateList({this.totalCount, this.list});

  RebateList.fromJson(Map<String, dynamic> json) {
    this.totalCount = json['totalCount'];
    this.list = (json['list'] as List) != null
        ? (json['list'] as List).map((i) => RebateInfo.fromJson(i)).toList()
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalCount'] = this.totalCount;
    data['list'] =
        this.list != null ? this.list.map((i) => i.toJson()).toList() : null;
    return data;
  }
}

class RebateInfo {
  String userName;
  String consumeAmt;
  String iegralNum;

  RebateInfo({this.userName, this.consumeAmt, this.iegralNum});

  RebateInfo.fromJson(Map<String, dynamic> json) {
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
