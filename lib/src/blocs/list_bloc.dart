import 'dart:async';
import '../resources/resources.dart';
import 'package:rxdart/rxdart.dart';
import '../models/item_model.dart';

class ListBloc{
  final repository = Resources();
  final _listIn = PublishSubject<int>();
  final _listOut = BehaviorSubject<Map<int,Future<ItemModel>>>();
  final _listTopIds = PublishSubject<List<int>>();
  
  Observable<List<int>> get topIds => _listTopIds.stream;
  Observable<Map<int, Future<ItemModel>>> get listOut => _listOut.stream;

  

  ListBloc() {
    _listIn.stream.transform(_listTransformer()).pipe(_listOut);
  }

  Function(int) get fetchItem => _listIn.sink.add;

  fetchTopIds() async{
    final List<int> toIds = await repository.fetchTopIds();
    _listTopIds.sink.add(toIds);
  }

  _listTransformer(){
     return ScanStreamTransformer(
      (Map<int, Future<ItemModel>> cache, int id, int index) {
       
        cache[id] = repository.fetchOne(id);
        
        
        return cache;
      },
      <int, Future<ItemModel>>{},
    );
  }

  clearCache() async{
    await repository.clearAll();
  }

 

  @override
  void dispose() {
    _listIn.close();
    _listOut.close();
    _listTopIds.close();
  }
  
}