import 'package:flutter/material.dart';
import 'package:flutter_lib/model/address.dart';
import 'package:flutter_lib/model/orderListItem.dart';
import 'package:flutter_lib/model/product.dart';

class OrderViewModel {
  List<OrderItem> orders;

  OrderViewModel({this.orders});

  getOrders() => <OrderItem>[
        OrderItem(
          status: 0,
          address: new Address(
              name: "dsda地址",
              phone: "154xxxxxxx",
              address: "xxx号"),
          products: <Product>[
            Product(
                image:
                    "https://mosaic01.ztat.net/vgs/media/pdp-zoom/M6/61/1B/02/9A/11/M6611B029-A11@13.jpg",
                name: "HIGH HEELS",
                price: "£59.99",
                priceNum: 59.99,
                brand: "MAI PIÙ SENZA",
                description: "Awesome Heels",
                rating: 4.1,
                count: 1,
                totalReviews: 22),
            Product(
                name: "情趣内衣服女性感小胸兔女郎女仆装开档制服诱惑午夜魅力激情套装",
                image:
                    "https://gd4.alicdn.com/imgextra/i4/2927333027/O1CN01EW7p0O1YEPNUYL65B_!!2927333027.jpg_400x400.jpg_.webp",
                price: "¥49.00",
                priceNum: 59.99,
                brand: "MAI PIÙ SENZA",
                description: "Awesome Heels",
                rating: 4.1,
                count: 5,
                totalReviews: 22),
          ],
          orderNumber: "xxxxx",
          orderTime: DateTime.now().toLocal().toString(),
          payMode: "支付宝",
          productTotal: 230.00,
          freight: 10.00,
          payPrice: 240.00,
        ),
        OrderItem(
          status: 0,
          address: new Address(
              name: "dsda地址",
              phone: "154xxxxxxx",
              address: "xxx号"),
          products: <Product>[
            Product(
                image:
                    "https://mosaic01.ztat.net/vgs/media/pdp-zoom/M6/61/1B/02/9A/11/M6611B029-A11@13.jpg",
                name: "HIGH HEELS",
                price: "£59.99",
                priceNum: 59.99,
                brand: "MAI PIÙ SENZA",
                description: "Awesome Heels",
                rating: 4.1,
                count: 1,
                totalReviews: 22),
            new Product(
                name: "情趣内衣服女性感小胸兔女郎女仆装开档制服诱惑午夜魅力激情套装",
                image:
                    "https://gd4.alicdn.com/imgextra/i4/2927333027/O1CN01EW7p0O1YEPNUYL65B_!!2927333027.jpg_400x400.jpg_.webp",
                price: "¥49.00",
                priceNum: 59.99,
                brand: "MAI PIÙ SENZA",
                description: "Awesome Heels",
                rating: 4.1,
                count: 5,
                totalReviews: 22),
            new Product(
                name: "性感夜店情趣内衣女秘书ol紧身包臀短裙制服诱惑白领职业装睡衣裙",
                image:
                    "https://gd3.alicdn.com/imgextra/i2/0/TB1xcJ3kbsTMeJjSszdXXcEupXa_!!0-item_pic.jpg_400x400.jpg",
                price: "¥27.00",
                priceNum: 59.99,
                brand: "MAI PIÙ SENZA",
                description: "Awesome Heels",
                rating: 4.1,
                count: 5,
                totalReviews: 22),
          ],
          orderNumber: "xxxxx1",
          orderTime: DateTime.now().toLocal().toString(),
          payMode: "支付宝",
          productTotal: 230.00,
          freight: 10.00,
          payPrice: 240.00,
        ),
        OrderItem(
          status: 0,
          address: new Address(
              name: "dsda地址",
              phone: "154xxxxxxx",
              address: "xxx号"),
          products: <Product>[
            Product(
                image:
                    "https://mosaic01.ztat.net/vgs/media/pdp-zoom/M6/61/1B/02/9A/11/M6611B029-A11@13.jpg",
                name: "HIGH HEELS",
                price: "£59.99",
                priceNum: 59.99,
                brand: "MAI PIÙ SENZA",
                description: "Awesome Heels",
                rating: 4.1,
                count: 5,
                totalReviews: 22),
            new Product(
                name: "情趣内衣服女性感小胸兔女郎女仆装开档制服诱惑午夜魅力激情套装",
                image:
                    "https://gd4.alicdn.com/imgextra/i4/2927333027/O1CN01EW7p0O1YEPNUYL65B_!!2927333027.jpg_400x400.jpg_.webp",
                price: "¥49.00",
                priceNum: 59.99,
                brand: "MAI PIÙ SENZA",
                description: "Awesome Heels",
                rating: 4.1,
                count: 5,
                totalReviews: 22),
            new Product(
                name: "性感夜店情趣内衣女秘书ol紧身包臀短裙制服诱惑白领职业装睡衣裙",
                image:
                    "https://gd3.alicdn.com/imgextra/i2/0/TB1xcJ3kbsTMeJjSszdXXcEupXa_!!0-item_pic.jpg_400x400.jpg",
                price: "¥27.00",
                priceNum: 59.99,
                brand: "MAI PIÙ SENZA",
                description: "Awesome Heels",
                rating: 4.1,
                count: 5,
                totalReviews: 22),
            new Product(
                name: "情趣内衣蕾丝女仆极度诱惑性感女佣制服夜店兔女郎小胸激情套装骚",
                image:
                    "https://gd2.alicdn.com/imgextra/i2/2873137436/TB2gX2DrDmWBKNjSZFBXXXxUFXa_!!2873137436.png_400x400.jpg",
                price: "¥29.00",
                priceNum: 59.99,
                brand: "MAI PIÙ SENZA",
                description: "Awesome Heels",
                rating: 4.1,
                count: 5,
                totalReviews: 22),
          ],
          orderNumber: "xxxxx2",
          orderTime: DateTime.now().toLocal().toString(),
          payMode: "支付宝",
          productTotal: 230.00,
          freight: 10.00,
          payPrice: 240.00,
        ),
        OrderItem(
          status: 0,
          address: new Address(
              name: "dsda地址",
              phone: "154xxxxxxx",
              address: "xxx号"),
          products: <Product>[
            Product(
                image:
                    "https://mosaic01.ztat.net/vgs/media/pdp-zoom/M6/61/1B/02/9A/11/M6611B029-A11@13.jpg",
                name: "HIGH HEELS",
                price: "£59.99",
                priceNum: 59.99,
                brand: "MAI PIÙ SENZA",
                description: "Awesome Heels",
                rating: 4.1,
                count: 5,
                totalReviews: 22),
            new Product(
                name: "情趣内衣服女性感小胸兔女郎女仆装开档制服诱惑午夜魅力激情套装",
                image:
                    "https://gd4.alicdn.com/imgextra/i4/2927333027/O1CN01EW7p0O1YEPNUYL65B_!!2927333027.jpg_400x400.jpg_.webp",
                price: "¥49.00",
                priceNum: 59.99,
                brand: "MAI PIÙ SENZA",
                description: "Awesome Heels",
                rating: 4.1,
                count: 5,
                totalReviews: 22),
          ],
          orderNumber: "xxxxx3",
          orderTime: DateTime.now().toLocal().toString(),
          payMode: "支付宝",
          productTotal: 230.00,
          freight: 10.00,
          payPrice: 240.00,
        ),
      ];
}
