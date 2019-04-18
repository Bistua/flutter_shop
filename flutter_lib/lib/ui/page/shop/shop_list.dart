import 'package:flutter/material.dart';
import 'package:flutter_lib/logic/bloc/product_bloc.dart';
import 'package:flutter_lib/model/product.dart';
import 'package:flutter_lib/ui/page/shop/shop_detail.dart';
import 'package:flutter_lib/ui/widgets/shop_tab_item.dart';
import 'package:flutter_lib/utils/uidata.dart';
import 'package:flutter_lib/ui/widgets/shop_grid.dart';

class ShopList extends StatelessWidget {
  String title;
  ShopList(String title){
    this.title = title;
  }



  @override
  Widget build(BuildContext context) {
    return ShopListPage(title: title,);
  }
}


class ShopListPage extends StatefulWidget {

  ShopListPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  ShopListState createState() => ShopListState();
}

class ShopListState extends State<ShopListPage> {
  Widget appBarTitle;
  ProductBloc productBloc = ProductBloc();

  @override
  Widget build(BuildContext context) {

    print(productBloc.productItems);

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: new AppBar(
          centerTitle: true,
          title: Text(widget.title),
          bottom: new PreferreSizeWidget((v){
            if(v){
              productBloc.getProduct();
            }else{

            }
          }),
          leading: new IconButton(
            icon: UIData.back,
            onPressed: () => Navigator.pop(context, false),
          ),
        ),
        body: Container(
          child: bodyData(),
        ),
        // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }

  Widget bodyData() {
    productBloc.getProduct();
    return StreamBuilder<List<Product>>(
        stream: productBloc.productItems,
        builder: (context, snapshot) {
          return snapshot.hasData
              ? new ShopGridPage(snapshot.data)
              : Center(child: CircularProgressIndicator());
        });
  }


}

