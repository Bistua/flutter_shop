import 'package:flutter/cupertino.dart';

class EmptyWidget extends StatelessWidget {
  var type = 0;
  var tab;
  String error;

  EmptyWidget(
    this.error,
    this.tab,
  );

  EmptyWidget.WithSliverList(this.error,this.tab) {
    type = 1;
  }

  @override
  Widget build(BuildContext context) {
    if (type == 0) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: GestureDetector(
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Text(error==null?"无数据,点击重试":error),
            ),
            onTap: tab,
          ),
        ),
      );
    } else if (type == 1) {
      return SliverList(
        delegate: SliverChildListDelegate(
          [
            Center(
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: GestureDetector(
                  child: Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: Text(error==null?"无数据,点击重试":error),
                  ),
                  onTap: tab,
                ),
              ),
            ),
          ],
        ),
      );
    } else if (type == 2) {
      return SliverList(
        delegate: SliverChildListDelegate(
          [
            Center(
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: GestureDetector(
                  child: Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: Text(error==null?"无数据,点击重试":error),
                  ),
                  onTap: tab,
                ),
              ),
            ),
          ],
        ),
      );
    }
  }
}
