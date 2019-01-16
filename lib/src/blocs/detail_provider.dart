import 'package:flutter/material.dart';
import 'detail_bloc.dart';
export 'detail_bloc.dart';

class DetailProvider extends InheritedWidget {
  DetailProvider({Key key, this.child}) : bloc = DetailBloc(), super(key: key, child: child);

  final Widget child;
  final DetailBloc bloc;

  static DetailBloc of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(DetailProvider)as DetailProvider).bloc;
  }

  @override
  bool updateShouldNotify( DetailProvider oldWidget) {
    return true;
  }
}