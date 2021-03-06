import 'package:flutter/material.dart';
import '../blocs/list_provider.dart';
import '../models/item_model.dart';

class NewsItem extends StatelessWidget {
  final int itmId;

  NewsItem({this.itmId});

  Widget build(context) {
    final bloc = ListProvider.of(context);

    return StreamBuilder(
      stream: bloc.listOut,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Column(
                children: <Widget>[
                  ListTile(
                    title: Container(color: Colors.grey[400], width: 150.0, height: 24, margin: EdgeInsets.only(top:5.0, bottom: 5.0),),
                    subtitle: Container(color: Colors.grey[400], width: 150.0, height: 24, margin: EdgeInsets.only(top:5.0, bottom: 5.0),),
                    
                  ),
                  Divider(
                    color: Colors.grey,
                    height: 6.0,
                  )
                ],
              );
        }

        return FutureBuilder(
          future: snapshot.data[itmId],
          builder: (context, AsyncSnapshot<ItemModel> itemSnapshot) {
            if (!itemSnapshot.hasData) {
              return Column(
                children: <Widget>[
                  ListTile(
                    title: Container(color: Colors.grey[400], width: 150.0, height: 24, margin: EdgeInsets.only(top:5.0, bottom: 5.0),),
                    subtitle: Container(color: Colors.grey[400], width: 150.0, height: 24, margin: EdgeInsets.only(top:5.0, bottom: 5.0),),
                    
                  ),
                  Divider(
                    color: Colors.grey,
                    height: 6.0,
                  )
                ],
              );
            }

            return Column(
              children: <Widget>[
                ListTile(
                  onTap: (){Navigator.pushNamed(context, '/$itmId');},
                  title: Text(itemSnapshot.data.title,style: TextStyle(color:Colors.white,)),
                  subtitle: Text('${itemSnapshot.data.score}',style: TextStyle(color:Colors.grey[500],)),
                  trailing: Column(
                    children: <Widget>[
                      Icon(Icons.comment, color: Colors.white),
                      Text("${itemSnapshot.data.descendants}",style: TextStyle(color:Colors.white,))
                    ],
                  ),
                ),
                Divider(
                  color: Colors.grey,
                  height: 6.0,
                )
              ],
            );
          },
        );
      },
    );
  }
}
