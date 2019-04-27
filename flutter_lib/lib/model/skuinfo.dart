class SkuInfo {
  List<OptionsListBean> options;

  SkuInfo({this.options});

  SkuInfo.fromJson(Map<String, dynamic> json) {
    this.options = (json['options'] as List)!=null?(json['options'] as List).map((i) => OptionsListBean.fromJson(i)).toList():null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['options'] = this.options != null?this.options.map((i) => i.toJson()).toList():null;
    return data;
  }
}

class OptionsListBean {
  String key;
  List<ValuesListBean> values;

  OptionsListBean({this.key, this.values});

  OptionsListBean.fromJson(Map<String, dynamic> json) {    
    this.key = json['key'];
    this.values = (json['values'] as List)!=null?(json['values'] as List).map((i) => ValuesListBean.fromJson(i)).toList():null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['key'] = this.key;
    data['values'] = this.values != null?this.values.map((i) => i.toJson()).toList():null;
    return data;
  }
}

class ValuesListBean {
  String name;
  int id;

  ValuesListBean({this.name, this.id});

  ValuesListBean.fromJson(Map<String, dynamic> json) {    
    this.name = json['name'];
    this.id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['id'] = this.id;
    return data;
  }
}
