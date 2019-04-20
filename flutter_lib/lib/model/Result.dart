import 'dart:convert';

class Result {
  int code;
  String msg;
  dynamic data;

  Result(this.code, this.msg, this.data);

  Result.fromJson(String data) {
    print(json.decode(data));
    Map<dynamic, dynamic> map = json.decode(data);
    msg = map['msg'] == null ? "" : map['msg'];
    code = map['code'];
    dynamic  s = map['data'] == null ? "" : map['data'];
    this.data = s;

    print("bridge result  code:" + code.toString());
    print("bridge result  msg:" + msg);
    print("bridge result  data:" + s.toString());
  }
}
