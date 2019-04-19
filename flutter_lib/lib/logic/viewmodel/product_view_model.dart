import 'package:flutter/material.dart';
import 'package:flutter_lib/bridge/product_bridge.dart';
import 'package:flutter_lib/model/Result.dart';
import 'package:flutter_lib/model/address.dart';
import 'package:flutter_lib/model/orderDetail.dart';

import 'package:flutter_lib/model/product.dart';
import 'dart:convert';

class ProductViewModel {
  List<Product> productsItems;

  ProductViewModel({this.productsItems});

  getProduct1Tests() => <Product>[
        new Product(
            name: "情趣内衣服女性感小胸兔女郎女仆装开档制服诱惑午夜魅力激情套装",
            image:
                "https://gd4.alicdn.com/imgextra/i4/2927333027/O1CN01EW7p0O1YEPNUYL65B_!!2927333027.jpg_400x400.jpg_.webp",
            price: "¥49.00",
            priceNum: 83.99,
            brand: "MAI PIÙ SENZA",
            description: "Awesome Heels",
            rating: 4.1,
            totalReviews: 22,
            size: [37, 40, 41],
            color: ["红色", "黑色", "蓝色"]),
        new Product(
            name: "Alice W花花家蝴蝶结一字肩抹胸上衣露肩性感打底内衣女无肩带",
            image:
                "https://img.alicdn.com/imgextra/i2/115232883/O1CN01EQXrw41XASMSEzjB9_!!115232883.jpg",
            price: "¥59.00",
            priceNum: 83.99,
            brand: "MAI PIÙ SENZA",
            description: "Awesome Heels",
            rating: 4.1,
            totalReviews: 22,
            size: [37, 40, 41],
            color: ["红色", "黑色", "蓝色"]),
        new Product(
            name: "性感夜店情趣内衣女秘书ol紧身包臀短裙制服诱惑白领职业装睡衣裙",
            image:
                "https://gd3.alicdn.com/imgextra/i2/0/TB1xcJ3kbsTMeJjSszdXXcEupXa_!!0-item_pic.jpg_400x400.jpg",
            price: "¥27.00",
            priceNum: 83.99,
            brand: "MAI PIÙ SENZA",
            description: "Awesome Heels",
            rating: 4.1,
            totalReviews: 22,
            size: [37, 40, 41],
            color: ["红色", "黑色", "蓝色"]),
        new Product(
            name: "情趣内衣蕾丝女仆极度诱惑性感女佣制服夜店兔女郎小胸激情套装骚",
            image:
                "https://gd2.alicdn.com/imgextra/i2/2873137436/TB2gX2DrDmWBKNjSZFBXXXxUFXa_!!2873137436.png_400x400.jpg",
            price: "¥29.00",
            priceNum: 83.99,
            brand: "MAI PIÙ SENZA",
            description: "Awesome Heels",
            rating: 4.1,
            totalReviews: 22,
            size: [37, 40, 41],
            color: ["红色", "黑色", "蓝色"]),
        new Product(
            name: "情趣内衣制服骚学生可爱套装激情水手服jk学院风女仆装性感老师",
            image:
                "https://gd2.alicdn.com/imgextra/i1/842112630/TB2Su1sxkKWBuNjy1zjXXcOypXa_!!842112630.jpg",
            price: "¥89.00",
            priceNum: 83.99,
            brand: "MAI PIÙ SENZA",
            description: "Awesome Heels",
            rating: 4.1,
            totalReviews: 22,
            size: [37, 40, 41],
            color: ["红色", "黑色", "蓝色"]),
        new Product(
            name: "jk学生制服女套装软妹服装内衣情趣水手服性感骚短可爱学生妹女装",
            image:
                "https://gd1.alicdn.com/imgextra/i4/842112630/TB2HDRvjb1YBuNjSszeXXablFXa_!!842112630.jpg",
            price: "¥89.00",
            priceNum: 83.99,
            brand: "MAI PIÙ SENZA",
            description: "Awesome Heels",
            rating: 4.1,
            totalReviews: 22,
            size: [37, 40, 41],
            color: ["红色", "黑色", "蓝色"]),
        new Product(
            name: "性感女仆情趣内衣服小胸激情套装血滴子透视开档紧身夜店制服诱惑",
            image:
                "https://gd3.alicdn.com/imgextra/i3/2873137436/TB2R7juDeySBuNjy1zdXXXPxFXa_!!2873137436.jpg",
            price: "¥38.00",
            priceNum: 83.99,
            brand: "MAI PIÙ SENZA",
            description: "Awesome Heels",
            rating: 4.1,
            totalReviews: 22,
            size: [37, 40, 41],
            color: ["红色", "黑色", "蓝色"]),
        new Product(
            name: "大moss 露肩性感裹胸内衣打底韩版外穿针织黑色抹胸上衣女无肩带",
            image:
                "https://gd1.alicdn.com/imgextra/i1/173752284/O1CN01a8IsUi1Sk774g4TgD_!!173752284.jpg",
            price: "¥59.00",
            priceNum: 83.99,
            brand: "MAI PIÙ SENZA",
            description: "Awesome Heels",
            rating: 4.1,
            totalReviews: 22,
            size: [37, 40, 41],
            color: ["红色", "黑色", "蓝色"]),
        new Product(
            name: "情趣性感内衣cosplay女佣制服诱惑围裙女仆装洛丽塔撩汉可爱套装",
            image:
                "https://gd2.alicdn.com/imgextra/i2/2393144150/TB2w5wMoiMnBKNjSZFoXXbOSFXa_!!2393144150.jpg",
            price: "¥35.80",
            priceNum: 83.99,
            brand: "MAI PIÙ SENZA",
            description: "Awesome Heels",
            rating: 4.1,
            totalReviews: 22,
            size: [37, 40, 41],
            color: ["红色", "黑色", "蓝色"])
      ];

