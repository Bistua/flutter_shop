class OrderComment{
  String orderId;

  List<Goods> goodsEvaluates;

  OrderComment(this.orderId, this.goodsEvaluates);

  OrderComment.fromJson(Map<String, dynamic> json) {
    this.orderId = json['orderId'];
    this.goodsEvaluates = (json['goodsEvaluates'] as List)
        ?.map((e) =>
    e == null ? null : Goods.fromJson(e as Map<String, dynamic>))
        ?.toList();

  }


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['orderId'] = this.orderId;
    data['goodsEvaluates'] = this.goodsEvaluates;
    return data;
  }

}

class Goods{
  String productId;
  String content;
  String level;


  Goods(this.productId, this.content, this.level);


  Goods.fromJson(Map<String, dynamic> json) {
    this.productId = json['productId'];
    this.content = json['content'];
    this.level = json['level'];
  }


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['productId'] = this.productId;
    data['content'] = this.content;
    data['level'] = this.level;
    return data;
  }


}
