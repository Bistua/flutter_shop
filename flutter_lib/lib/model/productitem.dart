class ProductList {
  String totalCount;
  List<ProductItem> list;

  ProductList({this.totalCount, this.list});

  ProductList.fromJson(Map<String, dynamic> json) {
    this.totalCount = json['totalCount'];
    this.list = (json['list'] as List)!=null?(json['list'] as List).map((i) => ProductItem.fromJson(i)).toList():null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalCount'] = this.totalCount;
    data['list'] = this.list != null?this.list.map((i) => i.toJson()).toList():null;
    return data;
  }

}

class ProductItem {
  String name;
  String description;
  String cretaeTime;
  String categoryName;
  double price;
  int id;
  int categoryId;
  int skuId;
  List<MediasListBean> medias;

  ProductItem({this.name, this.description, this.cretaeTime, this.categoryName, this.price, this.id, this.categoryId, this.skuId, this.medias});

  ProductItem.fromJson(Map<String, dynamic> json) {
    this.name = json['name'];
    this.description = json['description'];
    this.cretaeTime = json['cretaeTime'];
    this.categoryName = json['categoryName'];
    this.price = json['price'];
    this.id = json['id'];
    this.categoryId = json['categoryId'];
    this.skuId = json['skuId'];
    this.medias = (json['medias'] as List)!=null?(json['medias'] as List).map((i) => MediasListBean.fromJson(i)).toList():null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['description'] = this.description;
    data['cretaeTime'] = this.cretaeTime;
    data['categoryName'] = this.categoryName;
    data['price'] = this.price;
    data['id'] = this.id;
    data['categoryId'] = this.categoryId;
    data['skuId'] = this.skuId;
    data['medias'] = this.medias != null?this.medias.map((i) => i.toJson()).toList():null;
    return data;
  }
}

class MediasListBean {
  String name;
  String url;
  int id;

  MediasListBean({this.name, this.url, this.id});

  MediasListBean.fromJson(Map<String, dynamic> json) {    
    this.name = json['name'];
    this.url = json['url'];
    this.id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['url'] = this.url;
    data['id'] = this.id;
    return data;
  }
}