  getProductTests() => <Product>[
        Product(
            brand: "Levis",
            description: "Print T-shirt",
            image:
                "https://gd4.alicdn.com/imgextra/i4/2927333027/O1CN01EW7p0O1YEPNUYL65B_!!2927333027.jpg_400x400.jpg_.webp",
            name: "THE PERFECT",
            price: "£19.99",
            priceNum: 19.99,
            rating: 4.0,
            colors: [
              ProductColor(
                color: Colors.red,
                colorName: "Red",
              ),
              ProductColor(
                color: Colors.green,
                colorName: "Green",
              ),
              ProductColor(
                color: Colors.blue,
                colorName: "Blue",
              ),
              ProductColor(
                color: Colors.cyan,
                colorName: "Cyan",
              )
            ],
            quantity: 0,
            sizes: ["S", "M", "L", "XL"],
            totalReviews: 170,
            size: [37, 40, 41],
            color: ["红色", "黑色", "蓝色"]),
        Product(
            brand: "adidas Performance",
            description: "Pool sliders",
            image:
                "https://gd4.alicdn.com/imgextra/i4/2927333027/O1CN01EW7p0O1YEPNUYL65B_!!2927333027.jpg_400x400.jpg_.webp",
            name: "AQUALETTE",
            price: "£13.49",
            priceNum: 13.49,
            rating: 5.0,
            totalReviews: 10,
            size: [37, 40, 41],
            color: ["红色", "黑色", "蓝色"]),
        Product(
            brand: "Produkt",
            description: "Men's Shirt",
            image:
                "https://mosaic01.ztat.net/vgs/media/pdp-zoom/PY/52/2D/01/FG/11/PY522D01F-G11@8.jpg",
            name: "ROBI CHECK",
            price: "£16.49",
            priceNum: 34.99,
            rating: 4.5,
            totalReviews: 0,
            size: [37, 40, 41],
            color: ["红色", "黑色", "蓝色"]),
        Product(
            brand: "adidas Originals",
            description: "Hoodie",
            image:
                "https://gd4.alicdn.com/imgextra/i4/2927333027/O1CN01EW7p0O1YEPNUYL65B_!!2927333027.jpg_400x400.jpg_.webp",
            name: "TREF OVER HOOD",
            price: "£34.99",
            priceNum: 34.99,
            rating: 4.0,
            totalReviews: 5,
            size: [37, 40, 41],
            color: ["红色", "黑色", "蓝色"]),
        Product(
            brand: "ION",
            description: "Hydration rucksack",
            image:
                "https://gd4.alicdn.com/imgextra/i4/2927333027/O1CN01EW7p0O1YEPNUYL65B_!!2927333027.jpg_400x400.jpg_.webp",
            name: "BACKPACK VILLAIN 4",
            price: "£34.99",
            priceNum: 55.99,
            rating: 4.8,
            totalReviews: 12,
            size: [37, 40, 41],
            color: ["红色", "黑色", "蓝色"]),
        Product(
            brand: "Diesel",
            description: "Straight leg jeans",
            image:
                "https://gd4.alicdn.com/imgextra/i4/2927333027/O1CN01EW7p0O1YEPNUYL65B_!!2927333027.jpg_400x400.jpg_.webp",
            name: "THYTAN",
            price: "£83.99",
            priceNum: 83.99,
            rating: 4.2,
            totalReviews: 28,
            size: [37, 40, 41],
            color: ["红色", "黑色", "蓝色"]),
        Product(
            brand: "YOURTURN",
            description: "Watch in budget",
            image:
                "https://gd4.alicdn.com/imgextra/i4/2927333027/O1CN01EW7p0O1YEPNUYL65B_!!2927333027.jpg_400x400.jpg_.webp",
            name: "Watch",
            price: "£11.99",
            priceNum: 11.99,
            rating: 4.7,
            totalReviews: 120,
            size: [37, 40, 41],
            color: ["红色", "黑色", "蓝色"]),
        Product(
            brand: "Vero Moda",
            description: "Day dress - black/off",
            image:
                "https://gd4.alicdn.com/imgextra/i4/2927333027/O1CN01EW7p0O1YEPNUYL65B_!!2927333027.jpg_400x400.jpg_.webp",
            name: "VMKANA",
            price: "£26.59",
            priceNum: 26.59,
            rating: 4.0,
            totalReviews: 33,
            size: [37, 40, 41],
            color: ["红色", "黑色", "蓝色"]),
        Product(
            brand: "ONLY",
            description: "A-line skirt",
            image:
                "https://mosaic01.ztat.net/vgs/media/pdp-zoom/ON/32/1B/0B/JG/11/ON321B0BJ-G11@8.jpg",
            name: "ONLTHAI FRILL",
            price: "£25.59",
            priceNum: 25.59,
            rating: 4.4,
            totalReviews: 44,
            size: [37, 40, 41],
            color: ["红色", "黑色", "蓝色"]),
        Product(
            image:
                "https://mosaic01.ztat.net/vgs/media/pdp-zoom/M6/61/1B/02/9A/11/M6611B029-A11@13.jpg",
            name: "HIGH HEELS",
            price: "£59.99",
            priceNum: 59.99,
            brand: "MAI PIÙ SENZA",
            description: "Awesome Heels",
            rating: 4.1,
            totalReviews: 22,
            size: [37, 40, 41],
            color: ["红色", "黑色", "蓝色"]),
      ];

