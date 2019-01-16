import 'package:flutter/material.dart';
import 'screens/list_screen.dart';
import 'screens/detail_screen.dart';
import 'blocs/detail_provider.dart';
import 'blocs/list_provider.dart';

class App extends StatelessWidget {
  Widget build(context) {
    return ListProvider(
      child: DetailProvider(
        child: MaterialApp(
          onGenerateRoute: (RouteSettings settings) {
            if (settings.name == '/') {
              return MaterialPageRoute(builder: (context) {
                final bloc = ListProvider.of(context);
                bloc.fetchTopIds();
                return ListScreen();
              });
            } else {
              return MaterialPageRoute(builder: (context) {
                final bloc = DetailProvider.of(context);
                final int page = int.parse(settings.name.replaceFirst('/', ''));
                bloc.detailInner(page);

                return DetailScreen(page);
              });
            }
          },
        ),
      ),
    );
  }
}
