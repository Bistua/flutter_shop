import 'package:flutter/material.dart';
import 'package:flutter_lib/model/homeitem.dart';
import 'package:flutter_lib/utils/uidata.dart';
import 'package:flutter_lib/model/userinfo.dart';

class HomeItemViewModel {
  List<HomeItem> rankList;

  HomeItemViewModel({this.rankList});

  getMenuItems(Userinfo userInfo) {

    return rankList = <HomeItem>[
      HomeItem(
          icon:  "images/vip.png",
          title: "成为VIP",
          subTitle: "邀请返利不限量",
          arrowIcon:Icons.arrow_forward_ios,
          action: UIData.OrderDetailPage),
      HomeItem(
          icon:  "images/invite.png",
          title: "邀请好友赢返利 ",
          subTitle: "邀请好友赢返利  ",
          arrowIcon:Icons.arrow_forward_ios,
          action: UIData.IviteFriendsPage,
          params: userInfo==null?"":userInfo.balanceAmt+"/"),
      HomeItem(
        icon:  "images/coin.png",
          title: "我的金币",
          subTitle: "累计"+(userInfo==null?"0":userInfo.balanceAmt)+"个",
          arrowIcon:Icons.arrow_forward_ios,),

      HomeItem(
          icon:  "images/invite_code.png",
          title: "输入邀请码",
          subTitle: "",
          arrowIcon:Icons.arrow_forward_ios,
          action: UIData.InviteInputPage),
      HomeItem(
          icon:  "images/favor.png",
          title: "我的收藏",
          subTitle: "",
          arrowIcon:Icons.arrow_forward_ios,
          action: UIData.MineCollectionPage),

      HomeItem(
          icon:  "images/setting.png",
          title: "设置中心",
          subTitle: "",
          arrowIcon:Icons.arrow_forward_ios),

      HomeItem(
          icon:  "images/logout.png",
          title: "退出登录",
          subTitle: "",
          arrowIcon:Icons.arrow_forward_ios),

    ];
  }
}