  getOderDetailProducts() => <Product>[
        new Product(
            brand: "Levis",
            description: "Print T-shirt",
            image:
                "https://mosaic02.ztat.net/vgs/media/pdp-zoom/LE/22/1D/02/2A/12/LE221D022-A12@16.1.jpg",
            name: "THE PERFECT",
            price: "¥19.99",
            priceNum: 19.99,
            rating: 4.0,
            colors: [
              ProductColor(
                color: Colors.red,
                colorName: "Red",
              ),
              ProductColor(
                color: Colors.green,
                colorName: "Green",
              ),
              ProductColor(
                color: Colors.blue,
                colorName: "Blue",
              ),
              ProductColor(
                color: Colors.cyan,
                colorName: "Cyan",
              )
            ],
            quantity: 0,
            sizes: ["S", "M", "L", "XL"],
            totalReviews: 170,
            size: [37, 40, 41],
            color: ["红色", "黑色", "蓝色"]),
        new Product(
            name: "情趣内衣蕾丝女仆极度诱惑性感女佣制服夜店兔女郎小胸激情套装骚",
            image:
                "https://gd2.alicdn.com/imgextra/i2/2873137436/TB2gX2DrDmWBKNjSZFBXXXxUFXa_!!2873137436.png_400x400.jpg",
            price: "¥29.00",
            brand: "MAI PIÙ SENZA",
            description: "Awesome Heels",
            rating: 4.1,
            totalReviews: 22,
            size: [37, 40, 41],
            color: ["红色", "黑色", "蓝色"]),
        new Product(
            name: "情趣内衣制服骚学生可爱套装激情水手服jk学院风女仆装性感老师",
            image:
                "https://gd2.alicdn.com/imgextra/i1/842112630/TB2Su1sxkKWBuNjy1zjXXcOypXa_!!842112630.jpg",
            price: "¥89.00",
            brand: "MAI PIÙ SENZA",
            description: "Awesome Heels",
            rating: 4.1,
            totalReviews: 22,
            size: [37, 40, 41],
            color: ["红色", "黑色", "蓝色"])
      ];

