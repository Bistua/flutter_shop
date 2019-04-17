class Sku {
  /**
   * sku编号
   */
  String skuId;
  /**
   * 个数
   */
  int amount;
  /**
   * 商品的价格
   */
  double price;
  /**
   * 运费
   */
  double freight;

  Sku({
    this.skuId,
    this.amount,
    this.price,
    this.freight,
  });
}
