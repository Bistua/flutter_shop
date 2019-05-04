class Userinfo {
  String balanceAmt;
  String totalConsume;
  String phone;
  String userCode;
  String status;
  String parentId;
  String createTime;
  String userLevel;
  String userSex;
  String userImgUrl;
  String openId;
  String nickName;
  String cityName;
  String countryName;
  String provinceName;
  String imgUrl;
  String inviteNum;


  Userinfo({this.balanceAmt, this.totalConsume, this.phone, this.userCode, this.status, this.parentId, this.createTime, this.userLevel, this.userSex, this.userImgUrl, this.openId, this.nickName, this.cityName, this.countryName, this.provinceName, this.imgUrl, this.inviteNum});

  Userinfo.fromJson(Map<String, dynamic> json) {    
    this.balanceAmt = json['balanceAmt'];
    this.totalConsume = json['totalConsume'];
    this.phone = json['phone'];
    this.userCode = json['userCode'];
    this.status = json['status'];
    this.parentId = json['parentId'];
    this.createTime = json['createTime'];
    this.userLevel = json['userLevel'];
    this.userSex = json['userSex'];
    this.userImgUrl = json['userImgUrl'];
    this.openId = json['openId'];
    this.nickName = json['nickName'];
    this.cityName = json['cityName'];
    this.countryName = json['countryName'];
    this.provinceName = json['provinceName'];
    this.imgUrl = json['imgUrl'];
    this.inviteNum = json['inviteNum'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['balanceAmt'] = this.balanceAmt;
    data['totalConsume'] = this.totalConsume;
    data['phone'] = this.phone;
    data['userCode'] = this.userCode;
    data['status'] = this.status;
    data['parentId'] = this.parentId;
    data['createTime'] = this.createTime;
    data['userLevel'] = this.userLevel;
    data['userSex'] = this.userSex;
    data['userImgUrl'] = this.userImgUrl;
    data['openId'] = this.openId;
    data['nickName'] = this.nickName;
    data['cityName'] = this.cityName;
    data['countryName'] = this.countryName;
    data['provinceName'] = this.provinceName;
    data['imgUrl'] = this.imgUrl;
    data['inviteNum'] = this.inviteNum;
    return data;
  }

}