  List<OrderDetail> getOrderDetailList() {
    List<OrderDetail> orderList = new List<OrderDetail>();
    OrderDetail orderDetail = new OrderDetail();
    orderDetail.status = 2;
    orderDetail.express = "离开【太原中心】，下一站【广州中心】";
    Address address = new Address();
    address.name = "王大锤";
    address.phone = "12345678901";
    address.area = "金牛区";
    address.address = "四川省成都市金牛区西雅图";
    orderDetail.address = address;
    orderDetail.products = ProductViewModel().getOderDetailProducts();
    orderDetail.orderNumber = "2539129895";
    orderDetail.orderTime = "2018.12.22 09:32";
    orderDetail.payMode = "支付宝";
    orderDetail.productTotal = 195.00;
    orderDetail.freight = 12.00;
    orderDetail.payPrice = 165.00;
    orderList.add(orderDetail);
    OrderDetail orderDetail1 = new OrderDetail();
    orderDetail1.status = 1;
    orderDetail1.express = "离开【太原中心】，下一站【广州中心】";
    address = new Address();
    address.name = "王大锤";
    address.phone = "12345678901";
    address.area = "金牛区";
    address.address = "四川省成都市金牛区西雅图";
    orderDetail1.address = address;
    orderDetail1.products = <Product>[
      new Product(
          name: "大moss 露肩性感裹胸内衣打底韩版外穿针织黑色抹胸上衣女无肩带",
          image:
              "https://gd1.alicdn.com/imgextra/i1/173752284/O1CN01a8IsUi1Sk774g4TgD_!!173752284.jpg",
          price: "¥59.00",
          brand: "MAI PIÙ SENZA",
          description: "Awesome Heels",
          rating: 4.1,
          totalReviews: 22,
          size: [37, 40, 41],
          color: ["红色", "黑色", "蓝色"])
    ];
    orderDetail1.orderNumber = "2539129895";
    orderDetail1.orderTime = "2018.12.22 09:32";
    orderDetail1.payMode = "支付宝";
    orderDetail1.productTotal = 195.00;
    orderDetail1.freight = 12.00;
    orderDetail1.payPrice = 165.00;
    orderList.add(orderDetail1);
    OrderDetail orderDetail2 = new OrderDetail();
    orderDetail2.status = 0;
    orderDetail2.express = "离开【太原中心】，下一站【广州中心】";
    address = new Address();
    address.name = "王大锤";
    address.phone = "12345678901";
    address.area = "金牛区";
    address.address = "四川省成都市金牛区西雅图";
    orderDetail2.address = address;
    orderDetail2.products = <Product>[
      new Product(
          name: "大moss 露肩性感裹胸内衣打底韩版外穿针织黑色抹胸上衣女无肩带",
          image:
              "https://gd1.alicdn.com/imgextra/i1/173752284/O1CN01a8IsUi1Sk774g4TgD_!!173752284.jpg",
          price: "¥59.00",
          brand: "MAI PIÙ SENZA",
          description: "Awesome Heels",
          rating: 4.1,
          totalReviews: 22,
          size: [37, 40, 41],
          color: ["红色", "黑色", "蓝色"])
    ];
    orderDetail2.orderNumber = "2539129895";
    orderDetail2.orderTime = "2018.12.22 09:32";
    orderDetail2.payMode = "支付宝";
    orderDetail2.productTotal = 195.00;
    orderDetail2.freight = 12.00;
    orderDetail2.payPrice = 165.00;
    orderList.add(orderDetail2);
    OrderDetail orderDetail3 = new OrderDetail();
    orderDetail3.status = 3;
    orderDetail3.express = "离开【太原中心】，下一站【广州中心】";
    address = new Address();
    address.name = "王大锤";
    address.phone = "12345678901";
    address.area = "金牛区";
    address.address = "四川省成都市金牛区西雅图";
    orderDetail3.address = address;
    orderDetail3.products = <Product>[
      new Product(
          name: "性感女仆情趣内衣服小胸激情套装血滴子透视开档紧身夜店制服诱惑",
          image:
              "https://gd3.alicdn.com/imgextra/i3/2873137436/TB2R7juDeySBuNjy1zdXXXPxFXa_!!2873137436.jpg",
          price: "¥38.00",
          brand: "MAI PIÙ SENZA",
          description: "Awesome Heels",
          rating: 4.1,
          totalReviews: 22,
          size: [37, 40, 41],
          color: ["红色", "黑色", "蓝色"])
    ];
    orderDetail3.orderNumber = "2539129895";
    orderDetail3.orderTime = "2018.12.22 09:32";
    orderDetail3.payMode = "支付宝";
    orderDetail3.productTotal = 195.00;
    orderDetail3.freight = 12.00;
    orderDetail3.payPrice = 165.00;
    orderList.add(orderDetail3);
    OrderDetail orderDetail4 = new OrderDetail();
    orderDetail4.status = 4;
    orderDetail4.express = "离开【太原中心】，下一站【广州中心】";
    address = new Address();
    address.name = "王大锤";
    address.phone = "12345678901";
    address.area = "金牛区";
    address.address = "四川省成都市金牛区西雅图";
    orderDetail4.address = address;
    orderDetail4.products = <Product>[
      new Product(
          name: "jk学生制服女套装软妹服装内衣情趣水手服性感骚短可爱学生妹女装",
          image:
              "https://gd1.alicdn.com/imgextra/i4/842112630/TB2HDRvjb1YBuNjSszeXXablFXa_!!842112630.jpg",
          price: "¥89.00",
          brand: "MAI PIÙ SENZA",
          description: "Awesome Heels",
          rating: 4.1,
          totalReviews: 22,
          size: [37, 40, 41],
          color: ["红色", "黑色", "蓝色"])
    ];
    orderDetail4.orderNumber = "2539129895";
    orderDetail4.orderTime = "2018.12.22 09:32";
    orderDetail4.payMode = "支付宝";
    orderDetail4.productTotal = 195.00;
    orderDetail4.freight = 12.00;
    orderDetail4.payPrice = 165.00;
    orderList.add(orderDetail4);
    return orderList;
  }

