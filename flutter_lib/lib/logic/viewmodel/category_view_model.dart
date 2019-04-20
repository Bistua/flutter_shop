import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_lib/model/category.dart';

/**
 *精选推荐
    商务文具
    家居生活
    数码家电
    工艺收藏
    妈咪宝贝
    包装材料
    食品保健
    箱包皮具
    户外运动
    汽车周边


 */
class CategoryViewModel {
  List<Category> categorysItems;

  CategoryViewModel({this.categorysItems});


  static distest() {
    return json.encode({
      "code": 200,
      "msg": "success",
      "data": {
        "list": [
          {
            "id": 2001,
            "name": "精选推荐",
            "thumbnail": "https://gd2.alicdn.com/imgextra/i1/842112630/TB2Su1sxkKWBuNjy1zjXXcOypXa_!!842112630.jpg",
          },
          {
            "id": 2002,
            "name": "商务文具",
            "thumbnail":   "https://gd2.alicdn.com/imgextra/i1/842112630/TB2Su1sxkKWBuNjy1zjXXcOypXa_!!842112630.jpg",
          },
          {
            "id": 2003,
            "name": "家居生活",
            "thumbnail": "https://mosaic01.ztat.net/vgs/media/packshot/pdp-zoom/N1/94/4E/00/4G/11/N1944E004-G11@10.jpg",
          },
          {
            "id": 2004,
            "name": "数码家电",
            "thumbnail": "https://gd2.alicdn.com/imgextra/i1/842112630/TB2Su1sxkKWBuNjy1zjXXcOypXa_!!842112630.jpg",
          },
          {
            "id": 2008,
            "name": "工艺收藏",
            "thumbnail": "https://gd2.alicdn.com/imgextra/i1/842112630/TB2Su1sxkKWBuNjy1zjXXcOypXa_!!842112630.jpg",
          },
          {
            "id": 10050,
            "name": "妈咪宝贝",
            "thumbnail": "https://gd2.alicdn.com/imgextra/i1/842112630/TB2Su1sxkKWBuNjy1zjXXcOypXa_!!842112630.jpg",
          },
          {
            "id": 10150,
            "name": "包装材料",
            "thumbnail": "https://gd2.alicdn.com/imgextra/i1/842112630/TB2Su1sxkKWBuNjy1zjXXcOypXa_!!842112630.jpg",
          },
          {
            "id": 10205,
            "name": "食品保健",
            "thumbnail": "https://gd2.alicdn.com/imgextra/i1/842112630/TB2Su1sxkKWBuNjy1zjXXcOypXa_!!842112630.jpg",
          },
          {
            "id": 10206,
            "name": "箱包皮具",
            "thumbnail": "https://gd2.alicdn.com/imgextra/i1/842112630/TB2Su1sxkKWBuNjy1zjXXcOypXa_!!842112630.jpg",
          },
          {
            "id": 10209,
            "name": "户外运动",
            "thumbnail": "https://gd2.alicdn.com/imgextra/i1/842112630/TB2Su1sxkKWBuNjy1zjXXcOypXa_!!842112630.jpg",
          },
          {
            "id": 10210,
            "name": "汽车周边",
            "thumbnail": "https://gd2.alicdn.com/imgextra/i1/842112630/TB2Su1sxkKWBuNjy1zjXXcOypXa_!!842112630.jpg",
          },

        ]
      },
    });
  }

  static distest1() {
    return json.encode({
      "code": 200,
      "msg": "success",
      "data": {
        "list": [
          {
            "id": 2001,
            "name": "子分类1",
            "thumbnail":   "https://mosaic01.ztat.net/vgs/media/pdp-zoom/PY/52/2D/01/FG/11/PY522D01F-G11@8.jpg",
          },
          {
            "id": 2002,
            "name": "子分类2",
            "thumbnail":   "https://gd2.alicdn.com/imgextra/i1/842112630/TB2Su1sxkKWBuNjy1zjXXcOypXa_!!842112630.jpg",
          },
          {
            "id": 2003,
            "name": "子分类3",
            "thumbnail": "https://mosaic01.ztat.net/vgs/media/packshot/pdp-zoom/N1/94/4E/00/4G/11/N1944E004-G11@10.jpg",
          },
          {
            "id": 2004,
            "name": "子分类4",
            "thumbnail": "https://gd2.alicdn.com/imgextra/i1/842112630/TB2Su1sxkKWBuNjy1zjXXcOypXa_!!842112630.jpg",
          },
          {
            "id": 2008,
            "name": "子分类5",
            "thumbnail": "https://gd2.alicdn.com/imgextra/i1/842112630/TB2Su1sxkKWBuNjy1zjXXcOypXa_!!842112630.jpg",
          },
          {
            "id": 10050,
            "name": "子分类6",
            "thumbnail": "https://gd2.alicdn.com/imgextra/i1/842112630/TB2Su1sxkKWBuNjy1zjXXcOypXa_!!842112630.jpg",
          },
          {
            "id": 10150,
            "name": "子分类7",
            "thumbnail": "https://gd2.alicdn.com/imgextra/i1/842112630/TB2Su1sxkKWBuNjy1zjXXcOypXa_!!842112630.jpg",
          },
          {
            "id": 10205,
            "name": "子分类8",
            "thumbnail": "https://gd2.alicdn.com/imgextra/i1/842112630/TB2Su1sxkKWBuNjy1zjXXcOypXa_!!842112630.jpg",
          },
          {
            "id": 10206,
            "name": "子分类9",
            "thumbnail": "https://gd2.alicdn.com/imgextra/i1/842112630/TB2Su1sxkKWBuNjy1zjXXcOypXa_!!842112630.jpg",
          },
          {
            "id": 10209,
            "name": "子分类10",
            "thumbnail": "https://gd2.alicdn.com/imgextra/i1/842112630/TB2Su1sxkKWBuNjy1zjXXcOypXa_!!842112630.jpg",
          },
          {
            "id": 10210,
            "name": "子分类111",
            "thumbnail": "https://gd2.alicdn.com/imgextra/i1/842112630/TB2Su1sxkKWBuNjy1zjXXcOypXa_!!842112630.jpg",
          },

        ]
      },
    });
  }
}
