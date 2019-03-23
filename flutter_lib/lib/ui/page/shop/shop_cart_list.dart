import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_lib/logic/viewmodel/category_view_model.dart';
import 'package:flutter_lib/logic/viewmodel/sub_category_view_model.dart';
import 'package:flutter_lib/model/category.dart';
import 'package:flutter_lib/ui/page/shop/shop_list.dart';
import 'package:flutter_lib/utils/uidata.dart';
import 'package:flutter_lib/logic/manager/shop_cart_manager.dart';

class ShopCartList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ShopCartListPage();
  }
}

class ShopCartListPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ShopCartListState();
  }
}

class _ShopCartListState extends State<ShopCartListPage> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      statusBarColor: UIData.fffa4848, //or set color with: Color(0xFF0000FF)
    ));

    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: UIData.fffa4848,
        centerTitle: false,
        title: Text(
          "购物车",
          style: TextStyle(color: UIData.fff, fontSize: 18),
        ),
        elevation: 0,
        leading: new IconButton(
          icon: Icon(Icons.arrow_back_ios, color: UIData.fff),
          color: UIData.fff,
          onPressed: () => Navigator.pop(context, false),
        ),
      ),
      body: Container(
        child: Stack(
          children: <Widget>[
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 45,
                color: UIData.fffa4848,
                child: Text(""),
              ),
            ),
            Positioned(
              top: 0,
              bottom: 50,
              left: 10,
              right: 10,
              child: ListView.builder(
                itemCount: ShopCartManager.instance.size(),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    child: Container(
                      child:
                          Text(ShopCartManager.instance.products[index].name),
                    ),
                    onTap: () {},
                  );
                },
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 50,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Row(
                        children: <Widget>[
                          Checkbox(
                            value: false,
                            onChanged: (bool value) {},
                          ),
                          Text(
                            "全选",
                            style:
                                TextStyle(color: UIData.ff353535, fontSize: 15),
                          ),
                        ],
                      ),
                      flex: 1,
                    ),
                    Expanded(
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Padding(
                              child: Text(
                                "￥" +
                                    ShopCartManager.instance
                                        .getTotalPrice()
                                        .toStringAsFixed(2),
                                style: TextStyle(
                                    color: UIData.fffa4848, fontSize: 18),
                              ),
                              padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                            ),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(0, 0, 15, 0),
                                child: UIData.getShapeButton(UIData.fffa4848,
                                    UIData.fff, 90, 33, "提交订单", 15, 17, () {}),
                              ),
                            ),
                          ],
                        ),
                      ),
                      flex: 1,
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 50,
              left: 0,
              right: 0,
              child: Divider(),
            ),
          ],
        ),
      ),
    );
  }
}
