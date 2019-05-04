import 'package:flutter/material.dart';
import 'package:flutter_lib/logic/bloc/category_bloc.dart';
import 'package:flutter_lib/logic/inherited/category_provider.dart';
import 'package:flutter_lib/model/category.dart';
import 'package:flutter_lib/ui/page/shop/shop_list.dart';
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
  CategoryBloc categoryBloc = new CategoryBloc();

  @override
  void initState() {
    super.initState();
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
              return empty(snapshot.error);
            } else if (snapshot.hasData) {
              return body(snapshot.data);
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }

  int selectIndex = 0;
  int categoryId = 0;

  Widget empty(Object error) {
    return Center(
      child: GestureDetector(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Text(error.toString() + "无数据,点击重试"),
        ),
        onTap: () {
          categoryBloc.getCategories();
        },
      ),
    );
  }

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
              return snapshot.hasData
                  ? (snapshot.data.isEmpty
                      ? emptySub()
                      : sliverGrid(snapshot.data))
                  : SliverList(
                      delegate: SliverChildListDelegate(
                        [
                          Center(child: CircularProgressIndicator()),
                        ],
                      ),
                    );
            }));
  }

  Widget emptySub() {
    return SliverList(
      delegate: SliverChildListDelegate(
        [
          Center(
            child: GestureDetector(
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Text("无子分类数据,点击重试"),
              ),
              onTap: () {
                categoryBloc.getSubCategories(categoryId);
              },
            ),
          ),
        ],
      ),
    );
  }

  SliverGrid sliverGrid(List<Category> data) {
    return SliverGrid(
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
                      UIData.getImage(data[index].image),
                      Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: new Container(
                            color: Colors.white,
                            child: new Column(
                              children: <Widget>[
                                new Padding(
                                  padding: EdgeInsets.fromLTRB(0, 12, 0, 6),
                                  child: new Text(
                                    data[index].name,
                                    style: TextStyle(
                                        fontSize: 11, color: UIData.ff353535),
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
