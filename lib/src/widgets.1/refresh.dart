import 'package:flutter/material.dart';
import '../blocs/list_provider.dart';

class Refresh extends StatelessWidget{
  Widget child;
  
  Refresh({this.child});

  Widget build(context){
    final bloc = ListProvider.of(context);
    return RefreshIndicator(
      child: child,
      onRefresh: () async{
        await bloc.clearCache();
        await bloc.fetchTopIds();
      },
    );
  }
}