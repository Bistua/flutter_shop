import 'package:flutter_lib/model/Result.dart';


enum ApiType { getProductList, queryProductList, getProductDetail,getSkuList,getSkuResult }

class FetchProcess<T> {
  ApiType type;
  bool loading;
  Result response;

  FetchProcess({this.loading, this.response, this.type});
}
