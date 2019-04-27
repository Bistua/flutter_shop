class SkuResult {

  String activeStartDate;
  String activeEndDate;
  String name;
  String available;
  String inventoryType;
  String description;
  double retailPrice;
  double salePrice;
  int id;

  SkuResult({this.activeStartDate, this.activeEndDate, this.name, this.available, this.inventoryType, this.description, this.retailPrice, this.salePrice, this.id});

  SkuResult.fromJson(Map<String, dynamic> json) {
    this.activeStartDate = json['activeStartDate'];
    this.activeEndDate = json['activeEndDate'];
    this.name = json['name'];
    this.available = json['available'];
    this.inventoryType = json['inventoryType'];
    this.description = json['description'];
    this.retailPrice = json['retailPrice'];
    this.salePrice = json['salePrice'];
    this.id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['activeStartDate'] = this.activeStartDate;
    data['activeEndDate'] = this.activeEndDate;
    data['name'] = this.name;
    data['available'] = this.available;
    data['inventoryType'] = this.inventoryType;
    data['description'] = this.description;
    data['retailPrice'] = this.retailPrice;
    data['salePrice'] = this.salePrice;
    data['id'] = this.id;
    return data;
  }
}
