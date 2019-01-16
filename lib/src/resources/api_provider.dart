import 'dart:async';
import 'package:http/http.dart' show Client;
import '../models/item_model.dart';
import 'dart:convert';
import 'resources.dart';

class ApiProvider implements Source{
  final client = Client();

  final String addr = 'https://hacker-news.firebaseio.com/v0';

  Future<List<int>> fetchTopIds() async {
    final response = await client.get('$addr/topstories.json');
    final ids = json.decode(response.body);

    return ids.cast<int>();
  }

  Future<ItemModel> fetchOne(int id) async {
    final response = await client.get('$addr/item/$id.json');

    //print('${json.decode(response.body)}');
    final model = ItemModel.fromJson(json.decode(response.body));
    
    //print(model.toMapForDb());
    return model;
  }
}
