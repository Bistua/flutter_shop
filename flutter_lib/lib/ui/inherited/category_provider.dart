import 'package:flutter/material.dart';
import 'package:flutter_lib/logic/bloc/category_bloc.dart';

class CategoryProvider extends InheritedWidget {
  final CategoryBloc categoryBloc;
  final Widget child;

  CategoryProvider({this.categoryBloc, this.child}) : super(child: child);

  static CategoryProvider of(BuildContext context) =>
      context.inheritFromWidgetOfExactType(CategoryProvider);

  @override
  bool updateShouldNotify(CategoryProvider oldWidget) =>
      categoryBloc != oldWidget.categoryBloc;
}
