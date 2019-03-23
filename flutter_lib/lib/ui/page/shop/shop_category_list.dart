import 'package:flutter/material.dart';
import 'package:flutter_lib/logic/viewmodel/category_view_model.dart';
import 'package:flutter_lib/logic/viewmodel/sub_category_view_model.dart';
import 'package:flutter_lib/model/category.dart';
import 'package:flutter_lib/ui/page/shop/shop_list.dart';
import 'package:flutter_lib/utils/uidata.dart';

class ShopCategoryList extends StatelessWidget {
  String title;
  BuildContext buildContext;
  ShopCategoryList(String title) {
    this.title = title;
  }

  @override
  Widget build(BuildContext context) {
    buildContext = context;
    return ShopCategoryListPage(
      title: title,
    );
  }
}

class ShopCategoryListPage extends StatefulWidget {
  ShopCategoryListPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  ShopCategoryListState createState() => ShopCategoryListState();
}

class ShopCategoryListState extends State<ShopCategoryListPage> {
  Widget appBarTitle;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: new AppBar(
          centerTitle: true,
          title: Text(widget.title),
          leading: new IconButton(
            icon: UIData.back,
            onPressed: () => Navigator.pop(context, false),
          ),
        ),
        body: Container(
          color: UIData.fff,
          child: bodyData(),
        ),
        // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }

  int selectIndex = 0;

  Widget bodyData() {
    CategoryViewModel categoryViewModel = new CategoryViewModel();
    List<Category> categories = categoryViewModel.getCategory();

    SubCategoryViewModel productViewModel = new SubCategoryViewModel();
    List<Category> data = productViewModel.getCategory();
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: Container(
              color: UIData.fff6f6f6,
              child:  ListView.builder(
                itemCount: categories.length,
                itemBuilder: (buildContext, index) {
                  return GestureDetector(
                    child: Container(
                      color: selectIndex == index ? UIData.fff : UIData.fff6f6f6,
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(16, 16, 16, 16),
                        child: Text(
                          categories[index].name,
                          style: TextStyle(
                              color: selectIndex == index
                                  ? UIData.fffa4848
                                  : UIData.ff353535,
                              fontSize: selectIndex == index ? 15 : 12),
                        ),
                      ),
                    ),
                    onTap: () {
                      setState(() {
                        this.selectIndex = index;
                      });
                    },
                  );
                },
              ),
            ),
            flex: 1,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
              child: CustomScrollView(
                slivers: <Widget>[
                  SliverList(
                    delegate: SliverChildListDelegate(
                      [
                        Center(
                          child: UIData.getTextWithPading(
                              categories[selectIndex].name,
                              UIData.ff353535,
                              12,
                              16),
                        ),
                      ],
                    ),
                  ),
                  SliverGrid(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 8.0,
                      mainAxisSpacing: 8.0,
                      childAspectRatio: 0.66,
                    ),
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        return new GestureDetector(
                          child: new Container(
                            alignment: Alignment.center,
                            child: new Column(
                              children: <Widget>[
                                new Stack(
                                  children: <Widget>[
                                    Image.network(
                                      data[index].image,
                                      fit: BoxFit.contain,
                                    ),
                                    Positioned(
                                        bottom: 0,
                                        left: 0,
                                        right: 0,
                                        child: new Container(
                                          color: Colors.white,
                                          child: new Column(
                                            children: <Widget>[
                                              new Padding(
                                                padding: EdgeInsets.fromLTRB(
                                                    0, 12, 0, 6),
                                                child: new Text(
                                                  data[index].name,
                                                  style: TextStyle(
                                                      fontSize: 11,
                                                      color: UIData.ff353535),
                                                  maxLines: 1,
                                                ),
                                              ),
                                            ],
                                          ),
                                        )),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                new MaterialPageRoute(
                                    builder: (context) =>
                                        new ShopList(data[index].name)));
                          },
                        );
                      },
                      childCount: data.length,
                    ),
                  ),
                ],
              ),
            ),
            flex: 3,
          ),
        ],
      ),
    );
  }
}
