import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lib/utils/uidata.dart';

class ErrorStatusWidget extends StatelessWidget {
  var type = 0;
  var errorCode = 500;
  //errorCode200：请求成功
//  500：解析异常
//  404：找不到服务地址或服务访问失败
//  600：网络未开启
//  601：连接超时
  var tab;
  String error;
  String action;

  ErrorStatusWidget(
    this.errorCode,
    this.error,
    this.tab,
  );

  ErrorStatusWidget.order(
    this.errorCode,
    this.error,
    this.tab,
  ) {
    type = 0;
  }

  ErrorStatusWidget.search(
    this.errorCode,
    this.error,
    this.tab,
  ) {
    type = 1;
  }

  ErrorStatusWidget.cart(
    this.errorCode,
    this.error,
    this.tab,
  ) {
    type = 2;
  }

  @override
  Widget build(BuildContext context) {
    Widget img = Image.asset(UIData.net_error,width: 196,height: 196,);
    if (type == 0) {
      img = Image.asset(UIData.no_order,width: 196,height: 196,);
    } else if (type == 1) {
      img = Image.asset(UIData.no_search_result,width: 196,height: 196,);
    } else if (type == 2) {
      img = Image.asset(UIData.no_cart,width: 196,height: 196,);
    }
    switch (errorCode) {
      case 404:
      case 600:
      case 601:
        img = Image.asset(UIData.net_error,width: 196,height: 196,);
        break;
    }
    if (type == 0) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            children: <Widget>[
              img,
              GestureDetector(
                child: Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Text(
                    error == null ? "暂无订单" : error,
                    textAlign: TextAlign.center,
                  ),
                ),
                onTap: tab,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                child: SizedBox(
                  width: 105,
                  height: 30,
                  child: FlatButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          side: BorderSide(
                              color: Color(0xFFF9F3FF), style: BorderStyle.solid, width: 2)),
                    onPressed: tab,
                    child: new Text("去下单"),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    } else if (type == 1) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              children: <Widget>[
                img,
                Text(
                  error == null ? "暂无搜索结果\n换个搜索词试试" : error,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      );
    } else if (type == 2) {
      return Center(
        child: Column(
          children: <Widget>[
            img,
            GestureDetector(
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Text(
                  error == null ? "暂无购物记录~" : error,
                  textAlign: TextAlign.center,
                ),
              ),
              onTap: tab,
            ),
            SizedBox(
              width: 105,
              height: 30,
              child: FlatButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    side: BorderSide(
                        color: Color(0xFFF9F3FF), style: BorderStyle.solid, width: 2)),
                onPressed: tab,
                child: new Text("立即购物"),
              ),
            ),
          ],
        ),
      );
    }
  }
}
