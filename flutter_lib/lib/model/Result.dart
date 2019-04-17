class Result<T>{
  int code;
  String msg;
  T data;

  Result(this.code, this.msg, this.data);


  Result.fromJson(Map<String, dynamic> json) {
    data = json['data'] ;
    msg = json['msg'];
    code = json['code'];
  }

}