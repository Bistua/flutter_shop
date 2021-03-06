import 'package:flutter/material.dart';
import 'package:flutter_lib/logic/bloc/category_bloc.dart';
import 'package:flutter_lib/model/Result.dart';
import 'package:flutter_lib/model/category.dart';
import 'package:flutter_lib/ui/inherited/category_provider.dart';
import 'package:flutter_lib/ui/widgets/error_status_widget.dart';
import 'package:flutter_lib/utils/uidata.dart';

class ShopCategoryListPage extends StatefulWidget {
  ShopCategoryListPage({Key key, this.title, this.showBackBtn})
      : super(key: key);
  final String title;
  final bool showBackBtn;

  @override
  ShopCategoryListState createState() => ShopCategoryListState();
}

class ShopCategoryListState extends State<ShopCategoryListPage> {
  Widget appBarTitle;
  CategoryBloc categoryBloc;

  @override
  void initState() {
    super.initState();
    categoryBloc = new CategoryBloc();
  }

  @override
  void dispose() {
    categoryBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("ShopCategoryListPage build");

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: new AppBar(
          centerTitle: true,
          title: Text(widget.title),
          leading: widget.showBackBtn == true
              ? new IconButton(
                  icon: UIData.back,
                  onPressed: () => Navigator.pop(context, false),
                )
              : null,
        ),
        body: Container(
          color: UIData.fff,
          child: bodyData(),
        ),
        // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }

  Widget bodyData() {
    print("shop category build");
    return CategoryProvider(
      categoryBloc: categoryBloc,
      child: StreamBuilder<List<Category>>(
          stream: categoryBloc.categoryItems,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              Result result = snapshot.error;
              return ErrorStatusWidget.order(
                  result.code, result.msg, "点击重试", () {
                categoryBloc.getCategories();
              });
            } else if (snapshot.hasData) {
              if (snapshot.data.isNotEmpty) {
                return body(snapshot.data);
              } else {
                return ErrorStatusWidget.order(0, "暂无数据", "点击重试", () {
                  categoryBloc.getCategories();
                });
              }
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }

  int selectIndex = 0;
  int categoryId = 0;

  Widget body(List<Category> categories) {
    categoryId = categories[selectIndex].id;
    categoryBloc.getSubCategories(categoryId);
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: Container(
              alignment: Alignment.center,
              color: UIData.fff6f6f6,
              child: ListView.builder(
                itemCount: categories.length,
                itemBuilder: (buildContext, index) {
                  return GestureDetector(
                    child: Container(
                      color:
                          selectIndex == index ? UIData.fff : UIData.fff6f6f6,
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(16, 16, 16, 16),
                        child: Center(
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
                    ),
                    onTap: () {
                      setState(() {
                        this.selectIndex = index;
                        categoryId = categories[selectIndex].id;
                        categoryBloc.getSubCategories(categoryId);
                      });
                    },
                  );
                },
              ),
            ),
            flex: 2,
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
                  buildSliverGrid(),
                ],
              ),
            ),
            flex: 5,
          ),
        ],
      ),
    );
  }

  Widget buildSliverGrid() {
    return CategoryProvider(
        categoryBloc: categoryBloc,
        child: StreamBuilder<List<Category>>(
            stream: categoryBloc.suCategoryItems,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data.isEmpty) {
                  return ErrorStatusWidget.order(0, "暂无数据", "点击重试", () {
                    categoryBloc.getCategories();
                  });
                } else {
                  return sliverGrid(snapshot.data);
                }
              } else if (snapshot.hasError) {
                Result result = snapshot.error;
                return ErrorStatusWidget.order(result.code, result.msg, "点击重试", () {
                  categoryBloc.getCategories();
                });
              } else {
                return SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      Center(child: CircularProgressIndicator()),
                    ],
                  ),
                );
              }
            }));
  }

  SliverGrid sliverGrid(List<Category> data) {
    return SliverGrid(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
        childAspectRatio: 0.7,
      ),
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return new GestureDetector(
            child: new Stack(
              children: <Widget>[
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: UIData.getImageWithWHFit(
                      data[index].image, BoxFit.contain, 90, 90),
                ),
                Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: new Container(
                      alignment: Alignment.center,
                      color: Colors.white,
                      child: new Padding(
                        padding: EdgeInsets.fromLTRB(0, 12, 0, 6),
                        child: new Text(
                          data[index].name,
                          textAlign: TextAlign.center,
                          style:
                              TextStyle(fontSize: 11, color: UIData.ff353535),
                          maxLines: 1,
                        ),
                      ),
                    )),
              ],
            ),
            onTap: () {
              print(data[index].toString());
              Navigator.pushNamed(context, UIData.ShopListPage,
                  arguments: data[index]);
            },
          );
        },
        childCount: data.length,
      ),
    );
  }
}
