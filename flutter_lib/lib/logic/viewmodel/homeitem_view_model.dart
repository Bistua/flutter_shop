import 'package:flutter/material.dart';
import 'package:flutter_lib/model/homeitem.dart';
import 'package:flutter_lib/utils/uidata.dart';

class HomeItemViewModel {
  List<HomeItem> rankList;

  HomeItemViewModel({this.rankList});

  getMenuItems() {
    return rankList = <HomeItem>[
      HomeItem(
          icon: Icons.import_contacts,
          title: "成为VIP",
          subTitle: "邀请返利不限量",
          arrowIcon:Icons.arrow_forward_ios),
      HomeItem(
          icon: Icons.import_contacts,
          title: "邀请好友赢返利 ",
          subTitle: "邀请好友赢返利  ",
          arrowIcon:Icons.arrow_forward_ios,
          action: UIData.IviteFriendsPage),
      HomeItem(
          icon: Icons.import_contacts,
          title: "我的金币",
          subTitle: "累计155个",
          arrowIcon:Icons.arrow_forward_ios,),

      HomeItem(
          icon: Icons.import_contacts,
          title: "输入邀请码",
          subTitle: "",
          arrowIcon:Icons.arrow_forward_ios),
      HomeItem(
          icon: Icons.import_contacts,
          title: "我的收藏",
          subTitle: "",
          arrowIcon:Icons.arrow_forward_ios,
          action: UIData.MineCollectionPage),

      HomeItem(
          icon: Icons.import_contacts,
          title: "设置中心",
          subTitle: "",
          arrowIcon:Icons.arrow_forward_ios),

      HomeItem(
          icon: Icons.import_contacts,
          title: "退出登录",
          subTitle: "",
          arrowIcon:Icons.arrow_forward_ios),

    ];
  }
}
