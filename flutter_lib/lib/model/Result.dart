import 'dart:convert';

class Result<T> {
  int code;
  String msg;
  T data;

  Result(this.code, this.msg, this.data);

  Result.fromJson(String data) {
    Map<String, dynamic> map = json.decode(data);
    data = map['data'];
    msg = map['msg'];
    code = map['code'];
  }
}
