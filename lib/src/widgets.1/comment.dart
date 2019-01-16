import 'package:flutter/material.dart';
import 'dart:async';
import '../models/item_model.dart';

class Comment extends StatelessWidget{
  final int item;
  final Map<int, Future<ItemModel>> itemMap;
  final depth;

  Comment({this.item, this.itemMap, this.depth});

  Widget build(context){
    return FutureBuilder(
      future: itemMap[item],
      builder: (context, AsyncSnapshot<ItemModel> snapshot){
        if(!snapshot.hasData){
          return Column(
                children: <Widget>[
                  ListTile(
                    title: Container(color: Colors.grey[200], width: 150.0, height: 24, margin: EdgeInsets.only(top:5.0, bottom: 5.0),),
                    subtitle: Container(color: Colors.grey[200], width: 150.0, height: 24, margin: EdgeInsets.only(top:5.0, bottom: 5.0),),
                    
                  ),
                  Divider(
                    color: Colors.grey,
                    height: 6.0,
                  )
                ],
              );
        }

        final children = <Widget>[
          ListTile(
            title: snapshot.data.text == '' ? Text('Deleted'): buildText(snapshot.data),
            subtitle: snapshot.data.by == '' ? Text('Deleted') : Text(snapshot.data.by),
            contentPadding: EdgeInsets.only(
              right: 16.0,
              left: depth * 16.0,
            ),
          ),
          Divider(
            height: 7.0,
          ),
        ];
        snapshot.data.kids.forEach((kid){
          children.add(Comment(item: kid, itemMap: itemMap, depth: depth+1,));
        });

        return Column(
          children: children,

        );

        

      },
    );
    
  }
  Widget buildText(ItemModel item){
      final text = item.text
      .replaceAll('&#x27;', "'")
      .replaceAll('<p>', '\n\n')
      .replaceAll('</p>', '');
      return Text(text);
    }
    
}