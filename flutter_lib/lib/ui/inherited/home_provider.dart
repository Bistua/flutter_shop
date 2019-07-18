import 'package:flutter/material.dart';
import 'package:flutter_lib/logic/bloc/home_bloc.dart';
import 'package:flutter_lib/logic/bloc/product_bloc.dart';

class HomeBlocProvider extends InheritedWidget {
  final HomeBloc bloc;
  final Widget child;

  HomeBlocProvider({this.bloc, this.child}) : super(child: child);

  static HomeBlocProvider of(BuildContext context) =>
      context.inheritFromWidgetOfExactType(HomeBlocProvider);

  @override
  bool updateShouldNotify(HomeBlocProvider oldWidget) =>
      bloc != oldWidget.bloc;
}
