import 'package:flutter/material.dart';
import 'list_bloc.dart';
export 'list_bloc.dart';

class ListProvider extends InheritedWidget {
  ListProvider({Key key, this.child}) 
   : bloc = ListBloc(),
     super(key: key, child: child);

  final Widget child;
  final ListBloc bloc;

  static ListBloc of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(ListProvider)as ListProvider).bloc;
  }

  @override
  bool updateShouldNotify( ListProvider oldWidget) {
    return true;
  }
}