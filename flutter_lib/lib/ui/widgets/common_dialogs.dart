import 'package:flutter/material.dart';
import 'package:flutter_lib/bridge/common_bridge.dart';
import 'package:flutter_lib/bridge/pay_bridge.dart';
import 'package:flutter_lib/model/Result.dart';
import 'package:flutter_lib/utils/uidata.dart';

fetchApiResult(BuildContext context, String snapshot) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
          title: Text(UIData.error),
          content: Text("AlertDialog"),
          actions: <Widget>[
            FlatButton(
              child: Text(UIData.ok),
              onPressed: () => Navigator.pop(context),
            )
          ],
        ),
  );
}

showSuccess(BuildContext context, String message, IconData icon) {
  showDialog(
      context: context,
      builder: (context) => Center(
            child: Material(
              borderRadius: BorderRadius.circular(8.0),
              color: Colors.black,
              elevation: 5.0,
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Icon(
                      icon,
                      color: Colors.green,
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      message,
                      style: TextStyle(
                          fontFamily: UIData.ralewayFont, color: Colors.white),
                    )
                  ],
                ),
              ),
            ),
          ));
}

showProgress(BuildContext context) {
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.yellow,
            ),
          ));
}

hideProgress(BuildContext context) {
  Navigator.pop(context);
}

showPayDialog(BuildContext context, double totalMoney, String tradeOrderId) {
  if (tradeOrderId == null) {
    Bridge.showLongToast("订单id无效");
    return;
  }
  showModalBottomSheet(
      context: context,
      builder: (context) => Center(
            child: Material(
              borderRadius: BorderRadius.circular(8.0),
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(32, 0, 32, 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Center(
                        child: Text("确认付款",
                            style: TextStyle(
                                color: UIData.ff33333, fontSize: 18))),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 46, 0, 0),
                      child: Text(
                        "￥" + totalMoney.toStringAsFixed(2),
                        style: TextStyle(color: UIData.ff353535, fontSize: 33),
                      ),
                    ),
                    Divider(),
                    Padding(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Text(
                            "订单信息",
                            style:
                                TextStyle(color: UIData.ff666666, fontSize: 15),
                          ),
                          Text(
                            "商品组合",
                            style: TextStyle(color: Colors.black, fontSize: 15),
                          )
                        ],
                      ),
                      padding: EdgeInsets.fromLTRB(14, 14, 14, 14),
                    ),
                    Divider(),
                    Padding(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            "付款方式",
                            style:
                                TextStyle(color: UIData.ff666666, fontSize: 15),
                          ),
                          Text(
                            "微信",
                            style: TextStyle(color: Colors.black, fontSize: 15),
                          )
                        ],
                      ),
                      padding: EdgeInsets.fromLTRB(14, 14, 14, 0),
                    ),
                    Divider(),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                      child: UIData.getShapeButton(
                        UIData.fffa4848,
                        UIData.fff,
                        345,
                        45,
                        "立即付款",
                        18,
                        5,
                        () {
                          //"1555746236014000",
                          //"商品描述",
                          Future<Result> future = PayBridge.wxPay(
                              tradeOrderId,
                              "123.12.12.123",
                              "商品组合",
                              "附加数据，在查询API和支付通知中原样返回，该字段主要用于商户携带订单的自定义数据");
                          future.then((v) {
                            if (v.code == 200) {
                              Navigator.pushNamed(context, UIData.homeRoute);
                            } else if (v.code == 403) {
                              //支付失败
                              Navigator.pop(context, false);
                              Bridge.showShortToast(v.msg);
                            } else if (v.code == 406) {
                              //取消支付
                              Navigator.pop(context, false);
                              Bridge.showShortToast(v.msg);
                            }
                          });
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
          ));
}
