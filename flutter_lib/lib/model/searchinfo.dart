class SearchInfo {
  String keywold;
  int pageNo;
  int pageSzie;

  SearchInfo(
    this.keywold,
    this.pageNo,
    this.pageSzie,
  );

  SearchInfo.fromJson(Map<String, dynamic> json) {
    this.keywold = json['keywold'];
    this.pageNo = json['pageNo'];
    this.pageSzie = json['pageSize'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['keywold'] = this.keywold;
    data['pageNo'] = this.pageNo;
    data['pageSzie'] = this.pageSzie;
    return data;
  }
}
