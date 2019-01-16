import 'package:flutter/material.dart';
import '../blocs/list_provider.dart';
import '../widgets/news_item.dart';
import '../widgets/refresh.dart';

class ListScreen extends StatelessWidget {
  Widget build(context) {
    final bloc = ListProvider.of(context);

    

    return Scaffold(
      appBar: AppBar(
        title: Text('Haker News'),
      ),
      body: listOfNews(bloc),
    );
  }

  Widget listOfNews(bloc) {
    return StreamBuilder(
      stream: bloc.topIds,
      builder: (context, AsyncSnapshot<List<int>> snapshot) {
        if (!snapshot.hasData) {
          return Center(
              child: CircularProgressIndicator(
            strokeWidth: 10.0,
          ));
        }
        return Refresh(
          child: ListView.builder(
          itemCount: snapshot.data.length,
          itemBuilder: (context, index) {
            bloc.fetchItem(snapshot.data[index]);
            return NewsItem(itmId: snapshot.data[index]);
          },
        )
        );
        
        ;
      },
    );
  }
}
