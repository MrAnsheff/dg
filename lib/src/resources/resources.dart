import 'api_provider.dart';
import 'db_provider.dart';
import '../models/item_model.dart';

class Resources {
  List<Source> sources = [
    dbProvider,
    ApiProvider(),
  ];
  List<Cache> caches = [
    dbProvider,
  ];

  Future<List<int>> fetchTopIds() {
    return sources[1].fetchTopIds();
  }

  Future<ItemModel> fetchOne(int id) async {
    ItemModel result;


    for(var cache in caches){
      result = await cache.fetchOne(id);
    }

    if(result != null) return result;

    for(var source in sources){
      result = await source.fetchOne(id);
    }

    if(result != null){
      caches[0].saveOneId(result);
    }

    return result;
  }

  clearAll() async{
    for(var cache in caches){
      await cache.clearAll();
    }
  }
}

abstract class Source {
  Future<List<int>> fetchTopIds();
  Future<ItemModel> fetchOne(int id);
}

abstract class Cache {
  saveOneId(ItemModel item);
  fetchOne(int id);
  clearAll();
}