  getDiscountList() => <Product>[
        new Product(
            brand: "Levis",
            description: "Print T-shirt",
            image:
                "https://mosaic02.ztat.net/vgs/media/pdp-zoom/LE/22/1D/02/2A/12/LE221D022-A12@16.1.jpg",
            name: "THE PERFECT",
            price: "¥19.99",
            priceNum: 19.99,
            rating: 4.0,
            colors: [
              ProductColor(
                color: Colors.red,
                colorName: "Red",
              ),
              ProductColor(
                color: Colors.green,
                colorName: "Green",
              ),
              ProductColor(
                color: Colors.blue,
                colorName: "Blue",
              ),
              ProductColor(
                color: Colors.cyan,
                colorName: "Cyan",
              )
            ],
            quantity: 0,
            sizes: ["S", "M", "L", "XL"],
            totalReviews: 170,
            size: [37, 40, 41],
            color: ["红色", "黑色", "蓝色"]),
        new Product(
            name: "情趣内衣蕾丝女仆极度诱惑性感女佣制服夜店兔女郎小胸激情套装骚",
            image:
                "https://gd2.alicdn.com/imgextra/i2/2873137436/TB2gX2DrDmWBKNjSZFBXXXxUFXa_!!2873137436.png_400x400.jpg",
            price: "¥29.00",
            brand: "MAI PIÙ SENZA",
            description: "Awesome Heels",
            rating: 4.1,
            totalReviews: 22),
        new Product(
            name: "情趣内衣制服骚学生可爱套装激情水手服jk学院风女仆装性感老师",
            image:
                "https://gd2.alicdn.com/imgextra/i1/842112630/TB2Su1sxkKWBuNjy1zjXXcOypXa_!!842112630.jpg",
            price: "¥89.00",
            brand: "MAI PIÙ SENZA",
            description: "Awesome Heels",
            rating: 4.1,
            totalReviews: 22,
            size: [37, 40, 41],
            color: ["红色", "黑色", "蓝色"]),
        new Product(
            name: "Alice W花花家蝴蝶结一字肩抹胸上衣露肩性感打底内衣女无肩带",
            image:
                "https://img.alicdn.com/imgextra/i2/115232883/O1CN01EQXrw41XASMSEzjB9_!!115232883.jpg",
            price: "¥59.00",
            brand: "MAI PIÙ SENZA",
            description: "Awesome Heels",
            rating: 4.1,
            totalReviews: 22,
            size: [37, 40, 41],
            color: ["红色", "黑色", "蓝色"]),
      ];
}
