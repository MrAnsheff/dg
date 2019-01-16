import 'package:flutter/material.dart';
import '../blocs/detail_provider.dart';
import '../models/item_model.dart';
import '../widgets/comment.dart';

class DetailScreen extends StatelessWidget {
  final int pageNumber;

  DetailScreen(this.pageNumber) {}

  Widget build(context) {
    final bloc = DetailProvider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("News Detail"),
      ),
      body: StreamBuilder(
        stream: bloc.detailStream,
        builder: (contex, AsyncSnapshot<Map<int, Future<ItemModel>>> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          

          return FutureBuilder(
            future: snapshot.data[pageNumber],
            builder: (context, AsyncSnapshot<ItemModel> futSnapshot) {
              if(!futSnapshot.hasData){
                return Text('Loading...');
              }
              
              return buildList(futSnapshot.data, snapshot.data);
            },
          );
        },
      ),
    );
  }

  buildList(ItemModel item, Map<int, Future<ItemModel>> itemMap){
    final commentList = <Widget>[];
    commentList.add(buildTitle(item));
    final comments = item.kids.map((kid){
      return Comment(item: kid, itemMap: itemMap, depth: 1,);
    }).toList();
    commentList.addAll(comments);


    return ListView(
      children: commentList,
    );

  }

  buildTitle(ItemModel item){
    return Container(
      alignment: Alignment.topCenter,
      margin: EdgeInsets.all(10.0),
      child: Text(
        item.title,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
