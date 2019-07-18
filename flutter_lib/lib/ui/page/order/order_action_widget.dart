import 'package:flutter/material.dart';
import 'package:flutter_lib/bridge/common_bridge.dart';
import 'package:flutter_lib/bridge/order_bridge.dart';
import 'package:flutter_lib/model/OrderComment.dart';
import 'package:flutter_lib/model/Result.dart';
import 'package:flutter_lib/model/orderListItem.dart';
import 'package:flutter_lib/ui/widgets/common_dialogs.dart';
import 'package:flutter_lib/utils/uidata.dart';
class OrderActionWidget extends StatelessWidget{
  final orderItem;
  final type;
  final click;

  OrderActionWidget(this.orderItem, this.type, this.click);

  @override
  Widget build(BuildContext context) {
    return getActionBtn(context,orderItem,type,click);
  }

  Widget getActionBtn(BuildContext context,OrderItem orderItem, int type,click) {
    //    1:待付款，2:待发货，3:待收货，4:待评价,0:全部
    switch (orderItem.status) {
      case 1:
        return Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
              child: Container(
                child: GestureDetector(
                    onTap: () {
                      Future<Result> future =
                      OrderBridge.cancelOrder(orderItem.orderNumber);
                      future.then((r) {
                        if (r.code == 200) {
                          Bridge.showLongToast("取消成功");
                          click();
                        } else {
                          Bridge.showLongToast(r.msg);
                        }
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                      child: Text(
                        "取消订单",
                        style: TextStyle(color: UIData.ff353535, fontSize: 13),
                      ),
                    )),
                decoration: BoxDecoration(
                  border: Border.all(color: UIData.ff353535, width: 1),
                  borderRadius: BorderRadius.circular(13.0),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
              child: Container(
                child: GestureDetector(
                    onTap: () {
                      showPayDialog(context, double.parse(orderItem.payPrice),
                          orderItem.orderNumber,"");
                    },
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                      child: Text(
                        "立即付款",
                        style: TextStyle(color: UIData.ff353535, fontSize: 13),
                      ),
                    )),
                decoration: BoxDecoration(
                  border: Border.all(color: UIData.ff353535, width: 1),
                  borderRadius: BorderRadius.circular(13.0),
                ),
              ),
            ),
          ],
        );

      case 2:
        return Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
              child: Container(
                child: GestureDetector(
                    onTap: () {
                      Future<Result> future =
                      OrderBridge.cancelOrder(orderItem.orderNumber);
                      future.then((r) {
                        if (r.code == 200) {
                          Bridge.showLongToast("取消成功");
                          click();
                        } else {
                          Bridge.showLongToast(r.msg);
                        }
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                      child: Text(
                        "取消订单",
                        style: TextStyle(color: UIData.ff353535, fontSize: 13),
                      ),
                    )),
                decoration: BoxDecoration(
                  border: Border.all(color: UIData.ff353535, width: 1),
                  borderRadius: BorderRadius.circular(13.0),
                ),
              ),
            ),
          ],
        );
      case 3:
        return Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
              child: Container(
                child: GestureDetector(
                    onTap: () {
                      Bridge.webview("http://www.baidu.com");
                    },
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                      child: Text(
                        "查看物流",
                        style: TextStyle(color: UIData.ff353535, fontSize: 13),
                      ),
                    )),
                decoration: BoxDecoration(
                  border: Border.all(color: UIData.ff353535, width: 1),
                  borderRadius: BorderRadius.circular(13.0),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
              child: Container(
                child: GestureDetector(
                    onTap: () {
                      Future<Result> future =
                      OrderBridge.confirmOrder(orderItem.orderNumber);
                      future.then((r) {
                        if (r.code == 200) {
                          Bridge.showLongToast("已确认收货");
                          click();
                        } else {
                          Bridge.showLongToast(r.msg);
                        }
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                      child: Text(
                        "确认收货",
                        style: TextStyle(color: UIData.fffa4848, fontSize: 13),
                      ),
                    )),
                decoration: BoxDecoration(
                  border: Border.all(color: UIData.fffa4848, width: 1),
                  borderRadius: BorderRadius.circular(13.0),
                ),
              ),
            ),
          ],
        );
        break;
      case 4:
        return Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
              child: Container(
                child: GestureDetector(
                    onTap: () {
                      var goods = orderItem.products.map((f) {
                        return Goods(f.goodsId, "", "");
                      }).toList();
                      var orderComment =
                      OrderComment(orderItem.orderNumber, goods);
                      Navigator.pushNamed(context, UIData.OrderCommentPage,
                          arguments: orderComment);
                    },
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                      child: Text(
                        "评价",
                        style: TextStyle(color: UIData.fffa4848, fontSize: 13),
                      ),
                    )),
                decoration: BoxDecoration(
                  border: Border.all(color: UIData.fffa4848, width: 1),
                  borderRadius: BorderRadius.circular(13.0),
                ),
              ),
            ),
          ],
        );
      default:
        return Text("");
    }
  }
}

