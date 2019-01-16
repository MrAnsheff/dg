import 'dart:async';
import '../resources/resources.dart';
import 'package:rxdart/rxdart.dart';
import '../models/item_model.dart';

class DetailBloc {
  final repository = Resources();
  Subject<int> detailIn = PublishSubject<int>();
  Subject<Map<int, Future<ItemModel>>> detailOut = BehaviorSubject<Map<int, Future<ItemModel>>>();

  Observable<Map<int, Future<ItemModel>>> get detailStream => detailOut.stream;

  Function(int) get detailInner => detailIn.sink.add;

  DetailBloc(){
    detailIn.stream.transform(_listTransformer()).pipe(detailOut);
  }

  _listTransformer(){
     return ScanStreamTransformer<int, Map<int, Future<ItemModel>>>(
      (Map<int, Future<ItemModel>> cache, int id, int index) {
        
        cache[id] = repository.fetchOne(id);
        cache[id].then((ItemModel item){
          item.kids.forEach((kid) => detailInner(kid));
        });
        
        
        return cache;
      },
      <int, Future<ItemModel>>{},
    );
  }

  @override
  void dispose() { 
    detailIn.close();
    detailOut.close();
    
  }
  
}
